# Function for getting all NBA players' information: name, heigh/weight, college, birth year, birth place
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
  Players <- utils::read.csv("data-raw/Players.csv")
  Players
  # players_list_since1950 <- read.csv("https://s3-ap-southeast-2.amazonaws.com/koki25ando/Players.csv")
  # dplyr::select(players_list_since1950, Player:birth_state)
}
