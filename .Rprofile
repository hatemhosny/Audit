# # local({r <- getOption("repos")
# # r["CRAN"] <- "http://cran.revolutionanalytics.com"
# # options(repos=r)})
#
# ## Do you want to automatically convert strings to factor variables in a data.frame?
# ## WARNING!!! This makes your code less portable/reproducible.
# options(stringsAsFactors=FALSE)
#
# options(max.print=300)
#
# options(scipen=10)
#
# # options(editor="vim")
#
# # options(show.signif.stars=FALSE)
#
# # options(menu.graphics=FALSE)
#
# options(prompt="> ")
# options(continue="... ")
#
# options(width = 130)
#
# # Change the default behavior of “q()” to quit immediately and not save workspace.
# # q <- function (save="no", ...) {
# #   quit(save=save, ...)
# # }
#
# #tab-complete package names for use in “library()” or “require()” calls
# utils::rc.settings(ipck=TRUE)
#
# .First <- function(){
#
#   # save every command run in the console into a history file
#   if(interactive()){
#     library(utils)
#     timestamp(prefix=paste("##------ [",getwd(),"] ",sep=""))
#
#   }
# }
#
# # write all commands used in that session to my R command history file
# .Last <- function(){
#   if(interactive()){
#     hist_file <- Sys.getenv("R_HISTFILE")
#     if(hist_file=="") hist_file <- "~/.RHistory"
#     savehistory(hist_file)
#   }
# }
#
# # Enables the colorized output from R (provided by the colorout package) on appropriate consoles
# if(Sys.getenv("TERM") == "xterm-256color")
#   library("colorout")
#
# # defines a function that loads a libary into the namespace without any warning or startup messages
# sshhh <- function(a.package){
#   suppressWarnings(suppressPackageStartupMessages(
#     library(a.package, character.only=TRUE)))
# }
# #
# # auto.loads <-c("dplyr", "ggplot2")
# #
# # #  This loads the packages in “auto.loads” vector if the R session is interactive
# # if(interactive()){
# #   invisible(sapply(auto.loads, sshhh))
# # }
#
# ## Create a new invisible environment for all the functions to go in so it doesn't clutter your workspace.
# .env <- new.env()
# attach(.env)
#
# ## Strip row names from a data frame
# .env$unrowname <- function(x) {
#   rownames(x) <- NULL
#   x
# }
#
# # defines a function to sanely undo a “factor()” call
# .env$unfactor <- function(df){
#   id <- sapply(df, is.factor)
#   df[id] <- lapply(df[id], as.character)
#   df
# }
#
# message("\n*** Successfully loaded .Rprofile ***\n")
