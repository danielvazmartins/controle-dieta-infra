# Spec: Repositório e Código da Lambda

## 📋 Descrição

Criar novo repositório com código Node.js/TypeScript para a função Lambda que atende os endpoints da API.

**Status:** 🚀 Planejado

## 🎯 Objetivo

Implementar handlers, services e modelos de dados para servir dados de dietas e refeições via Lambda.

## 📁 Estrutura do Projeto

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

## ✅ Tarefas

### Setup Inicial
- [ ] Criar repositório GitHub `controle-dieta-lambda`
- [ ] Clonar repositório localmente
- [ ] Estruturar pastas (src/, dist/, etc)

### Configuração
- [ ] Configurar `package.json` com scripts (build, dev, test)
- [ ] Configurar `tsconfig.json` com target ES2020
- [ ] Instalar dependências (aws-sdk, typescript, ts-node, jest)

### Modelos de Dados
- [ ] Criar `src/models/Diet.ts` com interface Diet
- [ ] Criar `src/models/Meal.ts` com interface Meal

### Serviços DynamoDB
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

### Handlers
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

### Index Handler
- [ ] Criar `src/index.ts`
  - Exportar função `handler` (AWS Lambda Proxy Integration)
  - Rotear requisições para handlers apropriados

### Seed Data
- [ ] Criar script `src/seed.ts`
  - Migrar dados dos mocks para DynamoDB

### Build e Teste
- [ ] Executar `npm run build`
- [ ] Testar localmente com `npm run dev`

---

**Criado em:** 2026-07-19
