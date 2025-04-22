# Configuração do GitHub Actions para Terraform no Azure

Este documento explica como configurar os segredos necessários para executar a pipeline de CI/CD do Terraform utilizando GitHub Actions.

## Configuração do Terraform State Remoto

O projeto está configurado para usar um Azure Storage Account como backend remoto para o estado do Terraform. Antes de executar a pipeline principal, é necessário executar o processo de bootstrap para criar a infraestrutura necessária para o armazenamento do estado.

### Processo de Bootstrap

1. Para criar os recursos necessários para o Terraform State remoto, execute o workflow manualmente com a opção "workflow_dispatch" no GitHub Actions
2. Isso irá:
   - Criar um resource group chamado `terraform-state-rg`
   - Criar uma Storage Account chamada `tfstatehumbleiaca`
   - Criar um container chamado `tfstate`
   - Aplicar um bloqueio de gerenciamento para proteção contra exclusão acidental

### Como executar o bootstrap manualmente

Se preferir, pode executar o bootstrap localmente:

```bash
cd iac-demo/bootstrap
terraform init
terraform apply
```

Observe as saídas para obter o nome da Storage Account, container e a chave de acesso.

## Segredos Necessários

Para que o workflow funcione corretamente, você precisa configurar os seguintes segredos no seu repositório GitHub:

### Segredos para autenticação no Azure

1. `AZURE_CLIENT_ID`: O ID do cliente da aplicação do Azure AD
2. `AZURE_TENANT_ID`: O ID do tenant do Azure AD
3. `AZURE_SUBSCRIPTION_ID`: O ID da assinatura do Azure

## Como configurar os segredos

1. Vá para seu repositório no GitHub
2. Navegue até "Settings" > "Secrets and variables" > "Actions"
3. Clique em "New repository secret"
4. Adicione cada um dos segredos listados acima com seus valores correspondentes

## Configurar Ambientes no GitHub

Para aproveitar a funcionalidade de aprovação para o ambiente de produção:

1. No GitHub, vá para seu repositório
2. Navegue até "Settings" > "Environments"
3. Crie dois ambientes: `dev` e `prod`
4. No ambiente `prod`, habilite a opção "Required reviewers" e adicione os usuários que precisam aprovar os deployments para produção

## Fluxo do CI/CD

- **Pull Request**: O workflow executará `terraform plan` e comentará o plano na PR
- **Push para main**: O workflow executará automaticamente:
  1. `terraform plan` e `terraform apply` para o ambiente de desenvolvimento
  2. Aguardará aprovação manual para o ambiente de produção
  3. Após aprovação, aplicará as alterações no ambiente de produção

## Migração do Estado Existente

Se você já possui arquivos de estado local para sua infraestrutura, pode migrá-los para o backend remoto utilizando o seguinte comando:

```bash
terraform init -migrate-state
```

Quando solicitado, confirme a migração do estado local para o backend remoto.

## Notas Importantes

- Certifique-se de que a aplicação do Azure AD tenha permissões suficientes para criar e gerenciar recursos
- Os ambientes no GitHub devem ser configurados antes de executar o workflow
- Para o uso de OIDC no Azure, configure a federação de identidades no Azure AD para o GitHub Actions
- O workflow obtém automaticamente a chave da Storage Account para autenticação do backend remoto