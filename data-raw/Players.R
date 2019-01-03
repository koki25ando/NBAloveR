library(readr)

Player <- read_csv("data-raw/Players.csv")
devtools::use_data(Players, overwrite = TRUE)