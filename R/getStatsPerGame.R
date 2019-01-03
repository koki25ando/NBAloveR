#  Function for getting given player's stas per game
#'
#' @import dplyr
#' @import stringr
#' @import rvest
#' 
#' @example 
#' \dontrun{
#' getStatsPerGame(Player="Kobe Bryant", season="2008")
#' }
#'
#' @export

getStatsPerGame <- function(Player, season){
  head_url <- "https://www.basketball-reference.com/players/"
  tail_url <- paste0(substr(strsplit(Player, " ")[[1]][2], 0,1), "/",
                     substr(strsplit(Player, " ")[[1]][2], 1,5),
                     substr(strsplit(Player, " ")[[1]][1], 0,2),
                     "01/gamelog/", season, "/") %>% 
    stringr::str_to_lower()
  url <- paste0(head_url, tail_url)
  
  if (Player == "Ray Allen") {
    url <- url %>%
      stringr::str_replace("01/gamelog", "02/gamelog")
  } else if (Player == "Joe Johnson") {
    url <- url %>%
      stringr::str_replace("01/gamelog", "02/gamelog")
  }
  
  tables <- xml2::read_html(url) %>% 
    rvest::html_table(fill = TRUE)
  data.frame(tables[[8]]) %>% 
    dplyr::filter(Date != "Date")
}
