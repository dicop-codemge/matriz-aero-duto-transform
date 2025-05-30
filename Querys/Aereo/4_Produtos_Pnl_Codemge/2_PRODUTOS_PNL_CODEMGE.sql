with produtos_matriz_aereo as (
	select distinct matriz_formato_pnl2035_revisado as nome_produto_aereo
	FROM public.matriz_aerea
	order by matriz_formato_pnl2035_revisado
),
produtos as (
	select distinct produto_pnl35_corrigido as nome_produto_codemge
	from vw_relacao_produtos_ratio vrpr
	order by produto_pnl35_corrigido
),
relacao as (
    select 
        nome_produto_aereo, 
        nome_produto_codemge,
        similarity(nome_produto_aereo, nome_produto_codemge) as score
    from produtos_matriz_aereo as pma
    left join produtos as p
        on similarity(pma.nome_produto_aereo, p.nome_produto_codemge) > 0.3
    order by score desc
)
select *
from relacao
