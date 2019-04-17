#' Stats Per Game for a given player
#' 
#' Function for getting given player's stats per game
#'
#' @param Player The name of the player to fetch information for
#' @param season NBA season number
#' @param span Duration of data
#' 
#' @author Koki Ando <koki.25.ando@gmail.com>
#' 
#' @importFrom magrittr %>%
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
#' kobe08 <- getStatsPerGame(Player="Kobe Bryant", season=2008)
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
                                        end_url, season:paste0(as.numeric(season)+as.numeric(span)), "/")) %>% 
      stringr::str_to_lower()
    
    get_stats_scarping_script <- function(url) {
      tables <- xml2::read_html(url) %>%
        rvest::html_table(fill = TRUE)
      table_df <- data.frame(tables[[8]]) %>%
        dplyr::filter(data.frame(tables[[8]])$Date != "Date")
      table_df[,1:29]
    }
    
    data_list <- apply(data.frame(url_list), 1, get_stats_scarping_script)
    data.df <- do.call(rbind, data_list)
    return(data.df)
    
  } else if(span == 0) {
    warning("span has to be greater than 0")
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
      dplyr::filter(data.frame(tables[[8]]) $Date != "Date")
  }
  
  
  table <- table %>% 
    dplyr::select(c("Rk", "G", "Date", "Age", "Tm", "Var.6", "Opp", "GS", "MP", "FG", "FGA", "FG.", "X3P", "X3PA", "X3P.",  "FT", 
                    "FTA", "FT.", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS", "GmSc", "X..."))
  names(table) <- c("Rk", "G", "Date", "Age", "Tm", "Home", "Opp", "GS", "MP", "FG", "FGA", "FGP", "3PM", "3PA", "3PP", 
                    "FT", "FTA",  "FTP",  "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS", "GameScore", "PlusMinus")
  table %>% 
    dplyr::filter(GS != "Inactive",
                  GS != "Did Not Dress")
}


#' Career summary stats for a given player
#' 
#' Function for getting given player's career summary stats
#' 
#' @param Name The name of the player to fetch information for
#' 
#' @author Koki Ando <koki.25.ando@gmail.com>
#' 
#' @importFrom magrittr %>%
#' 
#' @author Koki Ando <koki.25.ando@gmail.com>
#' 
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
#'  kobe_summary  = getStatsSummary(Name = "Kobe Bryant")
#'  head(kobe_summary)
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
    dplyr::filter(tables[[1]]$Season=="Career")
}


#' Visualization of Stats comparison
#' 
#' Easy stats comparison function, which also includes simple line and point plots
#' 
#' @param player_list List of names of players.
#' @param Age Age valid values are TRUE or FALSE
#' 
#' @author Koki Ando <koki.25.ando@gmail.com>
#' 
#' @importFrom magrittr %>%
#' 
#' @return This function returns a point and line plot showing transitions of PPG stats of given players.
#'
#' @examples
#' \dontrun{
#'   statsCompare(c("Kevin Durant", "Russel Westbrook", "James Harden"), Age=FALSE)
#' }
#'
#' @export

statsCompare <- function(player_list = c(), Age=FALSE ) {
  
  player_key_list = list()
  plyaer_career = list()
  head_url = "https://www.basketball-reference.com/players/"
  tail_url = "01.html"
  
  for (i in 1:length(player_list)){
    player_key_list[i] <- paste0(substr(strsplit(player_list[i], " ")[[1]][2], 0,1), "/",
                                 substr(strsplit(player_list[i], " ")[[1]][2], 1,5),
                                 substr(player_list[i], 1,2)) %>%
      stringr::str_to_lower()
  }
  
  for (i in 1:length(player_key_list)){
    plyaer_career[i] <- paste0(head_url, player_key_list[[i]][1], tail_url) %>%
      xml2::read_html() %>%
      rvest::html_table()
    plyaer_career[[i]] = plyaer_career[[i]][plyaer_career[[i]]$Age != "NA", ]
  }
  
  for (i in 1:length(plyaer_career)){
    plyaer_career[[i]]$Player = player_list[i]
  }
  
  point_plot_syn = list()
  line_plot_syn = list()
  
  if (Age==FALSE) {
    for ( i in 1:length(plyaer_career)){
      point_plot_syn[[i]] <-
        ggplot2::geom_point(data = plyaer_career[[i]],
                            ggplot2::aes_string(x="Season", y="PTS", color="Player"))
      
      line_plot_syn[[i]] <-
        ggplot2::geom_line(data = plyaer_career[[i]],
                           ggplot2::aes_string(x="Season", y="PTS", group="Player", color="Player"))
    }
  } else {
    for ( i in 1:length(plyaer_career)){
      point_plot_syn[[i]] <-
        ggplot2::geom_point(data = plyaer_career[[i]],
                            ggplot2::aes_string(x="Age", y="PTS", color="Player"))
      
      line_plot_syn[[i]] <-
        ggplot2::geom_line(data = plyaer_career[[i]],
                           ggplot2::aes_string(x="Age", y="PTS", group="Player", color="Player"))
    }
  }
  
  ggplot2::ggplot() +
    point_plot_syn +
    line_plot_syn +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 40)) +
    ggplot2::labs(title = "Career PPG Comparison")
  
}
