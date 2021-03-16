<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/Conexao.asp"-->
<%
IF REQUEST("Operacao") = 1 THEN
call abreConexao
sql = "INSERT INTO CadLogin(CPF, NomeCompleto, Email, Senha) VALUES ('"&replace(replace(request.form("cpf"),".",""),"-","")&"', '"&request.form("nome_cad")&"', '"&request.form("email_cad")&"', '"&request.form("senha_cad")&"')"
conn.execute(sql)
call fechaConexao
response.Redirect("login.asp")
END IF
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" type="text/css" href="css/style.css" />
<title>Cadastro de Login</title>
<script src="javascript/Mascara.js"></script>
<script type="text/javascript">
function validar()
{
	var senha = frmCadLogin.senha_cad.value;
	
	if(document.frmCadLogin.cpf.value == "")
	{
		alert("Obrigatorio digitar o CPF");
		document.frmCadLogin.cpf.focus();
		return false;
	}
	else
	 if(!ValidarCPF(document.frmCadLogin.cpf.value.replace(".","").replace(".","").replace("-","")))
	 {
	   alert("CPF Invalido ou está na formatação errada 000.000.000-00");
	   return false
	 }
	 	 if(document.frmCadLogin.nome_cad.value == "")
	{
		alert("Obrigatorio digitar o digitar o Nome!");
		document.frmCadLogin.nome_cad.focus();
		return false;
	}
	 	 if(document.frmCadLogin.email_cad.value == "")
	{
		alert("Obrigatorio digitar o digitar o E-mail!");
		document.frmCadLogin.email_cad.focus();
		return false;
	}
	if(document.frmCadLogin.senha_cad.value == "")
	{
		alert("Obrigatorio digitar o digitar a senha!");
		document.frmCadLogin.senha_cad.focus();
		return false;
	}else if(senha.length < 8){
		alert('A senha deve ter no mínimo 8 caracteres');
		document.frmCadLogin.senha.focus();
		return false;
		}
	return true;
}

function cadastro()
{
	if(validar() == false)
	return false;
	
	document.frmCadLogin.Operacao.value = 1;
	document.frmCadLogin.action = "CadLogin.asp";
	document.frmCadLogin.submit();
}

</script>

</head>
<body>

<div class="container" >
    <a class="links" id="paracadastro"></a>
    <a class="links" id="paralogin"></a>
    
    <div class="content">      
      <!--FORMULÁRIO DE CADASTRO-->
      <div id="cadastro">
        <form method="post" name="frmCadLogin" onsubmit="return validar();"> 
        <input type="hidden" name="Operacao" id="Operacao" />
          <h1>Cadastro</h1> 
          <p> 
            <label for="cpf">CPF</label>
            <input id="cpf" name="cpf" onKeyPress="MascaraCPF(cpf)" required="required" type="text" placeholder="000.000.000-00" maxlength="14" onblur="MascaraCPF(cpf);verificar_cadastro();"/>
          </p>
          
          <p> 
            <label for="nome_cad">Seu nome</label>
            <input id="nome_cad" name="nome_cad" required="required" type="text" placeholder="Luiz Augusto" />
          </p>
          
          <p> 
            <label for="email_cad">Seu e-mail</label>
            <input id="email_cad" name="email_cad" required="required" type="email" placeholder="contato@htmlecsspro.com"/> 
          </p>
          
          <p> 
            <label for="senha_cad">Sua senha</label>
            <input id="senha_cad" name="senha_cad"  minlength="8" type="password"  placeholder="1234"/>
          </p>
          
          <p> 
            <input type="submit" value="Cadastrar" onclick="return cadastro();"/> 
          </p>
          
          <p class="link">  
            Já tem conta?
            <a href="login.asp"> Ir para Login </a>
          </p>
        </form>
      </div>
    </div>
  </div> 
</body>
</html>
