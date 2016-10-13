-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `cedula` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cedula_UNIQUE` (`cedula` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`calidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`calidad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_creacion` VARCHAR(45) NOT NULL,
  `kilos` FLOAT NOT NULL,
  `arrobas` FLOAT NOT NULL,
  `precio` FLOAT NOT NULL,
  `total` FLOAT NOT NULL,
  `bultos` INT NOT NULL,
  `calidad_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_producto_calidad1_idx` (`calidad_id` ASC),
  CONSTRAINT `fk_producto_calidad1`
    FOREIGN KEY (`calidad_id`)
    REFERENCES `mydb`.`calidad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`compra` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_creacion` VARCHAR(45) NULL,
  `clientes_id` INT NOT NULL,
  `producto_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_compra_clientes1_idx` (`clientes_id` ASC),
  INDEX `fk_compra_producto1_idx` (`producto_id` ASC),
  CONSTRAINT `fk_compra_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `mydb`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_producto1`
    FOREIGN KEY (`producto_id`)
    REFERENCES `mydb`.`producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`temporal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`temporal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `compra_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_temporal_compra1_idx` (`compra_id` ASC),
  CONSTRAINT `fk_temporal_compra1`
    FOREIGN KEY (`compra_id`)
    REFERENCES `mydb`.`compra` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`factura` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `valor` FLOAT NULL,
  `fecha_creacion` VARCHAR(45) NULL,
  `temporal_id` INT NOT NULL,
  `clientes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_factura_temporal1_idx` (`temporal_id` ASC),
  INDEX `fk_factura_clientes1_idx` (`clientes_id` ASC),
  CONSTRAINT `fk_factura_temporal1`
    FOREIGN KEY (`temporal_id`)
    REFERENCES `mydb`.`temporal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `mydb`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`gastos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`gastos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NULL,
  `valor` FLOAT NULL,
  `fecha_creacion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ingresos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ingresos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NULL,
  `valor` FLOAT NULL,
  `fecha_creacion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`prestamo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`prestamo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `valor` VARCHAR(45) NULL,
  `fecha_creacion` VARCHAR(45) NULL,
  `clientes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_prestamo_clientes1_idx` (`clientes_id` ASC),
  CONSTRAINT `fk_prestamo_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `mydb`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pagos_abonos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pagos_abonos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `valor` FLOAT NULL,
  `fecha_creacion` VARCHAR(45) NULL,
  `clientes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pagos_abonos_clientes1_idx` (`clientes_id` ASC),
  CONSTRAINT `fk_pagos_abonos_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `mydb`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cuadre_diario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cuadre_diario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `saldo_inicial` FLOAT NULL,
  `debe_haber` INT NULL,
  `hay` INT NULL,
  `fecha_creacion` VARCHAR(45) NULL,
  `diferencia` FLOAT NULL,
  `prestamo_id` INT NOT NULL,
  `gastos_id` INT NOT NULL,
  `ingresos_id` INT NOT NULL,
  `compra_id` INT NOT NULL,
  `pagos_abonos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cuadre_diario_prestamo1_idx` (`prestamo_id` ASC),
  INDEX `fk_cuadre_diario_gastos1_idx` (`gastos_id` ASC),
  INDEX `fk_cuadre_diario_ingresos1_idx` (`ingresos_id` ASC),
  INDEX `fk_cuadre_diario_compra1_idx` (`compra_id` ASC),
  INDEX `fk_cuadre_diario_pagos_abonos1_idx` (`pagos_abonos_id` ASC),
  CONSTRAINT `fk_cuadre_diario_prestamo1`
    FOREIGN KEY (`prestamo_id`)
    REFERENCES `mydb`.`prestamo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cuadre_diario_gastos1`
    FOREIGN KEY (`gastos_id`)
    REFERENCES `mydb`.`gastos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cuadre_diario_ingresos1`
    FOREIGN KEY (`ingresos_id`)
    REFERENCES `mydb`.`ingresos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cuadre_diario_compra1`
    FOREIGN KEY (`compra_id`)
    REFERENCES `mydb`.`compra` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cuadre_diario_pagos_abonos1`
    FOREIGN KEY (`pagos_abonos_id`)
    REFERENCES `mydb`.`pagos_abonos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`estado_cuentas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`estado_cuentas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `prestamo_id` INT NOT NULL,
  `pagos_abonos_id` INT NOT NULL,
  `saldo` FLOAT NULL,
  `fecha_creacion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_estado_cuentas_prestamo1_idx` (`prestamo_id` ASC),
  INDEX `fk_estado_cuentas_pagos_abonos1_idx` (`pagos_abonos_id` ASC),
  CONSTRAINT `fk_estado_cuentas_prestamo1`
    FOREIGN KEY (`prestamo_id`)
    REFERENCES `mydb`.`prestamo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estado_cuentas_pagos_abonos1`
    FOREIGN KEY (`pagos_abonos_id`)
    REFERENCES `mydb`.`pagos_abonos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
