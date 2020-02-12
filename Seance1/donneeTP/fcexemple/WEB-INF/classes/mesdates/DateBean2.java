   package mesdates;
   import java.util.*;
   public class DateBean2 {                 
      GregorianCalendar laDate = new GregorianCalendar(); 
      String message ="Bonjour voici la date d'aujourd'hui : ";
      int pays;
      private String DirData = "http://localhost:8080/examples/servlets/data/" ;
      private String fichiersDrapeaux[] = {    
         "fr.jpg","uk.gif", "bzh.gif" };
      public String getDate() {                       
         return " " + laDate.get(Calendar.DAY_OF_MONTH) 
            + " / " +   (laDate.get(Calendar.MONTH)+1) 
            + " / " + laDate.get(Calendar.YEAR);            
      }           
      public int getPays() {                       
         return pays;      
      }                
      public String getDrapeau() {                       
         return DirData + fichiersDrapeaux[pays];      
      }             
      public void setPays(int nouveau) {                       
         pays = nouveau ;      
      }                                 
      public String getMessage() {                       
         return message;      
      }                
      public void setMessage(String nouveau) {                       
         message = nouveau ;      
      }                        
      public int getJour() {                       
         return   laDate.get(Calendar.DAY_OF_WEEK);     
      }  
   
   }