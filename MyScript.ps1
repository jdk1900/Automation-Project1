<#what does this script:
It uses the For loop to create three different RGs with a specific name convention.
After the RGs have been created, the next step is to run 4 different PS functions.
Each function creates a Variable Group and some variables needed later for the YAML code in the Pipeline.
Also, in each function we need to include the PAT token#>

#First create the three RGs with the For loop:

$myResourceGroupName = "test-rg"
Get-AzResourceGroup -Name $myResourceGroupName -ErrorVariable notPresent -ErrorAction SilentlyContinue

For (($i = 1); ($i -lt 4); $i++)
{

     New-AzResourceGroup `
     -Name ($myResourceGroupName + $i) `
     -Location westeurope
}

<#Now we will use this function to create a Variable Group which will contain only the Common Variables like location (used to define the location for all the resources) and the subscriptionId.#>

Function New-VariableGroup-Common ($groupName, $groupDescription,#Define Group Variable Name and Group Description. 
                            $variableLocation, $variableLocationValue,#Define location variable and value for Common Group Variable 
                            $variableSubscriptionId, $variableSubscriptionIdValue <#Define subscriptionId variable and value.#> ) {

$organizationName = "dimitriskrallis0042"
$projectName = "MyAutomationProject"
$personalAccessToken = "jjjhjhjhjhjhjhjhjh"


$variableGroupsUri = "https://dev.azure.com/" + $organizationName + "/" + $projectName + "/_apis/distributedtask/variablegroups?api-version=5.1-preview.1"
$base64AuthInfo    = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "", $personalAccessToken)))
    $body = @{
 
        type        = "Vsts"
        name        = $groupName
        description = $groupDescription
        variables   = @{$variableLocation = $variableLocationValue
                        $variableSubscriptionId = $variableSubscriptionIdValue }
 
    }
 
    $json = $body | ConvertTo-Json
         
    Invoke-RestMethod -Uri $variableGroupsUri -Method POST -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo) } -Body $json
 
}

New-VariableGroup-Common CommonVariables Variables-For-CommonUse var_location westeurope var_subscriptionId 11111-1111-1111-1111-11

<#The following function will create the Group Variable in the Library which will be used for reference for the first Resource Group.
Inside this Variable Group,we will need to declare two variables: the keyvault name and the Resource Group where the keyvault will be deployed to.#>

Function New-VariableGroup-RG1 ($groupName, $groupDescription,#Define Group Variable Name and Group Description for RG1 Group Variable
                                $variableKeyVaultName, $variableKeyVaultNameValue, #Define KeyVault Variable Name and value for TestA-RG Group Variable
                                $variableResourceGroupName, $variableResourceGroupNameValue <#Define Resource Group Name and Value for RG1 Group Variable#>) {

$organizationName = "dimitriskrallis0042"
$projectName = "MyAutomationProject"
$personalAccessToken = "jhhhjjhjhhhjhjhjhhjh"


$variableGroupsUri = "https://dev.azure.com/" + $organizationName + "/" + $projectName + "/_apis/distributedtask/variablegroups?api-version=5.1-preview.1"
$base64AuthInfo    = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "", $personalAccessToken)))
    $body = @{
 
        type        = "Vsts"
        name        = $groupName
        description = $groupDescription
        variables   = @{$variableKeyVaultName = $variableKeyVaultNameValue
                        $variableResourceGroupName = $variableResourceGroupNameValue }
 
    }
 
    $json = $body | ConvertTo-Json
         
    Invoke-RestMethod -Uri $variableGroupsUri -Method POST -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo) } -Body $json
 
}
#We call the function and pass the parameters needed for the first RG:
New-VariableGroup-RG1 GroupVar-1 VariablesForRG1 KeyVaultName-1_var keyvaultA0015 RG-name-1_var test-rg1

<#The following function will create the Group Variable in the Library which will be used for reference for the second Resource Group.
Inside this Variable Group,we will need to declare two variables: the keyvault name and the Resource Group where the keyvault will be deployed to.#>

Function New-VariableGroup-RG2 ($groupName, $groupDescription,#Define Group Variable Name and Group Description for RG2 Group Variable
                                $variableKeyVaultName, $variableKeyVaultNameValue, #Define KeyVault Variable Name and value for RG2 Group Variable
                                $variableResourceGroupName, $variableResourceGroupNameValue <#Define Resource Group Name and Value for RG2 Group Variable#>) {

$organizationName = "dimitriskrallis0042"
$projectName = "MyAutomationProject"
$personalAccessToken = "hghghghhghghgghggg"


$variableGroupsUri = "https://dev.azure.com/" + $organizationName + "/" + $projectName + "/_apis/distributedtask/variablegroups?api-version=5.1-preview.1"
$base64AuthInfo    = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "", $personalAccessToken)))
    $body = @{
 
        type        = "Vsts"
        name        = $groupName
        description = $groupDescription
        variables   = @{$variableKeyVaultName = $variableKeyVaultNameValue
                        $variableResourceGroupName = $variableResourceGroupNameValue }
 
    }
 
    $json = $body | ConvertTo-Json
         
    Invoke-RestMethod -Uri $variableGroupsUri -Method POST -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo) } -Body $json
 
}
#We call the function and pass the parameters needed for the second RG:
New-VariableGroup-RG2 GroupVar-2 GroupVariablesForRG2 KeyVaultName-2_var keyvaultA0016 RG-name-2_var test-rg2

<#The following function will create the Group Variable in the Library which will be used for reference for the third Resource Group.
Inside this Variable Group,we will need to declare two variables: the keyvault name and the Resource Group where the keyvault will be deployed to.#>

Function New-VariableGroup-RG3 ($groupName, $groupDescription,#Define Group Variable Name and Group Description for RG3 Group Variable
                                $variableKeyVaultName, $variableKeyVaultNameValue, #Define KeyVault Variable Name and value for RG3 Group Variable
                                $variableResourceGroupName, $variableResourceGroupNameValue <#Define Resource Group Name and Value for RG3 Group Variable#>) {

$organizationName = "dimitriskrallis0042"
$projectName = "MyAutomationProject"
$personalAccessToken = "hghghghgghg"


$variableGroupsUri = "https://dev.azure.com/" + $organizationName + "/" + $projectName + "/_apis/distributedtask/variablegroups?api-version=5.1-preview.1"
$base64AuthInfo    = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "", $personalAccessToken)))
    $body = @{
 
        type        = "Vsts"
        name        = $groupName
        description = $groupDescription
        variables   = @{$variableKeyVaultName = $variableKeyVaultNameValue
                        $variableResourceGroupName = $variableResourceGroupNameValue }
 
    }
 
    $json = $body | ConvertTo-Json
         
    Invoke-RestMethod -Uri $variableGroupsUri -Method POST -ContentType "application/json" -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo) } -Body $json
 
}
#We call the function and pass the parameters needed for the third RG:
New-VariableGroup-RG3 GroupVar-3 GroupVariablesForRG3 KeyVaultName-3_var keyvaultA0017 RG-name-3_var test-rg3