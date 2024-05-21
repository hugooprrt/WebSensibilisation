-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 06 mai 2024 à 18:49
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `2024_websensibilisation`
--
CREATE DATABASE IF NOT EXISTS `2024_websensibilisation` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `2024_websensibilisation`;

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `proc_login`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_login` (IN `login` VARCHAR(50))   BEGIN
    SELECT utilisateurs.id_utilisateur, utilisateurs.nom_utilisateur, utilisateurs.prenom_utilisateur, utilisateurs.age_utilisateur, utilisateurs.login_utilisateur, utilisateurs.mail_utilisateur, utilisateurs.mot_de_passe
    FROM utilisateurs
    WHERE utilisateurs.login_utilisateur = login;
END$$

--
-- Fonctions
--
DROP FUNCTION IF EXISTS `func_createUser`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `func_createUser` (`prenom` VARCHAR(50), `nom` VARCHAR(50), `age` INT, `login` VARCHAR(50), `mail` VARCHAR(100), `mdp` VARCHAR(255)) RETURNS INT  BEGIN 
    DECLARE retour INT;
    
    DECLARE CONTINUE HANDLER FOR 1062
	SET retour  = -1062;

DECLARE CONTINUE HANDLER FOR 1452
	SET retour  = -1452;

    SELECT COUNT(*) INTO retour
    FROM utilisateurs
    WHERE utilisateurs.login_utilisateur = login;
    
    IF retour > 0 THEN
        SET retour = -1;
    ELSE
        SELECT COUNT(*) INTO retour
        FROM utilisateurs
        WHERE utilisateurs.mail_utilisateur = mail;
        
        IF retour > 0 THEN
            SET retour = -2;
        ELSE
            INSERT INTO utilisateurs (nom_utilisateur, prenom_utilisateur, age_utilisateur, login_utilisateur, mail_utilisateur, mot_de_passe)
            VALUES (nom, prenom, age, login, mail, mdp);
            
            SET retour = LAST_INSERT_ID();
        END IF;
    END IF;
    
    RETURN retour;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `acceuil`
--

DROP TABLE IF EXISTS `acceuil`;
CREATE TABLE IF NOT EXISTS `acceuil` (
  `id_information` int NOT NULL AUTO_INCREMENT,
  `libelle` text NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id_information`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `associer`
--

DROP TABLE IF EXISTS `associer`;
CREATE TABLE IF NOT EXISTS `associer` (
  `jeuxvideo` int NOT NULL,
  `utilisateur` int NOT NULL,
  PRIMARY KEY (`jeuxvideo`,`utilisateur`),
  KEY `utilisateur` (`utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `contact`
--

DROP TABLE IF EXISTS `contact`;
CREATE TABLE IF NOT EXISTS `contact` (
  `id_contact` int NOT NULL,
  `nom` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `escroqueries`
--

DROP TABLE IF EXISTS `escroqueries`;
CREATE TABLE IF NOT EXISTS `escroqueries` (
  `id_escroquerie` int NOT NULL AUTO_INCREMENT,
  `nom_escroquerie` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `explication` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_escroquerie`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `escroqueries`
--

INSERT INTO `escroqueries` (`id_escroquerie`, `nom_escroquerie`, `explication`) VALUES
(1, 'Phishing ', 'Le phishing est une tentative d\'obtenir des informations sensibles en se faisant passer pour une entité de confiance.'),
(2, 'Fraude financière en ligne', 'Les escrocs utilisent diverses techniques pour tromper les gens et les inciter à fournir des informations financières ou à effectuer des transactions frauduleuses.'),
(3, 'Vol d\'identité', 'Le vol d\'identité implique l\'utilisation frauduleuse des informations personnelles d\'une personne pour commettre des crimes.\r\n\r\n'),
(4, ' Logiciels malveillants', 'Les logiciels malveillants sont conçus pour endommager ou exploiter un système informatique sans le consentement de l\'utilisateur.'),
(5, 'Ransomware ', ' Les attaquants utilisent des logiciels malveillants pour chiffrer les fichiers d\'un utilisateur, rendant ceux-ci inaccessibles. Ensuite, ils exigent une rançon en échange de la clé de déchiffrement.'),
(6, 'Attaques par force brute', ' Les attaquants essaient de deviner les mots de passe en utilisant des programmes automatisés qui testent différentes combinaisons jusqu\'à ce qu\'ils trouvent la bonne.\r\n\r\n'),
(7, 'Ingénierie sociale', 'Les attaquants utilisent des tactiques psychologiques pour manipuler les individus et les inciter à divulguer des informations sensibles.'),
(8, 'Attaques DDoS ', 'Les attaquants utilisent des réseaux d\'ordinateurs compromis (botnets) pour inonder un serveur de trafic, le surchargeant et le rendant indisponible pour les utilisateurs légitimes.'),
(9, 'Injection SQL', ' Les attaquants insèrent des commandes SQL malveillantes dans les champs d\'entrée d\'une application web, exploitant les vulnérabilités de la base de données.'),
(10, 'Attaques de l\'homme du milieu', ' Un attaquant intercepte les communications entre deux parties sans qu\'elles le sachent, pouvant ainsi accéder à des informations sensibles.'),
(11, 'Attaques Zero-Day ', ' Les attaques exploitent les failles de sécurité non corrigées dans les logiciels avant que le fournisseur ne publie un correctif.'),
(12, 'Attaques par détournement de session', ' Les attaquants volent les cookies d\'authentification pour usurper l\'identité d\'un utilisateur authentifié.'),
(13, 'Attaques par déni de service (DoS) ', 'Les attaquants inondent un service avec du trafic légitime ou malveillant, rendant le service indisponible.'),
(14, 'Attaques contre les points d\'accès Wi-Fi', ' Les attaquants exploitent les vulnérabilités des réseaux sans fil pour accéder aux données des utilisateurs.'),
(15, 'Attaques sur les systèmes de gestion d\'identité', ': Les attaquants visent les systèmes qui gèrent les informations d\'identification des utilisateurs pour accéder à des comptes sensibles.'),
(16, 'Attaques par élévation de privilèges', 'Les attaquants cherchent à obtenir des privilèges d\'accès plus élevés que ce qui leur est initialement attribué.'),
(17, 'Attaques par détournement de cookies', ' Les attaquants volent les cookies d\'authentification stockés sur l\'ordinateur d\'un utilisateur pour accéder à des comptes en ligne.'),
(18, 'Attaques sur les objets connectés (IoT) ', ' Les attaquants ciblent les dispositifs IoT vulnérables pour compromettre les réseaux ou accéder à des informations sensibles.'),
(19, 'Attaques sur les serveurs web', ' Les attaquants exploitent les vulnérabilités des serveurs web pour prendre le contrôle de sites et accéder à des données.'),
(20, 'Attaques par canaux cachés', ' Les attaquants utilisent des méthodes non conventionnelles pour communiquer et éviter la détection.'),
(21, 'Attaques par exécution de code à distance', ' Les attaquants exploitent des vulnérabilités pour exécuter du code sur des systèmes distants, potentiellement compromettant leur intégrité.');

-- --------------------------------------------------------

--
-- Structure de la table `jeuxvideo`
--

DROP TABLE IF EXISTS `jeuxvideo`;
CREATE TABLE IF NOT EXISTS `jeuxvideo` (
  `id_jeu` int NOT NULL AUTO_INCREMENT,
  `id_utilisateur` int NOT NULL,
  `education_pegi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `risques_associes` text NOT NULL,
  `image_pegi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'lien de la photo du PEGI',
  `image_jeux` text NOT NULL COMMENT 'lien de l''image du jeux',
  PRIMARY KEY (`id_jeu`),
  KEY `id_utilisateur` (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pegi`
--

DROP TABLE IF EXISTS `pegi`;
CREATE TABLE IF NOT EXISTS `pegi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pegi` int NOT NULL,
  `pegi_explication` text NOT NULL,
  `pegi_image` varchar(255) NOT NULL,
  `jeux_image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `pegi`
--

INSERT INTO `pegi` (`id`, `pegi`, `pegi_explication`, `pegi_image`, `jeux_image`) VALUES
(1, 3, 'Avec cette classification, le contenu du jeu est considéré comme adapté à toutes les classes d’âge. Le jeu ne doit pas comporter de sons ou d’images susceptibles d’effrayer ou de faire peur à de jeunes enfants. Les formes de violence très modérées dans un contexte comique ou enfantin sont acceptables. Le jeu ne doit faire entendre aucun langage grossier.\r\n', 'pegi3.png', ''),
(2, 7, 'Les contenus présentant des scènes ou sons potentiellement effrayants tombent dans cette classe. Avec une classification PEGI&nbsp;7 des scènes de violence très modérées (une violence implicite, non détaillée ou non réaliste) peuvent être autorisées.\r\n', 'pegi7.png', ''),
(3, 12, 'Des jeux vidéo montrant de la violence sous une forme plus graphique par rapport à des personnages imaginaires et/ou une violence non graphique envers des personnages à figure humaine entrent dans cette classe d’âge. Des insinuations à caractère sexuel ou des positions sexuelles peuvent être présentes, mais dans cette catégorie les grossièretés doivent rester légères. Les jeux d’argent tels qu’ils se déroulent normalement dans le monde réel, dans les casinos ou dans les salles de jeux de hasard, sont également autorisés (par exemple les jeux de cartes qui, dans le monde réel, seraient joués pour de l’argent).\r\n', 'pegi12.png', ''),
(4, 16, 'Cette classification s’applique lorsque la représentation de la violence (ou d’un contact sexuel) atteint un niveau semblable à celui que l’on retrouverait dans la réalité. Les jeux classés dans la catégorie&nbsp;16 peuvent contenir un langage grossier plus extrême, des jeux de hasard, ainsi qu’une consommation de tabac, d’alcool ou de drogues.\r\n', 'pegi16.png', ''),
(5, 18, 'La classification destinée aux adultes s’applique lorsque le degré de violence atteint un niveau où il rejoint une représentation de violence crue, de meurtre apparemment sans motivation ou de violence contre des personnages sans défense. La glorification des drogues illégales et les contacts sexuels explicites entrent également dans cette tranche d’âge.\r\n', 'pegi18.png', ''),
(6, 0, 'Le système PEGI de classification par âge des jeux vidéo est utilisé dans 38 pays européens. La classification par âge confirme que le jeu est approprié à l’âge du joueur. La classification PEGI se base sur le caractère adapté d’un jeu à une classe d’âge, et non sur le niveau de difficulté.', '', ''),
(7, 0, 'Le jeu contient un langage grossier. Ce descripteur peut apparaître sur les jeux classés PEGI 12 (grossièreté légère), PEGI 16 (jurons à caractère sexuel ou blasphèmes) ou PEGI 18 (jurons à caractère sexuel ou blasphèmes).\r\n', 'bad-language-black-EN.png', ''),
(8, 0, 'Le jeu contient des représentations ethniques, religieuses, nationalistes ou autres stéréotypes susceptibles d’encourager la haine. Ce contenu est toujours limité à la classification PEGI 18 (et susceptible d’enfreindre la législation pénale nationale).\r\n', 'discrimination-black-EN.png', ''),
(9, 0, 'Le jeu se réfère à ou décrit la consommation de drogues illégales, d’alcool ou de tabac. Les jeux sur lesquels apparaissent ce descripteur de contenu sont toujours classés PEGI 16 ou PEGI 18.\r\n', 'drugs-black-EN.png', ''),
(10, 0, 'Ce descripteur peut apparaître sur des jeux PEGI 7 s’ils contiennent des images ou des sons susceptibles d’effrayer ou de faire peur aux jeunes enfants, ou sur des jeux PEGI 12 s’ils contiennent des sons ou des effets horrifiants (mais sans aucun contenu violent).\r\n', 'fear-black-EN.png', ''),
(11, 0, 'Le jeu présente des contenus qui encouragent ou enseignent les jeux de hasard. Ces simulations de jeux concernent les jeux de hasard qui ont normalement lieu dans les casinos ou les salles de jeux de hasard. Les jeux ayant ce type de contenus sont classés PEGI&nbsp;12, PEGI 16 ou PEGI 18.\r\n', 'gambling-black-EN.png', ''),
(12, 0, 'This game presents players with the option to purchase digital goods or services with real-world currency. These purchases include but are not limited to bonus levels, skins, surprise items, music, virtual coins and other forms of in-game currency, subscriptions, season passes and upgrades (e.g. to disable ads).\r\n', 'in-game-purchase-black-EN.png', ''),
(13, 0, 'Ce descripteur peut accompagner une classification PEGI 12 si le jeu contient des positions ou des insinuations à caractère sexuel, une classification PEGI 16 s’il contient des scènes de nudité ou des rapports sexuels sans organes génitaux visibles ou une classification PEGI 18 s’il contient une activité sexuelle explicite. Les scènes de nudité dans un environnement non sexuel n’exigent aucune classification par âge spécifique et ce descripteur n’est pas nécessaire.\r\n', 'sexual-content-black-EN.png', ''),
(14, 0, 'Le jeu contient des scènes de violence. Dans les jeux classés PEGI 7, les scènes de violence ne peuvent être ni réalistes ni détaillées. Les jeux PEGI 12 peuvent contenir de la violence dans un environnement imaginaire ou une violence non réaliste par rapport à des personnages à figure humaine, alors que les jeux classés PEGI 16 ou 18 contiennent des scènes de violence de plus en plus réalistes.\r\n', 'violence-black-EN.png', ''),
(15, 3, '', '', 'rocketLeague.jpg'),
(16, 3, '', '', 'lego.jpg'),
(17, 7, '', '', 'minecraft.jpg'),
(18, 7, '', '', 'fifa24.jpg'),
(19, 12, '', '', 'needforspeed.jpg'),
(20, 12, '', '', 'fortnite.jpg'),
(21, 16, '', '', 'PUBG.jpg'),
(22, 16, '', '', 'spiderman.jpg'),
(23, 18, '', '', 'assassinsCreed.jpg'),
(24, 18, '', '', 'r6.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `question_enfant`
--

DROP TABLE IF EXISTS `question_enfant`;
CREATE TABLE IF NOT EXISTS `question_enfant` (
  `id_question` int NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `rep_correct` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_question`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `question_enfant`
--

INSERT INTO `question_enfant` (`id_question`, `question`, `rep_correct`) VALUES
(1, 'Tous les jeux vidéo conviennent à tous les âges.', 0),
(2, 'Les jeux vidéo peuvent aider à apprendre de nouvelles compétences.', 1),
(3, ' Les jeux vidéo peuvent être joués en ligne avec des amis.', 1),
(4, 'Il est important de respecter les limites de temps de jeu ', 1),
(5, 'Les jeux vidéo sont toujours un moyen sûr de se divertir en ligne.', 0),
(6, 'Les jeux vidéo peuvent encourager l\'imagination et la créativité.', 1),
(7, 'Jouer à des jeux vidéo peut aider à développer des compétences en résolution de problèmes.', 1),
(8, 'Les jeux vidéo peuvent contenir des informations personnelles sensibles.', 1),
(9, ' Il est important de respecter les règles de sécurité en ligne lorsqu\'on joue à des jeux vidéo.', 1),
(10, ' Les jeux vidéo peuvent être une source de stress et de frustration.', 1),
(11, 'Jouer à des jeux vidéo peut aider à améliorer la coordination main-œil.', 1),
(12, 'Tous les jeux vidéo contiennent des contenus violents.', 0),
(13, ' Les jeux vidéo sont uniquement destinés aux garçons.', 0),
(14, ' Les parents ne devraient pas surveiller ce que leurs enfants font en ligne lorsqu\'ils jouent à des jeux vidéo.', 0),
(15, 'Les jeux vidéo peuvent aider à renforcer les compétences en lecture et en écriture.', 1),
(16, 'Les jeux vidéo peuvent encourager la socialisation avec d\'autres joueurs.', 1),
(17, 'Jouer à des jeux vidéo pendant de longues périodes peut nuire à la santé physique.', 1),
(18, 'Il est acceptable de partager des informations personnelles en ligne lorsqu\'on joue à des jeux vidéo.', 0),
(19, 'Les jeux vidéo ne sont pas éducatifs et ne peuvent pas aider à l\'apprentissage.', 0),
(20, 'Les parents devraient encourager une variété d\'activités en plus des jeux vidéo.', 1);

-- --------------------------------------------------------

--
-- Structure de la table `question_parent`
--

DROP TABLE IF EXISTS `question_parent`;
CREATE TABLE IF NOT EXISTS `question_parent` (
  `id_question` int NOT NULL,
  `question` text NOT NULL,
  `rep_correct` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `question_parent`
--

INSERT INTO `question_parent` (`id_question`, `question`, `rep_correct`) VALUES
(1, ' Les jeux vidéo peuvent favoriser le développement de compétences cognitives chez les enfants.', 1),
(2, 'Tous les jeux vidéo sont violents et inappropriés pour les enfants.', 0),
(3, 'Passer de longues heures à jouer à des jeux vidéo peut affecter négativement la santé mentale des adolescents.', 1),
(4, ' Les jeux vidéo peuvent encourager la créativité et la résolution de problèmes chez les joueurs.', 1),
(5, ' Il est important pour les parents de superviser et de limiter le temps que leurs enfants passent à jouer à des jeux vidéo.', 1),
(6, 'Jouer à des jeux vidéo peut aider à développer des compétences sociales et à renforcer les amitiés.', 1),
(7, 'Les jeux vidéo sont exclusivement destinés aux enfants et aux adolescents.', 0),
(8, 'Les jeux vidéo peuvent avoir des classifications d\'âge, et les parents devraient prendre en compte ces recommandations.', 1),
(9, ' Les jeux vidéo peuvent être utilisés comme outils éducatifs pour enseigner des concepts académiques.', 1),
(10, 'La communication ouverte entre les parents et les enfants sur les jeux vidéo est essentielle pour une utilisation responsable.', 1),
(11, 'Tous les jeux vidéo sont addictifs et peuvent causer des problèmes de dépendance.', 0),
(12, 'Les jeux vidéo ne peuvent pas avoir d\'impact sur la performance académique des enfants.', 0),
(13, 'Les jeux vidéo n\'ont aucune influence sur le comportement des enfants en dehors du monde virtuel.', 0),
(14, 'Les jeux vidéo sont toujours une perte de temps et ne contribuent pas au développement des compétences utiles.', 0),
(15, 'Les jeux vidéo violents conduisent inévitablement à des comportements agressifs dans la vie réelle.', 0),
(16, 'Les enfants peuvent jouer à des jeux vidéo pendant des heures sans aucune conséquence pour leur santé physique.', 0),
(17, 'Les jeux vidéo sont exclusivement destinés aux garçons, les filles ne devraient pas y jouer.', 0),
(18, 'Les parents ne devraient pas s\'inquiéter de la vie en ligne de leurs enfants dans les jeux vidéo.', 0),
(19, 'Les jeux vidéo n\'ont aucune valeur éducative et ne peuvent pas contribuer à l\'apprentissage.', 0),
(20, 'Tous les jeux vidéo comportent des contenus inappropriés pour les enfants, quelle que soit leur classification d\'âge.', 0);

-- --------------------------------------------------------

--
-- Structure de la table `type_utilisateur`
--

DROP TABLE IF EXISTS `type_utilisateur`;
CREATE TABLE IF NOT EXISTS `type_utilisateur` (
  `id_type` int NOT NULL AUTO_INCREMENT,
  `code_type` int NOT NULL COMMENT '1 si c''est un enfant, 2si c''est un parent, 3 si c''est un admin',
  PRIMARY KEY (`id_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id_utilisateur` int NOT NULL AUTO_INCREMENT,
  `nom_utilisateur` varchar(50) NOT NULL,
  `prenom_utilisateur` varchar(50) NOT NULL,
  `age_utilisateur` int NOT NULL,
  `login_utilisateur` varchar(50) NOT NULL,
  `mail_utilisateur` varchar(100) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `date_inscription` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_utilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id_utilisateur`, `nom_utilisateur`, `prenom_utilisateur`, `age_utilisateur`, `login_utilisateur`, `mail_utilisateur`, `mot_de_passe`, `date_inscription`) VALUES
(7, 'perret', 'hugo', 18, 'dffddfdfdfdfdf', 'perret.hugo37@gmail.com', '$2y$10$qzwuZan565pX21ptN2lbTeCLmoDRgv5poLLxMPt/TP0GgBJ84kIoC', '2024-05-06 15:14:27');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `associer`
--
ALTER TABLE `associer`
  ADD CONSTRAINT `associer_ibfk_1` FOREIGN KEY (`utilisateur`) REFERENCES `type_utilisateur` (`id_type`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `jeuxvideo`
--
ALTER TABLE `jeuxvideo`
  ADD CONSTRAINT `jeuxvideo_ibfk_1` FOREIGN KEY (`id_jeu`) REFERENCES `associer` (`jeuxvideo`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `type_utilisateur`
--
ALTER TABLE `type_utilisateur`
  ADD CONSTRAINT `type_utilisateur_ibfk_1` FOREIGN KEY (`id_type`) REFERENCES `escroqueries` (`id_escroquerie`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
