DELIMITER //

CREATE FUNCTION ValorTotalComDesconto(pedido_id INT) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE vTotal DECIMAL(10,2);
    DECLARE vDesconto DECIMAL(5,2);

    SELECT valorTotal INTO vTotal FROM pedido WHERE id_Pedido = pedido_id;
    SELECT desconto INTO vDesconto FROM cupom JOIN pedido ON cupom.id_Cupom = pedido.id_Cupom WHERE pedido.id_Pedido = pedido_id;

    RETURN vTotal - (vTotal * (vDesconto/100));
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION QuantidadeProdutosNoCarrinho(carrinho_id INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE totalQty INT;

    SELECT SUM(quantidade) INTO totalQty FROM itens_carrinho WHERE id_Carrinho = carrinho_id;

    RETURN totalQty;
END //

DELIMITER ;

-- functions

DELIMITER //

CREATE FUNCTION CupomAtivo(codigo_cupom VARCHAR(255)) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE vStatus VARCHAR(10);

    SELECT status INTO vStatus FROM cupom WHERE codigo = codigo_cupom;

    IF vStatus = 'ativo' THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION QuantidadePedidosCliente(cliente_id INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE totalPedidos INT;

    SELECT COUNT(*) INTO totalPedidos FROM pedido JOIN cliente ON pedido.id_Cliente = cliente.id_Cliente WHERE cliente.id_Cliente = cliente_id;

    RETURN totalPedidos;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION UltimaCompraCliente(cliente_id INT) RETURNS DATETIME DETERMINISTIC
BEGIN
    DECLARE ultimaData DATETIME;

    SELECT MAX(dataHora) INTO ultimaData FROM pedido JOIN cliente ON pedido.id_Cliente = cliente.id_Cliente WHERE cliente.id_Cliente = cliente_id;

    RETURN ultimaData;
END //

DELIMITER ;

-- Triggers

DELIMITER //

CREATE TRIGGER Trig_InsertPedido_AfterInsert AFTER INSERT ON pedido
FOR EACH ROW 
BEGIN
    IF NEW.id_Cupom IS NOT NULL THEN
        UPDATE cupom SET status = 'usado' WHERE id_Cupom = NEW.id_Cupom;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER Trig_UpdatePedido_AfterUpdate AFTER UPDATE ON pedido
FOR EACH ROW 
BEGIN
    IF OLD.status != 'cancelado' AND NEW.status = 'cancelado' THEN
        -- Aumentar o estoque de cada produto nesse pedido
        -- Esta é uma simplificação, ajuste conforme necessário
        UPDATE produto 
        JOIN itens_carrinho ON produto.id_Produto = itens_carrinho.id_Produto
        SET produto.estoque = produto.estoque + itens_carrinho.quantidade
        WHERE itens_carrinho.id_Carrinho = NEW.id_Carrinho;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER Trig_DeleteCliente_AfterDelete AFTER DELETE ON cliente
FOR EACH ROW 
BEGIN
    DELETE FROM endereco WHERE id_Cliente = OLD.id_Cliente;
END //

DELIMITER ;
