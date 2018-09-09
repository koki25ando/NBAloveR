# function for getting summary stats
#' Function for getting given player's career summary stats
#' @param Name palyers name
#' @importFrom magrittr %>%
#' @import dplyr
#' 
#' @example
#' 
#' @export
getStatsSummary <- function (Name) {
  players_season_stats <- data.table::fread("https://s3-ap-southeast-2.amazonaws.com/playerinfomation/Seasons_Stats.csv", data.table = FALSE)
  players_season_stats$Player <- stringr::str_remove(players_season_stats$Player, "\\*")
  stats_summary <- players_season_stats %>% 
    dplyr::select(Year:G, "FG%", "3P", "3P%", TRB:PTS) %>% 
    dplyr::group_by(Player) %>% 
    dplyr::mutate(PPG = sum(PTS)/sum(G), RPG = sum(TRB)/sum(G), APG = sum(AST)/sum(G), SPG = sum(STL)/sum(G),
                  Career = paste0(min(Year), "-", max(Year))) %>% 
    dplyr::arrange(dplyr::desc(Player)) %>% 
    dplyr::distinct(Player, .keep_all = TRUE) %>% 
    dplyr::select(Player, Career, Pos, PPG:SPG) %>% 
    dplyr::filter(Player == Name)
}