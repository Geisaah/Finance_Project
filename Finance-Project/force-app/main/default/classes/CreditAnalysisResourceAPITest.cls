/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-09-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
private class CreditAnalysisResourceAPITest {

    @isTest
    static void testCreateAnalysisSuccess() {
        // Criando o Wrapper para um cenário de SUCESSO
        CreditAnalysisResourceAPI.RequestWrapper req = new CreditAnalysisResourceAPI.RequestWrapper();
        req.name = 'Geisa Test';
        req.age = 33;
        req.income = 5000;
        req.requestedAmount = 1000;
        req.email = 'geisaahfreitas@gmail.com';

        Test.startTest();
        CreditAnalysisResourceAPI.ResponseWrapper res = CreditAnalysisResourceAPI.createAnalysis(req);
        Test.stopTest();

        // Aqui o status deve ser 'Success'
        System.assertEquals('Success', res.status, 'Deveria retornar status de sucesso');
        System.assertNotEquals(null, res.recordId, 'O ID do registro não deveria ser nulo');
    }

    @isTest
    static void testCreateAnalysisInvalidAge() {
        // Criando o Wrapper para um cenário de ERRO (Idade 500)
        CreditAnalysisResourceAPI.RequestWrapper req = new CreditAnalysisResourceAPI.RequestWrapper();
        req.name = 'Test Erro';
        req.age = 500; 
        req.income = 5000;
        req.requestedAmount = 1000;
        req.email = 'erro@teste.com';

        Test.startTest();
        // AGORA SIM: Passando o 'req' em vez de String, Integer...
        CreditAnalysisResourceAPI.ResponseWrapper res = CreditAnalysisResourceAPI.createAnalysis(req);
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

        List<Credit_Analysis_c__c> resultados = [SELECT Id FROM Credit_Analysis_c__c];
        System.assertEquals(200, resultados.size(), 'Deveria ter criado 200 registros');
    }
}