/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-06-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
private class CreditAnalysisResourceAPITest {

    @isTest
    static void testCreateAnalysisSuccess() {
        Test.startTest();
        // Chamada usando o novo retorno ResponseWrapper
        CreditAnalysisResourceAPI.ResponseWrapper res = CreditAnalysisResourceAPI.createAnalysis('Geisa Teste', 25, 5000.0, 1000.0);
        Test.stopTest();

        System.assertEquals('Success', res.status, 'Deveria retornar status de sucesso');
        System.assertNotEquals(null, res.recordId, 'O ID do registro não deveria ser nulo');
    }

    @isTest
    static void testCreateAnalysisInvalidAge() {
        Test.startTest();
        CreditAnalysisResourceAPI.ResponseWrapper res = CreditAnalysisResourceAPI.createAnalysis('Teste Erro', 500, 5000, 1000);
        Test.stopTest();

        System.assertEquals('Error', res.status, 'Deveria retornar status de erro');
        System.assertEquals(400, res.errorCode, 'O código de erro deveria ser 400');
    }

    @isTest
    static void testBulkCreditCreation() {
        List<Credit_Analysis_c__c> listaBulk = new List<Credit_Analysis_c__c>();
        
        for(Integer i=0; i<200; i++) {
            listaBulk.add(new Credit_Analysis_c__c(
                Nome_do_Cliente__c = 'Cliente Bulk ' + i,
                Idade_Age__c = 30,
                Renda_mensal__c = 5000,
                Valor_solicitado__c = 1000
            ));
        }

        Test.startTest();
        insert listaBulk;
        Test.stopTest();

        // Nome da API do campo que confirmamos no seu Setup
        List<Credit_Analysis_c__c> resultados = [SELECT Id, Score_de_Cr_dito_Credit_Score__c FROM Credit_Analysis_c__c];
        System.assertEquals(200, resultados.size(), 'Deveria ter criado 200 registros');
    }
}