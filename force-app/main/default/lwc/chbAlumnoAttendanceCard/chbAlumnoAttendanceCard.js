import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import markAttendance from '@salesforce/apex/ChbAttendanceController.markAttendance';

export default class ChbAlumnoAttendanceCard extends LightningElement {
    @api alumno;
    handleMarkAttendance() {
        if (!this.alumno || !this.alumno.Id) {
            console.log('No hay alumno válido');
            return;
        }
        markAttendance({ alumnId: this.alumno.Id }).then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Asistencia registrada',
                    message: `Se registró asistencia para ${this.alumno.Name}`,
                    variant: 'success',
                })
            );
        }).catch(error => {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: 'No fue posible registrar la asistencia',
                variant: 'error',
            })
        );
            console.log(error);
        });
    };

}