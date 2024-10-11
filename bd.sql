-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 09 oct. 2024 à 14:45
-- Version du serveur :  8.0.34
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `epsi`
--

-- --------------------------------------------------------
--
-- Structure de la table `informationmedicale`
--

DROP TABLE IF EXISTS `informationmedicale`;
CREATE TABLE IF NOT EXISTS `informationmedicale` (
  `id_info` int NOT NULL AUTO_INCREMENT,
  `id_medecin` int DEFAULT NULL,
  `id_patient` int DEFAULT NULL,
  `id_type_info` int DEFAULT NULL,
  `description` text,
  `date_creation` datetime DEFAULT NULL,
  PRIMARY KEY (`id_info`),
  KEY `id_medecin` (`id_medecin`),
  KEY `id_patient` (`id_patient`),
  KEY `id_type_info` (`id_type_info`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `informationmedicale`
--

INSERT INTO `informationmedicale` (`id_info`, `id_medecin`, `id_patient`, `id_type_info`, `description`, `date_creation`) VALUES
(1, 1, 1, 1, 'Chirurgie appendiculaire réalisée sans complications.', '2024-10-08 13:53:43'),
(2, 1, 2, 2, 'Consultation psychiatrique pour anxiété généralisée.', '2024-10-08 13:53:43'),
(3, 2, 3, 3, 'Suivi cardiaque effectué, tous les paramètres sont normaux.', '2024-10-08 13:53:43'),
(4, 2, 4, 4, 'Examen pédiatrique complet réalisé avec succès.', '2024-10-08 13:53:43');

-- --------------------------------------------------------

--
-- Structure de la table `patient`
--

DROP TABLE IF EXISTS `patient`;
CREATE TABLE IF NOT EXISTS `patient` (
  `id_patient` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) DEFAULT NULL,
  `prenom` varchar(50) DEFAULT NULL,
  `date_naissance` date DEFAULT NULL,
  `sexe` enum('Homme','Femme') DEFAULT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_patient`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `patient`
--

INSERT INTO `patient` (`id_patient`, `nom`, `prenom`, `date_naissance`, `sexe`, `adresse`, `telephone`, `email`) VALUES
(1, 'Durand', 'Alice', '1985-06-15', 'Femme', '12 rue de la Paix, Paris', '0123456789', 'alice.durand@example.com'),
(2, 'Moreau', 'Paul', '1990-03-22', 'Homme', '45 avenue des Champs, Lyon', '0987654321', 'paul.moreau@example.com'),
(3, 'Lefevre', 'Claire', '1978-11-30', 'Femme', '78 boulevard Saint-Michel, Marseille', '0147253698', 'claire.lefevre@example.com'),
(4, 'Rousseau', 'Marc', '1965-05-12', 'Homme', '33 chemin des Écoles, Toulouse', '0154938274', 'marc.rousseau@example.com');

-- --------------------------------------------------------

--
-- Structure de la table `tache`
--

DROP TABLE IF EXISTS `tache`;
CREATE TABLE IF NOT EXISTS `tache` (
  `id_tache` int NOT NULL AUTO_INCREMENT,
  `id_infirmier` int DEFAULT NULL,
  `id_medecin` int DEFAULT NULL,
  `id_info` int DEFAULT NULL,
  `description` text,
  `status` enum('a faire','en cours','termine') DEFAULT NULL,
  `date_creation` datetime DEFAULT NULL,
  `date_echeance` datetime DEFAULT NULL,
  PRIMARY KEY (`id_tache`),
  KEY `id_infirmier` (`id_infirmier`),
  KEY `id_medecin` (`id_medecin`),
  KEY `id_info` (`id_info`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `tache`
--

INSERT INTO `tache` (`id_tache`, `id_infirmier`, `id_medecin`, `id_info`, `description`, `status`, `date_creation`, `date_echeance`) VALUES
(1, 2, 1, 1, 'Préparer le patient pour la chirurgie.', 'a faire', '2024-10-08 13:53:38', '2024-10-08 13:53:45'),
(2, 2, 1, 2, 'Effectuer un suivi des médicaments prescrits.', 'en cours', '2024-10-08 13:53:37', '2024-10-08 13:53:46'),
(3, 1, 2, 3, 'Vérifier les résultats des tests de stress.', 'a faire', '2024-10-08 13:53:36', '2024-10-08 13:53:47'),
(4, 1, 2, 4, 'S’assurer que le patient a reçu toutes les vaccinations nécessaires.', 'termine', '2024-10-08 13:53:35', '2024-10-08 13:53:48');

-- --------------------------------------------------------

--
-- Structure de la table `typeinformationmedicale`
--

DROP TABLE IF EXISTS `typeinformationmedicale`;
CREATE TABLE IF NOT EXISTS `typeinformationmedicale` (
  `id_type_info` int NOT NULL AUTO_INCREMENT,
  `nom_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_type_info`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `typeinformationmedicale`
--

INSERT INTO `typeinformationmedicale` (`id_type_info`, `nom_type`) VALUES
(1, 'Chirurgie'),
(2, 'Psychiatrie'),
(3, 'Cardiologie'),
(4, 'Pédiatrie'),
(5, 'Gynécologie');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) DEFAULT NULL,
  `prenom` varchar(50) DEFAULT NULL,
  `role` enum('medecin','infirmier') DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mot_de_passe` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id_user`, `nom`, `prenom`, `role`, `email`, `mot_de_passe`) VALUES
(1, 'Dupont', 'Jean', 'medecin', 'jean.dupont@example.com', 'motdepasse1'),
(2, 'Martin', 'Sophie', 'infirmier', 'sophie.martin@example.com', 'motdepasse2'),
(3, 'Bernard', 'Lucas', 'medecin', 'lucas.bernard@example.com', 'motdepasse3'),
(4, 'Leroy', 'Emma', 'infirmier', 'emma.leroy@example.com', 'motdepasse4');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `informationmedicale`
--
ALTER TABLE `informationmedicale`
  ADD CONSTRAINT `informationmedicale_ibfk_1` FOREIGN KEY (`id_medecin`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `informationmedicale_ibfk_2` FOREIGN KEY (`id_patient`) REFERENCES `patient` (`id_patient`),
  ADD CONSTRAINT `informationmedicale_ibfk_3` FOREIGN KEY (`id_type_info`) REFERENCES `typeinformationmedicale` (`id_type_info`);

--
-- Contraintes pour la table `tache`
--
ALTER TABLE `tache`
  ADD CONSTRAINT `tache_ibfk_1` FOREIGN KEY (`id_infirmier`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `tache_ibfk_2` FOREIGN KEY (`id_medecin`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `tache_ibfk_3` FOREIGN KEY (`id_info`) REFERENCES `informationmedicale` (`id_info`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
