<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
dim existeCad
IF REQUEST("Operacao") = 1 then
call abreConexao
	sql = "Select CPF, Senha From CadLogin WHERE CPF = '"&replace(replace(request.form("cpf"), ".", ""),"-", "")&"' AND Senha = '"&request.form("senha_login")&"'"
	set rs = conn.execute(sql)
	if not rs.eof then
	Session("CPF_Usu") = replace(replace(request.form("cpf"),".",""),"-","")
	if replace(replace(request.form("cpf"), ".", ""),"-", "") = rs("CPF") and request.form("senha_login") = rs("Senha") then
			existeCad = true
		else
			existeCad = false
		rs.close
		set rs = nothing
		call fechaConexao
	end if
	end if

if existeCad = true then
response.Redirect("index.asp?cpf="&Session("CPF_Usu")&"")
elseif existeCad = false then
response.redirect("login.asp?Resp=2")
else 
response.write("Nada Encotrado!")
end if

END IF
%>

<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <!-- Font-icon css-->
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Login</title>
<style type="text/css">
.messagem_informacao {
    background: none repeat scroll 0 0 #F00;
    border: 2px solid #666;
    top:  -55px;
    left: 300px;
	color:#FFF;
	font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
	font-size:20px;	
}
.error {
	border-color: #e8273b;
	color: #000;
	background-color: #ed5565;
}

</style>
<script src="javascript/Mascara.js"></script>
<script type="text/javascript">

function validar()
{
	if(document.frmLogin.cpf.value == "")
	{
		alert("Obrigatorio digitar o CPF");
		document.frmLogin.cpf.focus();
		return false;
	}
	else
	 if(!ValidarCPF(document.frmLogin.cpf.value.replace(".","").replace(".","").replace("-","")))
	 {
	   alert("CPF Invalido ou está na formatação errada 000.000.000-00");
	   return false
	 }
		if(document.frmLogin.senha_login.value == "")
	{
		alert("Obrigatorio digitar a Senha");
		document.frmLogin.senha_login.focus();
		return false;
	}
	return true
}

function login(cpf)
{
	if(validar() == false)
	return false;
	
	document.frmLogin.Operacao.value = 1;
	document.frmLogin.action = "login.asp";
	document.frmLogin.submit();
}


</script>
  </head>
  <center>
<%if request("Resp") = 1 or request("Resp") = 2 then
	if request("Resp") = 1 then
	mensagem = "Cadastro Realizado com Sucesso!"
	else
	mensagem = "Email ou Senha estão incorretos!"
	end if
%>
<div class="messagem_informacao" align="center"><%=mensagem%></div>
<%end if%>
</center>
<br/>
<body>
    <section class="material-half-bg">
      <div class="cover"></div>
    </section>
    <section class="login-content">

      <div class="login-box">

    <div class="container" >
    <a class="links" id="paracadastro"></a>
    <a class="links" id="paralogin"></a>
    
    <div class="content">      
      <!--FORMULÁRIO DE LOGIN-->
      <div id="login">
        <form method="post" name="frmLogin" id="frmLogin" onsubmit="return validar();">
        <input type="hidden" name="Operacao" id="Operacao" /> 
        <input type="hidden" name="CpfVisualizar" id="CpfVisualizar" /> 
          <h1>Login</h1> 
          <p> 
            <label for="cpf">CPF(Somente Números)</label>
            <input id="cpf" name="cpf" onKeyPress="MascaraCPF(cpf)" required="required" type="text" placeholder="000.000.000-00" maxlength="14" onblur="MascaraCPF(cpf);"/>
          </p>
          
          <p> 
            <label for="senha_login">Sua senha</label>
            <input id="senha_login" name="senha_login" required="required" type="password" placeholder="1234" maxlength="20"/> 
          </p>
          
          <p> 
            <input type="checkbox" name="manterlogado" id="manterlogado" value="" /> 
            <label for="manterlogado">Manter-me logado</label>
          </p>
          
          <p> 
            <input type="submit" value="Entrar" onclick="return login();"/> 
          </p>
          
          <p class="link">
            Ainda não tem conta?
            <a href="CadLogin.asp">Cadastre-se</a>
          </p>
        </form>
      </div>


    <!-- Essential javascripts for application to work-->
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
    <!-- The javascript plugin to display page loading on top-->
    <script src="js/plugins/pace.min.js"></script>

  </body>
</html>