SurgeonTable <- function(df, year, interval = "month") {

  months <- Config$Months.Total.Mean
  quarters <- Config$Quarters.Total.Mean

  if (interval == "quarter") {
    usedInterval <- quarters
    getGroupFn <- GetGroupByQuarter
  } else {
    usedInterval <- months
    getGroupFn <- GetGroup
  }

  Magdi_Yacoub <- getGroupFn(df, year, list(list("Surgeon.1", "Prof. Magdi Yacoub")))
  Carin_van_Doorn <- getGroupFn(df, year, list(list("Surgeon.1", "Carin van Doorn")))
  Ahmed_Afifi <- getGroupFn(df, year, list(list("Surgeon.1", "Ahmed Afifi")))
  Ahmed_Shazly <- getGroupFn(df, year, list(list("Surgeon.1", "Ahmed Shazly")))
  Hatem_Hosny <- getGroupFn(df, year, list(list("Surgeon.1", "Hatem Hosny")))
  Walid_Simry <- getGroupFn(df, year, list(list("Surgeon.1", "Walid Simry")))
  Ahmed_Mahgoub <- getGroupFn(df, year, list(list("Surgeon.1", "Ahmed Mahgoub")))


  surgeonTable <- data.frame(Magdi_Yacoub, Carin_van_Doorn, Ahmed_Afifi, Ahmed_Shazly,
                             Hatem_Hosny, Walid_Simry, Ahmed_Mahgoub, row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  surgeonTable
}


