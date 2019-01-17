#' Stats Leaders
#' 
#' Function for getting stats leader
#' 
#' @param stats_type
#' @param RegularSeason
#' 
#' @author Koki Ando
#' 
#' @import dplyr
#' @import rvest
#' @import xml2
#' @import stringr
#' @import magrittr
#' 
#' @seealso \url{https://www.basketball-reference.com/leaders/}
#' 
#' @return This function returns \code{data.frame} including columns:
#' \itemize{
#'  \item Rank
#'  \item Player
#'  \item PTS
#'  \item Season
#' }
#' 
#' @examples
#' \dontrun{
#'  getStatsLeader(stats_type = "PTS", RegularSeason = TRUE)
#' }
#' 
#' @export

getStatsLeader <- function (stats_type = c("PTS", "AST", "STL", "BLK", "FG2", "FG3"), RegularSeason = TRUE) {
  base_url <- "https://www.basketball-reference.com/leaders/"
  if (!RegularSeason) {
    url <- paste0(base_url, stringr::str_to_lower(stats_type), "_season_p.html")
  } else {
    url <- paste0(base_url, stringr::str_to_lower(stats_type), "_season.html")
  }
  
  tables <- xml2::read_html(as.character(url)) %>% 
    rvest::html_table()
  data.frame(tables[[1]])
  
}
