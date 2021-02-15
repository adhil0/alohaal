## code to prepare `nwt_pikas` dataset goes here
library(usethis)
library(metajam)

# Save link location for the data package:
nwt_url <- "https://portal.edirepository.org/nis/dataviewer?packageid=knb-lter-nwt.8.4&entityid=4b6b9b433b678118b17c16e5827edf1f"

# Download the data package with metajam
nwt_download <- download_d1_data(data_url = nwt_url, path = tempdir())

# Read in data
nwt_files <- read_d1_files(nwt_download)
nwt_pikas <- nwt_files$data
nwt_pikas$weight <- as.numeric(nwt_pikas$weight)
nwt_pikas$rectal_temp <- as.numeric(nwt_pikas$rectal_temp)
# Save the data as a data object (.Rda) with usethis::use_data() - this code should already exist in the script, just update the dataset name
# NOTE: You could do some wrangling HERE to simplify the dataset before storing the .Rda, but we’ll just use it as read in from metajam today
use_data(nwt_pikas, overwrite = TRUE)

usethis::use_data(nwt_pikas, overwrite = TRUE)
