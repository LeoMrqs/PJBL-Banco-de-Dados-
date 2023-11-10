---- Seleciona todos os dados dos usuários no banco de dados.
SELECT * FROM mydb.cliente NATURAL JOIN usuario NATURAL JOIN endereco;

---- Seleciona cupons ativos
SELECT * FROM cupom WHERE status = 'Ativo';

---- Selecionar usuários que compraram o item
SELECT u.nome AS nome_usuario, p.nome
FROM carrinho AS c
JOIN itens_carrinho AS i ON c.id_Carrinho = i.id_Carrinho
JOIN produto AS p ON i.id_Produto = p.id_Produto
JOIN usuario AS u ON c.id_Usuario = u.id_Usuario
WHERE p.id_Produto = 3; -- Substitua 3 pelo id_Produto desejado

---- Selecionar itens com maior estoque
SELECT u.nome AS nome_usuario, p.nome AS Objeto
FROM itens_carrinho AS i
JOIN carrinho AS c ON i.id_Carrinho = c.id_Carrinho
JOIN produto AS p ON i.id_Produto = p.id_Produto
JOIN usuario AS u ON c.id_Usuario = u.id_Usuario
WHERE p.id_Produto = 3; -- Substitua 3 pelo id_Produto desejado

---- Seleciona nome e preço de todos os produtos de uma categoria
SELECT p.nome AS product_name, p.preco AS product_price
FROM produto p
WHERE p.categoria = 'eletrônicos';

---- Retorna o estado da entrega e a data estimada de um pedido
SELECT e.status AS delivery_status, e.dataEstimada AS estimated_delivery_date
FROM entrega e
JOIN pedido p ON e.id_Pedido = p.id_Pedido
WHERE p.id_Pedido = 1;

---- Nome do produto e quantidade no carrinho de um usuário
SELECT p.nome AS produto, ic.quantidade
FROM carrinho c
JOIN itens_carrinho ic ON c.id_Carrinho = ic.id_Carrinho
JOIN produto p ON ic.id_Produto = p.id_Produto
WHERE c.id_Usuario = 1;

---- Valor total e status de um usuário
SELECT p.valorTotal AS total_value, pg.status AS payment_status
FROM pedido p
JOIN pagamento pg ON p.id_Pedido = pg.id_Pedido
WHERE p.id_Carrinho IN (SELECT id_Carrinho FROM carrinho WHERE id_Usuario = 1);

---- Lista os 5 produtos mais comprados
SELECT p.nome AS product_name, SUM(ic.quantidade) AS total_quantity_ordered
FROM produto p
JOIN itens_carrinho ic ON p.id_Produto = ic.id_Produto
GROUP BY p.nome
ORDER BY total_quantity_ordered DESC
LIMIT 5;

---- Os clientes que mais gastaram em ordem
SELECT u.nome AS customer_name, SUM(CAST(p.valorTotal AS DECIMAL(10,2))) AS total_amount_spent
FROM usuario u
JOIN cliente c ON u.id_Usuario = c.id_Usuario
LEFT JOIN carrinho cr ON c.id_Usuario = cr.id_Usuario
LEFT JOIN pedido p ON cr.id_Carrinho = p.id_Carrinho
GROUP BY u.nome;

---- Usuários que são clientes
SELECT u.id_Usuario, u.nome
FROM usuario u
WHERE u.tipo = 'cliente'
GROUP BY u.id_Usuario;

---- Produtos mais baratos
SELECT nome, preco
FROM produto
GROUP BY id_Produto
ORDER BY preco ASC
LIMIT 5;

---- Clientes que nunca compraram
SELECT u.id_Usuario
FROM usuario u
LEFT JOIN carrinho c ON u.id_Usuario = c.id_Usuario
LEFT JOIN pedido p ON c.id_Carrinho = p.id_Carrinho
WHERE u.tipo = 'cliente' AND p.id_Pedido IS NULL
ORDER BY u.id_Usuario;

---- Produtos mais caros
SELECT nome, preco
FROM produto
GROUP BY id_Produto
ORDER BY preco DESC
LIMIT 5;

---- Clientes que utilizaram cupom
SELECT DISTINCT c.id_Usuario, cp.codigo
FROM carrinho c
JOIN pedido p ON c.id_Carrinho = p.id_Carrinho
JOIN cupom cp ON p.id_Cupom = cp.id_Cupom;

----  seleciona entregas mais recentes com estado e previsao de entrega
SELECT e.status AS delivery_status, e.dataEstimada AS estimated_delivery_date
FROM entrega e
ORDER BY e.dataEstimada DESC
LIMIT 5;

---- Seleciona o numero de itens d0 carrinho
SELECT c.id_Carrinho, COUNT(ic.id_Item) AS total_items
FROM carrinho c
LEFT JOIN itens_carrinho ic ON c.id_Carrinho = ic.id_Carrinho
GROUP BY c.id_Carrinho;

---- Clientes que nunca usaram um cupom
SELECT u.id_Usuario, u.nome
FROM usuario u
LEFT JOIN cliente c ON u.id_Usuario = c.id_Usuario
WHERE c.id_Usuario IS NULL;

---- Todos os produtos disponiveis n0 banco
SELECT nome AS product_name, preco AS product_price
FROM produto
WHERE estoque > 0;
