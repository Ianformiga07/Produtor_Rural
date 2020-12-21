<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file ="lib/conexao.asp"-->
<!--#include file="fpdf/fpdf.asp"-->
<%
'// criando o pdf
dim CPFProd, CodProp,Cod
CPFProd = request("CPF")
CodProp = request("Cod")

call abreConexao
   sql = "SELECT Produtor.CPF, Produtor.Nome as NomeProdutor,Produtor.CodigoMunicipio, Propriedade.Codigo, Propriedade.Nome,Propriedade.CodigoMunicipio, TipoExploracao.Descricao FROM ExploracaoPecuaria INNER JOIN Produtor ON Produtor.CPF = ExploracaoPecuaria.CPFCNPJProdutor INNER JOIN Propriedade ON Propriedade.Codigo = ExploracaoPecuaria.CodigoPropriedade INNER JOIN TipoExploracao ON TipoExploracao.Codigo = ExploracaoPecuaria.TipoExploracao WHERE CPFCNPJProdutor = '"&CPFProd&"' AND CodigoPropriedade = '"&CodProp&"'"

   set rs1 = conn.execute(sql)


set pdf=CreateJsObject("FPDF")
logoTo = "Imagens/logo-to.jpg"
logoAdapec = "Imagens/logo_adapec.jpg"
Set pdf=CreateJsObject("FPDF")

'// aki poderemos adcionar várias funções como titulos padroes para todas as páginasm numeração de páginas e etc.

'// montando o corpo do pdf, setando o tipo da folha, tipo de medida e o tamanho da folha
pdf.CreatePDF "P","mm","A4"
pdf.SetPath("fpdf/")
pdf.Open()

'// adcionando página
pdf.AddPage()



'// setando grossura da linha
pdf.SetLineWidth(0.3)

pdf.Image logoTo, 105, 5, 45, 20, "JPG"
pdf.Image logoAdapec, 60, 5, 40, 20, "JPG"

'// setando linhas, reapare que, as medidas são feitas em x1, y1, x2 e y2, començando no ponto inicial de x e y e finalizando nos mesmo.
'pdf.Line "7","50","201","50"
'// criamos aki uma linha horizontal, a linha pode ser feita de qualquer jeito, vertical, diagonal e td mais, somente setando os valores de x e y.

'// escrevendo um texto
'// setando fonte e tamanho
pdf.SetFont "Helvetica","B",12
pdf.Text "58","32","DADOS DE VINCULAÇÃO PRODUTOR RURAL"
'// na linha acima setamos primeiro a função Text, depois aonde começamos a escrever apartir do x e y e por fim o texto a ser adcionado
'// presta-se atenção aki, pois quem precisa fazer uma leitura de banco de dados ou resgatar uma session para ser impressa no pdf, n se pode usar as ' ' na função de texto
'Create Header Cells
pdf.SetFont "Helvetica","B",10
pdf.Text 10, 45, "INFORMAÇÕES PRODUTOR RURAL"
pdf.SetFont "Helvetica","",10


pdf.SetFont "Helvetica","",10
'BLOCO 01 SERVIDORES 1 -------------------------------------------------------------------------------------
pdf.SetXY 10, 47
pdf.SetFont "Helvetica","B",10
pdf.setfillcolor 235
pdf.Cell 30,4,"CPF",1,0,"C",1
pdf.Cell 60,4,"PRODUTOR",1,0,"C",1
pdf.Cell 60,4,"NOME PROPRIEDADE",1,0,"C",1
pdf.Cell 40,4,"TIPO EXPLORAÇÃO",1,0,"C",1
pdf.SetFont "Helvetica","",10
pdf.Ln()

while not rs1.EOF
'Example Data 
cpf1 = rs1("CPF")
prod1 = rs1("NomeProdutor")
propNome1 = rs1("Nome")
exp1 = rs1("Descricao")

pdf.Cell 30,5,""&trim(cpf1)&"",1,0,"L"
pdf.Cell 60,5,""&prod1&"",1,0,"L"
pdf.Cell 60,5,""&propNome1&"",1,0,"L"
pdf.Cell 40,5,""&(exp1)&"",1,0,"L"
'Add Line Break
pdf.Ln() 
rs1.movenext
wend
'BLOCO 02 ESCALA 1  -------------------------------------------------------------------------------------

'// fechando o pdf
pdf.Close()
pdf.Output()
%>