public class EmailMessageSubjectHandler {
    public static void addCaseNumberPrefix(List<EmailMessage> emailMessages) {
        
        Set<Id> caseIds = new Set<Id>();
        
        // Collect Case Ids
        for (EmailMessage em : emailMessages) {
            if (em.ParentId != null &&
                em.ParentId.getSObjectType() == Case.SObjectType) {
                    caseIds.add(em.ParentId);
                }
        }
        
        if (caseIds.isEmpty()) return;
        
        // Query related Cases
        Map<Id, Case> caseMap = new Map<Id, Case>(
            [SELECT Id, CaseNumber FROM Case WHERE Id IN :caseIds]
        );
        
        for (EmailMessage em : emailMessages) {
            
            Case c = caseMap.get(em.ParentId);
            if (c == null) continue;
            
            String caseNumber = c.CaseNumber;
            
            // ✅ If subject already contains case number → DO NOTHING
            if (!String.isBlank(em.Subject) &&
                em.Subject.contains(caseNumber)) {
                    continue;
                }
            
            String prefix = 'Case ' + caseNumber + ': ';
            
            if (String.isBlank(em.Subject)) {
                em.Subject = prefix;
            } else {
                em.Subject = prefix + em.Subject;
            }
        }
    }
    
}