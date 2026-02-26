public with sharing class SiteVisitController {

    @AuraEnabled
    public static Id createSiteVisit(Site_Visit__c siteVisit) {
        insert siteVisit;
        return siteVisit.Id;
    }
}