public with sharing class PropFlowLicenseController {

    @AuraEnabled(cacheable=true)
    public static List<PropFlowAppLicense__mdt> getLicenses() {
        return [
            SELECT Id,
            License_Type__c,
            Customer_Name__c,
            CustomerId__c,
            ExpiryDate__c, PropFlowCRM__c,
            PropFlowMaintenance__c,PropFlowProjects__c 
            FROM PropFlowAppLicense__mdt
            ORDER BY Customer_Name__c
        ];
    }
}