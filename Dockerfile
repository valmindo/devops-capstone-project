# Use Python 3.9-slim como a imagem base
FROM python:3.9-slim

# Criar o diretório de trabalho e instalar as dependências
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar os arquivos da aplicação
COPY service/ ./service/

# Criar e usar um usuário não root
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Expor a porta 8080 e definir o comando para rodar o serviço
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
