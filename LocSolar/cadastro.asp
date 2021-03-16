<!-- #include file="conexao.asp" -->
<%
nome=request.form("txt_nome")
valor=request.form("txt_valor")

sql="insert into filmes (nome,valor) values ('"&nome&"','"&valor&"')"

conexao.execute(sql)
%>
<link href="style.css" rel="stylesheet" type="text/css">

<font face="verdana" size="2">Cadastro realizado com sucesso</font><BR><BR>
<a href="cadastro_form.asp" class="texto" onMouseOver="this.className='link'" onMouseOut="this.className='texto'"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Cadastrar 
outro filme</font></a>