# 📋 Plano de Execução: Infraestrutura AWS + RDS + Auto-Migração Go + Deploy GitOps

Este documento detalha o passo a passo para provisionar a infraestrutura na AWS via Terraform, implementar a inicialização automática do banco de dados na aplicação Go, fazer o build e push da imagem no ECR, e realizar o deploy completo via Kustomize no cluster EKS.

---

## 🎯 Objetivo

1. **Infraestrutura (Terraform)**:
   - Descomentar e habilitar o módulo do **RDS PostgreSQL** (`db.t3.micro` / Free Tier) no `terraform/main.tf`.
   - Manter o **Ingress NGINX** e **ArgoCD** no Terraform.
   - Executar `terraform plan` e `terraform apply`.
2. **Aplicação (`auth-service` em Go)**:
   - Implementar a função `initDB` no `auth-service/main.go` para executar `CREATE TABLE IF NOT EXISTS api_keys` e injetar a seed key inicial na inicialização.
   - Testar o build da aplicação Go.
3. **Container & ECR**:
   - Fazer o build e push da imagem Docker do `auth-service` para o repositório `052717076243.dkr.ecr.us-east-2.amazonaws.com/jojo/auth-service-default:latest`.
4. **GitOps & K8s**:
   - Ajustar o secret `gitops/apps/auth-service/base/secret.yml` com o endpoint do RDS e credenciais.
   - Ajustar o `gitops/apps/auth-service/base/kustomization.yml` para apontar para `jojo/auth-service-default`.
   - Aplicar `kubectl apply -k gitops/overlays/prod`.
5. **Validação & Testes**:
   - Testar endpoints `/health`, `/validate` e `/admin/keys` via Ingress / Port-Forward.
   - Validar que o Pod está `1/1 Running` e as tabelas foram criadas no RDS.

---

## 🛠️ Etapas Propostas

### Fase 1: Ajuste e Validação do Terraform
1. **Descomentar módulo RDS** em `terraform/main.tf`.
2. **Descomentar outputs do RDS** em `terraform/outputs.tf`.
3. **Garantir conectividade do RDS SG**: Permitir tráfego na porta 5432 vindo do SG do cluster e do CIDR da VPC.
4. **Executar `terraform plan`** para conferir todos os recursos que serão criados.

---

### Fase 2: Implementação da Auto-Migração no `auth-service` (Go)
1. **Modificar `auth-service/main.go`**:
   - Adicionar função `initDB(db *sql.DB) error`.
   - Executar a criação da tabela `api_keys` e inserção idempotente (`ON CONFLICT DO NOTHING`) da chave de avaliação.
   - Chamar `initDB` logo após o `connectDB` no `main()`.
2. **Testar compilação e testes unitários locais** com `go test ./...`.

---

### Fase 3: Build e Push Manual para o ECR
1. Autenticar no Amazon ECR:
   ```bash
   aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 052717076243.dkr.ecr.us-east-2.amazonaws.com
   ```
2. Build da imagem Docker para arquitetura `linux/amd64`:
   ```bash
   docker build --platform linux/amd64 -t 052717076243.dkr.ecr.us-east-2.amazonaws.com/jojo/auth-service-default:latest ./auth-service
   ```
3. Push da imagem para o ECR:
   ```bash
   docker push 052717076243.dkr.ecr.us-east-2.amazonaws.com/jojo/auth-service-default:latest
   ```

---

### Fase 4: Ajustes nos Manifestos GitOps / Kustomize
1. **Atualizar `gitops/apps/auth-service/base/kustomization.yml`**:
   - Ajustar o repositório da imagem para `052717076243.dkr.ecr.us-east-2.amazonaws.com/jojo/auth-service-default`.
2. **Atualizar `gitops/apps/auth-service/base/secret.yml`**:
   - Inserir a string de conexão real do RDS obtida no output do Terraform:
     `postgres://<username>:<password>@<rds-address>:5432/<database>?sslmode=require`

---

### Fase 5: Provisionamento e Deploy no Cluster
1. Provisionar a infraestrutura:
   ```bash
   cd terraform && terraform apply -auto-approve
   ```
2. Atualizar o `kubeconfig`:
   ```bash
   aws eks update-kubeconfig --region us-east-2 --name jojo-eks-cluster
   ```
3. Aplicar os manifestos do GitOps:
   ```bash
   kubectl apply -k gitops/overlays/prod
   ```

---

### Fase 6: Verificação e Testes Finais
1. **Verificar Pods e Logs**:
   ```bash
   kubectl get pods -n toggle-master
   kubectl logs -n toggle-master -l app=auth-service
   ```
   *Validar se a mensagem "Tabelas verificadas/criadas com sucesso" e "Conectado ao PostgreSQL com sucesso" aparecem nos logs.*
2. **Testar Endpoint de Health Check**:
   ```bash
   kubectl exec -it -n toggle-master deploy/auth-service -- wget -qO- http://localhost:8001/health
   ```
3. **Testar Rota pelo Ingress NLB**:
   - Obter a URL do Ingress NGINX Load Balancer.
   - Fazer requisição GET em `http://<NLB_URL>/auth/health`.
