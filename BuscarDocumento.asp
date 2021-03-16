<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%

IF REQUEST("Operacao") = 2 THEN

	call abreConexao
	sql = "SELECT TB_Modulos.Modulo, TB_Faces.Face, TB_Recipiente.Niveis, TB_Recipiente.NumeroPasta, TB_CadDocumento.NumAuto, TB_CadDocumento.Serie FROM TB_Recipiente INNER JOIN TB_CadDocumento ON TB_CadDocumento.Itens_NPasta_NAuto = TB_Recipiente.CodigoItensModuloFace INNER JOIN Intens_ModuloFaces ON Intens_ModuloFaces.CodigoItensModuloFace = TB_Recipiente.CodigoItensModuloFace INNER JOIN TB_Modulos ON TB_Modulos.Codigo = Intens_ModuloFaces.CodigoModulo INNER JOIN TB_Faces ON TB_Faces.CodigoFace = Intens_ModuloFaces.CodigoFace WHERE NumAuto = '"&request.form("txtAuto")&"' AND Serie = '"&request.form("txtSerie")&"';"
	
	'sql = "Select NumAuto, Serie FROM TB_CadDocumento WHERE NumAuto = '"&request.form("txtAuto")&"' AND Serie = '"&request.form("txtSerie")&"'"
	'response.write sql
	'response.end
	set rs = conn.execute(sql)
	if not rs.eof then
	NumAuto = rs("NumAuto")
	Serie = rs("Serie")
	end if

END IF
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<br />
<script type="text/javascript">
function visualizar()
{
	document.frmBusca.Operacao.value = 2;
	document.frmBusca.action = "BuscarDocumento.asp";
	document.frmBusca.submit();
}

</script>
</head>
<body>
<form name="frmBusca" id="frmBusca" method="post">
<input type="hidden" name="Operacao" id="Operacao" />
<input type="hidden" name="NumAutoVisualizar" id="NumAutoVisualizar" />
<input type="hidden" name="SerieVisualizar" id="SerieVisualizar" />
<h1>Buscar Documentos</h1>
N° do Auto:
<input type="text" name="txtAuto" id="txtAuto" size="13" value="<%=NumAuto%>"/>
Série:
<input type="text" name="txtSerie" id="txtSerie" size="8" value="<%=Serie%>"/>

<input type="submit" name="btnBusca" id="btnBusca" value="Buscar" onclick="visualizar();"/>
</form>

  <%if request("Operacao") =  2 then%>

<table width="650" border="1" align="center">



  <tr>
  <th>Módulo </th>
  <th>Face</th>
  <th>Niveis</th>
  <th>Numero da Pasta(Recipiente)</th>
  <th>Numero do Auto</th>
  <th>Serie</th>
  </tr>

  <%do while not rs.eof%>
  <tr>
  <td align="center"><%=rs("Modulo")%></td>
  <td align="center"><%=rs("Face")%></td>
  <td align="center"><%=rs("Niveis")%></td>
  <td align="center"><%=rs("NumeroPasta")%></td>
  <td align="center"><%=rs("NumAuto")%></td>
  <td align="center"><%=rs("Serie")%></td>
  </tr>
  <%
     rs.movenext
	 loop
  %>
</table>
<%call fechaConexao
end if%>
</body>
</html>
