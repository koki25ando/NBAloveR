# function for getting given player's career summary stats
#' @importFrom dplyr %>% 

getStatsSummary <- function (Name) {
  players_season_stats <- fread("https://s3-ap-southeast-2.amazonaws.com/playerinfomation/Seasons_Stats.csv", data.table = FALSE)
  players_season_stats$Player <- players_season_stats$Player %>% 
    str_remove("\\*")
  stats_summary <- players_season_stats %>% 
    select(-contains("WS"), -contains("STL%"), -contains("RB%"),-blanl,
           -contains("BPM"), -contains("eFG%"), -contains("AST%"), -contains("BLK%"), 
           -contains("TOV%"), -contains("USG%"), -blank2, -contains("TS%"), 
           -contains("3PAr"), -VORP, -GS, -V1) %>% 
    group_by(Player) %>% 
    mutate(PPG = sum(PTS)/sum(G), RPG = sum(TRB)/sum(G), APG = sum(AST)/sum(G), SPG = sum(STL)/sum(G),
           Career = paste0(min(Year), "-", max(Year))) %>% 
    # select(Player, PPG:SPG) %>% 
    arrange(desc(Player)) %>% 
    distinct(Player, .keep_all = TRUE) %>% 
    select(Player, Career, Pos, PPG:SPG) %>% 
    filter(Player == Name)
}