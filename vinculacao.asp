<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<%
dim existeCad
function verificaExploracao()
call abreConexao
 SQL2 = "SELECT COUNT (*) as qt FROM ExploracaoPecuaria  WHERE CPFCNPJProdutor = '"&request.form("txtCPFProd")&"' AND CodigoPropriedade = '"&request.form("txtCodProp")&"'"
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
	IF verificaExploracao() = FALSE THEN
	call abreConexao
	sql = "INSERT INTO ExploracaoPecuaria(CPFCNPJProdutor, CodigoPropriedade, TipoExploracao) VALUES ('"&request.form("txtCPFProd")&"', '"&request.form("txtCodProp")&"','"&request.form("TipoExploracao")&"')"
	conn.execute(sql)
	call fechaConexao
	response.Redirect("vinculacao.asp?Resp=1")
	END IF
ELSEIF REQUEST("Operacao") = 2 THEN
	call abreConexao
	sql = "Select CPFCNPJProdutor, CodigoPropriedade, TipoExploracao FROM ExploracaoPecuaria WHERE CPFCNPJProdutor = '"&request.form("CpfVisualizar")&"' AND CodigoPropriedade = '"&request.form("Codigo_Propriedade")&"'"
	set rs = conn.execute(sql)
	if not rs.eof then
	CPFCNPJProdutor = rs("CPFCNPJProdutor")
	CodigoPropriedade = rs("CodigoPropriedade")
	TipoExploracao = clng(rs("TipoExploracao"))
	Existe = 1
	end if
	call fechaConexao
ELSEIF REQUEST("Operacao") = 3 THEN
	call abreConexao
	sql = "UPDATE ExploracaoPecuaria SET TipoExploracao = '"&request.Form("TipoExploracao")&"' WHERE CPFCNPJProdutor = '"&request.Form("txtCPFProd")&"' AND CodigoPropriedade = '"&request.form("txtCodProp")&"'"
	conn.execute(sql)
	call fechaConexao
	response.Redirect("vinculacao.asp?Resp=2")
END IF
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Vinculação</title>
<style type="text/css">
.messagem_informacao {
    background: none repeat scroll 0 0 #00FFCC;
    border: 2px solid #00FF33;
    top:  -55px;
    left: 300px;	
}
.sucesso {
	border-color: #87c940;
	color: #FFF;
	background-color: #a0d468;
}

.error {
	border-color: #e8273b;
	color: #FFF;
	background-color: #ed5565;
}

</style>
<script type="text/javascript">
function validar()
{
	if(document.frmVinculacao.txtCodProp.value == "")
	{
		alert("Obrigatorio preencher o campo!");
		document.frmVinculacao.txtCodProp.focus();
		return false;
		}
	if(document.frmVinculacao.txtCPFProd.value == "")
	{
		alert("Obrigatorio preencher o campo!");
		document.frmVinculacao.txtCPFProd.focus();
		return false;
		}
	if(document.frmVinculacao.TipoExploracao.value == "")
	{
		alert("Obrigatorio escolher Tipo de Exploração!");
		document.frmVinculacao.TipoExploracao.focus();
		return false;
	}		
}
function cadastrar()
{
	if(validar() == false)
	return false;
	
	document.frmVinculacao.Operacao.value = 1;
	document.frmVinculacao.action = "vinculacao.asp";
	document.frmVinculacao.submit();
}
function visualizar(cpf, Codigo)
{
	document.frmVinculacao.Operacao.value = 2;
	document.frmVinculacao.CpfVisualizar.value = cpf;
	document.frmVinculacao.Codigo_Propriedade.value = Codigo;
	document.frmVinculacao.action = "vinculacao.asp";
	document.frmVinculacao.submit();
}
function alterar()
{
	if(validar() == false)
	return false;
	
	document.frmVinculacao.Operacao.value = 3;
	document.frmVinculacao.action = "vinculacao.asp";
	document.frmVinculacao.submit();
}
function abrir() {
  window.open('BuscarProp.asp', 'janela', 'width=750, height=300, top=100, left=699, scrollbars=no, status=no, toolbar=no, location=no, menubar=no, resizable=no, fullscreen=no')
}
function abrir2() {
  window.open('BuscarProdutor.asp', 'janela', 'width=750, height=300, top=100, left=699, scrollbars=no, status=no, toolbar=no, location=no, menubar=no, resizable=no, fullscreen=no')
}


</script>
</head>
<body>
<div id="divCenter" align="center">
<form name="frmVinculacao" onsubmit="validar();" method="post">
<input type="hidden" name="Operacao" id="Operacao" />
<input type="hidden" name="CpfVisualizar" id="CpfVisualizar"/>
<input type="hidden" name="Codigo_Propriedade" id="Codigo_Propriedade"/>
<fieldset style="width: 35%;">
<legend align="center">Vinculação Propriedade/Produtor</legend>
<p>
Codigo Propriedade
<input type="text" name="txtCodProp" id="txtCodProp" value="<%=CodigoPropriedade%>" readonly/>&nbsp;&nbsp;&nbsp;
<input type="button" value="Propriedade" onclick="abrir()"/> 
</p>
<p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
CNPJ/CPF
<input type="text" name="txtCPFProd" id="txtCPFProd" value="<%=CPFCNPJProdutor%>" readonly />&nbsp;&nbsp;&nbsp;
<input type="button" value="Produtor" onclick="abrir2()"/>
</p>
Exploração Pecuaria:
<%
   call abreConexao
   sql = "SELECT Codigo, Descricao FROM TipoExploracao order by Codigo"
   set rs_TipoExploracao = conn.execute(sql)
%>
<select name="TipoExploracao" id="TipoExploracao">
	<option value="">Selecionar</option>
<%do while not rs_TipoExploracao.eof%>
	<option value="<%=rs_TipoExploracao("Codigo")%>"<%if clng(rs_TipoExploracao("Codigo")) = TipoExploracao then%>selected<%end if%>><%=rs_TipoExploracao("Descricao")%></option>
    <% rs_TipoExploracao.movenext
			loop
call fechaConexao%>
</select>&nbsp;&nbsp;&nbsp;
<input type="submit" name="btnExploracao" value="<%if Existe = 1 then%>Alterar<%else%>Exploração Pecuaria<%end if%>" onclick="return <%if Existe = 1 then%>alterar();<%else%>cadastrar();<%end if%>"/>
</fieldset>
</form>
 </div>
 <p>
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
  <td align="center"><a href="#" onclick="visualizar(<%=rs("CPF")%>, <%=rs("Codigo")%>)"><%=rs("CPF")%></a></td>
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
</p>

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

<div class="alerta error" align="center">
<%if existeCad = true then
'O Produtor já está vinculado a essa Propriedade!
response.write("O Produtor já está vinculado a essa Propriedade!")
else
end if
%>

</div>
</body>
</html>
