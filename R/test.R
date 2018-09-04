players_season_stats %>% 
  as.tibble()


players_season_stats$Year %>% 
  summary


## GET team history
url <- "https://www.basketball-reference.com/teams/HOU/"

library(rvest)
page <- read_html(url)
page %>% 
  html_table()

getTeamHistory()

