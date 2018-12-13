# Function for getting stats leader
#' 
#' @import dplyr
#' @import rvest
#' @import xml2
#' 
#' @example 
#' PointLeader <- getStatsLeader(stats_type = "PTS", RegularSeason = TRUE)
#' 
#' @export

getStatsLeader <- function (stats_type = c("PTS", "AST", "STL", "BLK", "FG2", "FG3"), RegularSeason = TRUE) {
  base_url <- "https://www.basketball-reference.com/leaders/"
  if (!RegularSeason) {
    url <- paste0(base_url, stringr::str_to_lower(stats_type), "_season_p.html")
  } else {
    url <- paste0(base_url, stringr::str_to_lower(stats_type), "_season.html")
  }
  
  tables <- read_html(as.character(url)) %>% 
    html_table()
  data.frame(tables[[1]])
  
}
