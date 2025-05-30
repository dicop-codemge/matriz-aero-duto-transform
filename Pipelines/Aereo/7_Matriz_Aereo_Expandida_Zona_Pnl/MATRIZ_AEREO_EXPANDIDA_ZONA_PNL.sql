-- PEGANDO MATRIZ AEREA EXPANDIDA POR UTP E EXPANDINDO NOVAMENTE PARA ZONA PNL
create materialized view matriz_cargas_codemge.mvw_matriz_aerea_corrigida as 
select 
	maeu.utp_o, 
	maeu.utp_d, 
	mcmicpr.zona_pnl_origem,
	mcmicpr.zona_pnl_destino,
	maeu.id_macroproduto_peltmg, 
	SUM(maeu.tonelada * mcmicpr.ton_ratio) as tonelada
from matriz_cargas_codemge.matriz_aerea_expandida_udp maeu
left join matriz_cargas_codemge.matriz_2019_completa_macroprod_infra_codemge_pnl_ratio mcmicpr on (
	cast(maeu.utp_o as text) = mcmicpr.utp_o and
	cast(maeu.utp_d as text) = mcmicpr.utp_d and
	maeu.id_macroproduto_peltmg = mcmicpr.id_macroproduto_peltmg
)
group by 
	maeu.utp_o,
	maeu.utp_d,
	mcmicpr.zona_pnl_origem,
	mcmicpr.zona_pnl_destino,
	maeu.id_macroproduto_peltmg