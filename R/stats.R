#' Stats Per Game for a given player
#' 
#' Function for getting given player's stats per game
#'
#' @param player Player name to fetch information for
#' @param season Season number
#' @param span Duration of season. Defaults 1.
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
#'  \item GmSc
#' }
#' 
#' @examples
#' \dontrun{
#' RayAllen <- getStatsPerGame(player="Ray Allen", season=2008, span=1)
#' head(RayAllen)
#' }
#'
#' @export

getStatsPerGame <- function(player, season, span=1){
  
  # Setting
  head_url <- "https://www.basketball-reference.com/players/"
  player_key = player_key_generation(player)
  end_url <- "/gamelog/"
  url_list <- paste0(head_url, player_key, end_url, season:(season+span-1), "/")
  
  
  if (length(url_list) == 1){
    url = url_list
    tables <- xml2::read_html(url) %>%
      rvest::html_table(fill = TRUE)
    main_df = data.frame(tables[[8]]) %>%
      dplyr::filter(data.frame(tables[[8]]) $Date != "Date")
    output_table = main_df[,1:29]
  } else if (length(url_list) > 1) {
    
    dt_list = list()
    for (i in 1:length(url_list)){
      url = url_list[[i]]
      tables <- xml2::read_html(url) %>%
        rvest::html_table(fill = TRUE)
      table <- data.frame(tables[[8]]) %>%
        dplyr::filter(data.frame(tables[[8]]) $Date != "Date")
      
      dt_list[[i]] = table
    }
    
    main_df = do.call(rbind, dt_list)
    output_table = main_df[,1:29]
  } else {
    warning("span has to be greater than 0")
  }
  output_table = output_table %>% 
    dplyr::select(-Rk, -'Var.8')
  names(output_table)[c(5, 11:14, 17)] = c("Home", "FGP", "3PM", "3PA", "3PP", "FTP")
  output_table %>% 
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
#' Easy stats comparison function, which includes simple line and point plots
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

statsCompare <- function(player_list = c(), Age=FALSE) {
  
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
