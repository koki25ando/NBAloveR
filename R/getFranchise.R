# Function for getting Franchises' data
# Founded year, W/L percentage, number of division/conf/league championship

# Package
library(tidyverse)

## Franchise data history
getFranchise <- function(conf){
  FranchiseHistory <- read.csv("https://s3-ap-southeast-2.amazonaws.com/koki25ando/NBA_Franchise.csv")
  FranchiseHistory %>% 
    select(Franchise:Conference) %>% 
    filter(Conference == conf)
}



## Example
# west <- getFranchise(conf = "WEST")
# west %>% 
#   as.tibble()
