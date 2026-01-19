# 🚀 Deploy da Evolution API no Railway

Este guia mostra como fazer o deploy da Evolution API no Railway.

## 📋 Pré-requisitos

1. Conta no [Railway](https://railway.app)
2. Repositório Git (GitHub, GitLab ou Bitbucket)
3. PostgreSQL habilitado no Railway (recomendado)

## 🔧 Passo a Passo

### 1. Preparar o Repositório

Este repositório já está configurado com os arquivos necessários:
- ✅ `railway.json` - Configuração do build e deploy
- ✅ `railway.toml` - Configuração alternativa
- ✅ `nixpacks.toml` - Configuração do Nixpacks
- ✅ `.env` - Variáveis de ambiente pré-configuradas

### 2. Criar Projeto no Railway

1. Acesse [Railway](https://railway.app) e faça login
2. Clique em **"New Project"**
3. Selecione **"Deploy from GitHub repo"**
4. Escolha este repositório
5. Railway detectará automaticamente a configuração

### 3. Adicionar PostgreSQL

1. No seu projeto Railway, clique em **"+ New"**
2. Selecione **"Database"** → **"Add PostgreSQL"**
3. O Railway criará automaticamente a variável `DATABASE_URL`

### 4. Configurar Variáveis de Ambiente

No Railway, vá em **Variables** e adicione/configure:

#### Obrigatórias:
```bash
DATABASE_URL=${DATABASE_URL}  # Criada automaticamente pelo Railway
AUTHENTICATION_API_KEY=sua_chave_segura_aqui  # MUDE ISSO!
SERVER_URL=https://seu-app.railway.app  # Será fornecido pelo Railway
```

#### Recomendadas:
```bash
DATABASE_PROVIDER=postgresql
DATABASE_CONNECTION_CLIENT_NAME=evolution_railway
LOG_LEVEL=ERROR,WARN,INFO
CORS_ORIGIN=*
```

### 5. Configurar Domínio Público

1. Vá na aba **"Settings"** do seu serviço
2. Em **"Networking"** → **"Generate Domain"**
3. Copie o domínio gerado (ex: `sua-app.up.railway.app`)
4. Atualize a variável `SERVER_URL` com este domínio

### 6. Deploy

1. O Railway iniciará o build automaticamente
2. Aguarde o processo de build e deploy (pode levar 5-10 minutos)
3. Verifique os logs em **"Deployments"** → **"View Logs"**

### 7. Verificar se Está Funcionando

Após o deploy, acesse:
```
https://seu-app.railway.app
```

Você deve ver a resposta da API Evolution.

## 🔐 Segurança

### API Key
**IMPORTANTE:** Altere a `AUTHENTICATION_API_KEY` no Railway para um valor seguro!

```bash
# Gerar uma chave segura (PowerShell)
[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes([System.Guid]::NewGuid().ToString()))
```

### Headers para Requisições

Todas as requisições devem incluir o header:
```
apikey: sua_chave_api_aqui
```

## 📱 Criar Instância do WhatsApp

### 1. Criar Instância
```bash
POST https://seu-app.railway.app/instance/create
Headers:
  apikey: sua_chave_api_aqui
  Content-Type: application/json

Body:
{
  "instanceName": "minha-instancia",
  "qrcode": true
}
```

### 2. Conectar WhatsApp
```bash
GET https://seu-app.railway.app/instance/connect/minha-instancia
Headers:
  apikey: sua_chave_api_aqui
```

Você receberá um QR Code para escanear com o WhatsApp.

## 🔧 Variáveis de Ambiente Disponíveis

### Servidor
- `SERVER_PORT` - Porta (Railway define automaticamente)
- `SERVER_URL` - URL pública da aplicação
- `SERVER_TYPE` - Tipo de servidor (http/https)

### Banco de Dados
- `DATABASE_URL` - Connection string do PostgreSQL (automático)
- `DATABASE_PROVIDER` - postgresql | mysql
- `DATABASE_CONNECTION_CLIENT_NAME` - Nome do cliente

### Autenticação
- `AUTHENTICATION_TYPE` - apikey | jwt
- `AUTHENTICATION_API_KEY` - Chave da API

### Logs
- `LOG_LEVEL` - ERROR,WARN,DEBUG,INFO,LOG,VERBOSE
- `LOG_COLOR` - true | false

### Integrações (Opcional)
- `TYPEBOT_ENABLED` - Habilitar Typebot
- `CHATWOOT_ENABLED` - Habilitar Chatwoot
- `OPENAI_ENABLED` - Habilitar OpenAI
- `DIFY_ENABLED` - Habilitar Dify

### Armazenamento (Opcional)
- `S3_ENABLED` - Habilitar S3/MinIO para mídias
- `S3_BUCKET` - Nome do bucket
- `S3_ENDPOINT` - Endpoint do S3

### Cache (Opcional)
- `CACHE_REDIS_ENABLED` - Habilitar Redis
- `CACHE_REDIS_URI` - URI do Redis

## 📊 Monitoramento

### Logs
Visualize logs em tempo real:
```
Railway Dashboard → Deployments → View Logs
```

### Métricas
O Railway fornece métricas de:
- CPU
- Memória
- Rede
- Requisições

## 🔄 Atualização

Para atualizar a aplicação:

1. Faça commit das mudanças no repositório Git
2. Push para o branch principal
3. Railway fará o deploy automaticamente

Ou:

1. No Railway, vá em **"Deployments"**
2. Clique em **"Redeploy"**

## 🐛 Solução de Problemas

### Build falhou
- Verifique os logs de build
- Certifique-se que o `DATABASE_URL` está configurado
- Verifique se os scripts em `./Docker/scripts/` têm permissão de execução

### Aplicação não inicia
- Verifique se a porta está correta (Railway usa `$PORT`)
- Confirme que o banco de dados está acessível
- Verifique as migrations do Prisma nos logs

### Erro de conexão do banco
- Confirme que o PostgreSQL está rodando
- Verifique se `DATABASE_URL` está correto
- Teste a conexão do banco no Railway

### WhatsApp desconecta
- Verifique se `DATABASE_SAVE_DATA_INSTANCE=true`
- Confirme que as sessions estão sendo salvas
- Verifique logs de erro do Baileys

## 📚 Documentação Adicional

- [Documentação Evolution API](https://doc.evolution-api.com)
- [Railway Documentation](https://docs.railway.app)
- [Baileys GitHub](https://github.com/WhiskeySockets/Baileys)

## 💡 Dicas

1. **Banco de Dados**: Use PostgreSQL do Railway para melhor desempenho
2. **Redis**: Adicione Redis para cache (opcional mas recomendado)
3. **Backups**: Configure backups automáticos no Railway
4. **Domínio Custom**: Você pode adicionar seu próprio domínio
5. **Escalabilidade**: O Railway permite escalar verticalmente quando necessário

## 🆘 Suporte

- [Discord Evolution API](https://evolution-api.com/discord)
- [WhatsApp Group](https://evolution-api.com/whatsapp)
- [GitHub Issues](https://github.com/EvolutionAPI/evolution-api/issues)

## 📄 Licença

Este projeto está sob a licença Apache-2.0. Veja o arquivo [LICENSE](./LICENSE) para mais detalhes.
