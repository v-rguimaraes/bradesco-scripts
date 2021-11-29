
RG="BRA-Simplifica-R$RANDOM"

location=brazilsouth

az group create --resource-group $RG --location $location

APPINSIGHTS_NAME="appinsightsbradescox$RANDOM"
APPSERVICE_PLAN="appserviceplanbradesco$RANDOM"
APPWEBAPP_NAME="webappbradesco$RANDOM"


az extension add -n application-insights

LOG_ANALYTICS_WORKSPACE="loganalyticsworkspacepocx$RANDOM"

MONITORINGLOGANALYTICSWORKSPACEID=$(az monitor log-analytics workspace create --resource-group $RG --location $location --workspace-name $LOG_ANALYTICS_WORKSPACE --query id -o tsv)

az monitor app-insights component create --app $APPINSIGHTS_NAME --resource-group $RG --application-type web --kind "web" --workspace $MONITORINGLOGANALYTICSWORKSPACEID --location $location

INSTRUMENTATIONKEY=$(az monitor app-insights component show --app $APPINSIGHTS_NAME --resource-group $RG --query instrumentationKey --output tsv)

az appservice plan create --name $APPSERVICE_PLAN --resource-group $RG --is-linux --location $location --sku S3

az webapp create --name $APPWEBAPP_NAME --plan $APPSERVICE_PLAN --resource-group $RG --deployment-container-image-name rogerioapp/rogerioapp:latest

az webapp config appsettings set --resource-group $RG --name $APPWEBAPP_NAME --settings APPINSIGHTS_INSTRUMENTATIONKEY=$INSTRUMENTATIONKEY APPLICATIONINSIGHTS_CONNECTION_STRING=InstrumentationKey=$INSTRUMENTATIONKEY ApplicationInsightsAgent_EXTENSION_VERSION=~2
