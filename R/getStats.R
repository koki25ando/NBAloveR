# function for getting stats
#' Function for getting stats data for each player divided by season
#' @importFrom magrittr %>%
#' @import dplyr
#' 
#' @example
#' 
#' @export
getStats <- function(){
  players_season_stats <- data.table::fread("https://s3-ap-southeast-2.amazonaws.com/playerinfomation/Seasons_Stats.csv", data.table = FALSE)
  players_season_stats %>% 
    dplyr::select(-dplyr::contains("WS"), -dplyr::contains("STL%"), -dplyr::contains("RB%"),-blanl,
           -dplyr::contains("BPM"), -dplyr::contains("eFG%"), -dplyr::contains("AST%"), -dplyr::contains("BLK%"), 
           -dplyr::contains("TOV%"), -dplyr::contains("USG%"), -blank2, -dplyr::contains("TS%"), 
           -dplyr::contains("3PAr"), -VORP, -GS, -V1) %>% 
    dplyr::group_by(Player, Year) %>% 
    dplyr::mutate(PPG = sum(PTS)/sum(G), RPG = sum(TRB)/sum(G), APG = sum(AST)/sum(G), SPG = sum(STL)/sum(G))
}