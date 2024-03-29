#' Stats Leader
#'
#' Stats Leader data
#'
#' @param stats_type Stats type. PTS, G, MP, FG, FT, TRB, AST, STL, BLK, TOV, PF or FG3
#' @param period Period. career, season or game
#'
#' @author Koki Ando <koki.25.ando@gmail.com>
#'
#' @importFrom magrittr %>%
#'
#' @seealso \url{https://www.basketball-reference.com/leaders/}
#'
#' @return This function returns \code{data.frame} including columns:
#' \itemize{
#'  \item{"Player"} - Player Name
#'  \item{"Season"} - Season number
#'  \item{"stats"} - Stats Type
#'  \item{"value"} - Value of record
#'  \item{"period"} - Period. career, season or game.
#' }
#'
#' @examples
#' \dontrun{
#'  pts_leader = getStatsLeader(stats_type = "PTS", period = "season")
#'  head(pts_leader)
#' }
#'
#' @export

getStatsLeader = function(stats_type = c("PTS", "G", "MP", "FG", "FT", "TRB", "AST", "STL", "BLK", "TOV", "PF", "FG3"),
                          period = c("career", "season", "game")){
  base_url = "https://www.basketball-reference.com/leaders/"

  url = paste0(base_url, stringr::str_to_lower(stats_type), "_", stringr::str_to_lower(period), ".html")
  tables <- xml2::read_html(url) %>% 
    rvest::html_table()
  table <- data.frame(tables[[1]])
  table$Player <- stringr::str_remove(table$Player, "\\*")
  dat = table[, 2:4]
  main_df = dat %>%
    tidyr::gather(key = "stats", value = "value", -'Season', -'Player') %>%
    dplyr::mutate(period = period)
  main_df
}
