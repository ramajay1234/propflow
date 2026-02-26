public class LeadTriggerHandler {
	public static void preventDuplicates(List<Lead> newLeads) {

        Set<String> phones = new Set<String>();
        Set<String> emails = new Set<String>();

        // Collect Phone & Email from incoming leads
        for (Lead ld : newLeads) {
            if (ld.Phone != null) {
                phones.add(ld.Phone.trim());
            }
            if (ld.Email != null) {
                emails.add(ld.Email.toLowerCase().trim());
            }
        }

        if (phones.isEmpty() && emails.isEmpty()) {
            return;
        }

        // Query existing leads
        List<Lead> existingLeads = [
            SELECT Id, Phone, Email
            FROM Lead
            WHERE Phone IN :phones
               OR Email IN :emails
        ];

        // Create lookup sets
        Set<String> existingPhones = new Set<String>();
        Set<String> existingEmails = new Set<String>();

        for (Lead ex : existingLeads) {
            if (ex.Phone != null) {
                existingPhones.add(ex.Phone.trim());
            }
            if (ex.Email != null) {
                existingEmails.add(ex.Email.toLowerCase().trim());
            }
        }

        // Validate duplicates
        for (Lead ld : newLeads) {
            if (
                (ld.Phone != null && existingPhones.contains(ld.Phone.trim())) ||
                (ld.Email != null && existingEmails.contains(ld.Email.toLowerCase().trim()))
            ) {
                ld.addError('Duplicate Lead detected. Phone or Email already exists.');
            }
        }
    }
    public static void scheduleSiteVisit(list<lead> newLeads) {
        
        list<SFCloudApps__Lead_Discussion__c > leadDisc = new list<SFCloudApps__Lead_Discussion__c>();
        for(Lead ld: newLeads) {
            if((ld.Status == 'Open - Not Contacted' || ld.Status == 'Working - Contacted') && ld.Phone != null) {
                string visitlink = '';
            }
        }
        
    }
}