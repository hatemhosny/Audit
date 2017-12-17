library(dplyr)

source("filter-by.R")
source("adults-peds.R")


# GetContDescriptives(data)
# GetCatDescriptives(data)
#
# DrawPlots(data)


result <- data %>%
  FilterBy("Surgeon.1", "Hatem Hosny", FALSE) %>%
  FilterBy("Section", "Pediatrics") %>%
  FilterByMonth(2017, 11)

result2 <- data %>%
  FilterBy("Surgeon.1", "Hatem Hosny", FALSE) %>%
  FilterBy("Section", "Pediatrics") %>%
  FilterByMonth(2017, 11)

Aortic.in.nov <- data %>%
  FilterBy("Classification..choice.Aortic.", TRUE) %>%
  FilterByMonth(2017, 11)

table <- AdultsPedsTable(data)
# write.csv(table, "data/table.csv")

