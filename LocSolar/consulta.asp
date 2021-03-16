<link href="style.css" rel="stylesheet" type="text/css"> <!-- #include file="conexao.asp" -->
<%
codigo=request.form("txt_codigo")

sql="select * from filmes where codigo="&codigo

set resultado=conexao.execute(sql)

if resultado.EOF Then
response.write("<font face='verdana' size='2'>Cadastro inexistente.")
%>
<br><br><a href="consulta_form.asp" class="texto" onMouseOver="this.className='link'" onMouseOut="this.className='texto'"><font face="verdana" size="2">Digitar outro codigo de filme</font></a>
<%
else
codigo=resultado("codigo")
nome=resultado("nome")
valor=resultado("valor")
response.write("<table border='0' width='100%' height='100%' align='center'><tr><td><table align='center' border='0' width='70%'><tr><td colspan='2'><font face='verdana' size='7'>Consulta de Filmes</font><tr><td><br><tr><td><font face='verdana' size='2'>Codigo do Filme:<td><font face='verdana' size='2'>"&codigo&"<tr><td><font face='verdana' size='2'>Nome do Filme:<td><font face='verdana' size='2'>"&nome&"<tr><td><font face='verdana' size='2'>Valor:<td><font face='verdana' size='2'>"&valor&"</table>")
%>
<br><br><a href="consulta_form.asp" class="texto" onMouseOver="this.className='link'" onMouseOut="this.className='texto'"><font face="verdana" size="2">Consultar outro filme</font></a>
<%
response.write("</table>")
end if
%>