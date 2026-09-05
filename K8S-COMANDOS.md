# 🛠️ Comandos Úteis do Kubernetes (K8s & Kind)

Guia rápido de referência com todos os comandos essenciais para desenvolvimento local com **Kind**, gerenciamento de recursos e troubleshooting no namespace `toggle-master`.

---

## 🧭 1. Gerenciamento de Cluster & Contexto

```bash
# Listar todos os contextos configurados
kubectl config get-contexts

# Alternar para o cluster Kind local
kubectl config use-context kind-meu-primeiro-cluster

# Alternar para o cluster EKS (AWS)
kubectl config use-context arn:aws:eks:us-east-1:052717076243:cluster/togglemaster-cluster

# Ver contexto ativo no momento
kubectl config current-context

# Visualizar os nós do cluster
kubectl get nodes -o wide

# Informações gerais do cluster
kubectl cluster-info
```

---

## 🐳 2. Gerenciamento de Imagens no Kind (Kubernetes in Docker)

```bash
# Fazer build da imagem no Docker da máquina
docker compose build auth-service
# ou: docker build -t fase2-auth-service:latest ./auth-service

# Carregar a imagem Docker da máquina para dentro do nó do Kind (Obrigatório no Kind)
kind load docker-image fase2-auth-service:latest --name meu-primeiro-cluster

# Listar imagens carregadas dentro do nó do Kind
docker exec meu-primeiro-cluster-control-plane crictl images
```

---

## 📦 3. Namespaces

```bash
# Criar o namespace a partir do arquivo
kubectl apply -f k8s/namespace.yml

# Listar todos os namespaces
kubectl get namespaces

# Deletar o namespace inteiro (apaga absolutamente tudo dentro dele)
kubectl delete namespace toggle-master
```

---

## 🚀 4. Aplicação de Recursos & Deployments

```bash
# Aplicar todos os recursos na ordem correta
kubectl apply -f k8s/namespace.yml
kubectl apply -f auth-service/k8s/configmap.yml
kubectl apply -f auth-service/k8s/secret.yml
kubectl apply -f auth-service/k8s/service.yml
kubectl apply -f auth-service/k8s/deployment.yml

# Atalho: Aplicar toda a pasta do auth-service de uma vez
kubectl apply -f auth-service/k8s/

# Criar Secret local direto via linha de comando (sem precisar de Base64)
kubectl create secret generic auth-service-secret \
  --namespace=toggle-master \
  --from-literal=DATABASE_URL="postgres://togglemaster_user:minhaSenhaSegura123@host.docker.internal:5432/auth_db?sslmode=disable" \
  --from-literal=MASTER_KEY="admin-secreto-123" \
  --dry-run=client -o yaml | kubectl apply -f -
```

---

## 🌐 5. Port-Forward (Acesso Local aos Serviços)

```bash
# Rodar em primeiro plano (trava o terminal)
kubectl port-forward svc/auth-service -n toggle-master 8001:8001

# Rodar em segundo plano de forma simples (&)
kubectl port-forward svc/auth-service -n toggle-master 8001:8001 &

# Rodar em segundo plano silenciando logs no terminal
kubectl port-forward svc/auth-service -n toggle-master 8001:8001 > /dev/null 2>&1 &

# Verificar se a porta 8001 está ocupada / rodando
lsof -i :8001

# Encerrar o port-forward em segundo plano
pkill -f "port-forward svc/auth-service"
# ou se usou '&':
kill %1
```

---

## 🔍 6. Inspeção, Logs & Diagnóstico (Troubleshooting)

```bash
# Listar apenas os Deployments do namespace
kubectl get deployments -n toggle-master

# Listar apenas os Pods (com status e restarts)
kubectl get pods -n toggle-master

# Visualizar pods em tempo real (-w = watch)
kubectl get pods -n toggle-master -w

# Listar Services, ConfigMaps e Secrets
kubectl get svc -n toggle-master
kubectl get configmaps -n toggle-master
kubectl get secrets -n toggle-master

# Visualizar TODOS os recursos juntos dentro do namespace
kubectl get all -n toggle-master

# Ver detalhes completos e eventos de erro de um Pod (ex: ImagePullBackOff, CrashLoop)
kubectl describe pod -l app=auth-service -n toggle-master

# Ver logs do Pod em tempo real
kubectl logs -f deployment/auth-service -n toggle-master

# Ver as últimas 100 linhas de logs do Pod
kubectl logs -l app=auth-service -n toggle-master --tail=100

# Reiniciar um Deployment (forçar recriação dos pods)
kubectl rollout restart deployment/auth-service -n toggle-master

# Verificar status de um rollout/deploy
kubectl rollout status deployment/auth-service -n toggle-master
```

---

## 🧹 7. Deleção & Limpeza de Recursos

```bash
# Deletar apenas os recursos do auth-service
kubectl delete -f auth-service/k8s/

# Deletar APENAS os Deployments do namespace
kubectl delete deployments --all -n toggle-master

# Deletar TODOS os recursos (Deployments, Pods, Services, Secrets, ConfigMaps) MANTENDO o namespace
kubectl delete all,configmap,secret,ingress,hpa --all -n toggle-master

# Deletar o namespace completo (remoção total e definitiva)
kubectl delete namespace toggle-master
```
