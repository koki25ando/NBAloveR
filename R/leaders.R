#' Stats leaders of a given season
#' 
#' Function for getting data of stats leaders of each season
#' 
#' @param stats_type Stats type you want to fetch information for
#' @param range Duration of data. Valid values are Career, Active or Single Season.
#' 
#' @author Koki Ando <koki.25.ando@gmail.com>
#' 
#' @importFrom magrittr %>%
#' 
#' @return This function returns \code{data.frame} including columns:
#' \itemize{
#'  \item Rank
#'  \item Player
#'  \item X3P
#'  \item Season
#' }
#' 
#' @seealso \url{https://www.basketball-reference.com/leaders/}
#' 
#' @examples
#' \dontrun{
#'  leaders_3pm <- getLeaders(stats_type="3PM", range="Single Season")
#'  head(leaders_3pm)
#' }
#' 
#' @export


getLeaders <- function(stats_type = c("3PM", "2PM", "3PA", "2PA", "PTS", "AST", "BLK", "STL", "FG", 
                                      "FGA", "FLS", "MP", "TOV", "G", "PF"), 
                       range = c("Single Season", "Career", "Active")){
  head_url = "https://www.basketball-reference.com/leaders/"
  tail_url = ".html"
  
  if (stats_type == "3PM") {
    type_key = "fg3"
  } else {
    type_key = stringr::str_to_lower(stats_type)
  }
  
  if (range == "Career") {
    range_key = "career"
  } else if (range == "Single Season") {
    range_key = "season"
  } else {
    range_key = "active"
  }
  
  url = paste0(head_url, type_key, "_", range_key, tail_url)
  tables <- xml2::read_html(url) %>% 
    rvest::html_table()
  table <- data.frame(tables[[1]])
  table$Player <- stringr::str_remove(table$Player, "\\*")
  table[, 2:4]
}

#' Stats Leaders
#' 
#' Function for getting stats leader
#' 
#' @param stats_type Stats type to fetch information for
#' @param RegularSeason Regular season or not. Valid values are TRUE or FALSE
#' 
#' @author Koki Ando <koki.25.ando@gmail.com>
#' 
#' @importFrom magrittr %>%
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

