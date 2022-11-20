trigger VisitAgent on Visit_Agent__c (before insert, before update) {
    if(Trigger.isBefore){
    if(trigger.isInsert || trigger.isUpdate){
        VisitAgentTriggerHandler.validateVisitAgent(trigger.new);
    }
    }
}  
