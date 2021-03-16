<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->

<%
if request("Operacao") = 5 and request("Codigo") <> "" then
dim CodigoModulo
 CodigoModulo = request.form("Codigo")
call abreConexao
 SQL2 = "SELECT intens_ModuloFaces.CodigoModulo, TB_Modulos.Codigo as CodigoModulo, TB_Modulos.Modulo, TB_Faces.CodigoFace, TB_Faces.Face FROM intens_ModuloFaces INNER JOIN TB_Modulos ON TB_Modulos.Codigo = intens_ModuloFaces.CodigoModulo INNER JOIN TB_Faces ON TB_Faces.CodigoFace = intens_ModuloFaces.CodigoFace WHERE Codigo = '"&request.form("Codigo")&"'"
 set rs1 = conn.Execute(SQL2)
end if
%>

<%
'dim cpf
'cpf = "04426330173"
'cpf = left((cpf),3)&"."&mid((cpf),4,3)&"."&mid((cpf),7,3)&"-"&right((cpf),2)
'response.Write(cpf)
'response.end
IF REQUEST("Operacao") = 1 THEN 'Cadastrar
call abreConexao
sql = "SELECT CodigoItensModuloFace FROM Intens_MOduloFaces WHERE CodigoModulo = '"&request.Form("modulo")&"' and Codigoface = '"&request.Form("faces")&"'"
set rs_ItensModulo = conn.execute(sql)
sql = "INSERT INTO TB_Recipiente(CodigoItensModuloFace, Niveis, NumeroPasta) VALUES ('"&rs_ItensModulo("CodigoItensModuloFace")&"', '"&request.Form("niveis")&"', '"&request.Form("txtNumPasta")&"')"
conn.execute(sql)
call FechaConexao
response.Redirect("CadRecipiente.asp?Resp=1")

ELSEIF REQUEST("Operacao") = 2 THEN
call abreConexao
sql = "SELECT CodigoItensModuloFace, Niveis, NumeroPasta FROM TB_Recipiente WHERE CodigoItensModuloFace = '"&request.Form("CodigoVisualizar")&"'"
set rs1 = conn.execute(sql)
if not rs1.eof then
	CodigoItensModuloFace = rs("CodigoItensModuloFace")
	niveis = rs("Niveis")
	NumeroPasta = rs("NumeroPasta")
end if
call fechaConexao

END IF
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
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
	if(document.frmCadRecipiente.modulo.value == "")
	{
		alert("Obrigatorio escolher o Módulo!");
		document.frmCadRecipiente.modulo.focus();
		return false;
	}
	if(document.frmCadRecipiente.faces.value == "")
	{
		alert("Obrigatorio escolher face!");
		document.frmCadRecipiente.faces.focus();
		return false;
	}
	return true;
}
function cadastrar()
{
	if(validar() == false)
	return false;
	
	document.frmCadRecipiente.Operacao.value = 1;
	document.frmCadRecipiente.action = "CadRecipiente.asp";
	document.frmCadRecipiente.submit();
}
function visualizar(codigo)
{
	document.frmCadRecipiente.Operacao.value = 2;
	document.frmCadRecipiente.CodigoVisualizar.value = codigo;
	document.frmCadRecipiente.action = "CadRecipiente.asp";
	document.frmCadRecipiente.submit();
}

function verificar_cadastro()
{
	var codigo = document.getElementById("modulo").value
	
	document.frmCadRecipiente.Operacao.value = 5;
	document.frmCadRecipiente.Codigo.value = codigo;
	document.frmCadRecipiente.action = "CadRecipiente.asp";
	document.frmCadRecipiente.submit();
}
function somente_numero(campo){   
var digits="0123456789"   
var campo_temp   
    for (var i=0;i<campo.value.length;i++){   
        campo_temp=campo.value.substring(i,i+1)   
        if (digits.indexOf(campo_temp)==-1){   
            campo.value = campo.value.substring(0,i);   
        }   
    }   
} 

</script>
</head>

<body>
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
<h1>Cadastro de Recipiente</h1>
<form name="frmCadRecipiente" id="frmCadRecipiente" onsubmit="return validar();" method="post">
<input type="hidden" name="Operacao" id="Operacao" />
<input type="hidden" name="CodigoVisualizar" id="CodigoVisualizar" />
<input type="hidden" name="Codigo" id="Codigo" />
<p>Módulos: 
 <%
	call abreConexao
	sql = "SELECT Codigo, Modulo FROM TB_Modulos ORDER BY Modulo"
	 set rs = conn.execute(sql)
	
 %>
<select name="modulo" id="modulo" onchange="verificar_cadastro();">
	<option value="">Selecionar</option>
<%do while not rs.eof%>
	<option value="<%=rs("Codigo")%>"<%if trim(rs("Codigo")) = trim(request.form("Modulo")) then%>selected<%end if%>><%=rs("Modulo")%></option>
    <% rs.movenext
			loop
call fechaConexao%>
</select>
&nbsp;&nbsp;&nbsp;

Faces: 

<select name="faces" id="faces" onblur="">
	<option value="">Selecionar</option>
<%do while not rs1.eof%>
	<option value="<%=trim(rs1("CodigoFace"))%>"><%=trim(rs1("Face"))%></option>
    <% rs1.movenext
			loop
%>
</select>
&nbsp;&nbsp;&nbsp;&nbsp;
Niveis: 

<select name="niveis" id="niveis">
	<option value="" selected>Selecionar</option>
	<option value="NIVEL01" <%if niveis = "NIVEL01" then%> selected <%end if%>> NÍVEL 01 </option>
    <option value="NIVEL02" <%if niveis = "NIVEL02" then%> selected <%end if%>> NÍVEL 02 </option>
    <option value="NIVEL03" <%if niveis = "NIVEL03" then%> selected <%end if%>> NÍVEL 03 </option>
    <option value="NIVEL04" <%if niveis = "NIVEL04" then%> selected <%end if%>> NÍVEL 04 </option>
    <option value="NIVEL05" <%if niveis = "NIVEL05" then%> selected <%end if%>> NÍVEL 05 </option>
    <option value="NIVEL06" <%if niveis = "NIVEL06" then%> selected <%end if%>> NÍVEL 06 </option>
    <option value="NIVEL07" <%if niveis = "NIVEL07" then%> selected <%end if%>> NÍVEL 07 </option>
</select>
</p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
N° da Pasta(Recipiente): 
<input type="text" name="txtNumPasta" id="txtNumPasta" onkeypress="somente_numero(txtNumPasta);" onblur="somente_numero(txtNumPasta);" value="<%=NumeroPasta%>"/>
&nbsp;&nbsp;&nbsp;&nbsp;


<input type="submit" name="btnCadastrar" id="btnCadastrar" onclick="return cadastrar();" value="Cadastrar" />



&nbsp;&nbsp;&nbsp;




</form>
</body>
</html>
