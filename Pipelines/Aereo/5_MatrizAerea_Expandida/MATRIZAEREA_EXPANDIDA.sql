-- CRIANDO A VIEW MATRIZ AEREA PNL35 EXPANDIDA
create view vw_matriz_aerea_expandida as
with matriz_aerea_pnl35 as ( -- AMARRANDO PRODUTOS DA MATRIZ AEREA COM PRODUTOS PNL35 CODEMGE COM SEUS IDS
	select 
		ma.utp_o,
		ma.utp_d,
		vpac.id_produto_pnl35_corrigido,
		vpac.nome_produto_codemge as produto_pnl35_corrigidol,
		ma.aereo_2023 as tonelada
	from aerea.matriz_aerea ma
		left join vw_produtos_aero_codemge vpac on vpac.nome_produto_aereo::text = ma.matriz_formato_pnl2035_revisado::text
), 
expansao_matriz_aerea_pnl35_para_macroproduto_codemge as ( -- REALIZANDO A EXPANSÃO DA MATRIZ AEREA COM BasE NA RELAÇÃO DA DISTRIBUIÇÃO DOS PRODUTOS RODOVIARIOS
	select 
		map.utp_o,
		map.utp_d,
		rpr.id_macroproduto_peltmg,
		rpr.nome_macroproduto_peltmg,
		map.tonelada,
		rpr.ton_ratio
	from matriz_aerea_pnl35 map
		left join vw_relacao_produtos_ratio rpr on map.id_produto_pnl35_corrigido = rpr.id_produto_pnl35_corrigido
), 
matriz_expandida_tonelada_corrigida as (  -- REALIZANDO CORREÇÃO Das TONELADas
	select 
		exp.utp_o,
		exp.utp_d,
		exp.id_macroproduto_peltmg,
		exp.nome_macroproduto_peltmg,
		exp.tonelada * exp.ton_ratio as tonelada
	from expansao_matriz_aerea_pnl35_para_macroproduto_codemge as exp
),
agrupando_tons as ( -- AGRUPANDO FLUXOS DUPLICADOS
	select 
		utp_o, utp_d, id_macroproduto_peltmg, nome_macroproduto_peltmg, SUM(tonelada) as tonelada
	from matriz_expandida_tonelada_corrigida
	group by utp_o, utp_d, id_macroproduto_peltmg, nome_macroproduto_peltmg
	order by id_macroproduto_peltmg asc
)
select *
from agrupando_tons;