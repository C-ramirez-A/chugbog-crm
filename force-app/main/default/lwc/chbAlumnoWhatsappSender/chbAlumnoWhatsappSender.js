import { LightningElement, api } from 'lwc';
import sendWhatsAppToAlumno from '@salesforce/apex/ChbWhatsAppService.sendWhatsAppToAlumno';

export default class ChbAlumnoWhatsappSender extends LightningElement {

    @api recordId;
    message='';

    handleMessageChange(event){
        this.message= event.target.value;
    }

    handleSend(){
        if(!this.recordId){
            console.log('no hay alumno');
            return;
        }
        if(!this.message){
            console.log('no hay mensaje');
            return;
        }
        else{
            sendWhatsAppToAlumno({ alumnId: this.recordId, messageBody: this.message}).then(result=>{
            if( result== null){
                console.log('error con algun dato de la cuenta'+result);
            }
            else{console.log('mensaje enviado');}
            
            
        }).catch(error=>{
            console.error(error);
        });
        }
        
    }

}