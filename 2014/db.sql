SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `user_id` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  `address` VARCHAR(512) NULL,
  `url` VARCHAR(512) NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(255) NULL,
  `logo_url` VARCHAR(1024) NULL,
  `hours_to_email` INT NULL,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `token` VARCHAR(45) NULL,
  `data_add` DATETIME NULL,
  `date_update` DATETIME NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customers` (
  `customer_id` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  `surname` VARCHAR(255) NULL,
  `address` VARCHAR(512) NULL,
  `city` VARCHAR(255) NULL,
  `post_code` VARCHAR(10) NULL,
  `country` VARCHAR(255) NULL,
  `born_date` DATETIME NULL,
  `sex` CHAR(1) NULL,
  `e-mail` VARCHAR(255) NULL,
  `phone` VARCHAR(45) NULL,
  `date_add` DATETIME NULL,
  `date_update` DATETIME NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_Customers_Users_idx` (`user_id` ASC),
  CONSTRAINT `fk_Customers_Users`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`Users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `order_id` INT NOT NULL,
  `description` VARCHAR(1024) NULL,
  `date` DATETIME NULL,
  `token` VARCHAR(45) NULL,
  `date_add` DATETIME NULL,
  `date_update` DATETIME NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_Orders_Customers1_idx` (`customer_id` ASC),
  CONSTRAINT `fk_Orders_Customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`Customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`OrderLines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OrderLines` (
  `order_line_id` INT NOT NULL,
  `product_code` VARCHAR(200) NULL,
  `product_name` VARCHAR(1024) NULL,
  `price` DECIMAL(17,2) NULL,
  `date_add` DATETIME NULL,
  `date_update` DATETIME NULL,
  `order_id` INT NOT NULL,
  PRIMARY KEY (`order_line_id`),
  INDEX `fk_OrderLines_Orders1_idx` (`order_id` ASC),
  CONSTRAINT `fk_OrderLines_Orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`Orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Opinions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Opinions` (
  `opinion_id` INT NOT NULL,
  `description` VARCHAR(4000) NULL,
  `rating` INT NULL,
  `date` DATETIME NULL,
  `date_add` DATETIME NULL,
  `date_update` DATETIME NULL,
  `order_id` INT NOT NULL,
  PRIMARY KEY (`opinion_id`),
  INDEX `fk_Opinions_Orders1_idx` (`order_id` ASC),
  CONSTRAINT `fk_Opinions_Orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`Orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

