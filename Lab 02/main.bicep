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

resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: 'sb-toy-product-launch-starter'
  location: 'australiaeast'
  sku: {
    name: 'F1'
    tier: 'Free'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2021-01-15' = {
  name: 'sb-toy-product-launch-1'
  location: 'australiaeast'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly:true
  }
}
