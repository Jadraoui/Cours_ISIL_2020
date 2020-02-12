   import java.awt.*;
   import java.io.*;
   import java.applet.*;
   import java.net.*;
   import java.awt.event.*;


   public class AppletDrapeau extends Applet {
      Font f = new Font ("TimesRoman",Font.BOLD, 16);
      Panel panelHaut;
      Panel panelBas;
      CheckboxGroup choixPays ;
      Button demande = new Button("demander");
      String adressehttp = "http://localhost:8080/fcexemple/servlet/ServletDrapeau2a";
      String [] [] lesPays = { 
         { "France" , "fr"},
         { "Angleterre" , "uk"},
         { "Bretagne" , "bzh"}
      };
      public void init() {
         setLayout(new BorderLayout());
         panelHaut = new Panel();
         panelHaut.setLayout(new FlowLayout());
         panelHaut.setBackground(Color.red);
         panelBas = new Panel();
         panelBas.setBackground(Color.green);
         panelBas.add ( new Label ("appuyer sur le bouton pour avoir un drapeau") );
         panelBas.add(demande);
         demande.setFont(f);
      	demande.setBackground(Color.yellow);
         choixPays = new CheckboxGroup();
         for (int i = 0; i < lesPays.length; i++) 
            panelHaut.add(new Checkbox(lesPays[i][0], choixPays, true));
         add(panelHaut,"North");
         add(panelBas,"Center");
         demande.addActionListener(new Choixdemande());
         System.out.println("depart");
      
      }
   
      class Choixdemande implements ActionListener {
      
         public void actionPerformed(ActionEvent  evenement) {
            URL lUrl=null;
            try {
               for (int i = 0; i < lesPays.length; i++) {
                  if (choixPays.getSelectedCheckbox().getLabel().equals(lesPays[i][0]))
                  {
                     lUrl = new URL(adressehttp + "?country=" + lesPays[i][1] );
                     getAppletContext().showDocument(lUrl,"_blank" );
                  }
               }
               repaint();
            }
               catch (Exception erreur ) {
                  System.out.println("mauvaise adresse URL : " + erreur.getClass().getName());
               }
         }
      }
   
   
   
   
   
   
   }