/* a. Dados completos de pessoas físicas */
SELECT 
	idpessoa, 
	nome, 
	logradouro, 
	cidade, 
	estado, 
	telefone, 
	email, 
	Pessoa_idPessoa, 
	cpf 
FROM
	dbo.Pessoa
INNER JOIN
	dbo.PessoaFisica ON dbo.Pessoa.idPessoa = dbo.PessoaFisica.Pessoa_idPessoa
WHERE
	idpessoa = Pessoa_idPessoa


/* b. Dados completos de pessoas jurídicas */
SELECT
	idpessoa, 
	nome, 
	logradouro, 
	cidade, 
	estado, 
	telefone, 
	email, 
	Pessoa_idPessoa, 
	cnpj 
FROM
	dbo.Pessoa
INNER JOIN
	dbo.PessoaJuridica ON dbo.Pessoa.idPessoa = dbo.PessoaJuridica.Pessoa_idPessoa
WHERE 
	idPessoa = Pessoa_idPessoa


/* c. Movimentações de entrada, com produto, fornecedor, quantidade, preço unitário e valor total */
SELECT
    mov.tipo AS TIPO_MOVIMENTAÇÃO,
    pro.nome AS PRODUTO,
	pes.nome AS FORNECEDOR,
    mov.quantidade AS QUANTIDADE,
    mov.valorUnitario AS VALOR_UNITÁRIO,
    (mov.quantidade * mov.valorUnitario) AS VALOR_TOTAL
FROM
    dbo.Movimento AS mov
INNER JOIN
	dbo.Pessoa AS pes ON mov.Pessoa_idPessoa = pes.idPessoa
INNER JOIN
	dbo.Produto AS pro ON mov.Produto_idProduto = pro.idProduto
WHERE
    tipo = 'E';


/* d. Movimentações de saída, com produto, comprador, quantidade, preço unitário e valor total */
SELECT
    mov.tipo AS TIPO_MOVIMENTAÇÃO,
    pro.nome AS PRODUTO,
	pes.nome AS COMPRADOR,
    mov.quantidade AS QUANTIDADE,
    mov.valorUnitario AS VALOR_UNITÁRIO,
    (mov.quantidade * mov.valorUnitario) AS VALOR_TOTAL
FROM
    dbo.Movimento AS mov
INNER JOIN
	dbo.Pessoa AS pes ON mov.Pessoa_idPessoa = pes.idPessoa
INNER JOIN
	dbo.Produto AS pro ON mov.Produto_idProduto = pro.idProduto
WHERE
    tipo = 'S';


/* e. Valor total das entradas agrupadas por produto */
SELECT
    pro.nome AS PRODUTO_ENTRADA,
    SUM(mov.quantidade) AS QTDE_TOTAL,
    SUM(mov.quantidade * mov.valorUnitario) AS VALOR_TOTAL
FROM
    dbo.Movimento AS mov
INNER JOIN
    dbo.Pessoa AS pes ON mov.Pessoa_idPessoa = pes.idPessoa
INNER JOIN
    dbo.Produto AS pro ON mov.Produto_idProduto = pro.idProduto
WHERE
    mov.tipo = 'E'
GROUP BY
    pro.nome


/* f. Valor total das saídas agrupadas por produto */
SELECT
    pro.nome AS PRODUTO_SAIDA,
    SUM(mov.quantidade) AS QTDE_TOTAL,
    SUM(mov.quantidade * mov.valorUnitario) AS VALOR_TOTAL
FROM
    dbo.Movimento AS mov
INNER JOIN
    dbo.Pessoa AS pes ON mov.Pessoa_idPessoa = pes.idPessoa
INNER JOIN
    dbo.Produto AS pro ON mov.Produto_idProduto = pro.idProduto
WHERE
    mov.tipo = 'S'
GROUP BY
    pro.nome


/* g. Operadores que não efetuaram movimentações de entrada (compra) */
SELECT
	usu.login AS OPERADOR
FROM
	dbo.Usuario AS usu
WHERE
    NOT EXISTS (
        SELECT 1
        FROM
            dbo.Movimento AS mov
        WHERE
            mov.Usuario_idUsuario = usu.idUsuario
            AND mov.tipo = 'E'
    );


/* h. Valor total de entrada, agrupado por operador */
SELECT
    usu.login AS OPERADOR_ENTRADA,
    SUM(mov.quantidade) AS QTDE_TOTAL,
    SUM(mov.quantidade * mov.valorUnitario) AS VALOR_TOTAL
FROM
    dbo.Movimento AS mov
INNER JOIN
    dbo.Usuario AS usu ON mov.Usuario_idUsuario = usu.idUsuario
INNER JOIN
    dbo.Produto AS pro ON mov.Produto_idProduto = pro.idProduto

WHERE
    mov.tipo = 'E'
GROUP BY
    usu.login


/* i. Valor total de saída, agrupado por operador */
SELECT
    usu.login AS OPERADOR_SAIDA,
    SUM(mov.quantidade) AS QTDE_TOTAL,
    SUM(mov.quantidade * mov.valorUnitario) AS VALOR_TOTAL
FROM
    dbo.Movimento AS mov
INNER JOIN
    dbo.Usuario AS usu ON mov.Usuario_idUsuario = usu.idUsuario
INNER JOIN
    dbo.Produto AS pro ON mov.Produto_idProduto = pro.idProduto

WHERE
    mov.tipo = 'S'
GROUP BY
    usu.login


/* j. Valor médio de venda por produto, utilizando média ponderada */
SELECT
    pro.nome AS PRODUTO_SAIDA,
    SUM(mov.quantidade) AS QTDE_TOTAL,
    SUM(mov.quantidade * mov.valorUnitario)/SUM(mov.quantidade) AS              VALOR_PONDERADO,
    SUM(mov.quantidade * mov.valorUnitario) AS VALOR_TOTAL
FROM
    dbo.Movimento AS mov
INNER JOIN
    dbo.Pessoa AS pes ON mov.Pessoa_idPessoa = pes.idPessoa
INNER JOIN
    dbo.Produto AS pro ON mov.Produto_idProduto = pro.idProduto
WHERE
    mov.tipo = 'S'
GROUP BY
    pro.nome
