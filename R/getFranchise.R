#' Franchise data for a given team
#' 
#' Function for getting Franchises' data: founded year, W/L percentage, number of division/conf/league championship
#' 
#' @author Koki Ando
#' 
#' @import magrittr
#' @import dplyr
#' @import rvest
#' 
#' @return This function returns \code{data.frame} including columns:
#' \itemize{
#'  \item Franchise
#'  \item Lg
#'  \item From
#'  \item To
#'  \item Yrs
#'  \item G
#'  \item W
#'  \item L
#'  \item W/L%
#'  \item Plyfs
#'  \item Div
#'  \item Conf
#'  \item Champ
#' }
#'
#' @examples
#' \dontrun{
#'   Franchise <- getFranchise()
#'   head(Franchise)
#' }
#'
#' @export

getFranchise <- function () {
  url <- "https://www.basketball-reference.com/teams/"
  page <- xml2::read_html(url)
  # tables <- rvest::html_table(page)
  tables <- rvest::html_table(page)
  table <- as.data.frame(tables[[1]])
  table <- dplyr::filter(table, To == 2019)
  table <- dplyr::distinct(table, Franchise, .keep_all=TRUE)
  table
}

names(Franchise) <- c("Franchise", "Lg", "From", "To", "Years", "G", "W", "L", "Per", "Playoffs", "Division", "Conference", "Champions")
