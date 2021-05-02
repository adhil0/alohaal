#' ---
#' title: "Data Preparation"
#' ---

#' ### Download the raw data from EDI.org

#+ download_data, eval=FALSE
library(usethis)
library(metajam)
library(tidyverse)
library(janitor)

# Pika demography data for west knoll and Indian Peaks wilderness, 2008 - ongoing
# Main URL: https://doi.org/10.6073/pasta/0a786c99fe3d4e1dfb8c57424ce79091
nwt_url <-
  "https://portal.edirepository.org/nis/dataviewer?packageid=knb-lter-nwt.8.4&entityid=4b6b9b433b678118b17c16e5827edf1f"

# Download the data package with metajam
nwt_download <-
  download_d1_data(data_url = nwt_url, path = tempdir())

#' ### Data cleaning
#+ data sampling, eval=FALSE
# Read in data
nwt_files <- read_d1_files(nwt_download)
nwt_pikas_raw <- nwt_files$data
nwt_pikas <- nwt_pikas_raw %>%
  select(
    local_site,
    date,
    easting,
    northing,
    weight,
    stage,
    sex,
    fleas_obs,
    rectal_temp,
    foot_length
  ) %>%
  mutate(
    weight = as.numeric(weight),
    fleas_obs = as.numeric(fleas_obs),
    rectal_temp = as.numeric(rectal_temp),
    foot_length = as.numeric(foot_length),
    local_site = recode(
      local_site,
      "WK" = "West Knoll",
      "LL" = "Long Lake",
      "ML" = "Mitchell Lake",
      "CG" = "Cable Gate"
    )
    ,
    local_site = as.factor(local_site),
    sex = as.factor(sex),
    stage = as.factor(stage),
    sex = recode(sex, "M" = "male", "F" = "female"),
    stage = recode(
      stage,
      "NS" = NA_character_,
      "A?" = NA_character_,
      "J?" = NA_character_,
      "A" = "adult",
      "J" = "juvenile"
    )
    ,
    sex = recode(
      sex,
      "NS" = NA_character_,
      "F?" = NA_character_,
      "M?" = NA_character_
    )
  ) %>%
  clean_names()

#+ save data, include=FALSE, eval = FALSE
## Save sample file
use_data(nwt_pikas, overwrite = TRUE)
