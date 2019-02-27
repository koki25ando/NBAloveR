#' Players data set
#'
#' Data set of all NBA players
#'
#' @format A data.frame with 13 columns
#' \describe{
#' \item{Player}{Name of Player}
#' \item{POS}{Position of given player}
#' \item{HT}{Height}
#' \item{WT}{Weight}
#' \item{Age}{Age}
#' \item{Teams}{Team(s) the given player belongs to}
#' \item{GP}{Games played}
#' \item{YOS}{Year of seasons}
#' \item{PreDraftTeam}{Pre-draft team}
#' \item{Draft.Status}{Draft status}
#' \item{Nationality}{Nationality}
#' \item{Year}{Year}
#' \item{RookieYear}{Rookie year}
#' }
#' @source Basketball Real GM
#'
"players"

#' Data set of players in the Naismith Memorial Basketball Hall of Fame
#'
#' @format A data.frame with 4 columns
#' \describe{
#' \item{Year}{Year}
#' \item{Inductee}{Name of inductee}
#' \item{Pos}{Position}
#' \item{Achievements}{Achievements}
#' }
#' @source wikipedia
#' 
"HallOfFame"

#' Data set of NBA franchises
#' 
#' @format A data.frame with 13 columns
#' \descrive{
#' \item{Franchise}{Franchise name}
#' \item{Lg}{League}
#' \item{From}{Year the team established}
#' \item{To}{To year}
#' \item{Years}{Years}
#' \item{G}{Games}
#' \item{W}{Wins}
#' \item{L}{Losses}
#' \item{Per}{Win Percentage}
#' \item{Playoffs}{Playoffs}
#' \item{Division}{Division titles}
#' \item{Conference}{Conference titles}
#' \item{Champions}{Champions}
#' }
#' @source Basketball Reference
#'
"franchise"
