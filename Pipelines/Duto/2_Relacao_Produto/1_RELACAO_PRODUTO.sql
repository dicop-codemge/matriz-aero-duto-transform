-- CRIANDO A RELAÇÃO PRODUTOS PNL PARA PRODUTOS PELT
insert into duto.relacao_produtos (
    id_macroproduto_peltmg,
    nome_macroproduto_peltmg,
    id_produto_pnl50,
    produto_pnl50,
    tonelada_total, 
    valor_total
)
select 
    id_macroproduto_peltmg,
    nome_macroproduto_peltmg,
    id_produto_pnl50,
    produto_pnl50,
    SUM(tonelada) as tonelada_total,
    SUM(valor) as valor_total
from aerea.matriz_2019_reduzida_utp
group by
    id_macroproduto_peltmg,
    nome_macroproduto_peltmg,
    id_produto_pnl50,
    produto_pnl50
order by id_produto_pnl50 asc;