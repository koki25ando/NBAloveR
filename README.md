# NBAloveR

"NBAloveR" is an R package that helps you analyze basketball data easily using statistical software tool, R.

[koki25ando/NBAloveR](https://rdrr.io/github/koki25ando/NBAloveR/)

## Installation

```{r}
devtools::install_github("koki25ando/NBAloveR")
library(NBAloveR)
```

## Package Contents

```{r}
# New functions!!!
getHOF(): Function for getting list of Hall of Famers in NBA & WNBA history
getDraftResult(year): Function for getting draft results of each year
seasonSchedule(Team, year): Function for getting schedules and result of each game per season
statsCompare(player_list, Age): Function to compare selected players' PPG. Currently this is the only function which provides simple visualization.
getStandings(year, conf): Function for getting data of standings per season
```

```{r}
getPlayers(): Function for getting all NBA players' information: name, heigh/weight, college, birth year, birth place
getFranchise(): Function for getting team list
getStats(): Function for getting stats data for each player divided by season
getStatsSummary(Name): Function for getting given player's career summary stats
getTeamSalary(team_code): Function that allows you to get players7 salary data per each NBA team
getTeamHistory(team_code): Function that allows you to get team history data
```

## Data Source
Data you can get using this package are from following websites.
+ [Basketball Reference](https://www.basketball-reference.com/)
+ [nbadraft.net](https://www.nbadraft.net)
+ [RealGM](https://basketball.realgm.com/)

## Hands-on Tutorial
Visit [my blog post](http://kokiando.hatenablog.com/entry/2018/09/10/121855) to learn how to use NBAloveR packge!
+ [Introducing "NBAloveR"](http://kokiando.hatenablog.com/entry/2018/09/10/121855)
+ [NBAloveR is now updated!](http://kokiando.hatenablog.com/entry/2018/12/23/202938)
