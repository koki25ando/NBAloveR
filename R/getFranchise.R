# function for getting team list
#' Function for getting Franchises' data: founded year, W/L percentage, number of division/conf/league championship
#' @importFrom magrittr %>%
#' @import dplyr
#' @import rvest
#'
#' @example
#' # Import data
#' Franchise <- getFranchise()
#'
#' # Overview
#' head(Franchise)
#'
#' # A visualization example
#' Franchise %>%
#'   ggplot(aes(Champ, Franchise)) +
#'   geom_point()
#'
#' @export
#'
getFranchise <- function () {
  url <- "https://www.basketball-reference.com/teams/"
  page <- xml2::read_html(url)
  # tables <- rvest::html_table(page)
  tables <- rvest::html_table(page)
  table <- as.data.frame(tables[[1]])
  table <- dplyr::filter(table, To == 2019)
  table <- dplyr::distinct(table, Franchise, .keep_all=TRUE)
}
