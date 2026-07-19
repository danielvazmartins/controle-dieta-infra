# Spec: Lambda + DynamoDB + API Gateway

## 📋 Descrição

Implementar backend serverless com AWS Lambda, DynamoDB e API Gateway para migrar de mocks locais para uma API real.

**Status:** 🚀 Em Desenvolvimento

## 🎯 Objetivo

Criar um backend que sirva os dados de dietas e refeições através de uma API REST, substituindo os mocks locais do frontend.

## 🏗️ Arquitetura

```
Frontend (Angular SPA)
    ↓ HTTP
CloudFront (CDN)
    ↓
API Gateway (/diets, /diets/{id}, etc)
    ↓ Lambda Proxy
Lambda (controle-dieta-function)
    ↓
DynamoDB (diets, meals)
```

## 📝 Tarefas

### Fase 1: Infraestrutura Terraform

Criar os recursos AWS necessários usando Terraform.

#### IAM & Permissões
- [ ] Criar arquivo `terraform/iam.tf`
  - Role para Lambda com permissões DynamoDB
  - Policy para CloudWatch Logs
  - Policy para acesso a DynamoDB (GetItem, Query, Scan, PutItem, UpdateItem, DeleteItem)

#### DynamoDB
- [ ] Criar arquivo `terraform/dynamodb.tf`
  - Tabela `controle-dieta-diets` (hash_key: id)
  - Tabela `controle-dieta-meals` (hash_key: id, range_key: dietId)
  - Billing mode: PAY_PER_REQUEST (ideal para free tier)

#### Lambda
- [ ] Criar arquivo `terraform/lambda.tf`
  - Função Lambda Node.js 20.x
  - Handler: index.handler
  - Environment variables: DIETS_TABLE, MEALS_TABLE

#### S3 para Deploy
- [ ] Adicionar bucket S3 em `terraform/main.tf`
  - Nome: controle-dieta-lambdas
  - Versioning habilitado
  - Acesso privado

#### API Gateway
- [ ] Atualizar `terraform/gateway.tf`
  - Integração Lambda Proxy no endpoint /diets
  - Permissão para API Gateway invocar Lambda

#### Outputs
- [ ] Atualizar `terraform/outputs.tf`
  - lambda_function_name
  - dynamodb_diets_table
  - dynamodb_meals_table
  - lambda_bucket_name
  - api_gateway_invoke_url

#### Validação
- [ ] Executar `terraform plan` e revisar recursos
- [ ] Executar `terraform apply` e confirmar criação

---

### Fase 2: Repositório da Lambda

Criar novo repositório com código Node.js/TypeScript.

#### Setup Inicial
- [ ] Criar repositório `controle-dieta-lambda` no GitHub
- [ ] Clonar e estruturar pastas:
  ```
  controle-dieta-lambda/
  ├── src/
  │   ├── index.ts              # Handler Lambda
  │   ├── handlers/
  │   │   ├── diets.ts
  │   │   └── meals.ts
  │   ├── services/
  │   │   ├── DietService.ts
  │   │   └── MealService.ts
  │   ├── models/
  │   │   ├── Diet.ts
  │   │   └── Meal.ts
  │   └── utils/
  │       └── dynamodb.ts
  ├── dist/                     # Build output
  ├── package.json
  ├── tsconfig.json
  └── .gitignore
  ```

#### Configuração
- [ ] Configurar `package.json` com scripts:
  - `npm run build` - Compilar TypeScript
  - `npm run dev` - Rodar localmente
  - `npm run test` - Rodar testes
- [ ] Configurar `tsconfig.json` com target ES2020
- [ ] Instalar dependências:
  - aws-sdk (ou @aws-sdk/client-dynamodb)
  - typescript
  - ts-node
  - jest (para testes)

#### Modelos de Dados
- [ ] Criar `src/models/Diet.ts`
  ```typescript
  interface Diet {
    id: string;
    name: string;
    description: string;
    createdAt: string;
  }
  ```
- [ ] Criar `src/models/Meal.ts`
  ```typescript
  interface Meal {
    id: string;
    dietId: string;
    name: string;
    calories: number;
    createdAt: string;
  }
  ```

#### Serviços DynamoDB
- [ ] Criar `src/services/DietService.ts`
  - getAllDiets()
  - getDietById(id)
  - createDiet(diet)
  - updateDiet(id, diet)
  - deleteDiet(id)
- [ ] Criar `src/services/MealService.ts`
  - getMealsByDietId(dietId)
  - getMealById(id)
  - createMeal(meal)
  - updateMeal(id, meal)
  - deleteMeal(id)

#### Handlers
- [ ] Criar `src/handlers/diets.ts`
  - GET /diets
  - GET /diets/{id}
  - POST /diets
  - PUT /diets/{id}
  - DELETE /diets/{id}
- [ ] Criar `src/handlers/meals.ts`
  - GET /diets/{id}/meals
  - GET /meals/{id}
  - POST /meals
  - PUT /meals/{id}
  - DELETE /meals/{id}

#### Index Handler
- [ ] Criar `src/index.ts`
  - Exportar função `handler` (AWS Lambda Proxy Integration)
  - Rotear requisições para handlers apropriados
  - Retornar respostas formatadas

#### Seed Data
- [ ] Criar script `src/seed.ts`
  - Migrar dados dos mocks para DynamoDB
  - Executar manualmente quando necessário

---

### Fase 3: CI/CD da Lambda

Automatizar build e deploy via GitHub Actions.

#### Workflow Setup
- [ ] Criar `.github/workflows/deploy-lambda.yml`
  - Trigger: push em main, mudanças em src/ e package.json
  - Runs-on: ubuntu-latest

#### Build
- [ ] Setup Node.js 20.x
- [ ] npm install
- [ ] npm run build
- [ ] Verificar se `dist/` foi gerado

#### Package
- [ ] Compactar código em ZIP
  - Incluir dist/ + node_modules (ou instalar production-only)
  - Excluir arquivos desnecessários
  - Arquivo de saída: function.zip

#### Upload
- [ ] Fazer upload do ZIP para S3
  - S3 bucket: controle-dieta-lambdas
  - S3 key: function.zip
  - Usar credenciais via GitHub Secrets

#### Deploy
- [ ] Atualizar função Lambda via AWS CLI
  - `aws lambda update-function-code`
  - Usar função name: controle-dieta-function
  - Usar S3 bucket e key

#### Testes
- [ ] Testar fluxo completo:
  - Push para main
  - Confirmar que workflow executou
  - Verificar que Lambda foi atualizada
  - Testar endpoint da API

---

### Fase 4: Integração Frontend

Conectar frontend Angular aos novos endpoints.

#### Migração de Dados
- [ ] Remover arquivo `src/app/shared/mocks/diets.mock.ts` do frontend
- [ ] Criar serviço `src/app/services/DietApiService.ts`
  - Fazer requisições HTTP para API Gateway
  - Base URL: variável de ambiente

#### Atualização de Componentes
- [ ] Atualizar componentes para usar DietApiService
  - Remover importação de mocks
  - Injetar serviço
  - Usar observables/promises

#### Testes E2E
- [ ] Testar fluxo completo:
  - Frontend carrega dados da API
  - Visualizar dietas
  - Filtrar refeições
  - Tratar erros de conexão

#### Tratamento de Erros
- [ ] Implementar fallback em caso de erro na API
- [ ] Mostrar mensagens amigáveis ao usuário
- [ ] Log de erros para debugging

---

## 🔗 Referências

- [AWS Lambda Proxy Integration](https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html)
- [DynamoDB Node.js SDK](https://docs.aws.amazon.com/sdk-for-javascript/latest/developer-guide/dynamodb-examples.html)
- [Lambda Environment Variables](https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html)

---

**Criado em:** 2026-07-19  
**Última atualização:** 2026-07-19
