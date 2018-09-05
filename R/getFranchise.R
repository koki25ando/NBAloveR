# Function for getting team list
#' Function for getting Franchises' data: founded year, W/L percentage, number of division/conf/league championship
#' @import dplyr
#' @export

getFranchise <- function () {
  url <- "https://www.basketball-reference.com/teams/"
  page <- xml2::read_html(url)
  tables <- rvest::html_table(page)
  table <- as.data.frame(tables[[1]])
  table <- dplyr::filter(table, To == 2019)
  table <- dplyr::distinct(table, Franchise, .keep_all=TRUE)
}
