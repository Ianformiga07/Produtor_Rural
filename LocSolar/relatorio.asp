<link href="style.css" rel="stylesheet" type="text/css"> <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- #include file="conexao.asp" -->
<%
ordem=request.form("txt_ordem")
sql="select * from filmes order by "&ordem

set resultado=conexao.execute(sql)

if resultado.EOF Then
response.write("<font face='verdana' size='2'>Não existe nenhum filme cadastrado")
%>
<br><br>
<font size="2" face="Verdana, Arial, Helvetica, sans-serif"><a href="relatorio_form.asp" class="texto" onMouseOver="this.className='link'" onMouseOut="this.className='texto'">Voltar</a></font> 
<%
else
response.write("<table border='0' width='100%' heigth='100%' align='center'><tr><td><table align='center' border='0' width='70%'><tr><td colspan='3'><font face='verdana' size='7'>Relatorio de Filmes<tr><td><br><tr><td><font face='verdana' size='2'><b>Codigo do filme</b><td><font face='verdana' size='2'><b>Nome do Filme</b><td><font face='verdana' size='2'><b>Valor</b>")
while not resultado.EOF
codigo=resultado("codigo")
nome=resultado("nome")
valor=resultado("valor")
%>
<tr class="fora" onMouseOver="this.className='cima'" onMouseOut="this.className='fora'">
<%
response.write("<td><font face='verdana' size='2'>"&codigo&"<td><font face='verdana' size='2'>"&nome&"<td><font face='verdana' size='2'>"&valor)
resultado.movenext
wend
response.write("</table>")
%>
<br><br>
<font size="2" face="Verdana, Arial, Helvetica, sans-serif"><a href="relatorio_form.asp" class="texto" onMouseOver="this.className='link'" onMouseOut="this.className='texto'">Escolher outra ordem de exibição</a></font> 
<%
end if
%>