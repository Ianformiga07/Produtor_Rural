<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<%
IF REQUEST("Operacao") = 1 THEN 'Cadastrar
	'if request.ServerVariables("CONTENT_LENGTH")<> 0 then
	 call abreConexao
     sql = "INSERT INTO Produtor(CPF, CodigoMunicipio, Nome, Endereco, Telefone, CEP, Status) VALUES ('"&replace(replace(request.form("txtcpf"),".",""),"-","")&"', '"&request.form("municipio")&"','"&request.form("txtNome")&"','"&request.form("txtEndereco")&"', '"&request.form("txtTelefone")&"', '"&request.form("txtCEP")&"', 1)"
	 conn.execute(sql)
     call fechaConexao
	Session("CPF_Usu") = replace(replace(request.form("txtcpf"),".",""),"-","")
	response.Redirect("teste.asp?Resp=1&Operacao=2&CpfVisualizar="&replace(replace(request.form("txtcpf"),".",""),"-","")&"")
	'end if
ELSEIF REQUEST("Operacao") = 2 THEN ' visualizar
	call abreConexao
	sql = "Select CPF, CodigoMunicipio, Nome, Endereco, Telefone, CEP, Status FROM Produtor WHERE CPF = '"&replace(replace(request("CpfVisualizar"),".",""),"-","")&"'"
	set rs = conn.execute(sql)
	if not rs.eof then 
	CPF = left(rs("CPF"),3)&"."&mid(rs("CPF"),4,3)&"."&mid(rs("CPF"),7,3)&"-"&right(rs("CPF"),2)
	CodMunicipio = rs("CodigoMunicipio")
	Nome = rs("Nome")
	Endereco = rs("Endereco")
	Telefone = rs("Telefone")
	CEP = rs("CEP")
	StatusUsuario = rs("Status")
	Existe = 1
	Session("CPF_Usu") = rs("CPF")
	end if
	call fechaConexao
ELSEIF REQUEST("Operacao") = 3 THEN 'ALTERAR
	'if Request.ServerVariables("CONTENT_LENGTH") <> 0 then
	call abreConexao
	sql = "UPDATE Produtor SET CodigoMunicipio = '"&request.Form("municipio")&"', Nome = '"&request.Form("txtNome")&"', Endereco = '"&request.Form("txtEndereco")&"', CEP = '"&request.Form("txtCEP")&"', Status = '"&request.Form("status")&"' WHERE CPF = '"&replace(replace(request.form("txtcpf"),".",""),"-","")&"'"
	conn.execute(sql)
	Session("CPF_Usu") = replace(replace(request.form("txtcpf"),".",""),"-","")
	call fechaConexao
	Response.Redirect("teste.asp?Resp=2")
	'end if
END IF
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ADAPEC/TO</title>
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
	if(document.frmCadastro.txtcpf.value == "")
	{
		alert("Obrigatorio digitar o CPF");
		document.frmCadastro.txtcpf.focus();
		return false;
	}
	else
	 if(!ValidarCPF(document.frmCadastro.txtcpf.value.replace(".","").replace(".","").replace("-","")))
	 {
	   alert("CPF Invalido ou está na formatação errada 000.000.000-00");
	   return false
	 }
		if(document.frmCadastro.txtNome.value == "")
	{
		alert("Obrigatorio digitar o Nome");
		document.frmCadastro.txtNome.focus();
		return false;
	}
		if(document.frmCadastro.municipio.value == "")
	{
		alert("Obrigatorio escolher o Municipio");
		document.frmCadastro.municipio.focus();
		return false;
	}
		if(document.frmCadastro.txtEndereco.value == "")
	{
		alert("Obrigatorio digitar o Endereço");
		document.frmCadastro.txtEndereco.focus();
		return false;
	}
		if(document.frmCadastro.txtTelefone.value == "")
	{
		alert("Obrigatorio digitar o Telefone");
		document.frmCadastro.txtTelefone.focus();
		return false;
	}
	else
	if(!ValidaCelular(document.frmCadastro.txtTelefone.value))
	{
	  document.frmCadastro.txtTelefone.focus();
	  return false
	}
		if(document.frmCadastro.txtCEP.value == "")
	{
		alert("Obrigatorio digitar o CEP");
		document.frmCadastro.txtCEP.focus();
		return false;
	}
	else
	if(!ValidaCep(document.frmCadastro.txtCEP.value))
	{
	  document.frmCadastro.txtCEP.focus();
	  return false
	}
	return true;
}
function cadastrar()
{
	if(validar() == false)
	return false;
	
	document.frmCadastro.Operacao.value = 1;
	document.frmCadastro.action = "teste.asp";
	document.frmCadastro.submit();
}
function visualizar(cpf)
{
	document.frmCadastro.Operacao.value = 2;
	document.frmCadastro.CpfVisualizar.value = cpf;
	document.frmCadastro.action = "teste.asp";
	document.frmCadastro.submit();
}
function verificar_cadastro()
{
	document.frmCadastro.Operacao.value = 2;
	document.frmCadastro.CpfVisualizar.value = document.frmCadastro.txtcpf.value;
	document.frmCadastro.action = "teste.asp";
	document.frmCadastro.submit();
}

function alterar()
{
	if(validar() == false)
	return false;
	
	document.frmCadastro.Operacao.value = 3;
	document.frmCadastro.action = "teste.asp";
	document.frmCadastro.submit();
}

function novo()
{
	window.location.href = "teste.asp";
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
        <tr>
          <th width="104" scope="col">&nbsp;</th>
          <th scope="col" align="center">CADASTRO PRODUTOR</th>
        </tr>
<form name="frmCadastro" onsubmit="validar();" method="post">
<input type="hidden" name="Operacao" id="Operacao"/>
<input type="hidden" name="CpfVisualizar" id="CpfVisualizar"/>
<p>CPF: <br />
<input type="text" onKeyPress="MascaraCPF(txtcpf)"  name="txtcpf" id="txtcpf" value="<%IF Existe = 1 THEN Response.Write(CPF) ELSE Response.Write(Request("txtcpf")) END IF%>" maxlength="14" onblur="MascaraCPF(txtcpf);verificar_cadastro();"<%IF REQUEST ("Operacao") = 2 AND Existe = 1 THEN%> readonly="readonly"<%END IF%>/>
</p>
<p>Nome Completo: <br />
<input type="text" name="txtNome" id="txtNome" value="<%=Nome%>"size="50"/>
</p>
<p>Municipio: <br />
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
<p>Endereço: <br />
<input type="text" name="txtEndereco" id="txtEndereco" value="<%=Endereco%>" size="50"/>
</p>
<p>Telefone: <br />
<input type="text" name="txtTelefone" id="txtTelefone" value="<%=Telefone%>" onKeyPress="MascaraCelular(txtTelefone)" onblur="MascaraCelular(txtTelefone)" maxlength="15"/>
</p>
<p>CEP: <br />
<input type="text" name="txtCEP" id="txtCEP" value="<%=CEP%>" onKeyPress="MascaraCep(txtCEP)" onblur="MascaraCep(txtCEP)" maxlength="10"/>
</p>
<%IF Existe = 1 THEN%>
<p>Status: <br />
<select name="status" id="status">
<option value="1" <%if StatusUsuario = true then%> selected <%end if%>> Ativo </option>
<option value="0"<%if StatusUsuario = false then%> selected <%end if%>> Desativo </option>
</select>
</p>
<%END IF%>
<p>
<input type="submit" name="btnCadastro" value="<%IF Existe = 1 THEN%>Alterar<%ELSE%>Cadastrar<%END IF%>" onclick="return <%IF Existe = 1 THEN%>alterar();<%ELSE%>cadastrar();<%END IF%>"/>
<%IF Existe = 1 THEN%>
<input type="button" onclick="return novo();" value="Novo Cadastro"/>
<a href="propriedade.asp"><input type="button" value="Ir Propriedade"/></a>
</p>
<%END IF%>
</form>

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
  <th>Operação</th>
  </tr>
  <%do while not rs.eof%>
  <tr>
  <td align="center"><%=rs("CPF")%></td>
  <td align="center"><%=rs("NomeProdutor")%></td>
  <td align="center"><%=rs("NomeMunicipio")%></td>
  <td align="center"><%=rs("Endereco")%></td>
  <td align="center"><%=rs("Telefone")%></td>
  <td align="center"><%IF  rs("Status") = TRUE THEN%>
  <font color="#009933"> ATIVO </font>
  <%ELSE%>
  <font color="#FF0000"> DESATIVO </font>
  <%END IF%></td>
  <td align="center"><a href="#" onclick="visualizar(<%=rs("CPF")%>)"><img src="Imagens\editar.png" width="30"/></a></td>
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
