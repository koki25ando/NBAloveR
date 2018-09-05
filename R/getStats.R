# Function for getting stats data for each player divided by season
#' importFrom dplyr %>% 

getStats <- function(){
  players_season_stats <- data.table::fread("https://s3-ap-southeast-2.amazonaws.com/playerinfomation/Seasons_Stats.csv", data.table = FALSE)
  players_season_stats %>% 
    select(-contains("WS"), -contains("STL%"), -contains("RB%"),-blanl,
           -contains("BPM"), -contains("eFG%"), -contains("AST%"), -contains("BLK%"), 
           -contains("TOV%"), -contains("USG%"), -blank2, -contains("TS%"), 
           -contains("3PAr"), -VORP, -GS, -V1) %>% 
    group_by(Player, Year) %>% 
    mutate(PPG = sum(PTS)/sum(G), RPG = sum(TRB)/sum(G), APG = sum(AST)/sum(G), SPG = sum(STL)/sum(G))
}