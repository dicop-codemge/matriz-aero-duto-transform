
CREATE TABLE aerea.matriz_2019_reduzida_utp (
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

CREATE TABLE aerea.matriz_aerea (
	origem_pnl int4 NULL,
	destino_pnl int4 NULL,
	utp_o int4 NULL,
	utp_d int4 NULL,
	sede_o int4 NULL,
	sede_d int4 NULL,
	ncm int4 NULL,
	xo varchar(50) NULL,
	yo varchar(50) NULL,
	xd varchar(50) NULL,
	yd varchar(50) NULL,
	aereo_2017 varchar(50) NULL,
	duto_2017 varchar(50) NULL,
	aereo_2035_ref varchar(50) NULL,
	duto_2035_ref varchar(50) NULL,
	aereo_2035_transf varchar(50) NULL,
	duto_2035_transf varchar(50) NULL,
	fluxo varchar(50) NULL,
	preco_medio varchar(50) NULL,
	valor_2017 varchar(50) NULL,
	valor_2035_ref varchar(50) NULL,
	valor_2035_transf varchar(50) NULL,
	valor_duto_2017 varchar(50) NULL,
	valor_duto_2035 varchar(50) NULL,
	uf_o varchar(50) NULL,
	uf_d varchar(50) NULL,
	uf1 varchar(50) NULL,
	uf2 varchar(50) NULL,
	tx_2017_2023 varchar(50) NULL,
	aereo_2023 float4 NULL,
	matriz_formato_pnl2035_revisado varchar(50) NULL,
	subdivisao_de_matriz_aereo int4 NULL
);

CREATE TABLE aerea.produto_aero_codemge (
	nome_produto_aereo varchar(50) NULL,
	nome_produto_codemge varchar(50) NULL
);

CREATE TABLE aerea.relacao_produtos (
	id_produto_pnl35_original int4 NULL,
	produto_pnl35_original varchar(50) NULL,
	id_produto_pnl35_corrigido int4 NULL,
	produto_pnl35_corrigido varchar(50) NULL,
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