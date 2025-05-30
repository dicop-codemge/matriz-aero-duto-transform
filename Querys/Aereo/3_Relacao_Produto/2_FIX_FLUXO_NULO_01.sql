-- PEGA FLUXOS NULOS QUE FICARAM POR NCM E AGRUPA POR FLUXOS NÃO NULOS
CREATE VIEW vw_relacao_produtos AS
with matriz as (
	select
		ROW_NUMBER() OVER (ORDER BY id_macroproduto_peltmg) AS row_id,
		*
	from relacao_produtos
),
fluxo_null as ( -- FLUXO NULO
	select * 
	from matriz
	where
		id_produto_pnl35_original is null and id_produto_pnl35_corrigido is not null and id_macroproduto_peltmg is not null
    order by id_produto_pnl35_corrigido
),
fluxo_oposto_null as ( -- FLUXO OPOSTO DO NÃO NULO
	select *
	from matriz
	where row_id not in (select row_id from fluxo_null)
),
join_null_not_null as ( -- ADICIONANDO AS COLUNAS DO FLUXO NULO AO NÃO NULO
	select 
		mnn.row_id as row_id1,
		mn.row_id as row_id2,
		mnn.id_produto_pnl35_original, 
    	mnn.produto_pnl35_original, 
    	mnn.id_produto_pnl35_corrigido, 
    	mnn.produto_pnl35_corrigido, 
    	mnn.id_macroproduto_peltmg, 
    	mnn.nome_macroproduto_peltmg, 
    	mnn.tonelada_total as tonelada_total1,
    	mn.tonelada_total as tonelada_total2,
    	--(mnn.tonelada_total + coalesce(mn.tonelada_total, 0)) as tonelada_total, 
    	mnn.valor_total as valor_total1,
    	mn.valor_total as valor_total2
    	--(mnn.valor_total + coalesce(mn.valor_total, 0)) as valor_total
    	--mn.valor_total as valor_total2
	from fluxo_oposto_null mnn
	left join fluxo_null mn on (
    	mnn.id_produto_pnl35_corrigido = mn.id_produto_pnl35_corrigido and 
    	mnn.id_macroproduto_peltmg = mn.id_macroproduto_peltmg
	)
),
fluxo_duplicado as (
	select *
	from (
		select row_id2, count(*) as repeticoes
		from join_null_not_null
		group by row_id2
	) as fd
	where repeticoes > 1
),
remove_fluxo_duplicado as (
	select 
		id_produto_pnl35_original, 
		produto_pnl35_original, 
		id_produto_pnl35_corrigido, 
		produto_pnl35_corrigido, 
		id_macroproduto_peltmg, 
		nome_macroproduto_peltmg,
		(tonelada_total1 + coalesce(tonelada_total2,0) ) as tonelada_total,
		(valor_total1 + coalesce(valor_total2,0) ) as valor_total
	from (
		select
			id_produto_pnl35_original, 
			produto_pnl35_original, 
			id_produto_pnl35_corrigido, 
			produto_pnl35_corrigido, 
			id_macroproduto_peltmg, 
			nome_macroproduto_peltmg, 
			tonelada_total1,
			CASE
				WHEN row_id2 IN (select row_id2 from fluxo_duplicado) THEN 0
				ELSE tonelada_total2
			END as tonelada_total2,
			valor_total1,
			CASE
				WHEN row_id2 IN (select row_id2 from fluxo_duplicado) THEN 0
				ELSE valor_total2
			END as valor_total2
		from join_null_not_null
	) as rfd
),
fix_fluxo as (
	select * from (
		select 
			id_produto_pnl35_original, 
			produto_pnl35_original, 
			id_produto_pnl35_corrigido, 
			produto_pnl35_corrigido, 
			id_macroproduto_peltmg, 
			nome_macroproduto_peltmg,
			tonelada_total,
			valor_total
		from remove_fluxo_duplicado
		union all 
		select 
			id_produto_pnl35_original, 
			produto_pnl35_original, 
			id_produto_pnl35_corrigido, 
			produto_pnl35_corrigido, 
			id_macroproduto_peltmg, 
			nome_macroproduto_peltmg,
			tonelada_total,
			valor_total
		from matriz where row_id in (select row_id2 from fluxo_duplicado)
	) as u
	where
		id_produto_pnl35_original is not null and id_produto_pnl35_corrigido is not null
)
select *
from fix_fluxo