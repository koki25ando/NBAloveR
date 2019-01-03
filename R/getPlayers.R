# Function for getting all NBA players' information: name, heigh/weight, college, birth year, birth place
#'
#' @import data.table
#' 
#' @example
#' # Data import
#' players <- getPlayers()
#'
#' # Brief overview
#' head(players)
#'
#' # An example of visualization using ggplot2
#' players %>%
#'   ggplot(aes(height,weight)) +
#'   geom_point()
#'
#' @export

getPlayers <- function () {
  players_list_since1950 <- data.table::fread("https://s3-ap-southeast-2.amazonaws.com/koki25ando/NBAloveR/Players.csv")
}
