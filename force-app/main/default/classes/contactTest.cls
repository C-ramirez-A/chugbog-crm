@isTest
public with sharing class contactTest {
    @isTest
    public static void contactTest() {
        List<Contact> Contactos= new List<Contact>();
        for (Integer i=0; i<20; i++ ){
            contact con = new Contact( 
                FirstName= 'Prueba'+i,
                LastName= 'Prueba'+i
            );
            if (math.mod(i, 2) == 0) {
                con.email= 'prueba@example.com';
            } 
            contactos.add(con);
        }
        test.startTest();
        insert Contactos;
        test.stopTest();

        list<contact> check= [SELECT Id, Name, email FROM contact  WHERE FirstName LIKE 'Prueba%'];
        for(contact conCheck: check){
           
            System.assertNotEquals(null, conCheck.Email, 'email no asignado');
        
            
        }

        
    }

}