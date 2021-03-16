<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/conexao.asp"-->

<%
Session("Num_Auto")
Session("serie")

dim Num_Auto, Serie,Cod
Num_Auto = request("NumAuto")
Serie = request("serie")
call abreConexao
	sql = "SELECT TB_Modulos.Modulo, TB_Faces.Face, TB_Recipiente.Niveis, TB_Recipiente.NumeroPasta, TB_CadDocumento.NumAuto, TB_CadDocumento.Serie FROM TB_Recipiente INNER JOIN TB_CadDocumento ON TB_CadDocumento.Itens_NPasta_NAuto = TB_Recipiente.CodigoItensModuloFace INNER JOIN Intens_ModuloFaces ON Intens_ModuloFaces.CodigoItensModuloFace = TB_Recipiente.CodigoItensModuloFace INNER JOIN TB_Modulos ON TB_Modulos.Codigo = Intens_ModuloFaces.CodigoModulo INNER JOIN TB_Faces ON TB_Faces.CodigoFace = Intens_ModuloFaces.CodigoFace WHERE NumAuto = '"&Session("Num_Auto")&"' AND Serie = '"&Session("serie")&"';"

   set rs1 = conn.execute(sql)
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Buscar Produtor</title>

<style type="text/css">
h1{
  font-size: 48px;
  color: #066a75;
  padding: 2px 0 10px 0;
  font-family: Arial,sans-serif;
  font-weight: bold;
  text-align: center;
  padding-bottom: 30px;
}
h1:after{
  content: ' ';
  display: block;
  width: 100%;
  height: 2px;
  margin-top: 10px;
  background: -webkit-linear-gradient(left, rgba(147,184,189,0) 0%,rgba(147,184,189,0.8) 20%,rgba(147,184,189,1) 53%,rgba(147,184,189,0.8) 79%,rgba(147,184,189,0) 100%); 
  background: linear-gradient(left, rgba(147,184,189,0) 0%,rgba(147,184,189,0.8) 20%,rgba(147,184,189,1) 53%,rgba(147,184,189,0.8) 79%,rgba(147,184,189,0) 100%); 
}
</style>
</head>
<body>
<h1> Buscar Produtor </h1>
<%
   call abreConexao
   sql = "SELECT TB_Modulos.Modulo, TB_Faces.Face, TB_Recipiente.Niveis, TB_Recipiente.NumeroPasta, TB_CadDocumento.NumAuto, TB_CadDocumento.Serie FROM TB_Recipiente INNER JOIN TB_CadDocumento ON TB_CadDocumento.Itens_NPasta_NAuto = TB_Recipiente.CodigoItensModuloFace INNER JOIN Intens_ModuloFaces ON Intens_ModuloFaces.CodigoItensModuloFace = TB_Recipiente.CodigoItensModuloFace INNER JOIN TB_Modulos ON TB_Modulos.Codigo = Intens_ModuloFaces.CodigoModulo INNER JOIN TB_Faces ON TB_Faces.CodigoFace = Intens_ModuloFaces.CodigoFace WHERE NumAuto = '"&Session("Num_Auto")&"' AND Serie = '"&Session("serie")&"';"
   set rs = conn.execute(sql)
%>

<table width="650" border="1" align="center">
  <%if rs.eof then%>
  <tr><td>Não Existe Nenhum Registro na base de Dados!</td></tr>
  <%else%>
  <tr>
  <th>Módulo</th>
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
  <%end if%>
</table>
<%call fechaConexao%>
</body>
</html>
