# Estágio 1: Builder para instalar as dependências
FROM python:3.12-slim AS builder

WORKDIR /app

# Instalar dependências de compilação básicas, se necessárias
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Criar um ambiente virtual para isolar as dependências
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copiar e instalar dependências do requirements.txt
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


# Estágio 2: Imagem final leve para execução
FROM python:3.12-slim AS runner

# Definir variáveis de ambiente recomendadas
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/opt/venv/bin:$PATH"

WORKDIR /app

# Copiar as dependências instaladas no ambiente virtual
COPY --from=builder /opt/venv /opt/venv

# Copiar os códigos da aplicação
COPY app.py .

# Criar um usuário não-root por segurança
RUN addgroup --system appgroup && adduser --system --group appuser \
    && chown -R appuser:appgroup /app

# Mudar para o usuário não-root
USER appuser

# Expor a porta em que o Flask/Gunicorn escuta
EXPOSE 8005

# Comando para iniciar a aplicação com o Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8005", "app:app"]
