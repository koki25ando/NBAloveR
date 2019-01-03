library(readr)

Players <- utils::read.csv("data-raw/Players.csv")
devtools::use_data(Players, overwrite = TRUE)
