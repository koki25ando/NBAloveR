#' List of Hall of Famers
#' 
#' Function to get list of Hall of Famers
#' 
#' @author Koki Ando
#' 
#' @import magrittr
#' @import rvest
#' @import xml2
#' 
#' @return This function returns \code{data.frame} including columns:
#' \itemize{
#'  \item Year
#'  \item Inductees
#'  \item Pos.
#'  \item Achievements
#' }
#' 
#' @seealso \url{https://en.wikipedia.org/wiki/List_of_players_in_the_Naismith_Memorial_Basketball_Hall_of_Fame}
#' 
#' @examples
#' \dontrun{
#'   NBAhof <- getHOF()
#'   head(NBAhof)
#' }
#' 
#' @export

getHOF <- function(){
  url <- "https://en.wikipedia.org/wiki/List_of_players_in_the_Naismith_Memorial_Basketball_Hall_of_Fame"
  tables <- xml2::read_html(url) %>% 
    rvest::html_table(fill = TRUE)
  data.frame(tables[[1]])[,1:4]
}

