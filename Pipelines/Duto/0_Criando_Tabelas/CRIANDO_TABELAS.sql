CREATE TABLE duto.matriz_duto (
	cdorigem int4 NULL,
	vhr_origem varchar(50) NULL,
	uf_origem varchar(50) NULL,
	cddestino int4 NULL,
	vhr_destino varchar(50) NULL,
	uf_destino varchar(50) NULL,
	id_produto int4 NULL,
	"vhr_produto_PNL250" varchar(50) NULL,
	" ton " varchar(50) NULL
);

CREATE TABLE duto.matriz_2019_reduzida_utp (
	id_utp_origem varchar NULL,
	id_utp_destino varchar NULL,
	ncm int4 NULL,
	id_macroproduto_peltmg int4 NULL,
	nome_macroproduto_peltmg varchar NULL,
	id_produto_pnl35_original int4 NULL,
	produto_pnl35_original varchar NULL,
	id_produto_pnl35_corrigido int4 NULL,
	produto_pnl35_corrigido varchar NULL,
	id_produto_pnl50 int4 NULL,
	produto_pnl50 varchar NULL,
	tonelada numeric NULL,
	valor float4 NULL
);

CREATE TABLE duto.relacao_produtos (
	id_produto_pnl50 int4 NULL,
	produto_pnl50 varchar(50) NULL,
	id_macroproduto_peltmg int4 NULL,
	nome_macroproduto_peltmg varchar(64) NULL,
	tonelada_total float4 NULL,
	valor_total float4 NULL
);

CREATE TABLE aerea.vw_agregacao_municipio (
	id_agregacao_municipio int4 NULL,
	id_municipio int4 NULL,
	nome_municipio varchar NULL,
	id_uf int4 NULL,
	nome_uf varchar NULL,
	sigla_uf varchar NULL,
	id_rgi int4 NULL,
	regiao_reografica_imediata varchar NULL,
	id_rgint int4 NULL,
	regiao_reografica_intermediaria varchar NULL,
	id_utp int4 NULL,
	sede_utp varchar NULL,
	id_zona_pnl int4 NULL,
	nome_zona varchar NULL
);

CREATE TABLE aerea.zona_pnl (
	id_zona_pnl int4 NULL,
	cdmunibge int4 NULL,
	nome_zona varchar(50) NULL,
	cdmunmdic int4 NULL,
	idvisum_mr int4 NULL,
	nmmr_pnl varchar(50) NULL,
	ufpnl varchar(50) NULL,
	regiao varchar(50) NULL,
	pais varchar(50) NULL,
	continente varchar(50) NULL,
	longitude float4 NULL,
	latitude float4 NULL
);