library(readr)
library(tidyverse)

url <- "https://raw.githubusercontent.com/OxCGRT/covid-policy-tracker/master/data/OxCGRT_latest.csv"

data <- read_csv(url)

data$Date <- as.Date(as.character(data$Date), format = "%Y%m%d")

eu_af_data <- read_csv("../1_EU_Data/african_latest_data.csv")
eu_af_data <- eu_af_data[, (names(eu_af_data) %in% c("countriesAndTerritories", "countryterritoryCode"))]
eu_af_data <- unique(eu_af_data)

## ck <- read_csv("./country_key.csv")

african_data <- subset(data, (CountryCode %in% eu_af_data$countryterritoryCode))# | countriesAndTerritories == "Namibia")

write_csv(african_data, "./african_data.csv")

