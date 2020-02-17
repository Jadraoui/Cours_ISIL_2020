<html>
<body>
<form method=post action="selection.jsp">
Choisissez une couleur<p>
Rouge<input type=radio name=couleur value="rouge">
Bleu<input type=radio name=couleur value="bleu">
Vert<input type=radio name=couleur value="vert">
<p>
<input type=submit>
</form>
<!-- ajoutez ici le code permettant d'afficher la couleur choisie si une couleur a ete choisie -->
<!-- pour savoir si un choix a ete effectue, il suffit de tester que la methode de la requete est POST -->
<% if(request.getMethod().equals("POST")){ %>
	<p> Vous avez choisi la couleur <%=request.getParameter("couleur") %> </p>
<% } %>
</body>
</html>
