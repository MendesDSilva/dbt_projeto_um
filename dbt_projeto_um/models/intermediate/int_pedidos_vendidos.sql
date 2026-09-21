{{
    config(
        tags = ['vendas']
    )
}}

with pedidos as (

    select * from {{ ref('stg_pedidos') }}

)

, cliente as (

    select * from {{ ref('stg_clientes') }}

)

, itens_pedidos as (

    select * from {{ ref('stg_itens_pedidos') }}

)

, produtos as (

    select * from {{ ref('stg_produtos') }}

)

, pagamentos as (

    select * from {{ ref('stg_pagamentos') }}

)

, categorias as (

    select * from {{ ref('stg_categorias') }}

)

, joined as (

    select 
        pe.data_pedido
        , c.nome 
        , c.email
        , p.valor
        , p.metodo
        , p.status
        , p.data_pagamento
        , pr.nome as nome_produto
        , ct.nome as categoria_produto
        , i.quantidade
        , i.preco_unitario
    from pedidos pe
    left join cliente c on pe.cliente_id = c.id
    left join pagamentos p on pe.id = p.pedido_id
    left join itens_pedidos i on pe.id = i.pedido_id
    left join produtos pr on i.produto_id = pr.id
    left join categorias ct on pr.categoria_id = ct.id
)

select * from joined