SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `Hackajobs` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;

CREATE TABLE IF NOT EXISTS `Hackajobs`.`tbl_user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(1000) NOT NULL,
  `token` VARCHAR(255) NULL DEFAULT NULL,
  `role` INT(11) NOT NULL,
  `facebook_id` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `Hackajobs`.`tbl_job` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` VARCHAR(4000) NOT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `city` VARCHAR(1000) NOT NULL,
  `latitude` DOUBLE NULL DEFAULT NULL,
  `longitude` DOUBLE NULL DEFAULT NULL,
  `picture_url` VARCHAR(1000) NULL DEFAULT NULL,
  `owner_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_job_tbl_user_idx` (`owner_id` ASC),
  CONSTRAINT `fk_tbl_job_tbl_user`
    FOREIGN KEY (`owner_id`)
    REFERENCES `Hackajobs`.`tbl_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `Hackajobs`.`tbl_application` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(4000) NOT NULL,
  `cv_url` VARCHAR(1000) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `job_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_subscription_tbl_job1_idx` (`job_id` ASC),
  INDEX `fk_tbl_subscription_tbl_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_tbl_subscription_tbl_job1`
    FOREIGN KEY (`job_id`)
    REFERENCES `Hackajobs`.`tbl_job` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_subscription_tbl_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `Hackajobs`.`tbl_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `Hackajobs`.`tbl_contact` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(1000) NOT NULL,
  `picture_url` VARCHAR(1000) NOT NULL,
  `facebook_id` VARCHAR(255) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_contact_tbl_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_tbl_contact_tbl_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `Hackajobs`.`tbl_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `Hackajobs`.`tbl_recommendation` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(4000) NOT NULL,
  `completed` TINYINT(1) NULL DEFAULT NULL,
  `numeric_rate` DOUBLE NULL DEFAULT NULL,
  `reccomender_id` INT(11) NOT NULL,
  `job_id` INT(11) NOT NULL,
  `application_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_recommendation_tbl_contact1_idx` (`reccomender_id` ASC),
  INDEX `fk_tbl_recommendation_tbl_job1_idx` (`job_id` ASC),
  INDEX `fk_tbl_recommendation_tbl_application1_idx` (`application_id` ASC),
  CONSTRAINT `fk_tbl_recommendation_tbl_contact1`
    FOREIGN KEY (`reccomender_id`)
    REFERENCES `Hackajobs`.`tbl_contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_recommendation_tbl_job1`
    FOREIGN KEY (`job_id`)
    REFERENCES `Hackajobs`.`tbl_job` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_recommendation_tbl_application1`
    FOREIGN KEY (`application_id`)
    REFERENCES `Hackajobs`.`tbl_application` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

