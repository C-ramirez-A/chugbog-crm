    import { LightningElement } from 'lwc';
    import getAlumnosByCC from '@salesforce/apex/ChbAttendanceController.getAlumnosByCC';
    import getInitialMessage from '@salesforce/apex/ChbConfigController.getInitialMessage';

 
    export default class ChbAttendanceQuick extends LightningElement {
        CC= '';
        alumno= null;
        initialMsg='';
        msg= 'Ingresa Un Documento de Identidad';

        connectedCallback(){
            getInitialMessage().then(
                result=>{this.initialMsg=result;
                        this.msg=result;                
                }
            ).catch(error=>{
                console.error('Error obteniendo mensaje inicial', error);
                this.initialMsg='Ingresa Un Documento de Identidad';
                this.msg=this.initialMsg;
            });
        }

        handleCedulaChange(event){
            this.CC= event.target.value;
            this.alumno= null;
            this.msg= this.initialMsg;
        }
        handleSearch(){ 
            if(this.CC){
                getAlumnosByCC({CC: this.CC}).then( result => {
                    if(result){
                    this.alumno = result;
                    this.msg = '';
                    }
                    else{ 
                        this.msg= 'Documento de Identidad No Encontrado';
                        this.alumno= null;
                        return;
                    }
                }).catch( error => {
                    this.msg= 'Documento de Identidad No Encontrado';
                    console.error(error);
                    this.alumno= null;
                })
            }else {
                this.msg = this.initialMsg || 'Ingresa Un Documento de Identidad';
            }

        }
    }