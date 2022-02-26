#' Stats Per Game for a given player
#'
#' Function for getting given player's stats per game
#'
#' @param player Player name to fetch information for
#' @param season Season number
#' @param span Duration of season(s). Defaults 1.
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
  url_list <- paste0(
    head_url,
    player_key,
    end_url,
    season:(season+span-1),
    "/"
  )


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
    dplyr::select(-'Rk', -'Var.8')
  names(output_table)[c(5, 11:14, 17)] = c("Home", "FGP", "3PM", "3PA", "3PP", "FTP")
  output_table %>%
    dplyr::filter(output_table$GS != "Inactive",
                  output_table$GS != "Did Not Dress")
}


#' Career Stats Summary
#'
#' Career stats summary of a given player
#'
#' @param player Player name
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
#'  kobe_summary  = getStatsSummary(player = "Kobe Bryant")
#'  head(kobe_summary)
#' }
#'
#' @export
getStatsSummary <- function (player) {

  head_url = "https://www.basketball-reference.com/players/"
  player_key = player_key_generation(player)
  url = paste0(head_url, player_key, ".html")

  tables <- url %>%
    xml2::read_html() %>%
    rvest::html_table()
  tables[[1]] %>%
    dplyr::filter(tables[[1]]$Season=="Career")
}


#' Visualization of Stats comparison
#'
#' Easy stats comparison function, which includes simple line and point plots
#'
#' @param player_list List of players
#' @param age Age. valid values are TRUE or FALSE
#'
#' @author Koki Ando <koki.25.ando@gmail.com>
#'
#' @importFrom magrittr %>%
#'
#' @return This function returns a point and line plot showing transitions of PPG stats of given players.
#'
#' @examples
#' \dontrun{
#'   statsCompare(player_list = c("Ray Allen", "Klay Thompson", "Stephen Curry"), Age=TRUE)
#' }
#'
#' @export

statsCompare <- function(player_list = c(), age=FALSE) {

  player_url = list()
  plyaer_career = list()
  head_url = "https://www.basketball-reference.com/players/"

  for (i in 1:length(player_list)){
    player_url[i] <- paste0(head_url, player_key_generation(player_list[[i]]), ".html")
  }

  for (i in 1:length(player_url)){
    plyaer_career[i] <- player_url[[i]] %>%
      xml2::read_html() %>%
      rvest::html_table()
    plyaer_career[[i]] = plyaer_career[[i]][plyaer_career[[i]]$Age != "NA", ]
  }

  for (i in 1:length(plyaer_career)){
    plyaer_career[[i]]$Player = player_list[i]
  }

  point_plot_syn = list()
  line_plot_syn = list()

  if (age==FALSE) {
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
