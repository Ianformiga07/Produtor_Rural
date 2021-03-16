<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%

IF REQUEST("Operacao") = 1 THEN
call abreConexao
sql = "INSERT INTO TB_CadDocumento(NumAuto, Serie, Itens_NPasta_NAuto, Observacao) VALUES('"&request.Form("txtNumAuto")&"', '"&request.Form("txtNumSerie")&"', '"&request.form("NumPasta")&"', '"&request.form("txtObs")&"')"
conn.execute(sql)
call fechaConexao
response.Redirect("cadDocumentos.asp")
END IF
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Cadastro de Documentos</title>
<script src="javascript/Mascara.js"></script>
<script type="text/javascript">
function validar()
{
	if(document.frmCadDocumento.txtNumAuto.value == "")
	{
		alert("Obrigatorio digitar o Número do Auto!");
		document.frmCadDocumento.txtNumAuto.focus();
		return false;
	}
	return true;
}
function cadastrar()
{
	if(validar() == false)
	return false;
	
	document.frmCadDocumento.Operacao.value = 1;
	document.frmCadDocumento.action = "cadDocumentos.asp";
	document.frmCadDocumento.submit();
}
function ApenasLetras(e, t) {
    try {
        if (window.event) {
            var charCode = window.event.keyCode;
        } else if (e) {
            var charCode = e.which;
        } else {
            return true;
        }
        if (
            (charCode > 64 && charCode < 91) || 
            (charCode > 96 && charCode < 123) ||
            (charCode > 191 && charCode <= 255) // letras com acentos
        ){
            return true;
        } else {
            return false;
        }
    } catch (err) {
        alert(err.Description);
    }
}
</script>
</head>
<body>
<h1>Cadastro de Documentos</h1>

<form name="frmCadDocumento" id="frmCadDocumento" method="post">
<input type="hidden" id="Operacao" name="Operacao" />
Numero da Pasta: 
<%
   call abreConexao
   sql = "SELECT CodigoItensModuloFace, NumeroPasta FROM TB_Recipiente order by NumeroPasta"
   set rs = conn.execute(sql)
%>
<select name="NumPasta" id="NumPasta">
	<option value="">Selecionar</option>
<%do while not rs.eof%>
	<option value="<%=rs("CodigoItensModuloFace")%>"><%=rs("NumeroPasta")%></option>
    <% rs.movenext
			loop
call fechaConexao%>
</select>
&nbsp;&nbsp;&nbsp;

N° Auto: 
<input type="text" name="txtNumAuto" id="txtNumAuto" size="13" onkeypress="somente_numero(txtNumAuto);" onblur="somente_numero(txtNumAuto);"/>
&nbsp;&nbsp;&nbsp;
Série: 
<input type="text" name="txtNumSerie" id="txtNumSerie" size="8" onkeypress="return ApenasLetras(event,this);"/>
&nbsp;&nbsp;&nbsp;<br /><br />
Observações:<br />
<textarea id="txtObs" name="txtObs" rows="8" cols="50"></textarea><br />
<p>
<input type="submit" name="btnCadastro" id="btnCadastro" value="Cadastrar" onclick="return cadastrar();"/>
</p>
</form>
</body>
</html>
