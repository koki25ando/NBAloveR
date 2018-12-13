# NBAloveR

"NBAloveR" is an R package that helps you analyze basketball data easily using statistical software tool, R.

## Installation

```{r}
devtools::install_github("koki25ando/NBAloveR")
library(NBAloveR)
```

## Package Contents

```{r}
getHOF():
getDraftResult():
seasonSchedule():
statsCompare()
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
Data you can get using this package are from [Basketball Reference](https://www.basketball-reference.com/).

## Hands-on Tutorial
Visit [my blog post](http://kokiando.hatenablog.com/entry/2018/09/10/121855) to learn how to use NBAloveR packge!
+ [Introducing "NBAloveR"](http://kokiando.hatenablog.com/entry/2018/09/10/121855)
