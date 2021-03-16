<%
if Session("logado")=true Then
response.redirect("cadastro_form.asp")
end if
%>
<html>
<head>
<title>Documento sem t&iacute;tulo</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="100%" border="0">
  <tr>
    <td><form action="login.asp" method="post" name="login" id="login">
        <table width="16%" border="0" align="center">
          <tr> 
            <td colspan="2"><div align="center"><font size="7" face="Verdana, Arial, Helvetica, sans-serif">Login</font></div></td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td><div align="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Usu&aacute;rio:</font></div></td>
            <td><input name="txt_usuario" type="text" id="txt_usuario" size="25"></td>
          </tr>
          <tr> 
            <td><div align="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Senha:</font></div></td>
            <td><input name="txt_senha" type="password" id="txt_senha" size="15"></td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="2"><div align="center"> 
                <input name="login" type="submit" class="btn" id="login" value="Login">
              </div></td>
          </tr>
        </table>
      </form></td>
  </tr>
</table>
</body>
</html>
