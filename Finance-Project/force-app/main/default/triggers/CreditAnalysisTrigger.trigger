/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-06-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger CreditAnalysisTrigger on Credit_Analysis_c__c (after insert) {
    List<Id> idsToProcess = new List<Id>();
    for (Credit_Analysis_c__c record : Trigger.new) {
        idsToProcess.add(record.Id);
    }
    CreditAnalysisService.calculateCreditScore(idsToProcess);
}