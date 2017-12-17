source("FilterBy.R")

GetProcedureAssociations <- function(df, prefix = "Procedures..choice.") {

  procs <- names(select(df, starts_with(prefix)))

  relation <- data.frame(from=character(), to=character(), weight=integer(), stringsAsFactors=FALSE)
  for(i in 1:length(procs)) {
    x <- i
    selfCount <- 0
    filter1 <- FilterBy(df, procs[i], TRUE)
    for(j in x:length(procs)) {
      rowCount <- nrow(FilterBy(filter1, procs[j], TRUE))
      relation <- rbind(relation, data.frame(from=procs[i], to=procs[j], weight=rowCount))
      if (j == i) {
        selfCount <- rowCount
      }
    }
      relationToOthers <- filter(relation, from == procs[i] & to != procs[i])
      relation[relation$from == procs[i] & relation$to == procs[i],3] <-
        selfCount - sum(relationToOthers$weight)
  }
  relation
}
