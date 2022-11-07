-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema meric
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema meric
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `meric` DEFAULT CHARACTER SET utf8 ;
USE `meric` ;

-- -----------------------------------------------------
-- Table `meric`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meric`.`categorias` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meric`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meric`.`productos` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `codigo_barras` VARCHAR(45) NULL,
  `nombre_producto` VARCHAR(45) NOT NULL,
  `precio` DECIMAL NOT NULL,
  `categoria_id` INT NOT NULL,
  `stock` DECIMAL NOT NULL,
  `minimo` DECIMAL NULL,
  `maximo` DECIMAL NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `categoria_id_idx` (`categoria_id` ASC) VISIBLE,
  CONSTRAINT `categoria_id`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `meric`.`categorias` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meric`.`pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meric`.`pago` (
  `id_pago` INT NOT NULL AUTO_INCREMENT,
  `tipo_pago` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_pago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meric`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meric`.`venta` (
  `id_venta` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `hora` TIME NULL,
  `producto_id` INT NULL,
  `cantidad` INT NULL,
  `total` DECIMAL NULL,
  `tipo_pago_id` INT NOT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `producto_id_idx` (`producto_id` ASC) VISIBLE,
  INDEX `tipo_pago_id_idx` (`tipo_pago_id` ASC) VISIBLE,
  CONSTRAINT `producto_id`
    FOREIGN KEY (`producto_id`)
    REFERENCES `meric`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tipo_pago_id`
    FOREIGN KEY (`tipo_pago_id`)
    REFERENCES `meric`.`pago` (`id_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meric`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meric`.`proveedores` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `proveedor` VARCHAR(45) NOT NULL,
  `contacto` VARCHAR(45) NULL,
  `preventa` TINYINT NOT NULL,
  PRIMARY KEY (`id_proveedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meric`.`productos_proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meric`.`productos_proveedores` (
  `id_prod_prov` INT NOT NULL AUTO_INCREMENT,
  `producto_id` INT NOT NULL,
  `proveedor_id` INT NOT NULL,
  `costo` DECIMAL NOT NULL,
  PRIMARY KEY (`id_prod_prov`),
  INDEX `producto_id_idx` (`producto_id` ASC) VISIBLE,
  INDEX `proveedor_id_idx` (`proveedor_id` ASC) VISIBLE,
  CONSTRAINT `FK_producto`
    FOREIGN KEY (`producto_id`)
    REFERENCES `meric`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `proveedor_id`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `meric`.`proveedores` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meric`.`tipo_operacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meric`.`tipo_operacion` (
  `id_tipo_op` INT NOT NULL AUTO_INCREMENT,
  `operacion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo_op`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meric`.`operacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meric`.`operacion` (
  `id_operacion` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  `tipo_op_id` INT NULL,
  PRIMARY KEY (`id_operacion`),
  INDEX `tipo_op_id_idx` (`tipo_op_id` ASC) VISIBLE,
  CONSTRAINT `tipo_op_id`
    FOREIGN KEY (`tipo_op_id`)
    REFERENCES `meric`.`tipo_operacion` (`id_tipo_op`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meric`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meric`.`estado` (
  `id_estado` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NULL,
  `operacion_id` INT NULL,
  PRIMARY KEY (`id_estado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meric`.`transaccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meric`.`transaccion` (
  `id_transaccion` INT NOT NULL AUTO_INCREMENT,
  `operacion_id` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `importe` DECIMAL NOT NULL,
  `estado_id` INT NOT NULL,
  PRIMARY KEY (`id_transaccion`),
  INDEX `operacion_id_idx` (`operacion_id` ASC) VISIBLE,
  INDEX `estado_id_idx` (`estado_id` ASC) VISIBLE,
  CONSTRAINT `operacion_id`
    FOREIGN KEY (`operacion_id`)
    REFERENCES `meric`.`operacion` (`id_operacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `estado_id`
    FOREIGN KEY (`estado_id`)
    REFERENCES `meric`.`estado` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

use meric;

select * from productos;
SHOW COLUMNS FROM productos;
ALTER TABLE productos MODIFY COLUMN codigo_barras VARCHAR(30);
ALTER TABLE productos MODIFY COLUMN nombre_producto VARCHAR(60);

INSERT INTO pago (tipo_pago) VALUES ('efectivo'),('tarjeta');

SELECT * FROM categorias;

DELETE FROM productos where id_producto >0;
drop table productos;










