# Function for getting summary stats
#' function for getting given player's career summary stats
#' @param Name palyers name
#' 
#' @importFrom magrittr %>%
#' @import dplyr
#' @export
getStatsSummary <- function (Name) {
  players_season_stats <- data.table::fread("https://s3-ap-southeast-2.amazonaws.com/playerinfomation/Seasons_Stats.csv", data.table = FALSE)
  players_season_stats$Player <- stringr::str_remove(players_season_stats$Player, "\\*")
  stats_summary <- players_season_stats %>% 
    dplyr::select(-dplyr::contains("WS"), -dplyr::contains("STL%"), -dplyr::contains("RB%"),-blanl,
           -dplyr::contains("BPM"), -dplyr::contains("eFG%"), -dplyr::contains("AST%"), -dplyr::contains("BLK%"), 
           -dplyr::contains("TOV%"), -dplyr::contains("USG%"), -dplyr::contains, -dplyr::contains("TS%"), 
           -dplyr::contains("3PAr"), -VORP, -GS, -V1) %>% 
    dplyr::group_by(Player) %>% 
    dplyr::mutate(PPG = sum(PTS)/sum(G), RPG = sum(TRB)/sum(G), APG = sum(AST)/sum(G), SPG = sum(STL)/sum(G),
           Career = paste0(min(Year), "-", max(Year))) %>% 
    # select(Player, PPG:SPG) %>% 
    dplyr::arrange(dplyr::desc(Player)) %>% 
    distinct(Player, .keep_all = TRUE) %>% 
    dplyr::select(Player, Career, Pos, PPG:SPG) %>% 
    dplyr::filter(Player == Name)
}
