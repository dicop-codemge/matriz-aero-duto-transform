-- PEGANDO MATRIZ AEREA EXPANDIDA POR UTP E EXPANDINDO NOVAMENTE PARA ZONA PNL
create materialized view matriz_cargas_codemge.mvw_matriz_aerea_corrigida as 
with zona_pnl_uf as (
	select 
		distinct
		cast(id_utp as integer) as id_utp,
		id_uf
	from (
		select 
			cast(zp.id_utp as text) as id_utp,
			am.id_uf
		from zona_pnl zp
		left join public.vw_agregacao_municipio am on  (
			cast(zp.id_utp as text) = cast(am.id_utp as text)
		)
		where zp.id_utp <> ''
	) as zona
	order by id_utp
), matriz_aerea_expandida_udp_cvt as (
	select 
		cast(maeu.utp_o as integer), 
		cast(maeu.utp_d as integer), 
		maeu.id_macroproduto_peltmg, 
		maeu.tonelada
	from matriz_cargas_codemge.matriz_aerea_expandida_udp maeu
)
select 
	maeu.utp_o, 
	maeu.utp_d, 
	mcmicpr.zona_pnl_origem,
	mcmicpr.zona_pnl_destino,
	zp1.id_utp as uf_o,
	zp2.id_utp as uf_d,
	maeu.id_macroproduto_peltmg, 
	SUM(maeu.tonelada * mcmicpr.ton_ratio) as tonelada
from matriz_aerea_expandida_udp_cvt maeu
left join matriz_cargas_codemge.mvw_matriz_2019_completa_ratio_uf_macroproduto mcmicpr on (
	maeu.utp_o = mcmicpr.utp_o and
	maeu.utp_d  = mcmicpr.utp_d and
	maeu.id_macroproduto_peltmg = mcmicpr.id_macroproduto_peltmg
)
left join zona_pnl_uf zp1 on zp1.id_utp = maeu.utp_o
left join zona_pnl_uf zp2 on zp2.id_utp = maeu.utp_d
group by 
	maeu.utp_o,
	maeu.utp_d,
	mcmicpr.zona_pnl_origem,
	mcmicpr.zona_pnl_destino,
	zp1.id_utp,
	zp2.id_utp,
	maeu.id_macroproduto_peltmg