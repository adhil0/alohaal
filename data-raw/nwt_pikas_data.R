## code to prepare `nwt_pikas` dataset goes here
library(usethis)
library(metajam)

# Save link location for the data package:
nwt_url <-
  "https://portal.edirepository.org/nis/dataviewer?packageid=knb-lter-nwt.8.4&entityid=4b6b9b433b678118b17c16e5827edf1f"

# Download the data package with metajam
nwt_download <-
  download_d1_data(data_url = nwt_url, path = tempdir())

# Read in data
nwt_files <- read_d1_files(nwt_download)
nwt_pikas_raw <- nwt_files$data
nwt_pikas <- nwt_pikas_raw %>%
  #clean_names() %>%
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
  )

# Save the data as a data object (.Rda) with usethis::use_data() - this code should already exist in the script, just update the dataset name
# NOTE: You could do some wrangling HERE to simplify the dataset before storing the .Rda, but we’ll just use it as read in from metajam today

usethis::use_data(nwt_pikas, overwrite = TRUE)
