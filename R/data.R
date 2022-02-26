#' players data set
#'
#' Data set of all NBA players
#'
#' @format A data.frame with 13 columns
#' \describe{
#'  \item{Player}{Name of Player}
#'  \item{POS}{Position of given player}
#'  \item{HT}{Height}
#'  \item{WT}{Weight}
#'  \item{Age}{Age}
#'  \item{Teams}{Team(s) the given player belongs to}
#'  \item{GP}{Games played}
#'  \item{YOS}{Year of seasons}
#'  \item{PreDraftTeam}{Pre-draft team}
#'  \item{Draft.Status}{Draft status}
#'  \item{Nationality}{Nationality}
#'  \item{Year}{Year}
#'  \item{RookieYear}{Rookie year}
#' }
#' @source Basketball Real GM
#'
"players"

#' HallOfFame data set
#'
#' Data set of players in the Naismith Memorial Basketball Hall of Fame
#'
#' @format A data.frame with 4 columns
#' \describe{
#'  \item{Year}{Year}
#'  \item{Inductee}{Name of inductee}
#'  \item{Pos}{Position}
#'  \item{Achievements}{Achievements}
#' }
#' @source wikipedia
#'
"HallOfFame"

#' franchise data set
#'
#' Data set of NBA franchises
#'
#' @format A data.frame with 13 columns
#' \describe{
#'  \item{Franchise}{Franchise name}
#'  \item{Lg}{League}
#'  \item{From}{Year the team established}
#'  \item{To}{To year}
#'  \item{Years}{Years}
#'  \item{G}{Games}
#'  \item{W}{Wins}
#'  \item{L}{Losses}
#'  \item{Per}{Win Percentage}
#'  \item{Playoffs}{Playoffs}
#'  \item{Division}{Division titles}
#'  \item{Conference}{Conference titles}
#'  \item{Champions}{Champions}
#' }
#' @source Basketball Reference
#'
"franchise"

#' player_data data set
#'
#' Data set of players information. from https://basketball.realgm.com
#'
#' @format A data.frame with 12 columns
#' \describe{
#'  \item{Player}{PLayer name}
#'  \item{Pos}{Position}
#'  \item{HT}{Height}
#'  \item{WT}{Weight}
#'  \item{Age}{Age}
#'  \item{Teams}{Teams}
#'  \item{GP}{Games Played}
#'  \item{YOS}{Year of season}
#'  \item{Pre-Draft Team}{Pre Draft Team}
#'  \item{Draft Status}{Draft Status}
#'  \item{Nationality}{Nationality}
#'  \item{url}{reference url}
#' }
#' @source RealGM
#'
"player_data"
