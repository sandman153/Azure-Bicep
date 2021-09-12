param location string
param appServiceAppName string

@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var appServicePlanName = 'sbttoy-plan'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2_v3' : 'F1'
var appServicePlanTierName = (environmentType == 'prod') ? 'PremiumV3':'Free'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
    tier: appServicePlanTierName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2021-01-15' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly:true
  }
}
output appServiceAppHostName string = appServiceApp.properties.defaultHostName
