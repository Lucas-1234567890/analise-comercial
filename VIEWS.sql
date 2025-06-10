--------------------------------------------------------
-- Tabela dCliente

ALTER VIEW [dbo].[dCliente] AS (

	SELECT
		c.id,
		c.descricao,
		g.id cidade_id,
		g.cidade,
		g.estado,
		g.uf,
		r.regiao
	FROM Cliente c
	LEFT JOIN Geografia g ON c.geografia_id = g.id
	LEFT JOIN RegioesBrasil r on r.UF = g.uf

)

--------------------------------------------------------
-- Tabela dProduto

ALTER VIEW [dbo].[dProduto] AS (

	SELECT
		p.id,
		p.descricao,
		p.tamanho,
		p.custoUnitario,
		cp.id categoria_id,
		cp.descricao categoria_descricao
	FROM Produto p
	LEFT JOIN CategoriaProduto cp ON p.categoria_id = cp.id

)

--------------------------------------------------------
-- Tabela dVendedor

ALTER VIEW [dbo].[dVendedor] AS (

	SELECT
		v.id,
		v.descricao,
		s.id supervisor_id,
		s.descricao supervisor_descricao,
		s.gerente_id,
		s.gerente_descricao	
	FROM Vendedor v
	LEFT JOIN Supervisor s ON v.supervisor_id = s.id

)

--------------------------------------------------------
-- Tabela fVendas

ALTER VIEW [dbo].[fVendas] AS (
SELECT        
	v.nfe, 
	v.data, 
	cc.vendedor_id, 
	v.cliente_id, 
	iv.produto_id, 
	(v.nf_desconto * iv.valor_bruto) / v.valor_bruto AS valor_desconto, 
	iv.item_quantidade, 
	iv.valor_unitario
FROM
	Vendas v 
	LEFT JOIN ItensVendas iv ON v.id = iv.vendas_id
	LEFT JOIN ClientesVendedores cc on cc.cliente_id = v.cliente_id
)