#' Salary data for a given team
#' 
#' Function that allows you to get salary data of each team
#'
#' @param team_code Team code consisting of 3 characters to fetch information for
#' 
#' @author Koki Ando <koki.25.ando@gmail.com>
#' 
#' @import rvest
#' @import stringr
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
#'  salary_gsw <- getTeamSalary(team_code = "gsw")
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
