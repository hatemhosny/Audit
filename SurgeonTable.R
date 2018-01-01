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


  Table <- data.frame(Magdi.Yacoub, Carin.van.Doorn, Ahmed.Afifi, Ahmed.Shazly,
                      Hatem.Hosny, Walid.Simry, Ahmed.Mahgoub, row.names = usedInterval) %>%
    t() %>%
    as.data.frame()

  row.names(Table) <- row.names(Table) %>%
    gsub(pattern = ".", replacement = " ", fixed = TRUE)

  Table
}


