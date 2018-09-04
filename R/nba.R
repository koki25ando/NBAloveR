# Package
library(tidyverse)
library(rvest)
library(magrittr)

# Data Importing
players_list_since1950 <- fread("https://s3-ap-southeast-2.amazonaws.com/koki25ando/Players.csv", data.table = FALSE)


getPlayers <- function () {
  players_list_since1950 %>% 
    select(Player:birth_state)
}



## Franchise data history
NBA_team_datasets <- read_html("https://www.basketball-reference.com/teams/")
nt <- 
  NBA_team_datasets %>% 
  html_table(header = TRUE) %>% 
  extract2(1) %>% 
  filter(To == 2019) %>% 
  distinct(Franchise, .keep_all=TRUE)
colnames(nt) <- c("Franchise","Lg", "From", "To", "Yrs", "G", "W", "L", "PCT", "Plyfs", "Div", "Conf", "Champ")

nt$Champ <- as.numeric(nt$Champ)
nt$Plyfs <- as.numeric(nt$Plyfs)
nt$Div <- as.numeric(nt$Div)
nt$Conf <- as.numeric(nt$Conf)
nt$Yrs <- as.numeric(nt$Yrs)

FranchiseHistory <- nt

FranchiseHistory <- FranchiseHistory %>% 
  mutate(Conference = case_when(
    Franchise %in% c("Atlanta Hawks", "Boston Celtics", "Washington Wizards", "Toronto Raptors", "Philadelphia 76ers",
                     "Orlando Magic", "New York Knicks", "Miami Heat", "Milwaukee Bucks", "Indiana Pacers", 
                     "Detroit Pistons", "Cleveland Cavaliers", "Chicago Bulls", "Charlotte Hornets", "Brooklyn Nets") ~ "EAST",
    TRUE ~ "WEST"
  ))









players_season_stats <- fread("https://s3-ap-southeast-2.amazonaws.com/playerinfomation/Seasons_Stats.csv", data.table = FALSE)
players_season_stats_by_year %>% 
  select(-contains("WS"), -contains("STL%"), -contains("RB%"),-blanl,
         -contains("BPM"), -contains("eFG%"), -contains("AST%"), -contains("BLK%"), 
         -contains("TOV%"), -contains("USG%"), -blank2, -contains("TS%"), 
         -contains("3PAr"), -VORP, -GS, -V1) %>% 
  group_by(Player, Year) %>% 
  mutate(PPG = sum(PTS)/sum(G), RPG = sum(TRB)/sum(G), APG = sum(AST)/sum(G), SPG = sum(STL)/sum(G)) %>% 
  filter(Player == "Stephen Curry") %>% 
  View()


players_season_stats <- fread("https://s3-ap-southeast-2.amazonaws.com/playerinfomation/Seasons_Stats.csv", data.table = FALSE)
players_season_stats %>% 
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
  select(Player, Career, Pos, PPG:SPG)

players_season_stats$Player <- players_season_stats$Player %>% 
  str_remove("\\*")
