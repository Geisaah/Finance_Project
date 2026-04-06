/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-06-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class CreditAnalysisService {
    public static void calculateCreditScore(List<Credit_Analysis_c__c> newAnalyses) {
        for (Credit_Analysis_c__c ana : newAnalyses) {
            if (ana.Renda_mensal__c != null && ana.Valor_solicitado__c != null && ana.Valor_solicitado__c > 0) {
                Decimal ratio = ana.Renda_mensal__c / ana.Valor_solicitado__c;
                
                if (ratio >= 4) {
                    ana.Score_de_Cr_dito_Credit_Score__c = 100; 
                    ana.Nivel_de_risco_Risk_Level__c = 'Low';
                    ana.Status__c = 'Approved';
                } else if (ratio >= 2) {
                    ana.Score_de_Cr_dito_Credit_Score__c = 50;
                    ana.Nivel_de_risco_Risk_Level__c = 'Medium';
                    ana.Status__c = 'Approved';
                } else {
                    ana.Score_de_Cr_dito_Credit_Score__c = 10;
                    ana.Nivel_de_risco_Risk_Level__c = 'High';
                    ana.Status__c = 'Rejected';
                }
            }
        }
    }
}