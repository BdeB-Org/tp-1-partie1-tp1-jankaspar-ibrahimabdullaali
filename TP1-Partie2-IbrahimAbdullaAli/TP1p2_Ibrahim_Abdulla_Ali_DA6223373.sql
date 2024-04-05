-- TP1 fichier réponse -- Modifiez le nom du fichier en suivant les instructions
-- Votre nom:  Ibrahim Abdulla Ali                      Votre DA: 6223373
--ASSUREZ VOUS DE LA BONNE LISIBILITÉ DE VOS REQUÊTES  /5--

-- 1.   Rédigez la requête qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
DESC OUTILS_USAGER;
DESC OUTILS_OUTILS;
DESC OUTILS_EMPRUNT;

-- 2.   Rédigez la requête qui affiche la liste de tous les usagers, sous le format prénom « espace » nom de famille (indice : concaténation). /2
SELECT CONCAT(PRENOM, ' ', NOM_FAMILLE) AS NOM_COMPLET 
FROM OUTILS_USAGER;

-- 3.   Rédigez la requête qui affiche le nom des villes où habitent les usagers, en ordre alphabétique, le nom des villes va apparaître seulement une seule fois. /2
SELECT DISTINCT VILLE AS "Nom des villes"
FROM OUTILS_USAGER
ORDER BY VILLE ASC;

-- 4.   Rédigez la requête qui affiche toutes les informations sur tous les outils en ordre alphabétique sur le nom de l’outil puis sur le code. /2
SELECT *
FROM OUTILS_OUTIL
ORDER BY NOM ASC, CODE_OUTIL ASC;

-- 5.   Rédigez la requête qui affiche le numéro des emprunts qui n’ont pas été retournés. /2
SELECT NUM_EMPRUNT
FROM OUTILS_EMPRUNT
WHERE DATE_RETOUR IS NULL;

-- 6.   Rédigez la requête qui affiche le numéro des emprunts faits avant 2014./3
SELECT NUM_EMPRUNT AS "Numéro des emprunts"
FROM OUTILS_EMPRUNT
WHERE DATE_EMPRUNT < '2014-01-01';

-- 7.   Rédigez la requête qui affiche le nom et le code des outils dont la couleur début par la lettre « j » (indice : utiliser UPPER() et LIKE) /3
SELECT NOM        AS "Nom des outils",
       CODE_OUTIL AS "Code des outils"
FROM OUTILS_OUTIL
WHERE UPPER(CARACTERISTIQUES) LIKE '%J%';

-- 8.   Rédigez la requête qui affiche le nom et le code des outils fabriqués par Stanley. /2
SELECT NOM        AS "Nom des outils",
       CODE_OUTIL AS "Code des outils"
FROM OUTILS_OUTIL
WHERE FABRICANT = 'Stanley';

-- 9.   Rédigez la requête qui affiche le nom et le fabricant des outils fabriqués de 2006 à 2008 (ANNEE). /2
SELECT NOM       AS "nom des outils fabriqués",
       FABRICANT AS "le fabricant des outils fabriqués"
FROM OUTILS_OUTIL
WHERE ANNEE BETWEEN 2006 AND 2008;

-- 10.  Rédigez la requête qui affiche le code et le nom des outils qui ne sont pas de « 20 volts ». /3
SELECT CODE_OUTIL AS "Code des outils",
       NOM AS "Nom des outils"
FROM OUTILS_OUTIL
WHERE CARACTERISTIQUES != '20 volts';

-- 11.  Rédigez la requête qui affiche le nombre d’outils qui n’ont pas été fabriqués par Makita. /2
SELECT COUNT(*) AS "Nombre d'outils"
FROM OUTILS_OUTIL
WHERE FABRICANT != 'Makita';

-- 12.  Rédigez la requête qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l’usager, le numéro d’emprunt, la durée de l’emprunt et le prix de l’outil (indice : n’oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5
SELECT CONCAT(' ', OU.PRENOM, OU.NOM_FAMILLE) AS "nom_complet", 
       OE.NUM_EMPRUNT AS "Numéro d'emprunt", 
       OE.DATE_RETOUR - OE.DATE_EMPRUNT AS "duree_emprunt", 
       OO.PRIX AS "Prix"
FROM OUTILS_EMPRUNT OE
JOIN OUTILS_USAGER OU 
ON OE.NUM_USAGER = OU.NUM_USAGER
JOIN OUTILS_OUTIL OO 
ON OE.CODE_OUTIL = OO.CODE_OUTIL
WHERE OU.VILLE IN ('Vancouver', 'Regina')
AND OO.PRIX IS NOT NULL
AND OE.DATE_RETOUR IS NOT NULL;

-- 13.  Rédigez la requête qui affiche le nom et le code des outils empruntés qui n’ont pas encore été retournés. /4
SELECT OO.NOM AS "nom des outils",
       OE.CODE_OUTIL AS "code des outils"
FROM OUTILS_EMPRUNT OE
JOIN OUTILS_OUTIL OO ON OE.CODE_OUTIL = OO.CODE_OUTIL
WHERE OE.DATE_RETOUR IS NULL;

-- 14.  Rédigez la requête qui affiche le nom et le courriel des usagers qui n’ont jamais fait d’emprunts. (indice : IN avec sous-requête) /3
SELECT NOM_FAMILLE AS "Nom des usagers" , 
       COURRIEL    AS "Courriel des usagers"
FROM OUTILS_USAGER
WHERE NUM_USAGER NOT IN (SELECT NUM_USAGER FROM OUTILS_EMPRUNT);

-- 15.  Rédigez la requête qui affiche le code et la valeur des outils qui n’ont pas été empruntés. (indice : utiliser une jointure externe – LEFT OUTER, aucun NULL dans les nombres) /4
SELECT OO.CODE_OUTIL AS "code des outils",
       OO.PRIX       AS "Valeur des outils"
FROM OUTILS_OUTIL OO
LEFT OUTER JOIN OUTILS_EMPRUNT OE ON OO.CODE_OUTIL = OE.CODE_OUTIL
WHERE OE.CODE_OUTIL IS NULL;

-- 16.  Rédigez la requête qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est supérieur à la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4

-- 17.  Rédigez la requête qui affiche le nom, le prénom et l’adresse des usagers et le nom et le code des outils qu’ils ont empruntés après 2014. Triés par nom de famille. /4
SELECT U.NOM_FAMILLE AS "Nom des usagers",
       U.PRENOM      AS "Prenom des usagers",
       U.ADRESSE     AS "Adresse des usagers",
       O.NOM         AS "Nom des outils",
       O.CODE_OUTIL  AS "Code des outils"
FROM OUTILS_USAGER U
JOIN OUTILS_EMPRUNT E ON U.NUM_USAGER = E.NUM_USAGER
JOIN OUTILS_OUTIL O ON E.CODE_OUTIL = O.CODE_OUTIL
WHERE E.DATE_EMPRUNT > TO_DATE('2014-01-01', 'YYYY-MM-DD')
ORDER BY U.NOM_FAMILLE;

-- 18.  Rédigez la requête qui affiche le nom et le prix des outils qui ont été empruntés plus qu’une fois. /4
SELECT OO.NOM  AS "Nom des outils",
       OO.PRIX AS "Prix des outils"
FROM OUTILS_OUTIL OO
JOIN OUTILS_EMPRUNT OE
ON OO.CODE_OUTIL = OE.CODE_OUTIL
GROUP BY OO.NOM, OO.PRIX
HAVING COUNT(OE.CODE_OUTIL) > 1;

-- 19.  Rédigez la requête qui affiche le nom, l’adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6

--  Une jointure
SELECT U.PRENOM   AS "Nom",
       U.ADRESSE, 
       U.VILLE
FROM OUTILS_USAGER U
JOIN OUTILS_EMPRUNT E
ON U.NUM_USAGER = E.NUM_USAGER;

--  IN
SELECT NOM_FAMILLE, ADRESSE, VILLE
FROM OUTILS_USAGER
WHERE NUM_USAGER 
IN (SELECT NUM_USAGER FROM OUTILS_EMPRUNT);

--  EXISTS
SELECT NOM_FAMILLE, ADRESSE, VILLE
FROM OUTILS_USAGER U
WHERE EXISTS (SELECT 1 FROM OUTILS_EMPRUNT E WHERE E.NUM_USAGER = U.NUM_USAGER);

-- 20.  Rédigez la requête qui affiche la moyenne du prix des outils par marque. /3
SELECT FABRICANT,
       AVG(PRIX) AS "MOYENNE_PRIX"
FROM OUTILS_OUTIL
GROUP BY FABRICANT;

-- 21.  Rédigez la requête qui affiche la somme des prix des outils empruntés par ville, en ordre décroissant de valeur. /4
SELECT U.VILLE,
       SUM(O.PRIX) AS "SOMME_PRIX"
FROM OUTILS_USAGER U
JOIN OUTILS_EMPRUNT E ON U.NUM_USAGER = E.NUM_USAGER
JOIN OUTILS_OUTIL O ON E.CODE_OUTIL = O.CODE_OUTIL
GROUP BY U.VILLE
ORDER BY SOMME_PRIX DESC;

-- 22.  Rédigez la requête pour insérer un nouvel outil en donnant une valeur pour chacun des attributs. /2

-- 23.  Rédigez la requête pour insérer un nouvel outil en indiquant seulement son nom, son code et son année. /2

-- 24.  Rédigez la requête pour effacer les deux outils que vous venez d’insérer dans la table. /2

-- 25.  Rédigez la requête pour modifier le nom de famille des usagers afin qu’ils soient tous en majuscules. /2
UPDATE OUTILS_USAGER
SET NOM_FAMILLE = UPPER(NOM_FAMILLE);

