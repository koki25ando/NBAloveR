# Function for getting all NBA players' information: name, heigh/weight, college, birth year, birth place
#' @importFrom dplyr %>% 

getPlayers <- function () {
  players_list_since1950 <- read.csv("https://s3-ap-southeast-2.amazonaws.com/koki25ando/Players.csv")
  dplyr::select(players_list_since1950, Player:birth_state) 
}