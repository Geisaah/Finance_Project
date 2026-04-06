/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-06-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@RestResource(urlMapping='/CreditAnalysis/*')
global with sharing class CreditAnalysisResourceAPI {

    // Esta é a nossa "Bandeja" de dados (Objeto JSON)
    global class ResponseWrapper {
        public String status;
        public String message;
        public String recordId;
        public Integer errorCode;
    }

    @HttpPost
    global static ResponseWrapper createAnalysis(String name, Integer age, Decimal income, Decimal requestedAmount) {
        ResponseWrapper res = new ResponseWrapper();
        
        try {
            // Validação de Idade (Nossa regra de segurança)
            if (age < 18 || age > 120) {
                res.status = 'Error';
                res.message = 'Idade inválida: deve ser entre 18 e 120 anos.';
                res.errorCode = 400;
                return res;
            }

            // Criação do Registro
            Credit_Analysis_c__c newAnalysis = new Credit_Analysis_c__c(
                Nome_do_Cliente__c = name,
                Idade_Age__c = age,
                Renda_mensal__c = income,
                Valor_solicitado__c = requestedAmount
            );

            insert newAnalysis;

            // Resposta de Sucesso Estruturada
            res.status = 'Success';
            res.message = 'Análise de crédito enviada com sucesso para processamento.';
            res.recordId = newAnalysis.Id;
            res.errorCode = null;

        } catch (Exception e) {
            res.status = 'Fatal Error';
            res.message = 'Erro interno: ' + e.getMessage();
            res.errorCode = 500;
        }

        return res;
    }
}