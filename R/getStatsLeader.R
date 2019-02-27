#' Stats Leaders
#' 
#' Function for getting stats leader
#' 
#' @param stats_type Stats type to fetch information for
#' @param RegularSeason Regular season or not. Valid values are TRUE or FALSE
#' 
#' @author Koki Ando
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
#'  pts_leader = getStatsLeader(stats_type = "PTS", RegularSeason = TRUE)
#'  head(pts_leader)
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
  table <- data.frame(tables[[1]])
  table$Player <- stringr::str_remove(table$Player, "\\*")
  table[, 2:4]
}
