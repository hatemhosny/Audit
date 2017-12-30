FixMortality <- function(df) {

	reverseRows <- function(df) {
		df[rev(rownames(df)),]
	}

	mortality <- df %>%
		FilterBy("Mortality") %>%
		reverseRows() %>%
		distinct(Patient.ID, .keep_all = TRUE) %>%
		reverseRows()

  # Alternative method to remove duplicate mortality entries for the same patient
  #
	# lastDistinct <- function(df, x) {
	#   aggregate(df, by=list(df[[x]]), FUN = function(x) {  last = tail(x,1) } )
	# }
	# distinct.mortality <- mortality %>%
	#   lastDistinct("Patient.ID")

	df$Mortality <- mortality[match(df$Record.ID, mortality$Record.ID), "Mortality"]
	df$Mortality[is.na(df$Mortality)] <- FALSE

	df$Date.of.mortality. <- mortality[match(df$Record.ID, mortality$Record.ID), "Date.of.mortality."]
	df$Date.of.mortality.[is.na(df$Date.of.mortality.)] <- ""

	df$Cause.of.mortality. <- mortality[match(df$Record.ID, mortality$Record.ID), "Cause.of.mortality."]
	df$Cause.of.mortality.[is.na(df$Cause.of.mortality.)] <- ""

  df
}
