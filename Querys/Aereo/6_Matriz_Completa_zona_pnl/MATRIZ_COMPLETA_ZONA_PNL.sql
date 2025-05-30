-- CRIANDO TABELA DE MACRO PRODUTO PELTMG PARA RELACIONAR MATRIZ AEREA
create materialized view matriz_cargas_codemge.matriz_2019_completa_macroprod_infra_codemge_pnl_ratio as 
with matriz_completa_pnl as (
	select zp1.id_utp as utp_o, zp2.id_utp as utp_d, zona_pnl_origem, zona_pnl_destino, id_macroproduto_peltmg, tonelada, valor 
	from matriz_cargas_codemge.matriz_2019_completa_macroprod_infra_codemge_pnl mcm
	left join public.zona_pnl zp1 on ( zp1.id_zona_pnl = mcm.zona_pnl_origem )
	left join public.zona_pnl zp2 on ( zp2.id_zona_pnl = mcm.zona_pnl_destino )
	--limit 1000000a
),
agrupamento_mc as (
	select utp_o, utp_d, zona_pnl_origem, zona_pnl_destino, id_macroproduto_peltmg, SUM(tonelada) as tonelada, SUM(valor) as valor
	from matriz_completa_pnl
	group by utp_o, utp_d, zona_pnl_origem, zona_pnl_destino, id_macroproduto_peltmg
),
ratio_ton as (
    select mc.utp_o, mc.utp_d, mc.zona_pnl_origem, mc.zona_pnl_destino, mc.id_macroproduto_peltmg,
        (mc.tonelada / NULLIF(azp.tonelada, 0)) as ton_ratio,
        (mc.valor / NULLIF(azp.valor, 0)) as val_ratio
    from matriz_completa_pnl mc
    left join agrupamento_mc azp on ( 
        azp.utp_o = mc.utp_o and 
        azp.utp_d = mc.utp_d and 
        azp.zona_pnl_origem = mc.zona_pnl_origem and 
        azp.zona_pnl_destino = mc.zona_pnl_destino and
        azp.id_macroproduto_peltmg = mc.id_macroproduto_peltmg
    )
)
select *
from ratio_ton