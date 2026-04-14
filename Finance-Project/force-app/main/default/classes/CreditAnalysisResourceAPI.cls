/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-10-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@RestResource(urlMapping='/CreditAnalysis/*')
global with sharing class CreditAnalysisResourceAPI {

    global class RequestWrapper {
        public String name;
        public integer age;
        public Decimal income;
        public Decimal requestedAmount;
        public String email;
    }
    // Esta é a nossa "Bandeja" de dados (Objeto JSON)
    global class ResponseWrapper {
        public String status;
        public String message;
        public String recordId;
        public Integer errorCode;
    }
    @HttpPost
    global static ResponseWrapper createAnalysis(RequestWrapper req) {
        ResponseWrapper res = new ResponseWrapper();
        
        try {
            // Validação de Idade (Nossa regra de segurança)
            if (req.age < 18 || req.age > 79) {
                res.status = 'Error';
                res.message = 'Idade inválida: deve ser entre 18 e 79 anos.';
                res.errorCode = 400;
                return res;
            }

            // Criação do Registro
            Credit_Analysis_c__c newAnalysis = new Credit_Analysis_c__c(
                Nome_do_Cliente__c = req.name,
                Idade_Age__c = req.age,
                Renda_mensal__c = req.income,
                Valor_solicitado__c = req.requestedAmount,
                Client_Email__c = req.email
            );
   

            insert newAnalysis;

            // Resposta de Sucesso Estruturada
            res.status = 'Success';
            res.message = 'Análise de crédito enviada com sucesso para processamento.';
            res.recordId = newAnalysis.Id;
            res.errorCode = null;

        } catch (Exception e) {
            res.status = 'Fatal Error';
            res.message = 'Internal error: ' + e.getMessage();
            res.errorCode = 500;
        }

        return res;
    }
}