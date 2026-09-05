# 🚀 Guia Prático: Rodando o `auth-service` no Kubernetes Local (Kind)

Este guia fornece o passo a passo completo para executar e validar o microsserviço **`auth-service`** no seu cluster Kubernetes local (**Kind**) com Docker.

---

## 📌 Pré-requisitos

- **Docker** em execução.
- **Kind** cluster ativo (contexto `kind-meu-primeiro-cluster`).
- **kubectl** configurado.

---

## 🗺️ Visão Geral do Fluxo

```mermaid
flowchart LR
    A["1. Ajustar Contexto K8s"] --> B["2. Build & Load Imagem no Kind"]
    B --> C["3. Criar Namespace"]
    C --> D["4. ConfigMap & Secret"]
    D --> E["5. Service & Deployment"]
    E --> F["6. Teste via Port-Forward"]
```

---

## 🛠️ Passo a Passo

### Passo 1: Apontar o `kubectl` para o Cluster Local (Kind)

Alterne o contexto do Kubernetes para o seu cluster local:

```bash
# Alternar para o cluster Kind local
kubectl config use-context kind-meu-primeiro-cluster

# Validar se o nó do cluster está pronto (Ready)
kubectl get nodes
```

---

### Passo 2: Carregar a Imagem Docker no Kind

No seu arquivo [auth-service/k8s/deployment.yml](file:///home/brsantos/projects/fiap/FASE2/auth-service/k8s/deployment.yml), a imagem configurada é **`fase2-auth-service:latest`**.

Como o Kind roda em nós isolados, carregue a imagem local existente no seu Docker para dentro do cluster Kind:

```bash
# 1. (Se precisar reconstruir a imagem):
docker compose build auth-service
# ou: docker build -t fase2-auth-service:latest ./auth-service

# 2. Carregar a imagem para dentro do cluster Kind:
kind load docker-image fase2-auth-service:latest --name meu-primeiro-cluster
```

---

### Passo 3: Garantir o Banco de Dados PostgreSQL

O `auth-service` necessita do PostgreSQL com a tabela `api_keys` inicializada.

#### Opção Recomendada: Usar o PostgreSQL do Docker Compose
Se você já subiu o banco com `docker compose`:
```bash
docker compose up -d auth-db-postgresql
```

> **Atenção sobre conectividade:**  
> A partir de dentro do cluster Kind, o endereço `localhost` ou `127.0.0.1` aponta para o próprio Pod.  
> Para acessar o PostgreSQL que está rodando no Docker da sua máquina, utilize o host gateway do Docker: `host.docker.internal` ou o IP `172.17.0.1`.

---

### Passo 4: Criar o Namespace `toggle-master`

Todos os manifestos do projeto estão vinculados ao namespace `toggle-master`. Crie-o primeiro:

```bash
kubectl apply -f k8s/namespace.yml
```

*Verificar criação:*
```bash
kubectl get namespaces
```

---

### Passo 5: Criar ConfigMap e Secret do `auth-service`

1. **Criar o ConfigMap (Porta 8001):**
   ```bash
   kubectl apply -f auth-service/k8s/configmap.yml
   ```

2. **Criar o Secret de Autenticação e Banco:**
   
   Para o ambiente local, o secret precisa conter as variáveis `DATABASE_URL` e `MASTER_KEY`.

   Você pode aplicar diretamente via comando `kubectl`:
   ```bash
   kubectl create secret generic auth-service-secret \
     --namespace=toggle-master \
     --from-literal=DATABASE_URL="postgres://togglemaster_user:minhaSenhaSegura123@host.docker.internal:5432/auth_db?sslmode=disable" \
     --from-literal=MASTER_KEY="admin-secreto-123" \
     --dry-run=client -o yaml | kubectl apply -f -
   ```

---

### Passo 6: Criar o Service (Rede Interna)

O Service permite a comunicação com o `auth-service` na porta `8001`:

```bash
kubectl apply -f auth-service/k8s/service.yml
```

*Verificar service:*
```bash
kubectl get svc -n toggle-master
```

---

### Passo 7: Criar o Deployment do `auth-service`

O seu manifesto [auth-service/k8s/deployment.yml](file:///home/brsantos/projects/fiap/FASE2/auth-service/k8s/deployment.yml) já está configurado com `image: fase2-auth-service:latest` e `imagePullPolicy: IfNotPresent`.

Aplique o manifesto:
```bash
kubectl apply -f auth-service/k8s/deployment.yml
```

---

### Passo 8: Acompanhar o Status dos Pods

Verifique se o pod inicializou com sucesso e passou nos testes de saúde (`startupProbe` e `readinessProbe`):

```bash
# Ver pods em tempo real
kubectl get pods -n toggle-master -w

# Ver logs do auth-service
kubectl logs -f deployment/auth-service -n toggle-master
```

---

## 🧪 Testando a Aplicação Localmente

Como o Service é do tipo `ClusterIP`, faça o encaminhamento de porta (`port-forward`) para testar no seu terminal/navegador:

```bash
kubectl port-forward svc/auth-service -n toggle-master 8001:8001
```

Em outro terminal, execute os testes:

### 1. Health Check
```bash
curl -i http://localhost:8001/health
```
*Resposta esperada:*
```json
HTTP/1.1 200 OK
{"status":"ok"}
```

### 2. Criar uma nova Chave de API
```bash
curl -i -X POST http://localhost:8001/keys \
  -H "Authorization: Bearer admin-secreto-123" \
  -H "Content-Type: application/json" \
  -d '{"name": "minha-chave-local"}'
```

### 3. Validar uma Chave de API
```bash
curl -i http://localhost:8001/validate \
  -H "Authorization: Bearer <CHAVE_GERADA_NO_PASSO_ANTERIOR>"
```

---

## 🔍 Comandos Úteis e Troubleshooting

| Ação | Comando |
| :--- | :--- |
| **Ver todos os recursos** | `kubectl get all -n toggle-master` |
| **Ver detalhes e eventos do Pod** | `kubectl describe pod -l app=auth-service -n toggle-master` |
| **Ver logs do Pod** | `kubectl logs -l app=auth-service -n toggle-master --tail=100` |
| **Reiniciar o Deployment** | `kubectl rollout restart deployment/auth-service -n toggle-master` |
| **Deletar os recursos do auth-service** | `kubectl delete -f auth-service/k8s/` |
| **Deletar todo o Namespace** | `kubectl delete namespace toggle-master` |
