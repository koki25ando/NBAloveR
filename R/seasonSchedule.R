### seasonSchedule

seasonSchedule <- function (Team, year) {
  base_url <- "https://www.basketball-reference.com/teams/"
  url <- paste0(base_url, str_to_upper(Team), "/", year, "_games.html")
  
  tables <- read_html(url) %>% 
    html_table()
  data.frame(tables[[1]])
}