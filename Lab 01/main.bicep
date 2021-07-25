resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name:'sbtoylaunchstorage'
  location:'australiaeast'
  sku:{
    name:'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
