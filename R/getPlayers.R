# Function for getting all NBA players' information
# name, heigh/weight, college, birth year, birth place

# Package
library(tidyverse)

# Function
getPlayers <- function () {
  players_list_since1950 <- fread("https://s3-ap-southeast-2.amazonaws.com/koki25ando/Players.csv", data.table = FALSE)
  players_list_since1950 %>% 
    select(Player:birth_state) 
}

## Example
# player <- getPlayers()
# player %>% 
#   as.tibble()
