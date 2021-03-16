<!-- #include file="conexao.asp" -->
<%
codigo=request.form("txt_codigo")
nome=request.form("txt_nome")
valor=request.form("txt_valor")

sql="update filmes set nome='"&nome&"', valor='"&valor&"' where codigo="&codigo

conexao.execute(sql)

response.write("<font face='verdana' size='2'>Filme foi alterado com sucesso")
%>
<link href="style.css" rel="stylesheet" type="text/css">
<BR><BR>
 <a href="alterar_form.asp" class="texto" onMouseOver="this.className='link'" onMouseOut="this.className='texto'"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Alterar 
outro filme</font></a>