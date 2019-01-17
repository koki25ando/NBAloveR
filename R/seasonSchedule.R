#' Results of each game for a given team in give season
#' 
#' Function to get result of games
#' 
#' @param Team
#' @param year
#' 
#' @author Koki Ando
#' 
#' @import rvest
#' @import dplyr
#' @import xml2
#' @import stringr
#' 
#' @seealso \url{https://www.basketball-reference.com/teams/}
#' 
#' @return This function returns \code{data.frame} including columns:
#' \itemize{
#'  \item G
#'  \item Date
#'  \item Start..ET.
#'  \item Var.6
#'  \item Opponent
#'  \item Var.8
#'  \item Var.9
#'  \item Tm
#'  \item Opp
#'  \item W
#'  \item L
#'  \item Streak
#' }
#' 
#' @examples
#' \dontrun{
#'  bos08 <- seasonSchedule(Team = "bos", year = 2008)
#'  head(bos08)
#' }
#' 
#' @export


seasonSchedule <- function (Team, year) {
  base_url <- "https://www.basketball-reference.com/teams/"
  url <- paste0(base_url, stringr::str_to_upper(Team), "/", year, "_games.html")
  
  tables <- xml::read_html(url) %>% 
    rvest::html_table()
  data.frame(tables[[1]]) %>% 
    dplyr::filter(Date != "Date")
}
  
