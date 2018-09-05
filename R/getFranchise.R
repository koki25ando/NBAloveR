# Function for getting Franchises' data: founded year, W/L percentage, number of division/conf/league championship
#' @importFrom magrittr %>%
#' @export

getFranchise <- function () {
  url <- "https://www.basketball-reference.com/teams/"
  page <- xml2::read_html(url)
  tables <- page %>% 
    rvest::html_table()
  tables[[1]] %>% 
    as.data.frame() %>% 
    dplyr::filter(To == 2019) %>% 
    distinct(Franchise, .keep_all=TRUE)
}
