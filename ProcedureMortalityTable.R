ProcedureMortalityTable <- function(df, year, interval="month", prefix="Procedures..choice.",
                                    allDf = df) {

  months <- Config$Months.Total.Mean
  quarters <- Config$Quarters.Total.Mean

  if (interval == "quarter") {
    usedInterval <- quarters
    getGroupFn <- GetGroupByQuarter
  } else {
    usedInterval <- months
    getGroupFn <- GetGroup
  }

  groups <- data.frame(row.names = usedInterval)
  groupMortality <- data.frame(row.names = paste(usedInterval, "Mort"))

  procs <- names(select(df, starts_with(prefix)))


  for (proc in procs) {
    groups <- cbind(groups, getGroupFn(allDf, year, list(list(proc, TRUE))))
    groupMortality <- cbind(groupMortality,
                            getGroupFn(allDf, year, list(list(proc, TRUE),
                                                      list("Mortality", TRUE))))
  }

  colnames(groups) <-  procs %>% FixProcedureNames()
  colnames(groupMortality) <-  colnames(groups)
  mergedDataFrame <- rbind(groups, groupMortality)

  Table <- mergedDataFrame %>%
    t() %>%
    as.data.frame()

  Table

}
