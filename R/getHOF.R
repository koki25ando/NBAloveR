# Function to get list of Hall of Famers
#' 
#' @import dplyr
#' @import rvest
#' @import xml2
#' 
#' @example 
#' NBAhof <- getHOF()
#' head(NBAhof)
#' 
#' @export

getHOF <- function(){
  url <- "https://en.wikipedia.org/wiki/List_of_players_in_the_Naismith_Memorial_Basketball_Hall_of_Fame"
  tables <- read_html(url) %>% 
    html_table(fill = TRUE)
  data.frame(tables[[1]])[,1:4]
}

