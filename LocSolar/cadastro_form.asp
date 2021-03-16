<%
if not Session("logado")=true Then
response.redirect("nlogado.htm")
end if
%>
<html>
<head>
<title>Documento sem t&iacute;tulo</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="100%" border="0">
  <tr>
    <td><form name="form1" method="post" action="cadastro.asp">
        <table width="70%" border="0" align="center">
          <tr> 
            <td colspan="2"><div align="center"><font size="7" face="Verdana, Arial, Helvetica, sans-serif">Cadastro 
                de Filmes</font></div></td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Nome 
              do Filme:</font></td>
            <td><input name="txt_nome" type="text" id="txt_nome" size="50" maxlength="50"></td>
          </tr>
          <tr> 
            <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Valor:</font></td>
            <td><select name="txt_valor" id="txt_valor">
                <option value="R$ 2,50">R$ 2,50</option>
                <option value="R$ 2,00">R$ 2,00</option>
              </select></td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="2"><div align="center"> 
                <input name="Submit" type="submit" class="btn" value="Cadastrar">
              </div></td>
          </tr>
        </table>
      </form></td>
  </tr>
</table>
</body>
</html>
