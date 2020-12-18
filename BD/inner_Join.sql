SELECT Produtor.CPF, Produtor.Nome as NomeProdutor,Produtor.CodigoMunicipio, Propriedade.Codigo, Propriedade.Nome,Propriedade.CodigoMunicipio, TipoExploracao.Descricao
FROM ExploracaoPecuaria
INNER JOIN Produtor 
ON Produtor.CPF = ExploracaoPecuaria.CPFCNPJProdutor
INNER JOIN Propriedade
ON Propriedade.Codigo = ExploracaoPecuaria.CodigoPropriedade
INNER JOIN TipoExploracao
ON TipoExploracao.Codigo = ExploracaoPecuaria.TipoExploracao
ORDER BY NomeProdutor;