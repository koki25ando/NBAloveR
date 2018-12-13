# setwd("/Users/KokiAndo/desktop/R/NBAloveR")

devtools::install_github("koki25ando/NBAloveR")
library(tidyverse)
library(NBAloveR)

statsCompare(player_list = c("Kobe Bryant", "LeBron James", "Kevin Durant"), Age=TRUE)

player_list = c("Kobe Bryant", "LeBron James", "Kevin Durant")

player_key_list = list()
plyaer_career = list()
head_url = "https://www.basketball-reference.com/players/"
tail_url = "01.html"

for (i in 1:length(player_list)){
  player_key_list[i] <- paste0(substr(strsplit(player_list[i], " ")[[1]][2], 0,1), "/",
                               substr(strsplit(player_list[i], " ")[[1]][2], 1,5),
                               substr(player_list[i], 1,2)) %>%
    str_to_lower()
}

for (i in 1:length(player_key_list)){
  plyaer_career[i] <- paste0(head_url, player_key_list[[i]][1], tail_url) %>%
    xml2::read_html() %>%
    rvest::html_table()
  # plyaer_career[[i]] <- plyaer_career[[i]] %>%
  #   filter(Age != "NA") %>%
  #   plyr::mutate(Player = player_list[[i]])
  plyaer_career[[i]] <- plyaer_career[[i]] %>%
    filter(Age != "NA")
  
}

for (i in 1:length(plyaer_career)){
  plyaer_career[[i]]$Name = player_list[i]
  print(plyaer_career)
}

player_list[1]
