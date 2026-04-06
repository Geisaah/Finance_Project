/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-06-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class CreditAnalysisService {

    @InvocableMethod(label='Calcular Score' description='Calcula o risco de crédito')
    public static void calculateCreditScore(List<Id> idsToProcess) {

        // Note o nome do objeto com _c__c e o nome do campo Score com o acento/caractere especial
        List<Credit_Analysis_c__c> records = [
            SELECT Id, Idade_Age__c, Renda_mensal__c, Valor_solicitado__c 
            FROM Credit_Analysis_c__c 
            WHERE Id IN :idsToProcess
        ];

        for (Credit_Analysis_c__c rec : records) {
            Decimal score = 0;

            // Regra 1: Renda
            if (rec.Renda_mensal__c > 5000) {
                score += 50;
            } else {
                score += 20;
            }

            // Regra 2: Valor solicitado
            if (rec.Valor_solicitado__c > 10000) {
                score -= 30;
            } else {
                score += 20;
            }

            // Regra 3: Idade
            if (rec.Idade_Age__c >= 25 && rec.Idade_Age__c <= 60) {
                score += 30;
            } else {
                score += 10;
            }

            // Atribuindo aos campos EXATOS da sua imagem
            rec.Score_de_Cr_dito_Credit_Score__c = score;
            
            if (score >= 80) {
                rec.Nivel_de_risco_Risk_Level__c = 'Low';
                rec.Status__c = 'Approved';
            } else if (score >= 50) {
                rec.Nivel_de_risco_Risk_Level__c = 'Medium';
                rec.Status__c = 'Pending';
            } else {
                rec.Nivel_de_risco_Risk_Level__c = 'High';
                rec.Status__c = 'Rejected';
            }
        }

        if (!records.isEmpty()) {
            update records;
        }
    }
}