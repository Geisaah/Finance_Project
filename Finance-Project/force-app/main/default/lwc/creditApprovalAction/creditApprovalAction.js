import { LightningElement, api } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreditApprovalAction extends LightningElement {
    @api recordId;

    handleApprove() { this.processAction('Approved'); }
    handleReject() { this.processAction('Rejected'); }

    processAction(newStatus) {
        // 1. Preparamos os dados exatamente como o Salesforce quer
        const fields = {};
        fields['Id'] = this.recordId;
        fields['Status__c'] = newStatus; 

        const recordInput = { fields };

        // 2. Chamamos a atualização
        updateRecord(recordInput)
            .then(() => {
                // 3. Mostramos o balãozinho de sucesso
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Sucesso!',
                        message: 'O status agora é: ' + newStatus,
                        variant: 'success'
                    })
                );
                
                // 4. O PULO DO GATO: Forçar a página a atualizar os dados
                // Sem isso, a página recarrega mas mostra o dado antigo que está no cache
                setTimeout(() => {
                    eval("$A.get('e.force:refreshView').fire();");
                    location.reload();
                }, 1000);
            })
            .catch(error => {
                console.error('Erro ao atualizar:', error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Erro',
                        message: 'Não foi possível atualizar. Tente novamente.',
                        variant: 'error'
                    })
                );
            });
    }
}