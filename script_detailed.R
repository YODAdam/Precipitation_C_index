# Chargement des bibliothèques nécessaires
library(precintcon)  # Pour le calcul des indices de concentration pluviométrique, comme le PCI
library(writexl)     # Pour l'écriture de fichiers Excel

# Chargement d'autres bibliothèques utiles pour le traitement de données
library(readxl)      # Pour lire les fichiers Excel
library(tidyverse)   # Pour la manipulation de données (dplyr, tidyr, etc.)

# Lecture du fichier Excel contenant les précipitations journalières
data <- read_excel(path = "Daily_rainfall.xls")

# Transformation du jeu de données
final_data <- data %>% 
  # Conversion des colonnes de stations (de "Bobo-Dioulasso" à la dernière colonne) en format long
  pivot_longer(cols = `Bobo-Dioulasso`:last_col(), names_to = 'stations', values_to = 'rain') %>%
  
  # Conversion en format large avec une ligne par combinaison (station, année, mois)
  # Chaque jour du mois devient une colonne
  pivot_wider(id_cols = c(stations, year, month), names_from = day, values_from = rain, names_sort = TRUE) %>%
  
  # Tri des données par station, année et mois
  arrange(stations, year, month)

# Récupération de la liste de toutes les stations météorologiques uniques
stations_all <- final_data %>% pull(stations) %>% unique()

# Initialisation d'une liste vide pour stocker les résultats PCI par station
concentration_list <- list()

# Initialisation d'un compteur
i = 0

# Boucle sur chaque station pour calculer le PCI
for (station in stations_all) {
  
  i = i + 1  # Incrémentation du compteur
  
  # Sous-ensemble des données pour une station donnée
  dt_subset <- final_data %>% 
    filter(stations == station) %>%  # Filtrage par station
    select(-stations) %>%            # Suppression de la colonne "stations"
    precintcon::as.daily()           # Conversion en format quotidien compatible avec precintcon
  
  # Calcul du PCI pour la station sélectionnée
  pci_index <- pci(dt_subset)
  pci_index <- as_tibble(pci_index)  # Conversion du résultat en tibble (tableau moderne)
  
  # Ajout du nom de la station dans les résultats
  pci_index$stations = station
  
  # Stockage du résultat dans la liste
  concentration_list[[i]] = pci_index
}

# Fusion de tous les résultats PCI dans un seul tableau
result_data_set <- concentration_list %>% list_rbind() %>% 
  select(stations, everything())  # Réorganisation des colonnes pour avoir "stations" en premier

# Export du tableau final des indices PCI dans un fichier Excel
result_data_set %>% 
  write_xlsx(path = "Results_pci.xlsx")
