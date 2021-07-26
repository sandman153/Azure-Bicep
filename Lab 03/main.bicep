param location string = resourceGroup().location
param storageAccountName string = 'sbtl${uniqueString(resourceGroup().id)}'
param appServiceName string = 'sbtl${uniqueString(resourceGroup().id)}'
@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var appServicePlanName = 'sbttoy-plan'
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2_v3' : 'F1'
var appServicePlanTierName = (environmentType == 'prod') ? 'PremiumV3':'Free'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  sku:{
    name:storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
    tier: appServicePlanTierName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2021-01-15' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly:true
  }
}
