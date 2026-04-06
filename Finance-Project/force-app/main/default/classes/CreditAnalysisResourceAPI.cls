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
    global static String createAnalysis(String nomeCliente, Integer idade, Decimal renda, Decimal valorSolicitado) {
        
        // --- VALIDAÇÕES DE SEGURANÇA (O FILTRO) ---
        if (String.isBlank(nomeCliente)) {
            return 'Erro: O nome do cliente é obrigatório.';
        }
        if (idade <= 0 || idade > 120) {
            return 'Erro: Idade inválida.';
        }
        if (renda < 0 || valorSolicitado <= 0) {
            return 'Erro: Renda ou Valor Solicitado não podem ser negativos/zero.';
        }

        try {
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