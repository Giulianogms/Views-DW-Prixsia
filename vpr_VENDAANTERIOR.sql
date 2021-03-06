CREATE OR REPLACE VIEW vpr_VENDAANTERIOR AS(

SELECT FV.DTAOPERACAO DTA_VDA, FV.NROEMPRESA NROEMP, FV.SEQPRODUTO, SUM(FV.QTDOPERACAO) VENDA_QTD, SUM(FV.VVLROPERACAOBRUTO) VLR_VENDA_BTA, 
       SUM(FV.VLROPERACAO) VLR_VENDA_LIQ,
       SUM(FV.VVLRCTOBRUTO) CUSTO_BRUTO, SUM(FV.VVLRCTOLIQUIDO) CUSTO_LIQUIDO, SUM(FV.VLROPERACAO) - SUM(FV.VVLRCTOBRUTO) LUCRO,
       ROUND(((SUM(FV.VLROPERACAO) - SUM(FV.VVLRCTOBRUTO) ) / SUM(FV.VVLRCTOBRUTO)) * 100,1) MARGEM, COUNT(DISTINCT(FV.SEQNF)) QTD_CUPOM,
       DECODE(FV.INDPROMOCAO, 'S','SIM','N','NAO') INDPROMOCAO, 
       DECODE(FV.NROSEGMENTO, '1','CD-GRU','2','NAGUMO-SP','3','RIO DE JANEIRO','4','MIXTER-ATACAREJO','5','E-COMMERCE') SEGMENTO
       
FROM FATO_VENDA FV
WHERE FV.CODGERALOPER IN (37,48,123,610,615,613,810,916,910,911)
AND FV.DTAOPERACAO BETWEEN TRUNC(SYSDATE - 365) AND TRUNC(SYSDATE -1)

GROUP BY FV.DTAOPERACAO, FV.SEQPRODUTO, FV.NROEMPRESA, FV.INDPROMOCAO, FV.NROSEGMENTO

);
