<%
set conexao=Server.createObject("ADODB.connection")
conexao.open "provider=microsoft.jet.oledb.4.0; data source="&Server.MapPath("locadora.mdb")&";"
%>