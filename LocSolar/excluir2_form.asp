<link href="style.css" rel="stylesheet" type="text/css"> <!-- #include file="conexao.asp" -->
<%
codigo=request.form("txt_codigo")

sql="select * from filmes where codigo="&codigo
set resultado=conexao.execute(sql)
if resultado.eof then
response.write("<font face='verdana' size='2'>Cadastro inexistente")
%>
<font size="2" face="Verdana, Arial, Helvetica, sans-serif"><br>
<br>
<a href="excluir_form.asp" class="texto" onMouseOver="this.className='link'" onMouseOut="this.className='texto'">Digitar 
outro codigo de filme</a></font> 
<%
else
codigo=resultado("codigo")
nome=resultado("nome")
valor=resultado("valor")
%>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="100%" border="0">
  <tr>
    <td><form name="form1" method="post" action="excluir.asp">
        <table width="70%" border="0" align="center">
          <tr> 
            <td colspan="2"><div align="center"><font size="7" face="Verdana, Arial, Helvetica, sans-serif">Excluir 
                Filme</font></div></td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Codigo do Filme:</font></td>
            <td><input readOnly name="txt_codigo" type="text" value="<%=codigo%>" id="txt_codigo" size="10"></td>
          </tr>
          <tr> 
            <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Nome 
              do Filme:</font></td>
            <td><input readonly name="txt_nome" type="text" value="<%=nome%>" id="txt_nome2" size="50" maxlength="50"></td>
          </tr>
          <tr> 
            <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Valor:</font></td>
            <td>
<input name="txt_valor" readonly type="text" id="txt_valor" value="<%=valor%>" size="15" readOnlu></td>
          </tr>
          <tr> 
            <td colspan="2"><div align="center"> </div></td>
          </tr>
          <tr>
            <td colspan="2"><div align="center">
                <input name="Submit" type="submit" class="btn" value="Excluir Filme">
              </div></td>
          </tr>
        </table>
      </form></td>
  </tr>
</table>
</body>
<%
end if
%>