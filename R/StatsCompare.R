# Easy stats comparison function, which also includes simple line plots
#'
#' @import tidyverse
#' @import rvest
#' @import xml2
#' @import rlist
#' @import stringr
#'
#' Example
#' statsCompare(c("Kobe Bryant", "Allen Iverson", "Paul Pierce"), Age=TRUE)
#'
#' @export
#' 

player_key_list = list()
plyaer_career = list()

head_url = "https://www.basketball-reference.com/players/"
tail_url = "01.html"

statsCompare <- function( player_list = c(), Age=FALSE ) {

  for (i in 1:length(player_list)){
    player_key_list[i] <- paste0(substr(strsplit(player_list[i], " ")[[1]][2], 0,1), "/",
                                 substr(strsplit(player_list[i], " ")[[1]][2], 1,5),
                                 substr(player_list[i], 1,2)) %>%
                          str_to_lower()
  }

  for (i in 1:length(player_key_list)){
    plyaer_career[i] <- paste0(head_url, player_key_list[[i]][1], tail_url) %>%
      read_html() %>%
      html_table()
    plyaer_career[[i]] <- plyaer_career[[i]] %>%
      filter(Age != "NA") %>%
      plyr::mutate(Player=player_list[i])
  }

  point_plot_syn = list()
  line_plot_syn = list()

  if (Age==FALSE) {
    for ( i in 1:length(plyaer_career)){
      point_plot_syn[[i]] <-
        geom_point(data = plyaer_career[[i]],
                   aes(x=Season, y=PTS, color=Player))

      line_plot_syn[[i]] <-
        geom_line(data = plyaer_career[[i]],
                  aes(x=Season, y=PTS, group=Player, color=Player))
    }
  } else {
    for ( i in 1:length(plyaer_career)){
      point_plot_syn[[i]] <-
        geom_point(data = plyaer_career[[i]],
                   aes(x=Age, y=PTS, color=Player))

      line_plot_syn[[i]] <-
        geom_line(data = plyaer_career[[i]],
                  aes(x=Age, y=PTS, group=Player, color=Player))
    }
  }

  ggplot() +
    point_plot_syn +
    line_plot_syn +
    theme(axis.text.x = element_text(angle = 40)) +
    labs(title = "Career PPG Comparison")

}
