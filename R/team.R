#' Salary data for a given team
#' 
#' Function that allows you to get salary data of each team
#'
#' @param team_code Team code consisting of 3 characters to fetch information for
#' 
#' @author Koki Ando <koki.25.ando@gmail.com>
#' 
#' @seealso \url{https://www.basketball-reference.com/contracts/GSW.html}
#' 
#' @return This function returns \code{data.frame} including columns:
#' \itemize{
#'  \item Player
#'  \item Season
#'  \item Signed Using
#'  \item Guaranteed
#' }
#' 
#' @examples
#' \dontrun{
#'  salary_gsw <- getTeamSalary(team_code = "phi")
#'  head(salary_gsw)
#' }
#'
#' @export

getTeamSalary <- function (team_code) {
  url <- paste0("https://www.basketball-reference.com/contracts/", stringr::str_to_upper(team_code), ".html")
  tables <- xml2::read_html(url)
  tables <- rvest::html_table(tables)
  df <- as.data.frame(tables[[1]])
  colnames(df) <- df[1,]
  df[-1,]
}


#' Franchise history data for a given team
#' 
#' Function that allows you to get team history data
#' 
#' @param team_code Team code consisting of 3 characters to fetch information for
#' 
#' @author Koki Ando <koki.25.ando@gmail.com>
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
#'  \item RelativePage
#'  \item ORtg
#'  \item RelativeORtg
#'  \item DRtg
#'  \item RelativeDRtg
#'  \item Playoffs
#'  \item Coaches
#'  \item TopWinShare
#' }
#' 
#' @examples
#' \dontrun{
#'   BostonCeltics <- getTeamHistory(team_code = "bos")
#'   head(BostonCeltics)
#' }
#' 
#' @export

getTeamHistory <- function (team_code) {
  url <- paste0("https://www.basketball-reference.com/teams/", stringr::str_to_upper(team_code), "/")
  page <- xml2::read_html(url)
  tables <- rvest::html_table(page)
  df <- as.data.frame(tables[[1]])[,-c(9,16)]
  df$Team = stringr::str_remove(df$Team, "\\*")
  names(df) = c("Season", "Lg", "Team", "W", "L", "W/L%", "Finish", "SRS", "Pace", 
                "RelativePace", "ORtg", "RelativeORtg", "DRtg", "RelativeDRtg", "Playoffs", "Coaches", "TopWinShare")
  df$TopWinShare = gsub("\u00A0", " ", df$TopWinShare, fixed = TRUE)
  df
}
