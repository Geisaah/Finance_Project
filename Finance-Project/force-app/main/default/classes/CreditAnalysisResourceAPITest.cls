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
        // 1. CENÁRIO: Preparar os dados para o teste
        String nome = 'Geisa Teste';
        Integer idade = 25;
        Decimal renda = 5000.0;
        Decimal valor = 1000.0;

        // 2. AÇÃO: Chamar o método da sua API
        Test.startTest();
        String resultado = CreditAnalysisResourceAPI.createAnalysis(nome, idade, renda, valor);
        Test.stopTest();

        // 3. VERIFICAÇÃO: O Salesforce "conferindo" se deu certo
        System.assert(resultado.contains('Sucesso'), 'A API deveria retornar sucesso');
        
        // Conferindo se o registro realmente nasceu no banco de dados "de teste"
        // Lembre-se de usar o nome da sua API: Credit_Analysis_c__c
        Credit_Analysis_c__c analise = [SELECT Id, Status__c FROM Credit_Analysis_c__c LIMIT 1];
        System.assertNotEquals(null, analise.Id, 'O registro deveria ter sido criado');
    }
    @isTest
    static void testCreateAnalysisInvalidAge() {
        // Cenário: Tentando criar com idade impossível (500 anos)
        String resultado = CreditAnalysisResourceAPI.createAnalysis('Teste Erro', 500, 5000, 1000);

        // Verificação: O resultado TEM que conter a mensagem de erro que definimos
        System.assert(resultado.contains('Erro: Idade inválida'), 'A API deveria ter bloqueado a idade de 500 anos');
        
        // Garantindo que NENHUM registro foi criado no banco
        List<Credit_Analysis_c__c> lista = [SELECT Id FROM Credit_Analysis_c__c];
        System.assertEquals(0, lista.size(), 'Não deveria ter criado nenhum registro com dados inválidos');
    }
}