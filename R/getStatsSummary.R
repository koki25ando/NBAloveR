# function for getting summary stats
#' Function for getting given player's career summary stats
#' @param Name palyers name
#' @importFrom magrittr %>%
#' @import dplyr
#' 
#' @example
#' 
#' @export
getStatsSummary <- function (Name) {
  head_url = "https://www.basketball-reference.com/players/"
  tail_url = "01.html"
  
  player_key <- paste0(substr(strsplit(Name, " ")[[1]][2], 0,1), "/",
                       substr(strsplit(Name, " ")[[1]][2], 1,5),
                       substr(Name, 1,2)) %>%
    stringr::str_to_lower()
  
  tables <- paste0(head_url, player_key, tail_url) %>%
    xml2::read_html() %>%
    rvest::html_table()
  tables[[1]] %>% 
    dplyr::filter(Season=="Career")
}