/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-06-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger CreditAnalysisTrigger on Credit_Analysis_c__c (before insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
        // Passamos a lista completa (Bulk)
        CreditAnalysisService.calculateCreditScore(Trigger.new);
    }
}