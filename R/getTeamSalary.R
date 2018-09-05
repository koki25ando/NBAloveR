# Function that allows you to get salary data of each team
#' @param team_code 3-characters team code
#' 
#' @importFrom dplyr %>% 
#' @export

getTeamSalary <- function (team_code) {
  url <- paste0("https://www.basketball-reference.com/contracts/", stringr::str_to_upper(team_code), ".html")
  tables <- 
    rvest::read_html(url) %>% 
    rvest::html_table()
  df <- tables[[1]] %>% 
    as.data.frame()
  colnames(df) <- df[1,]
  df[-1,]
}
