## code to prepare `lef_anole` dataset goes here
# Attach packages
library(usethis)
library(metajam)

# Save link location for the data package:
lef_url <- "https://portal.edirepository.org/nis/dataviewer?packageid=knb-lter-luq.5.347700&entityid=4aacbd7e95d37636d362ee2752382c74"

# Download the data package with metajam
lef_download <- download_d1_data(data_url = lef_url, path = tempdir())

# Read in data
lef_files <- read_d1_files(lef_download)
lef_anole <- lef_files$data

# Save the data as a data object (.Rda) with usethis::use_data() - this code should already exist in the script, just update the dataset name
# NOTE: You could do some wrangling HERE to simplify the dataset before storing the .Rda, but we’ll just use it as read in from metajam today
lef_anole[6] <- apply(lef_anole[6],2,tolower)

usethis::use_data(lef_anole, overwrite = TRUE)
