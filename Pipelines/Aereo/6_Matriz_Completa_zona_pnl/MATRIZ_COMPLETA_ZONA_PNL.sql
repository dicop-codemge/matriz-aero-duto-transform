-- CRIANDO TABELA DE MACRO PRODUTO PELTMG PARA RELACIONAR MATRIZ AEREA
create materialized view matriz_cargas_codemge.matriz_2019_completa_macroprod_infra_codemge_pnl_ratio as 
with matriz_completa_pnl as (
    select zp1.id_utp as utp_o,
        zp2.id_utp as utp_d,
        mcm.zona_pnl_origem,
        mcm.zona_pnl_destino,
        mcm.id_macroproduto_peltmg,
        mcm.tonelada,
        mcm.valor
    from matriz_cargas_codemge.matriz_2019_completa_macroprod_infra_codemge_pnl mcm
    left join zona_pnl zp1 on zp1.id_zona_pnl = mcm.zona_pnl_origem
    left join zona_pnl zp2 on zp2.id_zona_pnl = mcm.zona_pnl_destino
), agrupamento_mc as (
    select
        mcp.utp_o,
        mcp.utp_d,
        mcp.id_macroproduto_peltmg,
        sum(mcp.tonelada) as tonelada,
        sum(mcp.valor) as valor
    from matriz_completa_pnl mcp
    GROUP BY mcp.utp_o, mcp.utp_d, mcp.id_macroproduto_peltmg
), ratio_ton as (
    select mc.utp_o,
        mc.utp_d,
        mc.zona_pnl_origem,
        mc.zona_pnl_destino,
        mc.id_macroproduto_peltmg,
        mc.tonelada / NULLIF(azp.tonelada, 0) as ton_ratio,
        mc.valor / NULLIF(azp.valor, 0) as val_ratio
    from matriz_completa_pnl mc
    left join agrupamento_mc azp on azp.utp_o = mc.utp_o and azp.utp_d = mc.utp_d and azp.id_macroproduto_peltmg = mc.id_macroproduto_peltmg
)
select 
	utp_o,
    utp_d,
    zona_pnl_origem,
    zona_pnl_destino,
    id_macroproduto_peltmg,
    ton_ratio,
    val_ratio
from ratio_ton
order by utp_o, utp_d, zona_pnl_origem, zona_pnl_destino, id_macroproduto_peltmg;