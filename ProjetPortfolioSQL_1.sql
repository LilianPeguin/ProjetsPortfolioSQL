SELECT * FROM villes_france_free

SELECT * FROM departement

--Obtenir la liste des 10 villes les plus peuplées en 2012

SELECT ville_nom,ville_population_2012 FROM villes_france_free
ORDER BY ville_population_2012 DESC
LIMIT 10

--Obtenir la liste des 50 villes ayant la plus faible superficie

SELECT ville_nom, ville_surface FROM villes_france_free
ORDER BY ville_surface ASC
LIMIT 50

--Obtenir la liste des départements d’outres-mer, c’est-à-dire ceux dont le numéro de département commencent par “97”

SELECT departement_nom, departement_code FROM departement
WHERE departement_code LIKE '%97%'

--Obtenir le nom des 10 villes les plus peuplées en 2012, ainsi que le nom du département associé

SELECT ville_nom, ville_population_2012, ville_departement,departement_nom FROM villes_france_free,departement
ORDER BY `ville_population_2012` DESC 
LIMIT 10

--Obtenir la liste du nom de chaque département, associé à son code et du nombre de commune au sein de ces département, 
--en triant afin d’obtenir en priorité les départements qui possèdent le plus de communes

SELECT departement_nom, ville_departement, COUNT(*) AS nombre_ville_par_departement 
FROM `villes_france_free` 
LEFT JOIN departement ON departement_code = ville_departement
GROUP BY ville_departement
ORDER BY `nombre_ville_par_departement` DESC

--Obtenir la liste des 10 plus grands départements, en terme de superficie

SELECT departement_nom, SUM(ville_surface) AS surface_departement
FROM `villes_france_free` 
LEFT JOIN departement ON departement_code = ville_departement
GROUP BY ville_departement
ORDER BY `surface_departement` DESC

--Compter le nombre de villes dont le nom commence par “Saint”
SELECT COUNT(ville_nom) FROM `villes_france_free`
WHERE ville_nom LIKE 'Saint%'

--Obtenir la liste des villes qui ont un nom existants plusieurs fois, et trier afin d’obtenir en premier 
celles dont le nom est le plus souvent utilisé par plusieurs communes

SELECT ville_nom, COUNT(*) AS nombre_ville_nom_similaire
FROM `villes_france_free` 
GROUP BY `ville_nom` 
ORDER BY nombre_ville_nom_similaire DESC

--Obtenir en une seule requête SQL la liste des villes dont la superficie est supérieur à la superficie moyenne

SELECT ville_nom
FROM `villes_france_free` 
WHERE `ville_surface` > (SELECT AVG(`ville_surface`) FROM `villes_france_free`)

--Obtenir la liste des départements qui possèdent plus de 2 millions d’habitants

SELECT ville_departement, SUM(ville_population_2012) AS departement_population FROM `villes_france_free`
GROUP BY `ville_departement`
HAVING departement_population > 2000000
ORDER BY departement_population DESC

--Remplacez les tirets par un espace vide, pour toutes les villes commençant par “SAINT-” 

UPDATE `villes_france_free` 
SET ville_nom = REPLACE(ville_nom, '-', ' ') 
WHERE `ville_nom` LIKE 'SAINT-%'
