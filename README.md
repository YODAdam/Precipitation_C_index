# Analyse de l'Indice de Concentration des Précipitations (PCI)

Ce projet R permet de calculer l'indice de concentration des précipitations (PCI - Precipitation Concentration Index) à partir de données journalières de précipitations pour plusieurs stations météorologiques. Il utilise les bibliothèques `precintcon`, `tidyverse`, et `writexl`.

## 🔍 Objectif

L'indice PCI est un indicateur statistique permettant d'évaluer la distribution des précipitations sur une période donnée (par exemple un mois ou une année). Il est utile pour :
- Identifier des régimes pluviométriques irréguliers,
- Évaluer les risques d'érosion ou de sécheresse,
- Appuyer des analyses climatiques régionales.

---

## 📁 Structure des données

Le fichier d'entrée est un fichier Excel (`Daily_rainfall.xls`) contenant les données journalières de précipitations, organisées comme suit :

| year | month | day | Bobo-Dioulasso | Ouagadougou | ... |
|------|-------|-----|----------------|-------------|-----|
| 2022 |   6   |  1  |       5.2      |     0.0     | ... |
| 2022 |   6   |  2  |       0.0      |     3.1     | ... |
| ...  |  ...  | ... |      ...       |     ...     | ... |

Chaque station a sa propre colonne avec les valeurs de pluie journalière.

---

## ⚙️ Dépendances

Avant d’exécuter le script, assurez-vous d’avoir installé les packages suivants :

```r
install.packages("precintcon")
install.packages("writexl")
install.packages("readxl")
install.packages("tidyverse")

