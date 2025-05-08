/*
 Navicat MySQL Dump SQL

 Target Server Type    : MySQL
 Target Server Version : 80404 (8.4.4-commercial)
 File Encoding         : 65001

 Date: 14/03/2025 11:14:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for api_apikey
-- ----------------------------
DROP TABLE IF EXISTS `api_apikey`;
CREATE TABLE `api_apikey`  (
  `apikey_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `apikey` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `vertrag_id` bigint UNSIGNED NOT NULL,
  `zeitraum_id` bigint UNSIGNED NOT NULL,
  `ist_masterkey` tinyint NOT NULL DEFAULT 0,
  `bearbeiter_id` bigint UNSIGNED NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`apikey_id`) USING BTREE,
  UNIQUE INDEX `apikey`(`apikey` ASC) USING BTREE,
  INDEX `vertrag_id`(`vertrag_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of api_apikey
-- ----------------------------
INSERT INTO `api_apikey` VALUES (1, '99f26159eb7a50784a9006fa35a5dbe32e604fee', 1, 1, 0, 1, '2020-09-01 00:00:00');
INSERT INTO `api_apikey` VALUES (2, '3ae7824c75f1aef362dab353bfceee6722c1f6f9', 2, 1, 0, 1, '2020-09-01 00:00:00');
INSERT INTO `api_apikey` VALUES (3, '9faa37b23f350c516e3589e60083d10cd368df01', 3, 4, 0, 1, '2021-09-01 00:00:00');
INSERT INTO `api_apikey` VALUES (4, '8067562d7138d72501485941246cf9b229c3a46a', 2, 4, 1, 1, '2021-09-01 00:00:00');

-- ----------------------------
-- Table structure for stamd_flagbit_ref
-- ----------------------------
DROP TABLE IF EXISTS `stamd_flagbit_ref`;
CREATE TABLE `stamd_flagbit_ref`  (
  `flagbit_ref_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `datensatz_typ_id` int UNSIGNED NOT NULL,
  `datensatz_id` bigint UNSIGNED NOT NULL,
  `flagbit` bigint UNSIGNED NOT NULL,
  `zeitraum_id` bigint UNSIGNED NOT NULL,
  `bearbeiter_id` bigint UNSIGNED NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`flagbit_ref_id`) USING BTREE,
  INDEX `datensatz_typ_id`(`datensatz_typ_id` ASC) USING BTREE,
  INDEX `datensatz_id`(`datensatz_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of stamd_flagbit_ref
-- ----------------------------
INSERT INTO `stamd_flagbit_ref` VALUES (100, 2, 1, 4, 1, 2, '2020-10-01 12:05:00');
INSERT INTO `stamd_flagbit_ref` VALUES (101, 2, 2, 4, 2, 3, '2021-03-01 14:55:54');
INSERT INTO `stamd_flagbit_ref` VALUES (102, 2, 3, 12, 2, 2, '2021-09-01 13:15:58');

-- ----------------------------
-- Table structure for stamd_nutzerdetails
-- ----------------------------
DROP TABLE IF EXISTS `stamd_nutzerdetails`;
CREATE TABLE `stamd_nutzerdetails`  (
  `nutzerdetails_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `Bearbeiter` bigint UNSIGNED NULL DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`nutzerdetails_id`) USING BTREE,
  INDEX `stamd_nutzerdetails_FKIndex1`(`name` ASC) USING BTREE,
  INDEX `stamd_nutzerdetails_FKIndex6`(`timestamp` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of stamd_nutzerdetails
-- ----------------------------
INSERT INTO `stamd_nutzerdetails` VALUES (1, 'Admin User', NULL, '2020-01-01 00:00:00');
INSERT INTO `stamd_nutzerdetails` VALUES (2, 'Merchant A', 1, '2020-09-01 00:00:00');
INSERT INTO `stamd_nutzerdetails` VALUES (3, 'Merchant B', 1, '2020-09-01 00:00:00');
INSERT INTO `stamd_nutzerdetails` VALUES (4, 'User', 1, '2021-01-01 00:00:00');

-- ----------------------------
-- Table structure for transaktion_transaktionen
-- ----------------------------
DROP TABLE IF EXISTS `transaktion_transaktionen`;
CREATE TABLE `transaktion_transaktionen`  (
  `trans_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `produkt_id` int NOT NULL,
  `vertrag_id` bigint UNSIGNED NOT NULL,
  `Betrag` bigint UNSIGNED NOT NULL,
  `beschreibung` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `waehrung_id` int UNSIGNED NOT NULL DEFAULT 1,
  `bearbeiter` bigint UNSIGNED NOT NULL,
  `erstelldatum` datetime NULL DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`trans_id`) USING BTREE,
  INDEX `ix_betrag`(`Betrag` ASC) USING BTREE,
  INDEX `ix_erstelldatum`(`erstelldatum` ASC) USING BTREE,
  INDEX `ix_produkt_id_erstelldatum`(`produkt_id` ASC, `erstelldatum` ASC) USING BTREE,
  INDEX `ix_timestamp_produkt_id`(`timestamp` ASC, `produkt_id` ASC) USING BTREE,
  INDEX `ix_vertrag_id_produkt_id_erstelldatum`(`vertrag_id` ASC, `produkt_id` ASC, `erstelldatum` ASC) USING BTREE,
  INDEX `ix_waehrung_id_erstelldatum`(`waehrung_id` ASC, `erstelldatum` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of transaktion_transaktionen
-- ----------------------------
INSERT INTO `transaktion_transaktionen` VALUES (1, 1, 1, 123, 'Order #1', 1, 2, '2020-10-01 12:05:00', '2020-10-01 12:05:00');
INSERT INTO `transaktion_transaktionen` VALUES (2, 1, 2, 45, 'Order #2', 1, 3, '2021-03-01 14:55:54', '2021-03-01 14:55:54');
INSERT INTO `transaktion_transaktionen` VALUES (3, 1, 3, 234, 'Order #3', 1, 2, '2021-09-01 13:15:58', '2021-09-01 13:15:58');
INSERT INTO `transaktion_transaktionen` VALUES (4, 1, 2, 23, 'Order #4', 1, 3, '2021-09-02 00:26:44', '2021-09-02 00:26:44');

-- ----------------------------
-- Table structure for vertragsverw_vertrag
-- ----------------------------
DROP TABLE IF EXISTS `vertragsverw_vertrag`;
CREATE TABLE `vertragsverw_vertrag`  (
  `vertrag_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `zeitraum_id` bigint UNSIGNED NOT NULL,
  `nutzer_id` bigint UNSIGNED NOT NULL,
  `Bearbeiter` bigint UNSIGNED NOT NULL,
  `erstelldatum` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`vertrag_id`) USING BTREE,
  INDEX `nutzer_id`(`nutzer_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vertragsverw_vertrag
-- ----------------------------
INSERT INTO `vertragsverw_vertrag` VALUES (1, 1, 2, 1, '2020-09-01 00:00:00', '2020-09-01 00:00:00');
INSERT INTO `vertragsverw_vertrag` VALUES (2, 2, 3, 1, '2020-09-01 00:00:00', '2021-09-01 00:00:00');
INSERT INTO `vertragsverw_vertrag` VALUES (3, 4, 2, 1, '2021-09-01 00:00:00', '2021-09-01 00:00:00');

-- ----------------------------
-- Table structure for vorgaben_datensatz_typ
-- ----------------------------
DROP TABLE IF EXISTS `vorgaben_datensatz_typ`;
CREATE TABLE `vorgaben_datensatz_typ`  (
  `datensatz_typ_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `beschreibung` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`datensatz_typ_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vorgaben_datensatz_typ
-- ----------------------------
INSERT INTO `vorgaben_datensatz_typ` VALUES (1, 'nutzer_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (2, 'trans_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (3, 'karten_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (4, 'vertrag_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (5, 'zahlungsmittel_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (6, 'terminal_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (7, 'adr_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (8, 'hash_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (9, 'plz_normiert_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (10, 'branche_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (11, 'tid_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (12, 'mail_domain_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (13, 'bankengruppe_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (14, 'land_id für adr_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (15, 'zahlungsmittelcontainer_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (16, 'iin_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (17, 'land_id für iin_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (18, 'login (nutzer_id aus nutzer_logindaten)');
INSERT INTO `vorgaben_datensatz_typ` VALUES (19, 'mail_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (20, 'apikey_id (api_apikey)');
INSERT INTO `vorgaben_datensatz_typ` VALUES (21, 'merchant_whitelist_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (22, 'trans_hash_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (23, 'name_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (24, 'basket_item_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (25, 'kartengruppe_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (26, 'fall_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (27, 'servicekontakt_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (28, 'ean_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (29, 'wert_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (30, 'produkt_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (31, 'produktart_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (32, 'produkt_typ_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (33, 'nutzer_adress_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (34, 'nutzer_telefon_id');
INSERT INTO `vorgaben_datensatz_typ` VALUES (35, 'nutzer_email_id');

-- ----------------------------
-- Table structure for vorgaben_flagbit
-- ----------------------------
DROP TABLE IF EXISTS `vorgaben_flagbit`;
CREATE TABLE `vorgaben_flagbit`  (
  `flagbit_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `beschreibung` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tabellen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'nur als notiz, wird nicht ausgewertet',
  PRIMARY KEY (`flagbit_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vorgaben_flagbit
-- ----------------------------
INSERT INTO `vorgaben_flagbit` VALUES (1, '0 = Direkt, 1 = Accounting', 'Transaktion (datensatz_typ_id 2)');
INSERT INTO `vorgaben_flagbit` VALUES (2, '0 = keine ZG, 1 = ZG', 'Transaktion (datensatz_typ_id 2)');
INSERT INTO `vorgaben_flagbit` VALUES (3, '0 = kein 3DSecure, 1 = 3DSecure', 'Transaktion (datensatz_typ_id 2)');
INSERT INTO `vorgaben_flagbit` VALUES (4, '0 = XML, 1 = iFrame', 'Transaktion (datensatz_typ_id 2)');
INSERT INTO `vorgaben_flagbit` VALUES (5, '0 = keine Demo, 1 = Demo', 'Transaktion (datensatz_typ_id 2)');
INSERT INTO `vorgaben_flagbit` VALUES (6, '0 = keine Voraut. 1 = Voraut.', 'Transaktion (datensatz_typ_id 2)');
INSERT INTO `vorgaben_flagbit` VALUES (7, '0 = keine Rückstellung, 1 = mit Rückstellung von Auszahlung', 'Transaktion-Hash  (datensatz_typ_id 22)');
INSERT INTO `vorgaben_flagbit` VALUES (8, '0 = Stakeholderumbuchung nicht ausgeführt / nicht notwendig, 1 = Stakeholderumbuchung ausgeführt', 'Transaktion-Hash  (datensatz_typ_id 22)');
INSERT INTO `vorgaben_flagbit` VALUES (9, '0 = Warenkorb nicht verarbeitet, 1 = Warenkorb vollständig verarbeitet', 'Transaktion-Hash  (datensatz_typ_id 22)');
INSERT INTO `vorgaben_flagbit` VALUES (10, '0 = Warenkorbposition nicht verarbeitet / nicht notwendig, 1 = Warenkorbposition verarbeitet', 'api_basket_item_id (datensatz_typ_id 24)');
INSERT INTO `vorgaben_flagbit` VALUES (11, '1 = über Secucore erstellt', 'Transaktion (datensatz_typ_id 2)');
INSERT INTO `vorgaben_flagbit` VALUES (12, '1 = für Checkout erstellt', 'Transaktion (datensatz_typ_id 2)');
INSERT INTO `vorgaben_flagbit` VALUES (13, '0 = kein LVP, 1 = LVP', 'Transaktion (datensatz_typ_id 2)');
INSERT INTO `vorgaben_flagbit` VALUES (14, '0 = kein TRA, 1 = TRA', 'Transaktion (datensatz_typ_id 2)');
INSERT INTO `vorgaben_flagbit` VALUES (15, '0 = kein MIT, 1 = MIT', 'Transaktion (datensatz_typ_id 2)');

-- ----------------------------
-- Table structure for vorgaben_zeitraum
-- ----------------------------
DROP TABLE IF EXISTS `vorgaben_zeitraum`;
CREATE TABLE `vorgaben_zeitraum`  (
  `zeitraum_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `von` datetime NOT NULL,
  `bis` datetime NOT NULL,
  PRIMARY KEY (`zeitraum_id`) USING BTREE,
  UNIQUE INDEX `von_2`(`von` ASC, `bis` ASC) USING BTREE,
  INDEX `von`(`von` ASC) USING BTREE,
  INDEX `bis`(`bis` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of vorgaben_zeitraum
-- ----------------------------
INSERT INTO `vorgaben_zeitraum` VALUES (1, '2020-09-01 00:00:00', '2021-09-01 00:00:00');
INSERT INTO `vorgaben_zeitraum` VALUES (2, '2020-09-01 00:00:00', '2030-10-01 00:00:00');
INSERT INTO `vorgaben_zeitraum` VALUES (3, '2021-06-01 00:00:00', '2030-09-01 00:00:00');
INSERT INTO `vorgaben_zeitraum` VALUES (4, '2021-09-01 00:00:00', '2030-10-01 00:00:00');

-- ----------------------------
-- Procedure structure for api_erstelle_apikey
-- ----------------------------
DROP PROCEDURE IF EXISTS `api_erstelle_apikey`;
delimiter ;;
CREATE PROCEDURE `api_erstelle_apikey`(IN IN_vertrag_id INT(11),
  IN IN_bearbeiter_id INT(11),
  OUT OUT_fehler INT(11))
BEGIN

/*
#####
# Beschreibung:
#	Einen apikey für einen Vertrag erstellen
#
# OUT_fehler
# 0 - Ok
# 1 - INPUT leer
# 2 - Generierung API Key fehlgeschlagen
# 3 - es existiert bereits ein Eintrag für diese vertrag_id mit gültigem/aktuellem Zeitraum
#####
*/
DECLARE proz_max_anzahl_durchlaeufe INT DEFAULT 500;
DECLARE proz_anzahl_durchlaeufe INT DEFAULT 0;
DECLARE proz_von_datum DATETIME;
DECLARE proz_apikey VARCHAR(255);
DECLARE proz_anzahl, proz_zeitraum_id, proz_vertrag_id INT;

SELECT NOW() INTO proz_von_datum;

IF (IFNULL(IN_vertrag_id,0) <> 0 AND IFNULL(IN_bearbeiter_id,0) <> 0) THEN

	-- auf aktuellen Eintrag für den Vertrag prüfen
	SELECT vertrag_id
	INTO proz_vertrag_id
	FROM api_apikey
	INNER JOIN vorgaben_zeitraum ON vorgaben_zeitraum.zeitraum_id = api_apikey.zeitraum_id AND NOW() BETWEEN vorgaben_zeitraum.von AND vorgaben_zeitraum.bis
	WHERE vertrag_id = IN_vertrag_id LIMIT 1;

	-- prüfen ob ein aktueller Eintrag für diese vertrags_id bereits existiert
	IF IFNULL(proz_vertrag_id,0) = 0 THEN

		 loop_durchlauf: LOOP

			SELECT SHA1(CONCAT(UNIX_TIMESTAMP(NOW()), '537c70e7355eb935874e3ebd9e714fe7a0ecca69',UUID())) INTO proz_apikey;
		
			SELECT COUNT(*) INTO proz_anzahl FROM api_apikey WHERE apikey = proz_apikey;
			
			SET proz_anzahl_durchlaeufe = proz_anzahl_durchlaeufe + 1;

			IF ( proz_anzahl = 0 ) THEN
				-- generierter API Key noch nicht vorhanden
				SET OUT_fehler = 0;
				LEAVE loop_durchlauf;

			ELSEIF (proz_anzahl_durchlaeufe >= proz_max_anzahl_durchlaeufe) THEN

				SET OUT_fehler = 2;
				LEAVE loop_durchlauf;

			END IF;

		END LOOP loop_durchlauf;
		
		IF OUT_fehler = 0 THEN -- ok

			CALL erstelle_zeitraum(proz_von_datum, DATE_ADD(proz_von_datum,INTERVAL 50 YEAR), proz_zeitraum_id);

			INSERT INTO api_apikey (apikey, vertrag_id, zeitraum_id, bearbeiter_id) VALUES (proz_apikey, IN_vertrag_id, proz_zeitraum_id, IN_bearbeiter_id );

		END IF;

		

	ELSE

		SET OUT_fehler = 3;

	END IF;

ELSE

	SET OUT_fehler = 1;

END IF;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for erstelle_zeitraum
-- ----------------------------
DROP PROCEDURE IF EXISTS `erstelle_zeitraum`;
delimiter ;;
CREATE PROCEDURE `erstelle_zeitraum`(IN IN_von DATETIME,
  IN IN_bis DATETIME,
  OUT OUT_zeitraum_id INT UNSIGNED)
proc_block:BEGIN

/*
#####
# Beschreibung:
# Prozedur zum Erstellen eines Zeitraums.
#####
*/

-- Prüfen ob bereits ein Eintrag existiert
SELECT zeitraum_id
INTO OUT_zeitraum_id
FROM vorgaben_zeitraum
WHERE
  vorgaben_zeitraum.von = IN_von
  AND vorgaben_zeitraum.bis = IN_bis;

IF IFNULL( OUT_zeitraum_id, 0 ) <> 0 THEN
  LEAVE proc_block;
END IF;

INSERT IGNORE INTO vorgaben_zeitraum
SET
  von = IN_von,
  bis = IN_bis;

SELECT zeitraum_id
INTO OUT_zeitraum_id
FROM vorgaben_zeitraum
WHERE
  vorgaben_zeitraum.von = IN_von
  AND vorgaben_zeitraum.bis = IN_bis;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for stamd_aendern_erstellen_flagbit_ref
-- ----------------------------
DROP PROCEDURE IF EXISTS `stamd_aendern_erstellen_flagbit_ref`;
delimiter ;;
CREATE PROCEDURE `stamd_aendern_erstellen_flagbit_ref`(IN IN_datensatz_typ_id INT UNSIGNED,
  IN IN_datensatz_id INT UNSIGNED,
  IN IN_flagbit BIGINT(20),
  IN IN_modus TINYINT(4),
  IN IN_bearbeiter_id INT UNSIGNED,
  OUT OUT_fehler_code TINYINT(4),
  OUT OUT_fehler TEXT)
proc_block:BEGIN


/*
#####
# Beschreibung:
# Prozedur zum Referenzieren eines Flags
#
# IN_modus:
#   1 = Eintragen/Ändern
#   2 = Austragen
#
# OUT_fehler_code = OUT_fehler:
#   0 = NULL = kein Fehler
#   1 = Parameter nicht hinreichend gefüllt
#   2 = Flagbit-Parameter nicht gültig
#####
*/

DECLARE proz_flagbit_ref_id, proz_zeitraum_id_alt, proz_zeitraum_id_neu, proz_datensatz_typ_id, proz_datensatz_id, proz_fehler, proz_anzahl INT;
DECLARE proz_zeitraum_von_neu, proz_zeitraum_von_alt DATETIME;
DECLARE proz_flagbit BIGINT;
DECLARE proz_neuen_datensatz_anlegen, proz_alten_datensatz_deaktivieren BOOLEAN DEFAULT FALSE;

-- 0 = kein Fehler
SET OUT_fehler_code = 0;

IF IFNULL( IN_datensatz_typ_id, 0 ) = 0
  OR IFNULL( IN_datensatz_id, 0 ) = 0
  OR IFNULL( IN_modus, 0 ) NOT IN ( 1, 2 )
  OR IFNULL( IN_bearbeiter_id, 0 ) = 0
THEN

  -- 1 = Parameter nicht hinreichend gefüllt
  SET OUT_fehler_code = 1;
  SET OUT_fehler = 'Parameter nicht hinreichend gefüllt';
  LEAVE proc_block;

END IF;

IF IN_modus = 1 -- 1 = Eintragen/Ändern
  AND IN_flagbit IS NULL
THEN

  -- 1 = Parameter nicht hinreichend gefüllt
  SET OUT_fehler_code = 1;
  SET OUT_fehler = 'Parameter nicht hinreichend gefüllt';
  LEAVE proc_block;

END IF;

SET proz_zeitraum_von_neu = NOW();

-- nach aktuellem Datensatz suchen
SELECT
  stamd_flagbit_ref.flagbit_ref_id,
  vorgaben_zeitraum.von,
  stamd_flagbit_ref.datensatz_typ_id,
  stamd_flagbit_ref.datensatz_id,
  stamd_flagbit_ref.flagbit
INTO
  proz_flagbit_ref_id,
  proz_zeitraum_von_alt,
  proz_datensatz_typ_id,
  proz_datensatz_id,
  proz_flagbit
FROM
  stamd_flagbit_ref
  INNER JOIN vorgaben_zeitraum
    ON vorgaben_zeitraum.zeitraum_id = stamd_flagbit_ref.zeitraum_id
      AND proz_zeitraum_von_neu BETWEEN vorgaben_zeitraum.von AND vorgaben_zeitraum.bis
WHERE
  stamd_flagbit_ref.datensatz_typ_id = IN_datensatz_typ_id
  AND stamd_flagbit_ref.datensatz_id = IN_datensatz_id;

IF IN_modus = 1 -- 1 = Eintragen/Ändern
  AND IFNULL( proz_flagbit_ref_id, 0 ) = 0
THEN

  SET proz_neuen_datensatz_anlegen = TRUE;

ELSEIF IN_modus = 2 -- 2 = Austragen
  AND IFNULL( proz_flagbit_ref_id, 0 ) <> 0
THEN

  SET proz_alten_datensatz_deaktivieren = TRUE;

ELSEIF IN_modus = 1 -- 1 = Eintragen/Ändern
  AND IFNULL( proz_flagbit_ref_id, 0 ) <> 0
THEN

  IF NOT proz_flagbit <=> IN_flagbit THEN

    SET proz_neuen_datensatz_anlegen = TRUE;
    SET proz_alten_datensatz_deaktivieren = TRUE;

  END IF;

ELSEIF IN_modus = 2 -- 2 = Austragen
  AND IFNULL( proz_flagbit_ref_id, 0 ) = 0
THEN

  -- 2 = Flagbit-Parameter nicht gültig
  SET OUT_fehler_code = 2;
  SET OUT_fehler = 'Flagbit-Referenz existiert nicht';
  LEAVE proc_block;

END IF;

IF IFNULL( proz_alten_datensatz_deaktivieren, FALSE ) THEN

  CALL erstelle_zeitraum ( proz_zeitraum_von_alt, DATE_SUB( proz_zeitraum_von_neu, INTERVAL 1 SECOND ), proz_zeitraum_id_alt );

  UPDATE stamd_flagbit_ref
  SET
    stamd_flagbit_ref.zeitraum_id = proz_zeitraum_id_alt,
    stamd_flagbit_ref.bearbeiter_id = IN_bearbeiter_id
  WHERE stamd_flagbit_ref.flagbit_ref_id = proz_flagbit_ref_id;

END IF;

IF IFNULL( proz_neuen_datensatz_anlegen, FALSE ) THEN

  CALL erstelle_zeitraum ( proz_zeitraum_von_neu, DATE_ADD( proz_zeitraum_von_neu, INTERVAL 50 YEAR ), proz_zeitraum_id_neu );

  INSERT INTO stamd_flagbit_ref
  SET
    datensatz_typ_id = IN_datensatz_typ_id,
    datensatz_id = IN_datensatz_id,
    flagbit = IN_flagbit,
    zeitraum_id = proz_zeitraum_id_neu,
    bearbeiter_id = IN_bearbeiter_id;

END IF;

cursor_loop:LOOP

  SELECT SQL_CALC_FOUND_ROWS stamd_flagbit_ref.flagbit_ref_id
  INTO proz_flagbit_ref_id
  FROM
    stamd_flagbit_ref
    INNER JOIN vorgaben_zeitraum
      ON vorgaben_zeitraum.zeitraum_id = stamd_flagbit_ref.zeitraum_id
        AND NOW() BETWEEN vorgaben_zeitraum.von AND vorgaben_zeitraum.bis
  WHERE
    stamd_flagbit_ref.datensatz_typ_id = IN_datensatz_typ_id
    AND stamd_flagbit_ref.datensatz_id = IN_datensatz_id
  ORDER BY
    vorgaben_zeitraum.von DESC,
    stamd_flagbit_ref.flagbit_ref_id DESC
  LIMIT 1;

  SET proz_anzahl = FOUND_ROWS();

  IF proz_anzahl <= 1 THEN
    LEAVE cursor_loop;
  END IF;

  UPDATE stamd_flagbit_ref
  SET zeitraum_id = 17396 -- 17396 = 1900 - 19000
  WHERE flagbit_ref_id = proz_flagbit_ref_id;

END LOOP cursor_loop;

END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
