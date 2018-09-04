# Package
library(tidyverse)

# Data Importing
## Player list
players_list_since1950 <- fread("https://s3-ap-southeast-2.amazonaws.com/koki25ando/Players.csv", data.table = FALSE)

## Stats Data
players_season_stats <- fread("https://s3-ap-southeast-2.amazonaws.com/playerinfomation/Seasons_Stats.csv", data.table = FALSE)
