# function to get historical league standings
#' 
#' @import rvest
#' @import xml2
#' @import dplyr
#' 
#' @example
#' Standings06 <- getStandings(year = 2006, conf = "ALL")
#' Head(Standings06)
#' 
#' @export


getStandings <- function (year, conf = c("East", "West")) {
  head_url <- "https://www.basketball-reference.com/friv/standings.fcgi?month=5&day=10&year="
  tail_url <- "&lg_id=NBA"
  url <- paste0(head_url, as.character(year), tail_url)
  tables <- read_html(url) %>% 
    html_table()
  
  conference <- stringr::str_to_lower(conf)
  if (conference == "east") {
    table <- tables[[1]] %>% 
      filter(W != "NA") %>% 
      arrange(desc(W))
  } else if (conference == "west") {
    table <- tables[[2]] %>% 
      filter(W != "NA") %>% 
      arrange(desc(W))
  } else {
    names(tables[[1]])[1] <- "Team"
    names(tables[[2]])[1] <- "Team"
    
    table <- bind_rows(tables[[1]], tables[[2]]) %>% 
      filter(Team != "Atlantic Division" & Team != "Central Division" & 
               Team != "Midwest Division" & Team != "Pacific Division" &
               Team != "Southeast Division" & Team != "Northwest Division" &
               Team != "Southwest Division") %>% 
      arrange(desc(W))
  }
  
  data.frame(table)
}
