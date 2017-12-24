library(dplyr)

mortality <- mortality <- data %>%
  FilterBy("Mortality")

reverseRows <- function(df) {
  df[rev(rownames(df)),]
}

distinct.mortality <- mortality %>%
  reverseRows() %>%
  distinct(Patient.ID, .keep_all = TRUE) %>%
  reverseRows()


#
# lastDistinct <- function(df, x) {
#   aggregate(df, by=list(df[[x]]), FUN = function(x) {  last = tail(x,1) } )
# }
#
# distinct.mortality <- mortality %>%
#   lastDistinct("Patient.ID")


distinct.mortality.2017 <- distinct.mortality %>%
  FilterByYear(2017)
