# Function that allows you to get salary data of each team
#' @param team_code 3-characters team code
#' 
#' @export
#' 
#' # Extract salary dataset of Golden State Warriors' players
#' salary <- getTeamSalary(team_code = "gsw")
#' 
#' # Brief overview
#' head(salary)
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
