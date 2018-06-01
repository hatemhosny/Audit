ProceduresTable <- function(df, year, interval="month", allDf = df, prefix="Procedures..choice.") {

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
  procs <- names(select(df, starts_with(prefix)))


  for (proc in procs) {
    groups <- cbind(groups, getGroupFn(df, year, list(list(proc, TRUE))))
  }

  colnames(groups) <-  procs %>% FixProcedureNames()

  Table <- groups %>%
    t() %>%
    as.data.frame()

  Table
}
