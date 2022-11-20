public with sharing class VisitAgentTriggerHandler {

    public static void validateVisitAgent(List<Visit_Agent__c> visitAgents){
        set<id> setVisitIds = new set<id>();
        set<id> setAgentIds = new set<id>();
        map<string, Visit_Agent__c> visitAgentMap = new map<string, Visit_Agent__c>();

for(Visit_Agent__c eachVA: visitAgents){
        setVisitIds.add(eachVA.visit__c);  
        setAgentIds.add(eachVA.agent__c);  
        
        string myKey = string.valueOf(eachVA.agent__c) + string.valueOf(eachVA.visit__c);
        visitAgentMap.put(myKey, eachVA);
    } 
    system.debug(setVisitIds);
    system.debug(setAgentIds);

list<Visit_Agent__c> vaList = [select id, agent__c, visit__c  from Visit_Agent__c where visit__c in : setVisitIds and agent__c in : setAgentIds ];

for(Visit_Agent__c eachVA: vaList){
    string agKey = string.valueOf(eachVA.agent__c) + string.valueOf(eachVA.visit__c);
    Visit_Agent__c  visitAgent = visitAgentMap.get(agKey);
    if(visitAgent != null){
        visitAgent.addError(' This is not allowed, it is dublicate.');
    } 
}
}
} 