# Function to get draft result

getDraftResult <- function (year) {
  
  tail_url <- ".html"
  
  if (year >= 2009) {
    head_url <- "http://www.nbadraft.net/nba_final_draft/"
    url <-  paste0(head_url, as.character(year))
  } else {
    head_url <- "http://www.nbadraft.net/nba_draft_history/"
    url <- paste0(head_url, as.character(year), tail_url)
  }
  
  page <- read_html(url)
  tables <- page %>% 
    html_table()
  
  if (year >= 2009) {
    table_1 <- tables[[1]][,c(1:3,7)]
    table_2 <- tables[[1]][,c(9:11,15)]
    
    table <- bind_rows(table_1, table_2)
    
  } else if (year >= 2000) {
    table_1 <- tables[[1]][,c(1,3:4)]
    table_2 <- tables[[1]][,c(5,7:8)]
    names(table_1) <- c("No.", "Team", "Player")
    names(table_2) <- c("No.", "Team", "Player")
    
    table <- bind_rows(table_1, table_2)
    
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
    
    table <- bind_rows(table_1, table_2)
    
  } else {
    table_1 <- tables[[1]][-1,]
    table_2 <- tables[[2]][-1,]
    
    table <- bind_rows(table_1, table_2)
    names(table) <- c("Team", "Player", "College")
  }
  
  return(table)
 
}


# test
getDraftResult(year = 2009) %>% View()

