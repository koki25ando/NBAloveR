#' Career summary stats for a given player
#' 
#' Function for getting given player's career summary stats
<<<<<<< HEAD
#' 
#' @param Name The name of the player to fetch information for
#' 
#' @author Koki Ando <koki.25.ando@gmail.com>
#' 
#' @importFrom magrittr %>%
#' 
=======
#' 
#' @param Name The name of the player to fetch information for
#' 
#' @author Koki Ando <koki.25.ando@gmail.com>
#' 
>>>>>>> a326d2ccc47dec97d5501539f2a2846eed11a994
#' @seealso \url{https://www.basketball-reference.com}
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
<<<<<<< HEAD
#'   getStatsSummary(Name = "Kobe Bryant")
=======
#'   getStatsSummary("Kobe Bryant")
>>>>>>> a326d2ccc47dec97d5501539f2a2846eed11a994
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
<<<<<<< HEAD
    dplyr::filter(tables[[1]]$Season=="Career")
=======
    dplyr::filter(Season=="Career")
>>>>>>> a326d2ccc47dec97d5501539f2a2846eed11a994
}
