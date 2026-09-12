# Ao adicionar o Linter na verificações foi encontrado um erro no cod que precisou ser corrigido

- retorno de json.NewEncoder(w).Encode(...) não estava sendo tratado/ignorado

# Decisão instalar o Metrics Server via kustomize

# Decisição do ALB do nginx ingress

- Via terraform para ser deletado junto aos outros elementos do terraform

# Terraform Backend com Dinamo depreciado

### 💡 O que mudou?

• Antes (Legado): O S3 sozinho não conseguia travar concorrência nativamente, então era obrigatório criar uma tabela no DynamoDB (dynamodb_table = "...") para  
 fazer o lock.  
 • Agora (Terraform 1.10+): A AWS adicionou suporte a trava nativa diretamente no próprio S3. Com isso, você só precisa passar a flag use_lockfile = true,  
 tornando a tabela DynamoDB desnecessária (reduzindo complexidade e custo FinOps).
