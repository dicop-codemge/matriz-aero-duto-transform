with matriz_agrupada as (
    -- Agregação das toneladas e valores por UTP/produto corrigido
    select 
        id_utp_origem, 
        id_utp_destino, 
        id_produto_pnl35_corrigido, 
        SUM(tonelada) as tonelada_total,
        SUM(valor) as valor_total
    from matriz_2019_reduzida_utp mru
    --where id_produto_pnl35_corrigido is not null
    group by id_utp_origem, id_utp_destino, id_produto_pnl35_corrigido
),
matriz_2019_reduzida_udtp_ratio as (
	-- Inserindo o ratio % da distribuição de carga!
    select 
        mru.id_utp_origem,  
        mru.id_utp_destino, 
        mru.id_macroproduto_peltmg, 
        mru.nome_macroproduto_peltmg, 
        mru.id_produto_pnl35_original, 
        mru.produto_pnl35_original, 
        mru.id_produto_pnl35_corrigido, 
        mru.produto_pnl35_corrigido, 
        mru.tonelada, 
        --mg.tonelada_total, 
        mru.valor, 
        --mg.valor_total,
        ((mru.tonelada / NULLIF(mg.tonelada_total,0))) as ratio_ton,
        ((mru.valor / NULLIF(mg.valor_total,0))) as ratio_val
    from matriz_2019_reduzida_utp mru 
    inner join matriz_agrupada mg on 
        mru.id_utp_origem = mg.id_utp_origem and 
        mru.id_utp_destino = mg.id_utp_destino and 
        mru.id_produto_pnl35_corrigido = mg.id_produto_pnl35_corrigido
    --where mru.id_produto_pnl35_corrigido is not null
)
select *
from matriz_2019_reduzida_udtp_ratio;