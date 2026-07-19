# TODO - Controle Dieta Infra

## 📋 Tarefas de Desenvolvimento

### 🚀 Feature: Adicionar Lambda + DynamoDB + API Gateway

#### Fase 1: Infraestrutura Terraform
- [ ] Criar arquivo `terraform/iam.tf` com roles e policies para Lambda
- [ ] Criar arquivo `terraform/dynamodb.tf` com tabelas (diets e meals)
- [ ] Criar arquivo `terraform/lambda.tf` com função Lambda
- [ ] Criar bucket S3 para deployments da Lambda em `terraform/main.tf`
- [ ] Atualizar `terraform/gateway.tf` com integração Lambda + API Gateway
- [ ] Atualizar `terraform/variables.tf` com novas variáveis se necessário
- [ ] Atualizar `terraform/outputs.tf` com saídas da Lambda, DynamoDB e bucket
- [ ] Executar `terraform plan` e validar recursos
- [ ] Executar `terraform apply` e confirmar criação dos recursos

#### Fase 2: Repositório da Lambda
- [ ] Criar repositório `controle-dieta-lambda` (Node.js + TypeScript)
- [ ] Estruturar projeto: src/, handlers/, models/, tests/
- [ ] Configurar `package.json` e `tsconfig.json`
- [ ] Implementar mocks em modelos do DynamoDB
- [ ] Criar handlers para endpoints:
  - [ ] GET /diets - Retornar todas as dietas
  - [ ] GET /diets/{id} - Retornar dieta específica
  - [ ] GET /diets/{id}/meals - Retornar refeições de uma dieta
- [ ] Criar script de seed para popular DynamoDB

#### Fase 3: CI/CD da Lambda
- [ ] Criar workflow GitHub Actions `.github/workflows/deploy-lambda.yml`
- [ ] Implementar build (npm install + TypeScript compile)
- [ ] Implementar compactação em ZIP
- [ ] Implementar upload para S3
- [ ] Implementar atualização automática da função Lambda
- [ ] Testar deploy automático

#### Fase 4: Integração Frontend
- [ ] Atualizar frontend para usar endpoints da API Gateway
- [ ] Remover mocks locais do frontend
- [ ] Conectar requests HTTP aos endpoints da Lambda
- [ ] Testar fluxo completo (frontend → API Gateway → Lambda → DynamoDB)
- [ ] Tratar erros e validações

### 🐛 Bugs

- [ ] Bug 1
- [ ] Bug 2
- [ ] Bug 3

### 🔧 Melhorias

- [ ] Melhoria 1
- [ ] Melhoria 2
- [ ] Melhoria 3
- [ ] Limpar o cache do CloudFront após o deploy

### 📚 Documentação

- [ ] Atualizar README.md com arquitetura da Lambda
- [ ] Documentar endpoints da API Gateway
- [ ] Documentar estrutura do DynamoDB
- [ ] Documentar procedimento de deploy

### 🧪 Testes

- [ ] Teste 1
- [ ] Teste 2
- [ ] Teste 3

---

## 📝 Notas

Adicione aqui observações gerais sobre a infraestrutura e procedimentos de deploy.

### Arquitetura Atual (com Lambda)
```
Frontend (Angular SPA)
    ↓
CloudFront (CDN)
    ↓
API Gateway (/diets, /diets/{id}, etc)
    ↓
Lambda (controle-dieta-function)
    ↓
DynamoDB (diets, meals)
```

---

**Última atualização:** 2026-07-19
