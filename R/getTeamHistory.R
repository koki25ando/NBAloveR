# getTeamHistory() function: Function that allows you to get team history data
#' @param team_code 3-characters team code
#' 

getTeamHistory <- function (team_code) {
  url <- paste0("https://www.basketball-reference.com/teams/", str_to_upper(team_code), "/")
  tables <- xml2::read_html(url)
  tables <- rvest::html_table(tables)
  as.data.frame(tables[[1]])
}

