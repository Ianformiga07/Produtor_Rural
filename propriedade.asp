<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<%
session("CPF_Usu")
IF REQUEST("Operacao") = 1 THEN 'Cadastrar
	'if request.ServerVariables("CONTENT_LENGTH") <> 0 then
	call abreConexao
	sql = "INSERT INTO Propriedade(Codigo, Nome, Endereco, UF, CodigoMunicipio) VALUES ('"&request.Form("txtCodigo")&"', '"&request.Form("txtNome")&"', '"&request.Form("txtEndereco")&"', '"&request.Form("uf")&"', '"&request.form("municipio")&"')"
	conn.execute(sql)
	call fechaConexao
	Session("Id_Usu") = request.form("txtCodigo")
	response.Redirect("Propriedade.asp?Resp=1&Operacao=2&Codigo="&request("txtCodigo")&"")
	'response.Redirect("teste.asp?Operacao=2&CpfVisualizar="&request.form("txtcpf")&"") 
	'end if
ELSEIF REQUEST("Operacao") = 2 THEN 'visualizar
	call abreConexao
	sql = "Select Codigo, Nome, Endereco, UF, CodigoMunicipio FROM Propriedade WHERE Codigo = '"&request("Codigo")&"'"
	set rs = conn.execute(sql)
	if not rs.eof then
	CodigoProp = rs("Codigo")
	NomeProp = rs("Nome")
	EnderecoProp = rs("Endereco")
	uf = rs("UF")
	CodMunicipio = rs("CodigoMunicipio")
	Existe = 1
	Session("Id_Usu") = CodigoProp
	end if
	call fechaConexao
ELSEIF REQUEST ("Operacao") = 3 THEN 'ALTERAR
	'if Request.ServerVariables("CONTENT_LENGTH") <> 0 then
	call abreConexao
	sql = "UPDATE Propriedade SET Nome = '"&request.Form("txtNome")&"', Endereco = '"&request.Form("txtEndereco")&"', UF = '"&request.Form("uf")&"', CodigoMunicipio = '"&request.Form("municipio")&"' WHERE Codigo = '"&request.Form("txtCodigo")&"'"
	conn.execute(sql)
	Session("Id_Usu") = request.form("txtCodigo")
	call fechaConexao
	Response.Redirect("Propriedade.aspResp=2")
	'end if
END IF
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Propriedade</title>
<style type="text/css">
.messagem_informacao {
    background: none repeat scroll 0 0 #00FFCC;
    border: 2px solid #00FF33;
    top:  -55px;
    left: 300px;	
}
</style>
<script src="javascript/Mascara.js"></script>
<script type="text/javascript">
function validar()
{
	if(document.frmPropriedade.txtCodigo.value == "")
	{
		alert("Obrigatorio digitar o Código!");
		document.frmPropriedade.txtCodigo.focus();
		return false;
		}
	if(document.frmPropriedade.txtNome.value == "")
	{
		alert("Obrigatorio digitar o Nome da Propriedade!");
		document.frmPropriedade.txtNome.focus();
		return false;
	}
	if(document.frmPropriedade.txtEndereco.value == "")
	{
		alert("Obrigatorio digitar o Endereco!");
		document.frmPropriedade.txtEndereco.focus();
		return false;
	}
	if(document.frmPropriedade.uf.value == "")
	{
		alert("Obrigatorio escolher o Estado!");
		document.frmPropriedade.uf.focus();
		return false;
	}
		if(document.frmPropriedade.municipio.value == "")
	{
		alert("Obrigatorio escolher o Municipio!");
		document.frmPropriedade.municipio.focus();
		return false;
	}
	return true;
}
function cadastrar()
{
	if(validar() == false)
	return false;
	
	document.frmPropriedade.Operacao.value = 1;
	document.frmPropriedade.action = "propriedade.asp";
	document.frmPropriedade.submit();
}
function visualizar(Codigo)
{
	document.frmPropriedade.Operacao.value = 2;
	document.frmPropriedade.Codigo.value = Codigo;
	document.frmPropriedade.action = "propriedade.asp";
	document.frmPropriedade.submit();
}
function verificar_cadastro()
{
	document.frmPropriedade.Operacao.value = 2;
	document.frmPropriedade.Codigo.value = document.frmPropriedade.txtCodigo.value;
	document.frmPropriedade.action = "propriedade.asp";
	document.frmPropriedade.submit();
}
function alterar()
{
	if(validar() == false)
	return false;
	
	document.frmPropriedade.Operacao.value = 3;
	document.frmPropriedade.action = "propriedade.asp";
	document.frmPropriedade.submit();
}
function novo()
{
	window.location.href = "propriedade.asp";
}
</script>
</head>
<center>
<%if request("Resp") = 1 or request("Resp") = 2 then
	if request("Resp") = 1 then
	mensagem = "Cadastro Realizado com Sucesso!"
	else
	mensagem = "Alteração Realizada com Sucesso!"
	end if
%>
<div class="messagem_informacao" align="center"><%=mensagem%></div>
<%end if%>
</center>
<body>
<form name="frmPropriedade" id="frmPropriedade" onsubmit="validar();" method="post">
<input type="hidden" name="Operacao" id="Operacao"/>
<input type="hidden" name="Codigo" id="Codigo" />
<p>Codigo: </br>
<input type="text" name="txtCodigo" onkeypress="somente_numero(txtCodigo);" id="txtCodigo" maxlength="6" value="<%IF Existe = 1 THEN Response.Write(CodigoProp) ELSE Response.Write(Request("txtCodigo")) END IF%>" onblur="somente_numero(txtCodigo);verificar_cadastro();" <%IF Existe = 1 THEN%>  readonly="readonly"<%END IF%>/>
</p>
<p>Nome da Propriedade: </br>
<input type="text" name="txtNome" id="txtNome" size="50" value="<%=NomeProp%>"/>
</p>
<p>Endereço da Propriedade: </br>
<input type="text" name="txtEndereco" id="txtEndereco" size="50" value="<%=EnderecoProp%>"/>
</p>
<p>UF: </br>
<select name="uf" id="uf">
<option value=""> Selecionar </option>
<option value="TO" <%if uf = "TO" then%> selected <%end if%>> TO </option>
</select>
</p>
<p>Municipio: </br>
<%
   call abreConexao
   sql = "SELECT Codigo, Nome FROM Municipio order by Nome"
   set rs = conn.execute(sql)
%>
<select name="municipio" id="municipio">
	<option value="">Selecionar</option>
<%do while not rs.eof%>
	<option value="<%=rs("Codigo")%>"<%if rs("Codigo") = CodMunicipio then%>selected<%end if%>><%=rs("Nome")%></option>
    <% rs.movenext
			loop
call fechaConexao%>
</select>
</p>
<p>
<input type="submit" name="btnCadastro" value="<%IF Existe = 1 THEN%>Alterar<%ELSE%>Cadastrar<%END IF%>" onclick="return <%IF Existe = 1 THEN%>alterar();<%ELSE%>cadastrar();<%END IF%>"/>
<%IF Existe = 1 THEN%>
<input type="button" onclick="return novo();" value="Novo Cadastro"/>
<a href="vinculacao.asp"><input type="button" value="Vincular Exploração"/></a>
</p>
<%END IF%>
</form>


<%
   call abreConexao
   sql = "SELECT Propriedade.Codigo as CodigoID, Propriedade.Nome as NomePropriedade, Municipio.Nome as NomeMunicipio, Propriedade.Endereco, Propriedade.UF FROM Propriedade INNER JOIN Municipio ON Propriedade.CodigoMunicipio = Municipio.Codigo ORDER BY NomePropriedade;"
   set rs = conn.execute(sql)
%>

<table width="650" border="1" align="center">
  <%if rs.eof then%>
  <tr><td>Não Existe Nenhum Registro na base de Dados!</td></tr>
  <%else%>
  <tr>
  <th>Codigo</th>
  <th>Nome Propriedade</th>
  <th>Municipio</th>
  <th>Endereço Propriedade</th>
  <th>UF</th>
  <th>Operação</th>
  </tr>
  <%do while not rs.eof%>
  <tr>
  <td align="center"><%response.write rs("CodigoID")%></td>
  <td align="center"><%=rs("NomePropriedade")%></td>
  <td align="center"><%=rs("NomeMunicipio")%></td>
  <td align="center"><%=rs("Endereco")%></td>
  <td align="center"><%=rs("UF")%></td>
  <td align="center"><a href="#" onclick="visualizar(<%=rs("CodigoID")%>)"><img src="Imagens\editar.png" width="30"/></a></td>
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
