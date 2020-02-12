<%@ page info = "exemple jsp compile" %>
<HTML>
<HEAD>
<TITLE>La date par Jsp</TITLE> 
</HEAD>
</BODY>
<font size="+3">
<p> Démonstration de la génération de page dynamique </p>
<%@ page language="java" import = "mesdates.*" %>

<jsp:useBean id='ladate' class='mesdates.DateBean2' scope="session"/>
<jsp:setProperty name="ladate" property="*"   />

          Message d'accueil :
<font size=6 color="red"> 
  <%= ladate.getMessage() %>
   <br>
  <%= ladate.getDate() %>  
 </font> <br>
    <%!
      String [] semaine = {"dimanche","lundi", "mardi", "mercredi", "jeudi", "vendredi",  "samedi"};
    %>
<%
int jour = ladate.getJour() - 1 ;
out.println (semaine[jour]);
if (jour != 1) out.println (" , on travaille aujourd'hui");
else out.println (" , c'est férie aujourd'hui");
%>
<font>
<form method="get">   
changer le message : </br>
    <input type="text" name="message" size="50">
    <input type="submit" value="Valider">    
</form>

<IMG SRC="<%= ladate.getDrapeau() %> "/>

<form method="get">  
 choisissez votre pays :
</br>
 <select NAME="pays">
    <option VALUE=0> france&nbsp;
    <option VALUE=1 selected>angleterre&nbsp;
    <option VALUE=2>bretagne&nbsp;
 </select><input type="submit" value="Envoyer" > 
</form>
<%
String leMessage = ladate.getMessage();
if ( leMessage.indexOf("drapeau")!= -1) 
  for (int i =0; i<3; i++) {
   ladate.setPays(i);
   out.println ("<img src= \" "+ ladate.getDrapeau() + " \" />");
  }
%>
<%
if ( ladate.getMessage().indexOf("drapeau")!= -1) 
  for (int i =0; i<3; i++) {
   ladate.setPays(i);
%>
     <IMG SRC="<%= ladate.getDrapeau() %> "/> 
<%  }  %>


</body>
</html>
