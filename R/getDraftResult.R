#' Draft Result of a given year
#'
#' Function to get draft result
#'
#' @param year Year number
#'
#' @author Koki Ando <koki.25.ando@gmail.com>
#'
<<<<<<< HEAD
#' @importFrom magrittr %>%
#' 
=======
>>>>>>> a326d2ccc47dec97d5501539f2a2846eed11a994
#' @return This function returns \code{data.frame} including columns:
#' \itemize{
#'  \item #
#'  \item Team
#'  \item Player
#'  \item School
#' }
#' 
#' @seealso \url{http://www.nbadraft.net}
#'
#' @examples
#' \dontrun{
<<<<<<< HEAD
#'   draft09 <- getDraftResult(year = 2018)
=======
#'   draft09 <- getDraftResult(year = 2009)
>>>>>>> a326d2ccc47dec97d5501539f2a2846eed11a994
#'   head(draft09)
#' }
#'
#' @export


getDraftResult <- function (year) {

  tail_url <- ".html"

  if (year >= 2009) {
    head_url <- "http://www.nbadraft.net/nba_final_draft/"
    url <-  paste0(head_url, as.character(year))
  } else {
    head_url <- "http://www.nbadraft.net/nba_draft_history/"
    url <- paste0(head_url, as.character(year), tail_url)
  }

  tables <- xml2::read_html(url) %>%
    rvest::html_table()

  if (year >= 2009) {
    table_1 <- tables[[1]][,c(1:3,7)]
    table_2 <- tables[[1]][,c(9:11,15)]

    table <- dplyr::bind_rows(table_1, table_2)

  } else if (year >= 2000) {
    table_1 <- tables[[1]][,c(1,3:4)]
    table_2 <- tables[[1]][,c(5,7:8)]
    names(table_1) <- c("No.", "Team", "Player")
    names(table_2) <- c("No.", "Team", "Player")

    table <- dplyr::bind_rows(table_1, table_2)

  } else if (year == 1999) {
    table_1 <- tables[[1]]
    names(table_1) <- c("Team", "Player")
    table_1 <- table_1[-1,]
<<<<<<< HEAD
    table_1 <- tidyr::separate(table_1, Team, sep = "\n", into = c("No.", "Team"))
=======
    table_1 <- table_1 %>%
      tidyr::separate(Team, sep = "\n", into = c("No.", "Team"))
>>>>>>> a326d2ccc47dec97d5501539f2a2846eed11a994

    table_2 <- tables[[2]][-1,]
    names(table_2) <- c("Team", "Player", "College")
    table_2 <- table_2 %>%
<<<<<<< HEAD
      tidyr::separate(Team, sep = "\n", into = c("No.", "Team"))
    table_2 <- table_2 %>%
=======
      tidyr::separate(Team, sep = "\n", into = c("No.", "Team")) %>%
>>>>>>> a326d2ccc47dec97d5501539f2a2846eed11a994
      tidyr::unite(Player, College, sep = " ", col = "Player")

    table <- dplyr::bind_rows(table_1, table_2)

  } else {
    table_1 <- tables[[1]][-1,]
    table_2 <- tables[[2]][-1,]

    table <- dplyr::bind_rows(table_1, table_2)
    names(table) <- c("Team", "Player", "College")
  }
  
  table$Team <- stringr::str_remove(table$Team, "\\*")
<<<<<<< HEAD
  table
=======
  return(table)
>>>>>>> a326d2ccc47dec97d5501539f2a2846eed11a994

}
