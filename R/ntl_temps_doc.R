#' Madison Wisconsin Daily Meteorological Data 1869 - current
#'
#' Data includes date of collection, year of collection, and average air temperature in Madison, WI. Daily meteorological data was collected from various sites around Madison, WI since 1869. The final temperature data included is averaged for each year. Note: according to the metadata, temperature data collected prior to 1884 contains biases.
#'
#' @format A tibble with 55151 rows and 3 variables
#' \describe{
#'   \item{sampledate}{a Date denoting the day of collection}
#'   \item{year}{a number denoting the year of observation}
#'   \item{ave_air_temp_adjusted}{a number denoting the air temperature in degrees Celsius, collected in Madison, WI and adjusted for biases}
#'   }

#' @source {Anderson, L. and D. Robertson. 2020. Madison Wisconsin Daily Meteorological Data 1869 - current ver 32. Environmental Data Initiative.}
#' \url{https://doi.org/10.6073/pasta/e3ff85971d817e9898bb8a83fb4c3a8b}
"ntl_temps"
