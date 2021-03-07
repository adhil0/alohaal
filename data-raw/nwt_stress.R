## code to prepare `nwt_stress` dataset goes here
# Attach packages
library(usethis)
library(metajam)

# Save link location for the data package:
nwt_elevation_url <-
  "https://portal.edirepository.org/nis/dataviewer?packageid=knb-lter-nwt.268.1&entityid=6a10b35988119d0462837f9bfa31dd2f"

# Download the data package with metajam
nwt_elevation_download <-
  download_d1_data(data_url = nwt_elevation_url, path = tempdir())

# Read in data
nwt_elevation_files <- read_d1_files(nwt_elevation_download)
nwt_elevation_raw <- nwt_elevation_files$data
nwt_elevation <-
  nwt_elevation_raw %>% select(Elev_M, Station) %>%
  mutate(Station = as.factor(Station))
#---------------------------------------------------------------------------
# Save link location for the data package:
nwt_stress_url <-
  "https://portal.edirepository.org/nis/dataviewer?packageid=knb-lter-nwt.268.1&entityid=43270add3532c7f3716404576cfb3f2c"

# Download the data package with metajam
nwt_stress_download <-
  download_d1_data(data_url = nwt_stress_url, path = tempdir())

# Read in data
nwt_stress_files <- read_d1_files(nwt_stress_download)
nwt_stress_raw <- nwt_stress_files$data
nwt_stress <-
  nwt_stress_raw %>% select(-Notes, -Vial, -Plate, -Biweek) %>%
  mutate(
    Station = as.factor(Station),
    Site = as.factor(Site),
    Sex = as.factor(Sex),
    Date = as.Date(Date)
  ) %>% full_join(nwt_elevation)

# Save the data as a data object (.Rda) with usethis::use_data() - this code should already exist in the script, just update the dataset name

usethis::use_data(nwt_stress, overwrite = TRUE)
