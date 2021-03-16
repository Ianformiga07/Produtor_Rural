<%
if not Session("logado")=true Then
response.redirect("nlogado.htm")
end if
%>

<link href="style.css" rel="stylesheet" type="text/css">
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="100%" border="0">
  <tr>
    <td><form action="relatorio.asp" method="post" name="relatorio" id="relatorio">
        <table width="50%" border="0" align="center">
          <tr> 
            <td colspan="2"><div align="center"><font size="7" face="Verdana, Arial, Helvetica, sans-serif">Relat&oacute;rio</font></div></td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td><div align="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Ordem:</font></div></td>
            <td><select name="txt_ordem" id="txt_ordem">
                <option value="nome">Alfab&eacute;tica</option>
                <option value="codigo">Por C&oacute;digo</option>
                <option value="valor">Por Valor</option>
              </select></td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="2"><div align="center"> 
                <input name="login" type="submit" class="btn" id="login" value="Relat&oacute;rio">
              </div></td>
          </tr>
        </table>
      </form></td>
  </tr>
</table>
</body>
</html>
