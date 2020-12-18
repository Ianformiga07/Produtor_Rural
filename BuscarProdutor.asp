<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Buscar Produtor</title>
<script type="text/javascript">
function Clicar(CPF)
{
	opener.document.frmVinculacao.txtCPFProd.value = CPF;
	close();
}
</script>
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
   sql = "SELECT Produtor.CPF, Produtor.Nome as NomeProdutor, Municipio.Nome as NomeMunicipio, Produtor.Endereco, Produtor.Telefone, Produtor.Status FROM Produtor INNER JOIN Municipio ON Produtor.CodigoMunicipio = Municipio.Codigo ORDER BY NomeProdutor;"
   set rs = conn.execute(sql)
%>

<table width="650" border="1" align="center">
  <%if rs.eof then%>
  <tr><td>Não Existe Nenhum Registro na base de Dados!</td></tr>
  <%else%>
  <tr>
  <th>CPF</th>
  <th>Nome Completo</th>
  <th>Municipio</th>
  <th>Endereço</th>
  <th>Telefone</th>
  <th>Status</th>
  </tr>
  <%do while not rs.eof%>
  <tr>
  <td align="center"><a href="#" onclick="Clicar(<%=rs("CPF")%>)"><%=rs("CPF")%></a></td>
  <td align="center"><%=rs("NomeProdutor")%></td>
  <td align="center"><%=rs("NomeMunicipio")%></td>
  <td align="center"><%=rs("Endereco")%></td>
  <td align="center"><%=rs("Telefone")%></td>
  <td align="center"><%IF  rs("Status") = TRUE THEN%>
  <font color="#009933"> ATIVO </font>
  <%ELSE%>
  <font color="#FF0000"> DESATIVO </font>
  <%END IF%></td>
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
