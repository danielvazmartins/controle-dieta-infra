# Spec: Infraestrutura Lambda + DynamoDB

## 📋 Descrição

Provisionar recursos AWS necessários para backend serverless: Lambda, DynamoDB, S3 e integração com API Gateway.

**Status:** 🚀 Planejado

## 🎯 Objetivo

Criar toda a infraestrutura como código (IaC) usando Terraform para suportar o backend serverless.

## 🏗️ Arquitetura

```
API Gateway
    ↓
Lambda Function (Node.js 20.x)
    ↓
DynamoDB Tables (diets, meals)

+ S3 Bucket (para deployments)
+ IAM Roles & Policies
```

## ✅ Tarefas

### IAM & Permissões
- [ ] Criar arquivo `terraform/iam.tf`
  - Role para Lambda com permissões DynamoDB
  - Policy para CloudWatch Logs
  - Policy para acesso a DynamoDB

### DynamoDB
- [ ] Criar arquivo `terraform/dynamodb.tf`
  - Tabela `controle-dieta-diets` (hash_key: id)
  - Tabela `controle-dieta-meals` (hash_key: id, range_key: dietId)
  - Billing mode: PAY_PER_REQUEST

### Lambda
- [ ] Criar arquivo `terraform/lambda.tf`
  - Função Lambda Node.js 20.x
  - Handler: index.handler
  - Environment variables: DIETS_TABLE, MEALS_TABLE

### S3 para Deploy
- [ ] Adicionar bucket S3 em `terraform/main.tf`
  - Nome: controle-dieta-lambdas
  - Versioning habilitado
  - Acesso privado

### API Gateway
- [ ] Atualizar `terraform/gateway.tf`
  - Integração Lambda Proxy no endpoint /diets
  - Permissão para API Gateway invocar Lambda

### Outputs
- [ ] Atualizar `terraform/outputs.tf`
  - lambda_function_name
  - dynamodb_diets_table
  - dynamodb_meals_table
  - lambda_bucket_name
  - api_gateway_invoke_url

### Validação e Deploy
- [ ] Executar `terraform plan` e revisar recursos
- [ ] Executar `terraform apply` e confirmar criação
- [ ] Documentar outputs para próxima feature

---

**Criado em:** 2026-07-19
