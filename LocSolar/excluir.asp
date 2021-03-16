<!-- #include file="conexao.asp" -->
<%
codigo=request.form("txt_codigo")

sql="delete from filmes where codigo="&codigo

conexao.execute(sql)

response.write("<font face='verdana' size='2'>Filme excluido com sucesso")
%>
<link href="style.css" rel="stylesheet" type="text/css">

<br><br>
<a href="excluir_form.asp" class="texto" onMouseOver="this.className='link'" onMouseOut="this.className='texto'"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Excluir 
outro filme</font></a>