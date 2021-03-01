## code to prepare `ntl_ice` dataset goes here
# Attach packages
library(usethis)
library(metajam)

# Save link location for the data package:
ntl_url <-
  "https://portal.edirepository.org/nis/dataviewer?packageid=knb-lter-ntl.33.35&entityid=f5bc02452cafcd461c49bd7429d8b40c"

# Download the data package with metajam
ntl_download <-
  download_d1_data(data_url = ntl_url, path = tempdir())

# Read in data
ntl_files <- read_d1_files(ntl_download)
ntl_ice_raw <- ntl_files$data

ntl_ice <- ntl_ice_raw %>%
  select(-iceon,-iceoff,-season) %>%
  mutate(lakeid = recode(
    lakeid,
    "ME" = "Lake Mendota",
    "MO" = "Lake Monona",
    "WI" = "Lake Wingra"
  )) %>%
  rename(year = year4) %>%
  mutate(year = as.numeric(year)) %>%
  mutate(ice_duration = as.numeric(ice_duration)) %>%
  mutate(ice_on = as.Date(ice_on)) %>%
  mutate(ice_off = as.Date(ice_off)) %>%
  mutate(lakeid = as.factor(lakeid)) %>%
  mutate(ice_duration = replace(ice_duration, which(ice_duration<0), NA))

# Save the data as a data object (.Rda) with usethis::use_data() - this code should already exist in the script, just update the dataset name
# NOTE: You could do some wrangling HERE to simplify the dataset before storing the .Rda, but we’ll just use it as read in from metajam today

usethis::use_data(ntl_ice, overwrite = TRUE)
