INSERT INTO `mydb`.`Usuario` (`nome`, `senha`, `email`, `tipo`) VALUES 
('Luiz Farias', 'senha123', 'luizfarias@email.com', 'cliente'),
('Igor Mamus', '123senha', 'igormamus@email.com', 'funcionario'),
('Breno Monteiro', 'ktcwb', 'brenin@email.com', 'cliente'),
('Andre Felipe', '123senha123', 'andre.f@email.com', 'cliente'),
('Leonardo Marques', '0123senha', 'leomrqs@email.com', 'funcionario'),
('João Manfrin', 'senha0123', 'manfrin@email.com', 'cliente');

INSERT INTO `mydb`.`Endereco` (`id_Usuario`, `bairro`, `rua`, `numero`, `cep`, `cidade`) VALUES 
(1, 'Rebouças', 'Floriano Peixoto', '98', '12345532', 'Colombo'),
(2, 'Água Verde', 'Cora de carvalho', '4582', '23456210', 'Pedra Branca'),
(3, 'Batel', 'Duca serra', '928', '34567321', 'Causoene'),
(4, 'Prado Velho', 'Almirante barroso', '0123', '45678897', 'Laranjal do Jari'),
(5, 'Parolim', 'Hamilton silva', '345', '56789654', 'Oiapoque'),
(6, 'Barigui', 'Hildemar maia', '6782', '67890208', 'Ferreira Gomes');


INSERT INTO `mydb`.`Cliente` (`id_Usuario`, `cpf`, `telefone`) VALUES 
(1, '00940746275', '12-9956-7890'),
(2, '76940746275', '96-9843-7890'),
(3, '23456789012', '23-98567-8901'),
(4, '34567890123', '34-9978-9012'),
(5, '76160820629', '41-9822-0712'),
(6, '45678901234', '45-9889-0123');

INSERT INTO `mydb`.`Carrinho` (`id_Usuario`) VALUES 
(1),  -- Carrinho para Luiz Farias
(3),  -- Carrinho para Breno Monteiro
(4),  -- Carrinho para Andre Felipe
(6);  -- Carrinho para João Manfrin

INSERT INTO `mydb`.`Cupom` (`desconto`, `validade`, `codigo`, `status`) VALUES 
('10%', '31/12/2023', 'FAFA23', 'Ativo'),   -- Cupom de 10% de desconto válido até o final de 2023
('15%', '30/05/2023', 'MAI15', 'Ativo'),   -- Cupom de 15% de desconto válido até maio de 2023
('5%', '01/03/2023', 'VERAO5', 'inativo'), -- Cupom de 5% de desconto que já expirou
('30%', '2023-10-31', 'CUPOM30', 'inativo'),	
('25%', '2023-09-30', 'CUPOM25', 'inativo'),
('20%', '15/06/2023', 'ALUNOPUC', 'Ativo');-- Cupom de 20% de desconto para estudantes, válido até junho de 202


INSERT INTO `mydb`.`Pedido` (`id_Carrinho`, `status`, `valorTotal`, `frete`, `dataHora`, `id_Cupom`) VALUES
(1, 'Pendente', '100.00', '10.00', '10-01-2023 10:00:00', 1),
(2, 'Enviado', '200.00', '20.00', '02-01-2023 11:00:00', 2),
(3, 'Entregue', '300.00', '30.00', '23-01-2023 12:00:00', 3),
(4, 'Pendente', '400.00', '40.00', '20-01-2023 13:00:00', 4);

INSERT INTO `mydb`.`Entrega` (`id_Endereço`, `id_Pedido`, `status`, `dataEstimada`) VALUES
(1, 1, 'Enviado', '10-01-2023'),
(2, 2, 'Enviado', '15-02-2023'),
(3, 3, 'Pendente', '08-03-2023'),
(4, 4, 'Pendente', '20-04-2023');

INSERT INTO `mydb`.`Produto` (`nome`, `preco`, `descricao`, `categoria`, `estoque`) VALUES
('Notebook', 3000.00, 'Notebook Dell 16GB RAM', 'Eletrônicos', 10),
('Celular', 1500.00, 'Celular Xiaomi Redmi', 'Eletrônicos', 20),
('Livro', 50.00, 'Livro de Receitas', 'Livros', 30),
('Geladeira', 2000.00, 'Geladeira Brastemp', 'Eletrodomésticos', 5),
('TV', 1200.00, 'TV Samsung 42"', 'Eletrônicos', 8),
('Sofá', 800.00, 'Sofá 4 lugares', 'Móveis', 3);


INSERT INTO `mydb`.`Pagamento` (`id_Pedido`, `tipoPagamento`, `dataPagamento`, `status`) VALUES
(1, 'crédito', '2023-01-01', 'pago'),
(2, 'débito', '2023-01-02', 'processando'),
(3, 'crédito', '2023-01-03', 'não pago'),
(4, 'débito', '2023-01-04', 'pago');

INSERT INTO `mydb`.`itens_Carrinho` (`id_Carrinho`, `id_Produto`, `quantidade`) VALUES
(1, 1, 1),  -- 1 Notebook no carrinho de Luiz Farias
(1, 2, 2),  -- 2 Celulares no carrinho de Luiz Farias
(2, 3, 1),  -- 1 Livro no carrinho de Breno Monteiro
(2, 4, 1),  -- 1 Geladeira no carrinho de Breno Monteiro
(3, 5, 1),  -- 1 TV no carrinho de Andre Felipe
(3, 6, 1);  -- 1 Sofá no carrinho de Andre Felipe

-- Atualizações:
UPDATE `mydb`.`Usuario` 
SET `nome` = 'Luiz Alberto Farias' 
WHERE `email` = 'luizfarias@email.com';

UPDATE `mydb`.`Cupom` 
SET `desconto` = '15%' 
WHERE `codigo` = 'FAFA23';

UPDATE `mydb`.`Cliente` 
SET `telefone` = '23-99567-9999' 
WHERE `cpf` = '23456789012';

UPDATE `mydb`.`Pedido` 
SET `status` = 'Enviado' 
WHERE `id_Carrinho` = 1;

UPDATE `mydb`.`Produto` 
SET `preco` = 2800.00 
WHERE `nome` = 'Notebook';

-- Exclusões:
-- Delete item do carrinho pelo id
DELETE FROM `mydb`.`itens_Carrinho` WHERE `id_Carrinho` = 1;

-- Deletar pagamento do pedido pelo id
DELETE FROM `mydb`.`Pagamento` WHERE `id_Pedido` = 1 ;

-- Deletar produto pelo id
DELETE FROM `mydb`.`Produto` WHERE `id_Produto` = 1;


-- deletar endereco pelo id
DELETE FROM `mydb`.`Endereco` WHERE `id_Endereço` = 1;

-- deletar pedido pelo id
DELETE FROM `mydb`.`Pedido` WHERE `id_Pedido` = 1;


