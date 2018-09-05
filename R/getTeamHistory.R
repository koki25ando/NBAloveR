# getTeamHistory() function: Function that allows you to get team history data
#' @importFrom dplyr %>% 

getTeamHistory <- function (team_code) {
  url <- paste0("https://www.basketball-reference.com/teams/", str_to_upper(team_code), "/")
  tables <- 
    read_html(url) %>% 
    html_table()
  tables[[1]] %>% 
    as.data.frame()
}

