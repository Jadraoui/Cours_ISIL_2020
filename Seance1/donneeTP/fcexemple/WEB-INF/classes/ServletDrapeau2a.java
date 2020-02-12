
   import java.io.*;
   import java.util.*;
   import javax.servlet.ServletException;
   import javax.servlet.ServletConfig;
   import javax.servlet.http.HttpServlet;
   import javax.servlet.http.HttpServletRequest;
   import javax.servlet.http.HttpServletResponse;
   import javax.servlet.ServletOutputStream;


   public class ServletDrapeau2a extends HttpServlet {
   
      private String dirData = "E:/Tomcat5.5/Tomcat 5.5/webapps/fcexemple/data";
   			// un repertoire quelconque chez le serveur
      private String urlDrapeau = "http://localhost:8080/fcexemple/data/" ;
   	      // une adresse url connue par le serveur
      File repertoireTexte;
      Hashtable drapeaux = new Hashtable(); // table de hashcode  pour trouver les images indexes par le nom du pays
      Hashtable textes = new Hashtable(); //table de hashcode  pour trouver les textes indexes par le nom du pays
      private static final int CLE      = 0;
      private static final int NOMFICHIER    = 1;
      private static final int PAYS = 2;
      private String drapeauParDefaut[] = {"bzh",  "bzh.gif",  "Bretagne"}; 
   
      private String fichiersDrapeaux[][] = {     // contenu qui va etre mis dans la Table de Hascode pour les images
         {"uk",  "gb.gif",  "Angleterre"},      // la premiere valeur est la cle   :  fr 
         {"fr",  "fr.jpg",  "France"},            // la deuxieme valeur est le nom du fichier 
         {"bzh",  "bzh.gif",  "Bretagne"}              // la troisième valeur est nom du pays       
      };
   
   
      private String  fichiersTexte[][] = {     // contenu qui va etre  mis dans la Table de Hascode pour les textes
         {"bzh",  "bretagne.txt",  "Bretagne"},  // la premiere valeur est la cle   :  nl         
         {"fr",  "france.txt",  "France"},    // la deuxieme valeur est le texte
         {"uk",  "angleterre.txt",  "Angleterre"}  // la troisieme valeur est le type du fichier texte
      };
      public void init  (ServletConfig config) throws ServletException {
         super.init(config);
      // recherche du répertoire ou se trouve les fichiers contenant les drapeaux
         repertoireTexte = new File(dirData);
         if (!(repertoireTexte.exists() && repertoireTexte.isDirectory())) {
            log("le mauvais repertoire");
            throw new ServletException("On ne trouve pas votre repertoire" + dirData );
         }
      //	Création des table de Hashcode
         for (int i = 0; i < fichiersDrapeaux.length; i++) {   // remplissage  de la table de Hascode
            drapeaux.put(fichiersDrapeaux[i][CLE], fichiersDrapeaux[i]);
         }
         for (int i = 0; i < fichiersTexte.length; i++) {   // remplissage  de la table de Hascode
            textes.put(fichiersTexte[i][CLE], fichiersTexte[i]);
         }
      }
   
      public void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws IOException, ServletException {
         String country = "";
         try {
                  // Recherche du bon drapeau d'après la requete de type country 
            if (req.getParameter("country") != null) {
               country = req.getParameter("country");
            }
            else {
               country =fichiersDrapeaux[2][CLE];
            }
         
            String [] leDrapeau = (String [])(drapeaux.get(country));
            String [] leTexte = (String [])(textes.get(country));
            if (leDrapeau == null) {
               leDrapeau = drapeauParDefaut;
            }
            resp.setContentType("text/html");
            ServletOutputStream out = resp.getOutputStream();
            out.println("<HTML><HEAD><TITLE>");
            out.println("Page générée par une servlet");
            out.println("</TITLE></HEAD><BODY>");
         
            out.println(" <H1>  drapeau du pays  :  " + leDrapeau[PAYS] + "</H1>");
            out.print(" <IMG SRC=\"" + urlDrapeau + leDrapeau[NOMFICHIER] + "\" > ");
            out.println(" <H1> Hymne national du pays " + leDrapeau[PAYS] + " </H1>");
            BufferedReader in = new BufferedReader(new FileReader(repertoireTexte + "/" +leTexte[NOMFICHIER]) );
            String laChaineLue;
            while((laChaineLue = in.readLine())!= null) {
               out.print(" <p>" );
               out.print(laChaineLue);
               out.println(" </p>" );
            }
            out.println("</BODY></HTML>");
         
            in.close();
         }
            catch (IOException e) {
               throw new ServletException("Probleme dans l'écriture de la reponse" );
            }
            finally {
               resp.getOutputStream().close();
            }
      
      }
   }

