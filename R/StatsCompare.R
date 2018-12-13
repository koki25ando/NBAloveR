# Easy stats comparison function, which also includes simple line plots
#'
#' @import rvest
#' @import xml2
#' @import rlist
#' @import stringr
#' @import plyr
#' @import ggplot2
#' 
#'
#' Example
#' statsCompare(c("Kobe Bryant", "Allen Iverson", "Paul Pierce"), Age=TRUE)
#'
#' @export

statsCompare <- function( player_list = c(), Age=FALSE ) {
  
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
    # plyaer_career[[i]] <- plyaer_career[[i]] %>%
    #   filter(Age != "NA") %>% suppressWarnings()
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
                            ggplot2::aes(x=Season, y=PTS, color=Player))

      line_plot_syn[[i]] <-
        ggplot2::geom_line(data = plyaer_career[[i]],
                           ggplot2::aes(x=Season, y=PTS, group=Player, color=Player))
    }
  } else {
    for ( i in 1:length(plyaer_career)){
      point_plot_syn[[i]] <-
        ggplot2::geom_point(data = plyaer_career[[i]],
                            ggplot2::aes(x=Age, y=PTS, color=Player))

      line_plot_syn[[i]] <-
        ggplot2::geom_line(data = plyaer_career[[i]],
                           ggplot2::aes(x=Age, y=PTS, group=Player, color=Player))
    }
  }

  ggplot2::ggplot() +
    point_plot_syn +
    line_plot_syn +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 40)) +
    ggplot2::labs(title = "Career PPG Comparison")

}
