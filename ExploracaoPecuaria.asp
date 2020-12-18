<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<%
Session("Id_Usu")
dim existeCad
function verificaExploracao()
call abreConexao
 SQL2 = "SELECT COUNT (*) as qt FROM ExploracaoPecuaria  WHERE CPFCNPJProdutor = '"&session("CPF_Usu")&"' AND CodigoPropriedade = '"&session("Id_Usu")&"'"
 set rs = conn.Execute(SQL2)
		if rs("qt") <> 0 then
			existeCad = true
		else
			existeCad = false
		end if
		rs.close
		set rs = nothing
		verificaExploracao = existeCad 
call fechaConexao
end function
IF REQUEST("Operacao") = 1 THEN
	'if request.ServerVariables("CONTENT_LENGTH") <> 0 then
	IF verificaExploracao() = FALSE THEN
	call abreConexao
	sql = "INSERT INTO ExploracaoPecuaria(CPFCNPJProdutor, CodigoPropriedade, TipoExploracao) VALUES ('"&session("CPF_Usu")&"', '"&session("Id_Usu")&"','"&request.form("TipoExploracao")&"')"
	conn.execute(sql)
	call fechaConexao
	END IF 
	response.Redirect("ExploracaoPecuaria.asp") 
	'end if
END IF

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Exploração Pecuária</title>
<script type="text/javascript">
function validar()
{
	if(document.frmExpPecuaria.TipoExploracao.value == "")
	{
		alert("Obrigatorio escolher Tipo de Exploração!");
		document.frmExpPecuaria.TipoExploracao.focus();
		return false;
	}
}
function cadastrar()
{
	if(validar() == false)
	return false;
	
	document.frmExpPecuaria.Operacao.value = 1;
	document.frmExpPecuaria.action = "ExploracaoPecuaria.asp";
	document.frmExpPecuaria.submit();
}
</script>
</head>
<body>
<form name="frmExpPecuaria" method="post">
<input type="hidden" name="Operacao" id="Operacao" />
<p align="center">
<h1>Exploração Pecuária</h1>
</p>
Exploração Pecuaria: </br>
<%
   call abreConexao
   sql = "SELECT Codigo, Descricao FROM TipoExploracao order by Codigo"
   set rs = conn.execute(sql)
%>
<select name="TipoExploracao" id="TipoExploracao">
	<option value="">Selecionar</option>
<%do while not rs.eof%>
	<option value="<%=rs("Codigo")%>"><%=rs("Descricao")%></option>
    <% rs.movenext
			loop
call fechaConexao%>
</select>
</p>
<div class="box-actions">
<p>
<input type="submit" name="btnCadastro" value="Vincular" onclick="cadastrar();"/>
</p>
</div>
</form>


<%
   call abreConexao
   sql = "SELECT Produtor.CPF, Produtor.Nome as NomeProdutor,Produtor.CodigoMunicipio, Propriedade.Codigo, Propriedade.Nome,Propriedade.CodigoMunicipio, TipoExploracao.Descricao FROM ExploracaoPecuaria INNER JOIN Produtor ON Produtor.CPF = ExploracaoPecuaria.CPFCNPJProdutor INNER JOIN Propriedade ON Propriedade.Codigo = ExploracaoPecuaria.CodigoPropriedade INNER JOIN TipoExploracao ON TipoExploracao.Codigo = ExploracaoPecuaria.TipoExploracao ORDER BY NomeProdutor;"
   set rs = conn.execute(sql)
%>

<table width="650" border="1" align="center">
  <%if rs.eof then%>
  <tr><td>Não Existe Nenhum Registro na base de Dados!</td></tr>
  <%else%>
  <tr>
  <th>CPF Produtor</th>
  <th>Nome Produtor</th>
  <th>Codigo Propriedade</th>
  <th>Nome da Propriedade</th>
  <th>Codigo Municipio</th>
  <th>Tipo Exploracao</th>
  </tr>
  <%do while not rs.eof%>
  <tr>
  <td align="center"><%=rs("CPF")%></td>
  <td align="center"><%=rs("NomeProdutor")%></td>
  <td align="center"><%=rs("Codigo")%></td>
  <td align="center"><%=rs("Nome")%></td>
  <td align="center"><%=rs("CodigoMunicipio")%></td>
  <td align="center"><%=rs("Descricao")%></td>
  </tr>
  <%
     rs.movenext
	 loop
  %>
  <%end if%>
</table>
<%call fechaConexao%>
</body>
</html>
