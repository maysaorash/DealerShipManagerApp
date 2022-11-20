@isTest
public with sharing class VisitAgentTriggerHandlerTest {
    @TestSetup
    static void prepData(){
        DealershipManager__c dealership = new DealershipManager__c();
        dealership.name = 'Test dealership';
        dealership.Email__c = 'testemail@test.com';
        dealership.Phone__c = '09901234567';
        
        insert dealership;

        Visit__c visit = new Visit__c(DealershipManager__c = dealership.id,
                                    name__c = 'Test Visit', 
                                    Start_Date_Time__c = Datetime.now().addDays(1),
                                    Max_Place__c = 10,
                                    Live__c = true
        );
insert visit;

Agent__c agent = new Agent__c(name = 'test agent',
                                    Email__c = 'testagent@test.com',
                                    Phone__c = '98761234567'
);

insert agent;
visit_Agent__c visitagent = new visit_Agent__c(Visit__c=visit.id, 
                                                    Agent__c = agent.id
                                                    );
insert visitagent;
    }
    @isTest
    static void testSucces(){
        list<visit_Agent__c> systemRecord = [select Visit__c, Agent__c from visit_Agent__c limit 1];
        test.startTest();
        visitAgentTriggerHandler.validateVisitAgent(systemRecord);
        test.stopTest();
    system.assertEquals(1, systemRecord.size());
    }

    @isTest
    static void testNegative(){
        delete [select id from visit_Agent__c];
        Visit__c visit =[select id from Visit__c limit 1];
        Agent__c agent = [select id from Agent__c limit 1];
        visit_Agent__c listvisit = new visit_Agent__c(Visit__c = visit.id,
                                                    Agent__c=agent.id
                                                    );
            // insert listvisit;
        Test.startTest();
        // insert new visit_Agent__c(Visit__c = visit.id,
        //                             Agent__c=agent.id
        //                             );
        insert listvisit;
        test.stopTest();

        integer count = [select count() from visit_Agent__c];
        system.assertEquals(1, count);
    }
}
