#' Results of each game for a given team in give season
#' 
#' Function to get result of games
#' 
#' @param Team Team code consisting 3 characters of a team to fetch information for
#' @param year Year number
#' 
#' @author Koki Ando
#' 
#' @import rvest
#' @import dplyr
#' @import stringr
#' @import xml2
#' 
#' @seealso \url{https://www.basketball-reference.com/teams/}
#' 
#' @return This function returns \code{data.frame} including columns:
#' \itemize{
#'  \item G
#'  \item Date
#'  \item StartTime
#'  \item Opponent
#'  \item Result
#'  \item OT
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
  
  tables <- xml2::read_html(url) %>% 
    rvest::html_table()
  df <- data.frame(tables[[1]]) %>% 
    dplyr::filter(Date != "Date")
  names(df)  <- c("G", "Date", "StartTime", "Var.4", "Var.5", "Var.6", "Opponent", "Result", "OT", "Tm", "Opp", "W", "L", "Streak", "Notes")
  df %>% 
    select(G, Date, StartTime, Opponent, Result, OT, Tm, Opp, W, L, Streak) 
}
