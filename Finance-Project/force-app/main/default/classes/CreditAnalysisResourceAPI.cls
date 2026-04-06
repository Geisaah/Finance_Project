/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-06-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@RestResource(urlMapping='/CreditAnalysis/*')
global with sharing class CreditAnalysisResourceAPI {

    @HttpPost
    global static String createAnalysis(
        String nomeCliente, 
        Integer idade, 
        Decimal renda, 
        Decimal valorSolicitado
    ) {
        try {
            // USANDO O NOME REAL DA SUA API: Credit_Analysis_c__c
            Credit_Analysis_c__c novaAnalise = new Credit_Analysis_c__c();
            
            novaAnalise.Nome_do_Cliente__c = nomeCliente;
            novaAnalise.Idade_Age__c = idade;
            novaAnalise.Renda_mensal__c = renda;
            novaAnalise.Valor_solicitado__c = valorSolicitado;

            insert novaAnalise;

            return 'Sucesso! Registro criado com ID: ' + novaAnalise.Id;
            
        } catch (Exception e) {
            return 'Erro ao processar API: ' + e.getMessage();
        }
    }
}