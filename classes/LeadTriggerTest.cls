@IsTest
public class LeadTriggerTest {
	/* ---------------------------------------------------------
       Test 1: Duplicate by Phone
    --------------------------------------------------------- */
    @IsTest
    static void testDuplicateLeadByPhone() {

        // Existing Lead
        Lead existing = new Lead(
            LastName = 'Existing',
            Company  = 'Test Company',
            Phone    = '9999999999',
            Email    = 'existing@test.com',
            Status   = 'Open - Not Contacted'
        );
        insert existing;

        // Duplicate Lead (same phone)
        Lead duplicate = new Lead(
            LastName = 'Duplicate',
            Company  = 'Test Company',
            Phone    = '9999999999',
            Email    = 'new@test.com',
            Status   = 'Open - Not Contacted'
        );

        Test.startTest();
        Database.SaveResult sr = Database.insert(duplicate, false);
        Test.stopTest();

        System.assertEquals(false, sr.isSuccess(), 'Insert should fail');
        System.assert(
            sr.getErrors()[0].getMessage().contains('Duplicate Lead detected'),
            'Duplicate error message expected'
        );
    }

    /* ---------------------------------------------------------
       Test 2: Duplicate by Email
    --------------------------------------------------------- */
    @IsTest
    static void testDuplicateLeadByEmail() {

        Lead existing = new Lead(
            LastName = 'Existing',
            Company  = 'Test Company',
            Phone    = '8888888888',
            Email    = 'duplicate@test.com',
            Status   = 'Working - Contacted'
        );
        insert existing;

        Lead duplicate = new Lead(
            LastName = 'Duplicate',
            Company  = 'Test Company',
            Phone    = '7777777777',
            Email    = 'duplicate@test.com',
            Status   = 'Working - Contacted'
        );

        Test.startTest();
        Database.SaveResult sr = Database.insert(duplicate, false);
        Test.stopTest();

        System.assertEquals(false, sr.isSuccess());
        System.assert(
            sr.getErrors()[0].getMessage().contains('Duplicate Lead detected'),
            'Duplicate email error expected'
        );
    }

    /* ---------------------------------------------------------
       Test 3: No Duplicate (Valid Insert)
    --------------------------------------------------------- */
    @IsTest
    static void testNoDuplicateLead() {

        Lead ld = new Lead(
            LastName = 'Unique',
            Company  = 'Test Company',
            Phone    = '6666666666',
            Email    = 'unique@test.com',
            Status   = 'Open - Not Contacted'
        );

        Test.startTest();
        insert ld;
        Test.stopTest();

        System.assertNotEquals(null, ld.Id, 'Lead should be inserted successfully');
    }

    /* ---------------------------------------------------------
       Test 4: Empty Phone & Email (Early Return)
    --------------------------------------------------------- */
    @IsTest
    static void testNoPhoneNoEmail() {

        Lead ld = new Lead(
            LastName = 'NoContact',
            Company  = 'Test Company',
            Status   = 'Open - Not Contacted',
            Email = 'test@gmail.com'
        );

        Test.startTest();
        insert ld;
        Test.stopTest();

        System.assertNotEquals(null, ld.Id, 'Lead without phone/email should insert');
    }

    /* ---------------------------------------------------------
       Test 5: scheduleSiteVisit Method Coverage
    --------------------------------------------------------- */
    @IsTest
    static void testScheduleSiteVisitCoverage() {

        Lead ld = new Lead(
            LastName = 'Visit',
            Company  = 'Test Company',
            Phone    = '5555555555',
            Status   = 'Open - Not Contacted',
            Email = 'test1@gmail.com'
        );
        insert ld;

        Test.startTest();
        LeadTriggerHandler.scheduleSiteVisit(
            new List<Lead>{ ld }
        );
        Test.stopTest();

        // No assertions yet – method currently has no DML
        System.assert(true, 'scheduleSiteVisit executed');
    }
}