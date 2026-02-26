public with sharing class RealEstateLeadController {

    @AuraEnabled(cacheable=true)
    public static Lead getLead(Id leadId) {
        return [
            SELECT Id, FirstName, LastName, Phone, Email
            FROM Lead WHERE Id = :leadId
        ];
    }
    public List<String> getProjectsByLocation() {
        List<String> picklistValues = new List<String>();
        
        // 1. Get the describe result for the field
        Schema.DescribeFieldResult fieldResult = SFCloudApps__Project__c.SFCloudApps__Locations__c .getDescribe();
        
        // 2. Get the picklist values
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        // 3. Iterate through and add labels to the list
        for (Schema.PicklistEntry pickListVal : ple) {
            // Use pickListVal.getValue() for API name, getLabel() for display name
            picklistValues.add(pickListVal.getLabel());
        }
        return picklistValues;
    }

    @AuraEnabled(cacheable=true)
    public static InventoryDTO getTowerInventory(Id projectId) {
        // Query Towers, Floors, Units in ONE GO
        // Build DTO hierarchy in Apex
        // (I can expand this fully when you start coding)
        return new InventoryDTO();
    }
    @AuraEnabled(cacheable=true)
    public static InventoryDTO getProjects(string location) {
        list<SFCloudApps__Project__c> projects = [SELECT Id, SFCloudApps__Project_Code__c, 
                                                  SFCloudApps__Start_Date__c, SFCloudApps__Planned_Handover_Date__c, 
                                                  SFCloudApps__Status__c, SFCloudApps__Developer__c, 
                                                  SFCloudApps__Total_Units__c, SFCloudApps__Current_Completion__c, 
                                                  SFCloudApps__Amenities__c, SFCloudApps__Country__c, SFCloudApps__State__c,
                                                  SFCloudApps__Locations__c FROM SFCloudApps__Project__c WHERE SFCloudApps__Locations__c=:location];
        for(SFCloudApps__Project__c prj: projects) {
            
        }
        return new InventoryDTO();
    }
    @AuraEnabled(cacheable=true)
    public static InventoryDTO getTowers(Id projectId) {
        // Query Towers, Floors, Units in ONE GO
        // Build DTO hierarchy in Apex
        // (I can expand this fully when you start coding)
        return new InventoryDTO();
    }
}