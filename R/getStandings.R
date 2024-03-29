#' Standing Data
#'
#' Standing data
#'
#' @param year Season number consisting 4 digits
#' @param conf Conference to fetch information for. Valid values are East, West or All
#'
#' @author Koki Ando <koki.25.ando@gmail.com>
#'
#' @importFrom magrittr %>%
#'
#' @seealso \url{https://www.basketball-reference.com/leagues/NBA_2019_standings.html}
#'
#' @return This function returns \code{data.fram} including columns:
#' \itemize{
#'   \item{"Team"} - Team
#'   \item{"W"} - Wins
#'   \item{"L"} - Losses
#'   \item{"Per"} - Win-Loss Percentage
#'   \item{"GB"} - Games Behind
#'   \item{"PW"} - Pythagorean Wins, expected wins based on points scored and allowed
#'   \item{"PL"} - Pythagorean Lossed, expected losses based on points scored and allowed
#'   \item{"PSG"} - Points Per Game
#'   \item{"PAG"} - Opponent Points Per Game
#' }
#'
#' @examples
#' \dontrun{
#'   Standings06 <- getStandings(year = 2006, conf = "All")
#'   head(Standings06)
#' }
#'
#' @export


getStandings <- function (year, conf = c("East", "West", "All")) {
  head_url <- "https://www.basketball-reference.com/friv/standings.fcgi?month=5&day=10&year="
  tail_url <- "&lg_id=NBA"
  url <- paste0(head_url, as.character(year), tail_url)
  tables <- xml2::read_html(url) %>%
    rvest::html_table()

  conference <- stringr::str_to_lower(conf)
  if (conference == "east") {
    table <- tables[[1]] %>%
      plyr::arrange(plyr::desc(tables[[1]]$W)) %>%
      stats::na.omit()
    names(table)[1] <- "Team"
  } else if (conference == "west") {
    table <- tables[[2]] %>%
      plyr::arrange(plyr::desc(tables[[2]]$W)) %>%
      stats::na.omit()
    names(table)[1] <- "Team"
  } else {
    names(tables[[1]])[1] <- "Team"
    names(tables[[2]])[1] <- "Team"

    table <- dplyr::bind_rows(tables[[1]], tables[[2]]) %>%
      plyr::arrange(plyr::desc(dplyr::bind_rows(tables[[1]], tables[[2]])$W)) %>%
      stats::na.omit()
  }
  table$Team = stringr::str_remove(table$Team, "\\*")
  names(table) <- c("Team", "W", "L", "Per", "GB", "PW", "PL", "PSG", "PAG")
  table = dplyr::mutate(table, GB = ((max(table$W)-min(table$L))-(table$W-table$L))/2)
  data.frame(table)
}
