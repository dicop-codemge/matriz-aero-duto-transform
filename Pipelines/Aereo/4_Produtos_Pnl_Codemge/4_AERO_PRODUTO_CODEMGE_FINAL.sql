-- CRIANDO A VIEW DE RELAÇÃO ENTRE PRODUTOS AEREOS COM PRODUTOS CODEMGE
CREATE VIEW vw_produtos_aero_codemge AS
select distinct pac.nome_produto_aereo, pac.nome_produto_codemge, rpr.id_produto_pnl35_corrigido
from aerea.vw_relacao_produtos_ratio rpr
left join aerea.produto_aero_codemge pac on (
	pac.nome_produto_codemge = rpr.produto_pnl35_corrigido
)
order by nome_produto_codemge;