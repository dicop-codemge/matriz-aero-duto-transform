-- CRIANDO A RELAÇÃO PRODUTOS PNL PARA PRODUTOS PELT
insert into relacao_produtos (
    id_macroproduto_peltmg, 
    nome_macroproduto_peltmg, 
    id_produto_pnl35_original, 
    produto_pnl35_original, 
    id_produto_pnl35_corrigido, 
    produto_pnl35_corrigido, 
    tonelada_total, 
    valor_total
)
select 
    id_macroproduto_peltmg, 
    nome_macroproduto_peltmg, 
    id_produto_pnl35_original, 
    produto_pnl35_original, 
    id_produto_pnl35_corrigido, 
    produto_pnl35_corrigido, 
    SUM(tonelada) as tonelada_total, 
    SUM(valor) as valor_total
from matriz_2019_reduzida_utp
group by 
    id_produto_pnl35_original,
    produto_pnl35_original,
    id_produto_pnl35_corrigido,
    produto_pnl35_corrigido,
    id_macroproduto_peltmg,
    nome_macroproduto_peltmg
order by id_produto_pnl35_corrigido asc;