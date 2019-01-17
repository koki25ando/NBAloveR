#' Franchise history data for a given team
#' 
#' Function that allows you to get team history data
#' 
#' @param team_code Team code consisting of 3 characters to fetch information for
#' 
#' @author Koki Ando
#' 
#' @import rvest
#' @import stringr
#' 
#' @seealso \url{https://www.basketball-reference.com/teams/BOS/}
#' 
#' @return This function returns \code{data.frame} including columns:
#' \itemize{
#'  \item Season
#'  \item Lg
#'  \item Team
#'  \item W
#'  \item L
#'  \item W/L%
#'  \item Finish
#'  \item SRS
#'  \item Pace
#'  \item Rel Page
#'  \item ORtg
#'  \item Rel ORtg
#'  \item DRtg
#'  \item Rel DRtg
#'  \item Playoffs
#'  \item Coaches
#'  \item Top WS
#' }
#' 
#' 
#' @examples
#' \dontrun{
#'   BostonCeltics <- getTeamHistory(team_code = "BOS")
#'   head(BostonCeltics)
#' }
#' 
#' @export

getTeamHistory <- function (team_code) {
  url <- paste0("https://www.basketball-reference.com/teams/", stringr::str_to_upper(team_code), "/")
  tables <- xml2::read_html(url)
  tables <- rvest::html_table(tables)
  df <- as.data.frame(tables[[1]])
  df[,-c(9,16)]
}

