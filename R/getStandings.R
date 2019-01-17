#' Standing Data
#' 
#' Function to get historical league standings
#' 
#' @param year
#' @param conf
#' 
#' @author Koki Ando
#' 
#' @import rvest
#' @import xml2
#' @import dplyr
#' @import magrittr
#' @import plyr
#' @import stringr
#' 
#' @seealso \url{https://www.basketball-reference.com/leagues/NBA_2019_standings.html}
#' 
#' @return This function returns \code{data.fram} including columns:
#' \itemize{
#'   \item Team
#'   \item W
#'   \item L
#'   \item W.L.
#'   \item GB
#'   \item PW
#'   \item PL
#'   \item PS.G
#'   \item PA.G
#' }
#' 
#' @example
#' \dontrun{
#'   Standings06 <- getStandings(year = 2006, conf = "ALL")
#'   Head(Standings06)
#' }
#' 
#' @export


getStandings <- function (year, conf = c("East", "West", "All")) {
  head_url <- "https://www.basketball-reference.com/friv/standings.fcgi?month=5&day=10&year="
  tail_url <- "&lg_id=NBA"
  url <- paste0(head_url, as.character(year), tail_url)
  tables <- xml2::read_html(url) %>% 
    rvest::html_table()
  
  conference <- stringr::str_to_lower(conf)
  if (conference == "east") {
    table <- tables[[1]] %>% 
      plyr::arrange(plyr::desc(W)) %>% 
      na.omit()
  } else if (conference == "west") {
    table <- tables[[2]] %>% 
      plyr::arrange(plyr::desc(W)) %>% 
      na.omit()
  } else {
    names(tables[[1]])[1] <- "Team"
    names(tables[[2]])[1] <- "Team"
    
    table <- dplyr::bind_rows(tables[[1]], tables[[2]])%>% 
      plyr::arrange(plyr::desc(W)) %>% 
      na.omit()
  }
  
  data.frame(table)
}
