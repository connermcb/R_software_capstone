## Mastering Software Development in R
## Capstone Project

## Load libraries
library(dplyr)
library(lubridate)
library(readr)
library(stringr)
library(tidyr)

## Read in data
quakes <- read_delim("signif_earthquakes.txt", delim = "\t")

## Clean and format data
# MONTH NA's to 1 (January), DAY NA's to 1 (first day of month)
quakes <- quakes%>%
  mutate(MONTH=replace(MONTH, is.na(MONTH), 1),
         DAY=replace(DAY, is.na(DAY), 1)
         )

# combine timestamp data into single Date class variable
quakes$dates_w_shift <- with(quakes, as.Date(paste(YEAR+2152, MONTH, DAY, sep="-"),
                                         format="%Y-%m-%d")
                         )

# clean location name variable
quakes$LOCATION_NAME <- gsub("^.*:  ", "", quakes$LOCATION_NAME)

# converst LONGITUDE, LATITUDE to numeric
quakes$LONGITUDE <- as.numeric(quakes$LONGITUDE)
quakes$LATITUDE <- as.numeric(quakes$LATITUDE)

# write data to file
p <- file_path_as_absolute(".")
write_csv(quakes, paste0(p, "/clean_quakes.csv"))


