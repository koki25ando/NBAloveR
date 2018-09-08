# getTeamHistory() function: Function that allows you to get team history data
#' @param team_code 3-characters team code
#' 
#' @example
#' 
#' # Get Boston Celtics' franchise record
#' BostonCeltics <- getTeamHistory(team_code = "BOS")
#' 
#' # Brief overview of dataset
#' head(BostonCeltics)
#' 
#' @export

getTeamHistory <- function (team_code) {
  url <- paste0("https://www.basketball-reference.com/teams/", stringr::str_to_upper(team_code), "/")
  tables <- xml2::read_html(url)
  tables <- rvest::html_table(tables)
  df <- as.data.frame(tables[[1]])
  df[,-c(9,16)]
}

