-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Mer 06 Octobre 2021 à 18:10
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `toutiop`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `infor`(OUT `msg` VARCHAR(20))
select 'cv' into msg$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `appro`
--

CREATE TABLE IF NOT EXISTS `appro` (
  `ID_appro` int(100) NOT NULL AUTO_INCREMENT,
  `ID_Fournisseur` int(100) NOT NULL,
  PRIMARY KEY (`ID_appro`),
  KEY `four` (`ID_Fournisseur`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Contenu de la table `appro`
--

INSERT INTO `appro` (`ID_appro`, `ID_Fournisseur`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1);

-- --------------------------------------------------------

--
-- Structure de la table `approvisionnement`
--

CREATE TABLE IF NOT EXISTS `approvisionnement` (
  `ID_Approvis` int(100) NOT NULL AUTO_INCREMENT,
  `ID_appro` int(100) NOT NULL,
  `ID_Produit` int(100) NOT NULL,
  `Quantité_approvisionnée` int(100) NOT NULL,
  `Date` date NOT NULL,
  PRIMARY KEY (`ID_Approvis`),
  KEY `ID_Produit` (`ID_Produit`),
  KEY `fk_appro_four` (`ID_appro`),
  KEY `ID_Approvis` (`ID_Approvis`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Contenu de la table `approvisionnement`
--

INSERT INTO `approvisionnement` (`ID_Approvis`, `ID_appro`, `ID_Produit`, `Quantité_approvisionnée`, `Date`) VALUES
(1, 2, 1, 60, '2021-09-09'),
(2, 4, 5, 4, '2021-09-29'),
(3, 5, 5, 2, '2021-10-06'),
(4, 6, 1, 3, '2021-10-06'),
(5, 7, 1, 5, '2021-10-06'),
(6, 7, 5, 5, '2021-10-06');

--
-- Déclencheurs `approvisionnement`
--
DROP TRIGGER IF EXISTS `appro_prod`;
DELIMITER //
CREATE TRIGGER `appro_prod` AFTER INSERT ON `approvisionnement`
 FOR EACH ROW update produit set quantité_stockée=quantité_stockée + new.quantité_approvisionnée where id_produit=new.id_produit
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE IF NOT EXISTS `client` (
  `ID_Client` int(100) NOT NULL AUTO_INCREMENT,
  `Prénom` varchar(60) NOT NULL,
  `Nom` varchar(60) NOT NULL,
  `Sexe` varchar(100) NOT NULL,
  `Adresse` varchar(60) NOT NULL,
  `Téléphone` varchar(20) NOT NULL,
  `Email` varchar(60) NOT NULL,
  PRIMARY KEY (`Prénom`,`Nom`,`Téléphone`),
  UNIQUE KEY `ID_Client_2` (`ID_Client`),
  KEY `ID_Client` (`ID_Client`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `client`
--

INSERT INTO `client` (`ID_Client`, `Prénom`, `Nom`, `Sexe`, `Adresse`, `Téléphone`, `Email`) VALUES
(2, 'MMM', 'DD', 'Homme', 'GJK', '558', 'GG'),
(1, 'Modibo', 'Diarra', 'Homme', 'Bamako', '74222845', 'modibodiarra245@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `cmd`
--

CREATE TABLE IF NOT EXISTS `cmd` (
  `ID_cmd` int(100) NOT NULL AUTO_INCREMENT,
  `ID_Client` int(100) NOT NULL,
  PRIMARY KEY (`ID_cmd`),
  KEY `cli` (`ID_Client`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `cmd`
--

INSERT INTO `cmd` (`ID_cmd`, `ID_Client`) VALUES
(1, 1),
(3, 1),
(4, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

CREATE TABLE IF NOT EXISTS `commande` (
  `ID_Commande` int(100) NOT NULL AUTO_INCREMENT,
  `ID_Produit` int(100) NOT NULL,
  `Quantité_commandée` int(100) NOT NULL,
  `Date` date NOT NULL,
  `ID_cmd` int(100) NOT NULL,
  PRIMARY KEY (`ID_Commande`),
  KEY `fk_cmd_prod` (`ID_Produit`),
  KEY `cmd` (`ID_cmd`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Contenu de la table `commande`
--

INSERT INTO `commande` (`ID_Commande`, `ID_Produit`, `Quantité_commandée`, `Date`, `ID_cmd`) VALUES
(2, 1, 2, '2021-09-01', 1),
(3, 5, 1, '2021-09-01', 1),
(4, 5, 4, '2021-09-01', 2),
(5, 5, 5, '2021-10-06', 3),
(6, 1, 6, '2021-10-06', 3),
(7, 1, 5, '2021-10-06', 4),
(8, 5, 10, '2021-10-06', 4);

--
-- Déclencheurs `commande`
--
DROP TRIGGER IF EXISTS `cmd_prod`;
DELIMITER //
CREATE TRIGGER `cmd_prod` AFTER INSERT ON `commande`
 FOR EACH ROW update produit set quantité_stockée=quantité_stockée - new.quantité_commandée where id_produit=new.id_produit
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `consultation`
--

CREATE TABLE IF NOT EXISTS `consultation` (
  `ID_Consultation` int(100) NOT NULL AUTO_INCREMENT,
  `ID_Patient` int(100) NOT NULL,
  `Prix` int(100) NOT NULL,
  `ID_Ophtalmologue` int(100) NOT NULL,
  `Diagnostique` text NOT NULL,
  `Date` date NOT NULL,
  PRIMARY KEY (`ID_Consultation`),
  KEY `fk_coph` (`ID_Ophtalmologue`),
  KEY `fk_cons_dos` (`ID_Patient`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `consultation`
--

INSERT INTO `consultation` (`ID_Consultation`, `ID_Patient`, `Prix`, `ID_Ophtalmologue`, `Diagnostique`, `Date`) VALUES
(1, 27, 600, 1, 'azerty', '2021-09-29');

-- --------------------------------------------------------

--
-- Structure de la table `facture_client`
--

CREATE TABLE IF NOT EXISTS `facture_client` (
  `ID_Facture` int(100) NOT NULL AUTO_INCREMENT,
  `ID_Client` int(100) NOT NULL,
  `Montant_total` int(100) NOT NULL,
  `Versement` int(100) NOT NULL,
  `Reste_à_verser` int(100) NOT NULL,
  `Date` date NOT NULL,
  PRIMARY KEY (`ID_Facture`),
  KEY `fk_fc` (`ID_Client`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `facture_fournisseur`
--

CREATE TABLE IF NOT EXISTS `facture_fournisseur` (
  `ID_Facture` int(100) NOT NULL AUTO_INCREMENT,
  `ID_Fournisseur` int(100) NOT NULL,
  `Montant_total` int(100) NOT NULL,
  `Versement` int(100) NOT NULL,
  `Reste_à_verser` int(100) NOT NULL,
  `Date` date NOT NULL,
  PRIMARY KEY (`ID_Facture`),
  KEY `fk_ff` (`ID_Fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

CREATE TABLE IF NOT EXISTS `fournisseur` (
  `ID_Fournisseur` int(100) NOT NULL AUTO_INCREMENT,
  `Nom` varchar(60) NOT NULL,
  `Adresse` varchar(60) NOT NULL,
  `Téléphone` varchar(20) NOT NULL,
  `Email` varchar(60) NOT NULL,
  PRIMARY KEY (`Nom`,`Téléphone`),
  UNIQUE KEY `ID_Fournisseur_2` (`ID_Fournisseur`),
  KEY `ID_Fournisseur` (`ID_Fournisseur`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `fournisseur`
--

INSERT INTO `fournisseur` (`ID_Fournisseur`, `Nom`, `Adresse`, `Téléphone`, `Email`) VALUES
(1, 'Amadou & Frères', 'Kalaban', '773', 'ee@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `login`
--

CREATE TABLE IF NOT EXISTS `login` (
  `Identifiant` varchar(25) NOT NULL,
  `Nom` varchar(30) NOT NULL,
  `Pass` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `login`
--

INSERT INTO `login` (`Identifiant`, `Nom`, `Pass`) VALUES
('Modibo', 'admin', 'adminpass');

-- --------------------------------------------------------

--
-- Structure de la table `ophtalmologue`
--

CREATE TABLE IF NOT EXISTS `ophtalmologue` (
  `ID_Ophtalmologue` int(100) NOT NULL AUTO_INCREMENT,
  `Prénom` varchar(255) NOT NULL,
  `Nom` varchar(255) NOT NULL,
  `Sexe` varchar(100) NOT NULL,
  `Téléphone` varchar(100) NOT NULL,
  `Adresse` varchar(255) NOT NULL,
  `Spécialité` varchar(255) NOT NULL,
  PRIMARY KEY (`Prénom`,`Nom`,`Téléphone`),
  UNIQUE KEY `ID_Ophtalmologue_2` (`ID_Ophtalmologue`),
  KEY `ID_Ophtalmologue` (`ID_Ophtalmologue`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `ophtalmologue`
--

INSERT INTO `ophtalmologue` (`ID_Ophtalmologue`, `Prénom`, `Nom`, `Sexe`, `Téléphone`, `Adresse`, `Spécialité`) VALUES
(1, 'Touti', 'Maïga', 'Femme', '68', 'Kalaban', 'azerty');

-- --------------------------------------------------------

--
-- Structure de la table `patient`
--

CREATE TABLE IF NOT EXISTS `patient` (
  `ID_Patient` int(100) NOT NULL AUTO_INCREMENT,
  `Prénom` varchar(100) NOT NULL,
  `Nom` varchar(100) NOT NULL,
  `Sexe` varchar(60) NOT NULL,
  `Naissance` varchar(100) NOT NULL,
  `Adresse` varchar(255) NOT NULL,
  `Téléphone` varchar(100) NOT NULL,
  PRIMARY KEY (`Prénom`,`Nom`,`Téléphone`),
  UNIQUE KEY `ID_Patient_2` (`ID_Patient`),
  KEY `ID_Patient` (`ID_Patient`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

--
-- Contenu de la table `patient`
--

INSERT INTO `patient` (`ID_Patient`, `Prénom`, `Nom`, `Sexe`, `Naissance`, `Adresse`, `Téléphone`) VALUES
(26, 'Ana', 'Maïga', 'Femme', '1998-08-01', 'Kati', '737'),
(29, 'Fatoumata', 'Diallo', 'Homme', '1997-12-30', 'Klb', '50'),
(31, 'Fatoumata', 'Dicko', 'Homme', '1997-12-30', 'Klb', '50'),
(30, 'Issa', 'Diarra', 'Homme', '1991-12-31', 'NKoro', '66'),
(27, 'Madou', 'Coulibaly', 'Homme', '1980-01-01', 'Fld', '62');

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

CREATE TABLE IF NOT EXISTS `produit` (
  `ID_Produit` int(100) NOT NULL AUTO_INCREMENT,
  `Désignation` varchar(100) NOT NULL,
  `Prix` int(100) NOT NULL,
  `Quantité_stockée` int(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Désignation`),
  UNIQUE KEY `ID_Produit_2` (`ID_Produit`),
  KEY `ID_Produit` (`ID_Produit`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `produit`
--

INSERT INTO `produit` (`ID_Produit`, `Désignation`, `Prix`, `Quantité_stockée`) VALUES
(1, 'Lentille', 25000, 20),
(5, 'Lentilled', 25000, 15);

--
-- Déclencheurs `produit`
--
DROP TRIGGER IF EXISTS `ff`;
DELIMITER //
CREATE TRIGGER `ff` AFTER UPDATE ON `produit`
 FOR EACH ROW begin 
if (new.Quantité_stockée=3) then
call infor();
end if;
end
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `rdv`
--

CREATE TABLE IF NOT EXISTS `rdv` (
  `ID_RDV` int(100) NOT NULL AUTO_INCREMENT,
  `ID_Patient` int(100) NOT NULL,
  `Date` date NOT NULL,
  PRIMARY KEY (`ID_RDV`),
  KEY `rp` (`ID_Patient`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `rdv`
--

INSERT INTO `rdv` (`ID_RDV`, `ID_Patient`, `Date`) VALUES
(2, 30, '2021-12-01');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE IF NOT EXISTS `utilisateur` (
  `ID` int(100) NOT NULL,
  `Rôle` varchar(100) NOT NULL,
  `Nom` varchar(30) NOT NULL,
  `Pass` varchar(30) NOT NULL,
  PRIMARY KEY (`ID`,`Rôle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `utilisateur`
--

INSERT INTO `utilisateur` (`ID`, `Rôle`, `Nom`, `Pass`) VALUES
(0, '0', 'admin', 'adminpass');

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `appro`
--
ALTER TABLE `appro`
  ADD CONSTRAINT `appro_ibfk_1` FOREIGN KEY (`ID_Fournisseur`) REFERENCES `fournisseur` (`ID_Fournisseur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `approvisionnement`
--
ALTER TABLE `approvisionnement`
  ADD CONSTRAINT `fk_af` FOREIGN KEY (`ID_appro`) REFERENCES `appro` (`ID_appro`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ap` FOREIGN KEY (`ID_Produit`) REFERENCES `produit` (`ID_Produit`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `cmd`
--
ALTER TABLE `cmd`
  ADD CONSTRAINT `cmd_ibfk_1` FOREIGN KEY (`ID_Client`) REFERENCES `client` (`ID_Client`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `commande_ibfk_1` FOREIGN KEY (`ID_cmd`) REFERENCES `cmd` (`ID_cmd`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cp` FOREIGN KEY (`ID_Produit`) REFERENCES `produit` (`ID_Produit`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `consultation`
--
ALTER TABLE `consultation`
  ADD CONSTRAINT `consultation_ibfk_1` FOREIGN KEY (`ID_Patient`) REFERENCES `patient` (`ID_Patient`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_coph` FOREIGN KEY (`ID_Ophtalmologue`) REFERENCES `ophtalmologue` (`ID_Ophtalmologue`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `facture_client`
--
ALTER TABLE `facture_client`
  ADD CONSTRAINT `fk_fc` FOREIGN KEY (`ID_Client`) REFERENCES `client` (`ID_Client`),
  ADD CONSTRAINT `fk_fct` FOREIGN KEY (`ID_Client`) REFERENCES `client` (`ID_Client`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `facture_fournisseur`
--
ALTER TABLE `facture_fournisseur`
  ADD CONSTRAINT `fk_ff` FOREIGN KEY (`ID_Fournisseur`) REFERENCES `fournisseur` (`ID_Fournisseur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rdv`
--
ALTER TABLE `rdv`
  ADD CONSTRAINT `rp` FOREIGN KEY (`ID_Patient`) REFERENCES `patient` (`ID_Patient`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
