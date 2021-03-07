## code to prepare `ntl_ice` dataset goes here
# Attach packages
library(usethis)
library(metajam)

#------------------------------------------------------------------------------
ntl_temp_url <-
  "https://portal.edirepository.org/nis/dataviewer?packageid=knb-lter-ntl.20.32&entityid=3c7ddd692d3ac8e90bf2954a16b39e89"

# Download the data package with metajam
ntl_temp_download <-
  download_d1_data(data_url = ntl_temp_url, path = tempdir())

# Read in data
ntl_temp_files <- read_d1_files(ntl_temp_download)
ntl_temp_raw <- ntl_temp_files$data

ntl_temp <- ntl_temp_raw %>%
  select(year4,
         ave_air_temp_adjusted)
         #precip_raw_mm,
         #snow_raw_cm,
         #snow_depth_cm) %>%
  rename(year = year4) %>%
  group_by(year) %>%
  summarise(ave_air_temp_adjusted = mean(ave_air_temp_adjusted))

#-------------------------------------------------------------------------------
ntl_level_url <-
  "https://portal.edirepository.org/nis/dataviewer?packageid=knb-lter-ntl.362.3&entityid=62e58eb0c2d3175360958fc9e4f9f28e"

# Download the data package with metajam
ntl_level_download <-
  download_d1_data(data_url = ntl_level_url, path = tempdir())

# Read in data
ntl_level_files <- read_d1_files(ntl_level_download)
ntl_level_raw <- ntl_level_files$data
ntl_level_raw <-
  ntl_level_raw %>% filter(
    ntl_level_raw$SiteName == "Lake Monona" |
      ntl_level_raw$SiteName == "Lake Mendota" |
      ntl_level_raw$SiteName == "Lake Wingra"
  ) %>%
  select(Date, SiteName, Value) %>% mutate(Date = lubridate::year(Date)) %>%
  ##TODO: Need to keep lake name for water levels, water temp, chlorophyll
  group_by(Date) %>%
  summarise(Value = mean(Value))
#ntl_wind <- ntl_wind_raw %>%
#  select(year4,
#         ave_air_temp_adjusted,
##         precip_raw_mm,
#        snow_raw_cm,
#         snow_depth_cm) %>%
#  rename(year = year4) %>%
#  group_by(year) %>%
#  summarise(ave_air_temp_adjusted = mean(ave_air_temp_adjusted))
#---------------------------------------------------------------
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
  rename(year = year4) %>%
  mutate(
    lakeid = recode(
      lakeid,
      "ME" = "Lake Mendota",
      "MO" = "Lake Monona",
      "WI" = "Lake Wingra"
    ),
    year = as.numeric(year),
    ice_duration = as.numeric(ice_duration),
    ice_on = as.Date(ice_on),
    ice_off = as.Date(ice_off),
    lakeid = as.factor(lakeid),
    ice_duration = replace(ice_duration, which(ice_duration < 0), NA)
  ) %>% full_join(ntl_temp)

# Save the data as a data object (.Rda) with usethis::use_data() - this code should already exist in the script, just update the dataset name
# NOTE: You could do some wrangling HERE to simplify the dataset before storing the .Rda, but we’ll just use it as read in from metajam today


usethis::use_data(ntl_ice, overwrite = TRUE)
