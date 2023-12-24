# Долгодворова Маша, ДЗ 6

library('plyr')

baseballTeamsSorted = table(baseball["team"])[table(baseball["team"]) >= 200]

new = list()
for(i in 1:length(baseball$team)){
  element = is.element(baseball$team[i], names(baseballTeamsSorted))
  new = append(new, element)
}


allTeams = baseball[c(as.vector(unlist(new))), ]
allTeams
length(allTeams[, 1])

allTeamsNames = unique(allTeams$team)

x = matrix(1:512, nrow=length(allTeamsNames), ncol=length(allTeamsNames), dimnames = list(allTeamsNames, allTeamsNames))

for (i in 1:length(allTeamsNames)) {
  for (j in 1:length(allTeamsNames)) {
    idFirst = unique(allTeams[allTeams$team == allTeamsNames[i],]$id)
    idSecond = unique(allTeams[allTeams$team == allTeamsNames[j],]$id)
    idTeams = length(intersect(idFirst, idSecond))
    
    if (length(idFirst) > length(idSecond)) {
      x[allTeamsNames[i], allTeamsNames[j]] = 1 - idTeams/length(idSecond)
    }
    else {
      x[allTeamsNames[i], allTeamsNames[j]] = 1 - idTeams/length(idFirst)
    }
  }
}

x

mds = cmdscale(x, k=2)
plot(mds, pch=19, cex = diag(mds)/max(diag(mds)))
text(mds, rownames(mds), adj=c(1.2,1.2), col='red')
