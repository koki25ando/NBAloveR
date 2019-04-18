# Utilities

player_key_generation = function(input){
  head_url = "https://www.basketball-reference.com/players/"
  end_num = "01"
  tail_url = paste0(substr(strsplit(input, " ")[[1]][2], 0,1), "/",
                    substr(strsplit(input, " ")[[1]][2], 1,5),
                    substr(strsplit(input, " ")[[1]][1], 0,2),
                    end_num) %>% 
    stringr::str_to_lower()
  player_url = paste0(head_url, tail_url, ".html/")
  
  name_on_page = xml2::read_html(player_url) %>% 
    rvest::html_nodes("div.players") %>% 
    rvest::html_nodes("[itemprop = name]") %>% 
    rvest::html_text()
  
  if (input == name_on_page){
    player_key = tail_url
  } else {
    player_key = stringr::str_replace(tail_url, "01", "02")
  }
  
  return(player_key)
}
