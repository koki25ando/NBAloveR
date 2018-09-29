# Function to get draft result

getDraftResult <- function (year) {
  
  head_url <- "http://www.nbadraft.net/nba_draft_history/"
  tail_url <- ".html"
  url <- paste0(head_url, as.character(year), tail_url)
  
  page <- read_html(url)
  tables <- page %>% 
    html_table()
  
  if (year >= 2000) {
    table_1 <- tables[[1]][,c(1,3:4)]
    table_2 <- tables[[1]][,c(5,7:8)]
    names(table_1) <- c("No.", "Team", "Player")
    names(table_2) <- c("No.", "Team", "Player")
    
    bind_rows(table_1, table_2)
    
  } else if (year == 1999) {
    table_1 <- tables[[1]]
    names(table_1) <- c("Team", "Player")
    table_1 <- table_1[-1,]
    table_1 <- table_1 %>% 
      separate(Team, sep = "\n", into = c("No.", "Team"))
    
    table_2 <- tables[[2]][-1,]
    names(table_2) <- c("Team", "Player", "College")
    table_2 <- table_2 %>% 
      separate(Team, sep = "\n", into = c("No.", "Team")) %>% 
      unite(Player, College, sep = " ", col = "Player")
    
    bind_rows(table_1, table_2)
  } else {
    table_1 <- tables[[1]][-1,]
    table_2 <- tables[[2]][-1,]
    
    bind_rows(table_1, table_2)
  }
  
}


# test
getDraftResult(year = 2017)

url <- "http://www.nbadraft.net/nba_draft_history/1990.html"
