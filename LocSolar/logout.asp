<%
if not Session("logado")=true Then
response.redirect("nlogado2.htm")
end if

Session.Abandon()
Response.redirect("login_form.asp")
%>