-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `id_Usuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(90) NOT NULL,
  `senha` VARCHAR(90) NOT NULL,
  `email` VARCHAR(90) NOT NULL,
  `tipo` ENUM('cliente', 'funcionario') NOT NULL,
  PRIMARY KEY (`id_Usuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `id_Usuario` INT NOT NULL,
  `cpf` CHAR(11) NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_Usuario`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `telefone_UNIQUE` (`telefone` ASC) VISIBLE,
  INDEX `fk_Cliente_Usuario_idx` (`id_Usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Usuario`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `mydb`.`usuario` (`id_Usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`carrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`carrinho` (
  `id_Carrinho` INT NOT NULL AUTO_INCREMENT,
  `id_Usuario` INT NOT NULL,
  PRIMARY KEY (`id_Carrinho`),
  INDEX `fk_Carrinho_Cliente1_idx` (`id_Usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Carrinho_Cliente1`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `mydb`.`cliente` (`id_Usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`cupom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cupom` (
  `id_Cupom` INT NOT NULL AUTO_INCREMENT,
  `desconto` VARCHAR(45) NULL DEFAULT NULL,
  `validade` VARCHAR(45) NULL DEFAULT NULL,
  `codigo` VARCHAR(45) NULL DEFAULT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_Cupom`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`endereco` (
  `id_Endereço` INT NOT NULL AUTO_INCREMENT,
  `id_Usuario` INT NOT NULL,
  `complemento` VARCHAR(45) NULL DEFAULT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `rua` VARCHAR(255) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `cep` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Endereço`),
  INDEX `fk_usuarioid_idx` (`id_Usuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuarioid`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `mydb`.`usuario` (`id_Usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedido` (
  `id_Pedido` INT NOT NULL AUTO_INCREMENT,
  `id_Carrinho` INT NOT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `valorTotal` VARCHAR(45) NULL DEFAULT NULL,
  `frete` VARCHAR(45) NULL DEFAULT NULL,
  `dataHora` VARCHAR(45) NULL DEFAULT NULL,
  `id_Cupom` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_Pedido`),
  INDEX `fk_Pedido_Carrinho1_idx` (`id_Carrinho` ASC) VISIBLE,
  INDEX `fk_pedido_cupom_idx` (`id_Cupom` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Carrinho1`
    FOREIGN KEY (`id_Carrinho`)
    REFERENCES `mydb`.`carrinho` (`id_Carrinho`),
  CONSTRAINT `fk_pedido_cupom`
    FOREIGN KEY (`id_Cupom`)
    REFERENCES `mydb`.`cupom` (`id_Cupom`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`entrega` (
  `id_Entrega` INT NOT NULL AUTO_INCREMENT,
  `id_Endereço` INT NOT NULL,
  `id_Pedido` INT NOT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `dataEstimada` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_Entrega`),
  INDEX `fk_Entrega_Endereco1_idx` (`id_Endereço` ASC) VISIBLE,
  INDEX `fk_Entrega_Pedido1_idx` (`id_Pedido` ASC) VISIBLE,
  CONSTRAINT `fk_Entrega_Endereco1`
    FOREIGN KEY (`id_Endereço`)
    REFERENCES `mydb`.`endereco` (`id_Endereço`),
  CONSTRAINT `fk_Entrega_Pedido1`
    FOREIGN KEY (`id_Pedido`)
    REFERENCES `mydb`.`pedido` (`id_Pedido`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`produto` (
  `id_Produto` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `preco` DECIMAL(10,2) NOT NULL,
  `descricao` TEXT NOT NULL,
  `categoria` VARCHAR(255) NOT NULL,
  `estoque` INT NOT NULL,
  PRIMARY KEY (`id_Produto`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`itens_carrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`itens_carrinho` (
  `id_Item` INT NOT NULL AUTO_INCREMENT,
  `id_Carrinho` INT NOT NULL,
  `id_Produto` INT NULL DEFAULT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`id_Item`),
  INDEX `fk_Carrinho_has_Produto_Produto1_idx` (`id_Produto` ASC) VISIBLE,
  INDEX `fk_Carrinho_has_Produto_Carrinho1_idx` (`id_Carrinho` ASC) VISIBLE,
  CONSTRAINT `fk_Carrinho_has_Produto_Carrinho1`
    FOREIGN KEY (`id_Carrinho`)
    REFERENCES `mydb`.`carrinho` (`id_Carrinho`),
  CONSTRAINT `fk_Carrinho_has_Produto_Produto1`
    FOREIGN KEY (`id_Produto`)
    REFERENCES `mydb`.`produto` (`id_Produto`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pagamento` (
  `id_Pagamento` INT NOT NULL AUTO_INCREMENT,
  `id_Pedido` INT NOT NULL,
  `tipoPagamento` ENUM('crédito', 'débito') NULL DEFAULT NULL,
  `dataPagamento` DATE NULL DEFAULT NULL,
  `status` ENUM('pago', 'processando', 'não pago') NULL DEFAULT NULL,
  PRIMARY KEY (`id_Pagamento`),
  INDEX `fk_pedido_id_idx` (`id_Pedido` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_id`
    FOREIGN KEY (`id_Pedido`)
    REFERENCES `mydb`.`pedido` (`id_Pedido`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb3;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`carrinho_produto_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`carrinho_produto_view` (`nome_produto` INT, `quantidade` INT);

-- -----------------------------------------------------
-- View `mydb`.`carrinho_produto_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`carrinho_produto_view`;
USE `mydb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mydb`.`carrinho_produto_view` AS select `p`.`nome` AS `nome_produto`,`i`.`quantidade` AS `quantidade` from (((`mydb`.`carrinho` `c` join `mydb`.`itens_carrinho` `i` on((`c`.`id_Carrinho` = `i`.`id_Carrinho`))) join `mydb`.`produto` `p` on((`i`.`id_Produto` = `p`.`id_Produto`))) join `mydb`.`usuario` `u` on((`c`.`id_Usuario` = `u`.`id_Usuario`))) order by `i`.`quantidade` desc;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
