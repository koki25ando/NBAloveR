# Function to get result of games
#' 
#' @import rvest
#' @import dplyr
#' @import xml2
#' 
#' @example
#' bos08 <- seasonSchedule(Team = "bos", year = 2008)
#' head(bos08)
#' 
#' 
#' @export


seasonSchedule <- function (Team, year) {
  base_url <- "https://www.basketball-reference.com/teams/"
  url <- paste0(base_url, stringr::str_to_upper(Team), "/", year, "_games.html")
  
  tables <- read_html(url) %>% 
    html_table()
  data.frame(tables[[1]])
}
  
