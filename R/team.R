#' Players' Salary
#'
#' Players' salary data for a given team
#'
#' @param team_code Team code consisting of 3 characters to fetch information for
#'
#' @author Koki Ando <koki.25.ando@gmail.com>
#'
#' @seealso \url{https://www.basketball-reference.com/contracts/}
#'
#' @examples
#' \dontrun{
#'  salary_phi <- getTeamSalary(team_code = "phi")
#'  head(salary_phi)
#' }
#'
#' @export

getTeamSalary <- function (team_code) {
  url <- paste0("https://www.basketball-reference.com/contracts/", stringr::str_to_upper(team_code), ".html")
  tables <- xml2::read_html(url)
  tables <- rvest::html_table(tables)
  df <- as.data.frame(tables[[1]])
  colnames(df) <- df[1,]
  dat = df[-1,]
  dat %>%
    dplyr::filter(dat$Player != "")
}

#' Franchise History Data
#'
#' Franchise's season data
#'
#' @param team_code Team code consisting of 3 characters to fetch information for
#'
#' @author Koki Ando <koki.25.ando@gmail.com>
#'
#' @seealso \url{https://www.basketball-reference.com/teams/}
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


#' Season Matchups
#'
#' Season Matchups and results of a given team
#'
#' @param team_code Team code consisting 3 characters
#' @param season Season number
#'
#' @author Koki Ando
#'
#' @importFrom magrittr %>%
#'
#' @seealso \url{https://www.basketball-reference.com/teams/}
#'
#' @return This function returns \code{data.frame} including columns:
#' \itemize{
#'  \item{"G"} - Games
#'  \item{"Date"} - Date
#'  \item{"StartTime"} - Time-zone ET
#'  \item{"Opponent"} - Opponent Team
#'  \item{"Result"} - Game Result
#'  \item{"OT"} - Over Time
#'  \item{"Tm"} - Points
#'  \item{"Opp"} - Opponent Points
#'  \item{"W"} - Wins
#'  \item{"L"} - Losses
#'  \item{"Streak"} - Streaks
#' }
#'
#' @examples
#' \dontrun{
#'  bos19 <- getMatchups(team_code = "bos", season = 2019)
#'  head(bos19)
#' }
#'
#' @export


getMatchups <- function (team_code, season) {
  base_url <- "https://www.basketball-reference.com/teams/"
  url <- paste0(base_url, stringr::str_to_upper(team_code), "/", season, "_games.html")

  tables <- xml2::read_html(url) %>%
    rvest::html_table()
  df <- data.frame(tables[[1]]) %>%
    dplyr::filter(data.frame(tables[[1]])$Date != "Date")
  names(df)  <- c("G", "Date", "StartTime", "Var.4", "Var.5", "Var.6", "Opponent", "Result", "OT", "Tm", "Opp", "W", "L", "Streak", "Notes")
  df[, c(1:3, 7:14)]
}
