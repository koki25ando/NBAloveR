#' Stats leaders of a given season
#' 
#' Function for getting data of stats leaders of each season
#' 
#' @param stats_type Stats type you want to fetch information for
#' @param range Duration of data. Valid values are Career, Active or Single Season.
#' 
#' @author Koki Ando
#' 
<<<<<<< HEAD
#' @importFrom magrittr %>%
#' 
=======
>>>>>>> a326d2ccc47dec97d5501539f2a2846eed11a994
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
