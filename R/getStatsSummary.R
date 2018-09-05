# function for getting given player's career summary stats
#' @param Name palyers name
#' 

getStatsSummary <- function (Name) {
  players_season_stats <- data.table::fread("https://s3-ap-southeast-2.amazonaws.com/playerinfomation/Seasons_Stats.csv", data.table = FALSE)
  players_season_stats$Player <- stringr::str_remove(players_season_stats$Player, "\\*")
  stats_summary <- players_season_stats %>% 
    dplyr::select(-contains("WS"), -contains("STL%"), -contains("RB%"),-blanl,
           -contains("BPM"), -contains("eFG%"), -contains("AST%"), -contains("BLK%"), 
           -contains("TOV%"), -contains("USG%"), -blank2, -contains("TS%"), 
           -contains("3PAr"), -VORP, -GS, -V1) %>% 
    dplyr::group_by(Player) %>% 
    dplyr::mutate(PPG = sum(PTS)/sum(G), RPG = sum(TRB)/sum(G), APG = sum(AST)/sum(G), SPG = sum(STL)/sum(G),
           Career = paste0(min(Year), "-", max(Year))) %>% 
    # select(Player, PPG:SPG) %>% 
    dplyr::arrange(desc(Player)) %>% 
    distinct(Player, .keep_all = TRUE) %>% 
    dplyr::select(Player, Career, Pos, PPG:SPG) %>% 
    dplyr::filter(Player == Name)
}