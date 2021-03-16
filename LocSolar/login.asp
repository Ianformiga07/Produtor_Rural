<!-- #include file="conexao.asp" -->
<%
usuario=request.form("txt_usuario")
senha=request.form("txt_senha")

sql=" select * from login where usuario='"&usuario&"' and senha='"&senha&"'"

set resultado=conexao.execute(sql)

if resultado.EOF Then
login=false
else
login=true
end if

if login=true Then
Session("logado")=true
response.redirect("cadastro_form.asp")
else
response.redirect("incorretos.htm")
end if
%>