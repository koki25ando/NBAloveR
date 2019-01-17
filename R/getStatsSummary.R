#' Career summary stats for a given player
#' 
#' Function for getting given player's career summary stats
#' 
#' @param Name The name of the player to fetch information for
#' 
#' @author Koki Ando
#' 
#' @seealso \url{https://www.basketball-reference.com}
#' 
#' @import magrittr
#' @import dplyr
#' @import stringr
#' @import rvest
#' 
#' @return This function returns \code{data.frame} including columns:
#' \itemize{
#'  \item Season
#'  \item Age
#'  \item Tm
#'  \item Lg
#'  \item Pos
#'  \item G
#'  \item GS
#'  \item MP
#'  \item FG
#'  \item FG%
#'  \item 3P
#'  \item 3PA
#'  \item 3P%
#'  \item 2P
#'  \item 2PA
#'  \item 2P%
#'  \item eFG%
#'  \item FT
#'  \item FTA
#'  \item FT%
#'  \item ORB
#'  \item DRB
#'  \item TRB
#'  \item AST
#'  \item STL
#'  \item BLK
#'  \item TOV
#'  \item PF
#'  \item PTS
#' }
#' 
#' @examples
#' \dontrun{
#'   getStatsSummary("Kobe Bryant")
#' }
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
