#' Stats Per Game for a given player
#' 
#' Function for getting given player's stas per game
#'
#' @param Player The name of the player to fetch information for
#' @param season NBA season number
#' @param span Duration of data
#' 
#' @author Koki Ando <koki.25.ando@gmail.com>
#' 
#' @import stringr
#' @import rvest
#' 
#' @return This function returns \code{data.frame} including columns:
#' \itemize{
#'  \item G
#'  \item Date
#'  \item Age
#'  \item Tm
#'  \item Home
#'  \item Opp
#'  \item GS
#'  \item MP
#'  \item FG
#'  \item FGA
#'  \item FGP
#'  \item 3PM
#'  \item 3PA
#'  \item 3PP
#'  \item FT
#'  \item FTA
#'  \item FTP
#'  \item ORB
#'  \item DRB
#'  \item TRB
#'  \item AST
#'  \item STL
#'  \item BLK
#'  \item TOV
#'  \item PF
#'  \item PTS
#'  \item GameScore
#'  \item PlusMinus
#' }
#' 
#' @examples
#' \dontrun{
#' kobe08 <- getStatsPerGame(Player="Kobe Bryant", season="2008")
#' head(kobe08)
#' }
#'
#' @export

getStatsPerGame <- function(Player, season, span=1){
  
  if (Player == "Ray Allen") {
    end_url <- "02/gamelog/"
  } else if (Player == "Joe Johnson") {
    end_url <- "02/gamelog/"
  } else {
    end_url <- "01/gamelog/"
  }
  
  head_url <- "https://www.basketball-reference.com/players/"
  
  if (span > 1) {
    url_list <- paste0(head_url, paste0(substr(strsplit(Player, " ")[[1]][2], 0,1), "/",
                                        substr(strsplit(Player, " ")[[1]][2], 1,5),
                                        substr(strsplit(Player, " ")[[1]][1], 0,2),
                                        end_url, season:paste0(season+span), "/")) %>% 
      stringr::str_to_lower()
    
    get_stats_scarping_script <- function(url) {
      tables <- xml2::read_html(url) %>%
        rvest::html_table(fill = TRUE)
      table_df <- data.frame(tables[[8]]) %>%
        dplyr::filter(Date != "Date")
      table_df[,1:29]
    }
    
    data_list <- apply(data.frame(url_list), 1, get_stats_scarping_script)
    data.df <- do.call(rbind, data_list)
    return(data.df)
    
  } else if(span == 0) {
    print("span hast be greater than 0")
  } else {
    tail_url <- paste0(substr(strsplit(Player, " ")[[1]][2], 0,1), "/",
                       substr(strsplit(Player, " ")[[1]][2], 1,5),
                       substr(strsplit(Player, " ")[[1]][1], 0,2),
                       end_url, season, "/") %>% 
      stringr::str_to_lower()
    url <- paste0(head_url, tail_url)
    
    tables <- xml2::read_html(url) %>%
      rvest::html_table(fill = TRUE)
    table <- data.frame(tables[[8]]) %>%
      dplyr::filter(Date != "Date")
  }
  names(table) <- c("Rk", "G", "Date", "Age", "Tm", "Home", "Opp", "Var.8", "GS", "MP", "FG", "FGA", "FGP", "3PM", "3PA", "3PP",  "FT", 
    "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS", "GameScore", "PlusMinus")
  table %>% 
    select(c("Rk", "G", "Date", "Age", "Tm", "Home", "Opp", "GS", "MP", "FG", "FGA", "FGP", "3PM", "3PA", "3PP",  "FT", 
             "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS", "GameScore", "PlusMinus"))
}
