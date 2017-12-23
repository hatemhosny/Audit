RemoveStepProcedures <- function(df) {
  df <- df %>%
    within(Procedures..choice.ASD.Closure.[Procedures..choice.Arterial.switch. == TRUE] <- FALSE) %>%
    within(Procedures..choice.PDA.Closure.[Procedures..choice.Arterial.switch. == TRUE] <- FALSE) %>%
    within(Procedures..choice.VSD.Closure.[Procedures..choice.Fallot.Repair. == TRUE] <- FALSE)
  df
}
