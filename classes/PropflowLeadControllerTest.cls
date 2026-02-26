@IsTest
public class PropflowLeadControllerTest {
	@IsTest
    static void testCreateLead_success() {

        // Prepare input map (simulating LWC/Aura payload)
        Map<String, Object> leadRec = new Map<String, Object>();
        leadRec.put('FirstName', 'Test');
        leadRec.put('LastName', 'User');
        leadRec.put('Phone', '9876543210');
        leadRec.put('Email', 'testuser@example.com');
        leadRec.put('Company', 'SF Cloud Apps');
        leadRec.put('Unit_Type__c', '2BHK');

        Integer budget = 50;
        Integer timeline = 3;

        Test.startTest();

        // Call controller method
        Id leadId = PropflowLeadController.createLead(
            leadRec,
            budget,
            timeline
        );

        Test.stopTest();

        // Fetch created Lead
        Lead insertedLead = [
            SELECT FirstName, LastName, Phone, Email, Company,
                   Budget_Range__c, Purchase_Timeline__c,
                   Unit_Type__c, Qualified__c, Status
            FROM Lead
            WHERE Id = :leadId
            LIMIT 1
        ];

        // Assertions
        System.assertNotEquals(null, insertedLead, 'Lead should be created');
        System.assertEquals('Test', insertedLead.FirstName);
        System.assertEquals('User', insertedLead.LastName);
        System.assertEquals('9876543210', insertedLead.Phone);
        System.assertEquals('testuser@example.com', insertedLead.Email);
        System.assertEquals('SF Cloud Apps', insertedLead.Company);
        System.assertEquals(50, insertedLead.Budget_Range__c);
        System.assertEquals(3, insertedLead.Purchase_Timeline__c);
        System.assertEquals('2BHK', insertedLead.Unit_Type__c);
        System.assertEquals('New', insertedLead.Qualified__c);
        System.assertEquals('New', insertedLead.Status);
    }
}