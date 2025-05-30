CREATE VIEW vw_relacao_produtos_ratio AS
with agrupa_macroproduto_peltmg as (
    select 
        id_produto_pnl35_corrigido, 
        SUM(tonelada_total) as tonelada_total, 
        SUM(valor_total) as valor_total
    from aerea.vw_relacao_produtos
    group by id_produto_pnl35_corrigido
),
ratio_relacao_produtos as (
    select 
        vw.id_produto_pnl35_original, 
        vw.produto_pnl35_original, 
        vw.id_produto_pnl35_corrigido, 
        vw.produto_pnl35_corrigido, 
        vw.id_macroproduto_peltmg, 
        vw.nome_macroproduto_peltmg,
        --vw.tonelada_total,
        ((vw.tonelada_total/amp.tonelada_total)) as ton_ratio,
        --vw.valor_total,
        ((vw.valor_total/amp.valor_total)) as val_ratio
    from aerea.vw_relacao_produtos vw
    left join agrupa_macroproduto_peltmg amp 
        on vw.id_produto_pnl35_corrigido = amp.id_produto_pnl35_corrigido
)
select *
from ratio_relacao_produtos;