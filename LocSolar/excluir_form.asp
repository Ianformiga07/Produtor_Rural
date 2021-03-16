<%
if not Session("logado")=true Then
response.redirect("nlogado.htm")
end if
%>
<link href="style.css" rel="stylesheet" type="text/css">
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="100%" border="0">
  <tr>
    <td><form name="form1" method="post" action="excluir2_form.asp">
        <table width="70%" border="0" align="center">
          <tr> 
            <td colspan="2"><div align="center"><font size="7" face="Verdana, Arial, Helvetica, sans-serif">Excluir 
                Filme</font></div></td>
          </tr>
          <tr> 
            <td width="46%">&nbsp;</td>
            <td width="54%">&nbsp;</td>
          </tr>
          <tr> 
            <td><div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Codigo 
                do Filme:</font></div></td>
            <td><input name="txt_codigo" type="text" id="txt_codigo" size="10"></td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
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
