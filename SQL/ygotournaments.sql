-- phpMyAdmin SQL Dump
-- version 4.5.4.1
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Ven 09 Septembre 2022 à 13:33
-- Version du serveur :  5.7.11
-- Version de PHP :  7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `ygotournaments`
--

-- --------------------------------------------------------

--
-- Structure de la table `boutique`
--

CREATE TABLE `boutique` (
  `id_boutique` varchar(30) NOT NULL,
  `nom_boutique` varchar(100) DEFAULT NULL,
  `mail_boutique` varchar(150) DEFAULT NULL,
  `rue_boutique` varchar(150) DEFAULT NULL,
  `cp_boutique` char(5) DEFAULT NULL,
  `ville_boutique` varchar(80) DEFAULT NULL,
  `mdp_boutique` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `duel`
--

CREATE TABLE `duel` (
  `id_duel` int(10) UNSIGNED NOT NULL,
  `id_joueur_1` varchar(10) NOT NULL,
  `id_joueur_2` varchar(10) NOT NULL,
  `id_gagnant` varchar(10) NOT NULL,
  `id_manche` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `manche`
--

CREATE TABLE `manche` (
  `id_manche` int(10) UNSIGNED NOT NULL,
  `id_tournoi` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `participant`
--

CREATE TABLE `participant` (
  `id_konami_participant` varchar(10) NOT NULL,
  `id_tournoi` int(10) UNSIGNED NOT NULL,
  `nom_deck_participant` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `tournoi`
--

CREATE TABLE `tournoi` (
  `id_tournoi` int(10) UNSIGNED NOT NULL,
  `date_tournoi` date DEFAULT NULL,
  `id_boutique` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id_konami_utilisateur` varchar(10) NOT NULL,
  `pseudo_konami_utilisateur` varchar(50) DEFAULT NULL,
  `mail_utilisateur` varchar(150) DEFAULT NULL,
  `mdp_utilisateur` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `boutique`
--
ALTER TABLE `boutique`
  ADD PRIMARY KEY (`id_boutique`);

--
-- Index pour la table `duel`
--
ALTER TABLE `duel`
  ADD PRIMARY KEY (`id_duel`),
  ADD KEY `id_joueur_1` (`id_joueur_1`),
  ADD KEY `id_joueur_2` (`id_joueur_2`),
  ADD KEY `id_gagnant` (`id_gagnant`),
  ADD KEY `id_manche` (`id_manche`);

--
-- Index pour la table `manche`
--
ALTER TABLE `manche`
  ADD PRIMARY KEY (`id_manche`),
  ADD KEY `id_tournoi` (`id_tournoi`);

--
-- Index pour la table `participant`
--
ALTER TABLE `participant`
  ADD PRIMARY KEY (`id_konami_participant`,`id_tournoi`),
  ADD KEY `id_tournoi` (`id_tournoi`);

--
-- Index pour la table `tournoi`
--
ALTER TABLE `tournoi`
  ADD PRIMARY KEY (`id_tournoi`),
  ADD KEY `id_boutique` (`id_boutique`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id_konami_utilisateur`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `duel`
--
ALTER TABLE `duel`
  MODIFY `id_duel` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `manche`
--
ALTER TABLE `manche`
  MODIFY `id_manche` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `tournoi`
--
ALTER TABLE `tournoi`
  MODIFY `id_tournoi` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `duel`
--
ALTER TABLE `duel`
  ADD CONSTRAINT `duel_ibfk_1` FOREIGN KEY (`id_joueur_1`) REFERENCES `utilisateur` (`id_konami_utilisateur`),
  ADD CONSTRAINT `duel_ibfk_2` FOREIGN KEY (`id_joueur_2`) REFERENCES `utilisateur` (`id_konami_utilisateur`),
  ADD CONSTRAINT `duel_ibfk_3` FOREIGN KEY (`id_gagnant`) REFERENCES `utilisateur` (`id_konami_utilisateur`),
  ADD CONSTRAINT `duel_ibfk_4` FOREIGN KEY (`id_manche`) REFERENCES `manche` (`id_manche`);

--
-- Contraintes pour la table `manche`
--
ALTER TABLE `manche`
  ADD CONSTRAINT `manche_ibfk_1` FOREIGN KEY (`id_tournoi`) REFERENCES `tournoi` (`id_tournoi`);

--
-- Contraintes pour la table `participant`
--
ALTER TABLE `participant`
  ADD CONSTRAINT `participant_ibfk_1` FOREIGN KEY (`id_konami_participant`) REFERENCES `utilisateur` (`id_konami_utilisateur`),
  ADD CONSTRAINT `participant_ibfk_2` FOREIGN KEY (`id_tournoi`) REFERENCES `tournoi` (`id_tournoi`);

--
-- Contraintes pour la table `tournoi`
--
ALTER TABLE `tournoi`
  ADD CONSTRAINT `tournoi_ibfk_1` FOREIGN KEY (`id_boutique`) REFERENCES `boutique` (`id_boutique`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
