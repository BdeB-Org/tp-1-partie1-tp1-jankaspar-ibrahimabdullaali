-- TP1 fichier réponse -- Modifiez le nom du fichier en suivant les instructions
-- Votre nom: Jan Kaspar                       Votre DA: 2381231
--ASSUREZ VOUS DE LA BONNE LISIBILITÉ DE VOS REQUÊTES  /5--

-- 1.   Rédigez la requête qui affiche la description pour les trois tables. Le nom des champs et leur type. /2
DESC OUTILS_EMPRUNT;
DESC OUTILS_OUTIL;
DESC OUTILS_USAGER;

-- 2.   Rédigez la requête qui affiche la liste de tous les usagers, sous le format prénom « espace » nom de famille (indice : concaténation). /2
SELECT CONCAT(PRENOM, ' ', NOM_FAMILLE) AS "Nom complet"
FROM OUTILS_USAGER;

-- 3.   Rédigez la requête qui affiche le nom des villes où habitent les usagers, en ordre alphabétique, le nom des villes va apparaître seulement une seule fois. /2
SELECT DISTINCT VILLE
FROM OUTILS_USAGER
ORDER BY ville;

-- 4.   Rédigez la requête qui affiche toutes les informations sur tous les outils en ordre alphabétique sur le nom de l’outil puis sur le code. /2
SELECT *
FROM OUTILS_OUTIL
ORDER BY NOM, code_outil;

-- 5.   Rédigez la requête qui affiche le numéro des emprunts qui n’ont pas été retournés. /2
SELECT NUM_EMPRUNT
FROM OUTILS_EMPRUNT
WHERE DATE_RETOUR IS NULL;

-- 6.   Rédigez la requête qui affiche le numéro des emprunts faits avant 2014./3
SELECT NUM_EMPRUNT
FROM OUTILS_EMPRUNT
WHERE DATE_EMPRUNT < '2014-01-01';

-- 7.   Rédigez la requête qui affiche le nom et le code des outils dont la couleur début par la lettre « j » (indice : utiliser UPPER() et LIKE) /3
SELECT NOM AS "Nom outil", code_outil
FROM OUTILS_OUTIL
WHERE UPPER(caracteristiques) LIKE '%J%';

-- 8.   Rédigez la requête qui affiche le nom et le code des outils fabriqués par Stanley. /2
SELECT NOM AS "Nom Outil", code_outil
FROM OUTILS_OUTIL
WHERE fabricant = 'Stanley';

-- 9.   Rédigez la requête qui affiche le nom et le fabricant des outils fabriqués de 2006 à 2008 (ANNEE). /2
SELECT NOM, fabricant
FROM OUTILS_OUTIL
WHERE ANNEE BETWEEN 2006 AND 2008;

-- 10.  Rédigez la requête qui affiche le code et le nom des outils qui ne sont pas de « 20 volts ». /3
SELECT code_outil, NOM
FROM OUTILS_OUTIL
WHERE caracteristiques NOT LIKE '%20 volts%';

-- 11.  Rédigez la requête qui affiche le nombre d’outils qui n’ont pas été fabriqués par Makita. /2
SELECT COUNT(*) AS "nombre d'outils"
FROM OUTILS_OUTIL
WHERE fabricant != 'Makita';

-- 12.  Rédigez la requête qui affiche les emprunts des clients de Vancouver et Regina. Il faut afficher le nom complet de l’usager, le numéro d’emprunt, la durée de l’emprunt et le prix de l’outil (indice : n’oubliez pas de traiter le NULL possible (dans les dates et le prix) et utilisez le IN). /5
SELECT CONCAT(' ', OU.PRENOM, OU.NOM_FAMILLE) AS "nom_complet", 
       OE.NUM_EMPRUNT AS "Num?ro d'emprunt", 
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
SELECT OO.NOM AS nom_outil, OO.CODE_OUTIL AS code_outil
FROM OUTILS_EMPRUNT OE
JOIN OUTILS_OUTIL OO ON OE.CODE_OUTIL = OO.CODE_OUTIL
WHERE OE.DATE_RETOUR IS NULL;

-- 14.  Rédigez la requête qui affiche le nom et le courriel des usagers qui n’ont jamais fait d’emprunts. (indice : IN avec sous-requête) /3
SELECT NOM_FAMILLE, COURRIEL
FROM OUTILS_USAGER
WHERE NUM_USAGER NOT IN (SELECT DISTINCT NUM_USAGER FROM OUTILS_EMPRUNT);

-- 15.  Rédigez la requête qui affiche le code et la valeur des outils qui n’ont pas été empruntés. (indice : utiliser une jointure externe – LEFT OUTER, aucun NULL dans les nombres) /4
SELECT OO.CODE_OUTIL AS code_outil, OO.PRIX AS valeur_outil
FROM OUTILS_OUTIL OO
LEFT OUTER JOIN OUTILS_EMPRUNT OE ON OO.CODE_OUTIL = OE.CODE_OUTIL
WHERE OE.CODE_OUTIL IS NULL
AND OO.PRIX IS NOT NULL;

-- 16.  Rédigez la requête qui affiche la liste des outils (nom et prix) qui sont de marque Makita et dont le prix est supérieur à la moyenne des prix de tous les outils. Remplacer les valeurs absentes par la moyenne de tous les autres outils. /4
SELECT 
    COALESCE(OO.NOM, 'Moyenne') AS nom_outil,
    COALESCE(OO.PRIX, AVG(OO.PRIX) OVER()) AS prix
FROM 
    OUTILS_OUTIL OO
WHERE 
    OO.FABRICANT = 'Makita'
    AND OO.PRIX > (SELECT AVG(PRIX) FROM OUTILS_OUTIL);

-- 17.  Rédigez la requête qui affiche le nom, le prénom et l’adresse des usagers et le nom et le code des outils qu’ils ont empruntés après 2014. Triés par nom de famille. /4
SELECT
    OU.NOM_FAMILLE AS nom,
    OU.PRENOM AS prenom,
    OU.ADRESSE AS adresse,
    OO.NOM AS nom_outil,
    OO.CODE_OUTIL AS code_outil
FROM 
    OUTILS_USAGER OU
JOIN 
    OUTILS_EMPRUNT OE ON OU.NUM_USAGER = OE.NUM_USAGER
JOIN 
    OUTILS_OUTIL OO ON OE.CODE_OUTIL = OO.CODE_OUTIL
WHERE 
    OE.DATE_EMPRUNT > '2014-01-01'
ORDER BY 
    OU.NOM_FAMILLE;

-- 18.  Rédigez la requête qui affiche le nom et le prix des outils qui ont été empruntés plus qu’une fois. /4
SELECT 
    OO.NOM AS nom_outil,
    OO.PRIX AS prix
FROM 
    OUTILS_OUTIL OO
JOIN 
    OUTILS_EMPRUNT OE ON OO.CODE_OUTIL = OE.CODE_OUTIL
GROUP BY 
    OO.NOM, OO.PRIX
HAVING 
    COUNT(*) > 1;

-- 19.  Rédigez la requête qui affiche le nom, l’adresse et la ville de tous les usagers qui ont fait des emprunts en utilisant : /6

--  Une jointure
SELECT 
    OU.NOM_FAMILLE AS nom, 
    OU.ADRESSE AS adresse, 
    OU.VILLE AS ville
FROM 
    OUTILS_USAGER OU
JOIN 
    OUTILS_EMPRUNT OE ON OU.NUM_USAGER = OE.NUM_USAGER
GROUP BY 
    OU.NUM_USAGER, OU.NOM_FAMILLE, OU.ADRESSE, OU.VILLE;

--  IN
SELECT 
    OU.NOM_FAMILLE AS nom, 
    OU.ADRESSE AS adresse, 
    OU.VILLE AS ville
FROM 
    OUTILS_USAGER OU
WHERE 
    OU.NUM_USAGER IN (SELECT DISTINCT NUM_USAGER FROM OUTILS_EMPRUNT);

--  EXISTS
SELECT 
    OU.NOM_FAMILLE AS nom, 
    OU.ADRESSE AS adresse, 
    OU.VILLE AS ville
FROM 
    OUTILS_USAGER OU
WHERE 
    EXISTS (SELECT 1 FROM OUTILS_EMPRUNT OE WHERE OE.NUM_USAGER = OU.NUM_USAGER);

-- 20.  Rédigez la requête qui affiche la moyenne du prix des outils par marque. /3
SELECT 
    FABRICANT AS marque,
    AVG(PRIX) AS moyenne_prix
FROM 
    OUTILS_OUTIL
GROUP BY 
    FABRICANT;

-- 21.  Rédigez la requête qui affiche la somme des prix des outils empruntés par ville, en ordre décroissant de valeur. /4
SELECT 
    OU.VILLE AS ville,
    SUM(OO.PRIX) AS somme_prix
FROM 
    OUTILS_USAGER OU
JOIN 
    OUTILS_EMPRUNT OE ON OU.NUM_USAGER = OE.NUM_USAGER
JOIN 
    OUTILS_OUTIL OO ON OE.CODE_OUTIL = OO.CODE_OUTIL
GROUP BY 
    OU.VILLE
ORDER BY 
    somme_prix DESC;

-- 22.  Rédigez la requête pour insérer un nouvel outil en donnant une valeur pour chacun des attributs. /2
INSERT INTO OUTILS_OUTIL (NOM, FABRICANT, PRIX)
VALUES ('Nom_de_l_outil', 'fabricant_de_l_outil', 'prix_de_l_outil');

-- 23.  Rédigez la requête pour insérer un nouvel outil en indiquant seulement son nom, son code et son année. /INSERT INTO OUTILS_OUTIL (NOM_OUTIL, CODE_OUTIL, ANNEE)
INSERT INTO OUTILS_OUTIL (NOM, CODE_OUTIL, ANNEE)
VALUES ('Nom_de_l_outil', 'Code_de_l_outil', 'Annee_de_l_outil');


-- 24.  Rédigez la requête pour effacer les deux outils que vous venez d’insérer dans la table. /2
DELETE FROM OUTILS_OUTIL 
WHERE NOM = 'Nom_de_l_outil' OR CODE_OUTIL = 'Code_de_l_outil';

-- 25.  Rédigez la requête pour modifier le nom de famille des usagers afin qu’ils soient tous en majuscules. /2
UPDATE OUTILS_USAGER
SET NOM_FAMILLE = UPPER(NOM_FAMILLE);



