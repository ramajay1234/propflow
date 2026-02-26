public with sharing class PropflowLeadController {

    @AuraEnabled
    public static Id createLead(Map<String, Object> leadRec, Integer budget, Integer timeline) {

        Lead l = new Lead();
        l.FirstName = (String)leadRec.get('FirstName');
        l.LastName = (String)leadRec.get('LastName');
        l.Phone = (String)leadRec.get('Phone');
        l.Email = (String)leadRec.get('Email');
        l.Company = (String)leadRec.get('Company');
        l.Budget_Range__c = budget;//(Integer)leadRec.get('Budget_Range__c');
        l.Purchase_Timeline__c = timeline;//(Integer)leadRec.get('Purchase_Timeline__c');
        l.Unit_Type__c = (String)leadRec.get('Unit_Type__c');
        l.Qualified__c = 'New';
        //l.Site_Visit_Status__c = (String)leadRec.get('Site_Visit_Status__c');
        //l.Qualified__c = (Boolean)leadRec.get('Qualified__c');
        l.Status = 'New';

        insert l;
        return l.Id;
    }
}