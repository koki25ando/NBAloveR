# getTeamHistory() function: Function that allows you to get team history data
#' @param team_code 3-characters team code
#' 
#' @importFrom dplyr %>% 
#' @export

getTeamHistory <- function (team_code) {
  url <- paste0("https://www.basketball-reference.com/teams/", str_to_upper(team_code), "/")
  tables <- 
    rvest::read_html(url) %>% 
    rvest::html_table()
  tables[[1]] %>% 
    as.data.frame()
}

