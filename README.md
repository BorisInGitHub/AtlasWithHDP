# AtlasWithHDP


## Pré-requis


HortonWorks Sandbox from http://hortonworks.com/hdp/downloads/




## Scénario


- On part d'un fichier CSV représentant un ensemble de personnes.
- On charge ce fichier dans Hadoop
- On créer une table "Externe" dans Hive pour mapper ce fichier
- On créer une table interne (CTAS) dans Hive qui correspond à la première table
- On fait des requêtes des Hive

Cela permet de voir :
- La provenance des données
- Les audits de Hive

On va rajouter des tags personnalisés sur les colonnes et cela permettra de voir la recherche via les tags.


Le scénario est volontairement très simple pour ne pas compliqué inutilement la démonstration.
