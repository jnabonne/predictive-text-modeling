setwd("/Volumes/data/Dropbox/_COURS/MLAI/JHU/JHU-DS_Spe/10-capstone/workspace")

# --- LIBRARIES --- #
library(quanteda)   ; library(readtext)  # nlp library
library(data.table) ; library(dplyr) ; library(stringr)  # data manip
library(ggplot2)    ; library(gridExtra)  # plotting


# --- GLOBAL VAR --- #

#PATH_BASE    <- "~/Downloads/jhu-ds-capstone/"
PATH_BASE    <- "/Volumes/data/Documents/"
PATH_DATASET <- paste(PATH_BASE, "dataset/",        sep='')
PATH_RDATA   <- paste(PATH_BASE, "saveRdata/ddfm/", sep='')
PATH_MODELS  <- paste(PATH_BASE, "models/",         sep='')

DEBUG        <- TRUE
PLOTS_NGRAM  <- FALSE

MIN_FREQ     <- 4
MIN_PROB     <- 0
PENALTY      <- 0.4

# --- PATHS PROJECT RESSOURCES --- #
filepath_blogs   <- paste(PATH_DATASET, "en_US.blogs.txt",   sep='')
filepath_news    <- paste(PATH_DATASET, "en_US.news.txt",    sep='')
filepath_twitter <- paste(PATH_DATASET, "en_US.twitter.txt", sep='')

#profanities_url <- 'https://www.freewebheaders.com/download/files/wordpress-comment-blacklist-words-list_text-file_2018-08-17.zip'
#download.file(profanities_url, destfile="profanities.zip", method="curl")
profanities <- read.csv(unzip("profanities.zip"), header=F , comment.char='#', colClasses='character')[[1]]


# --- TEST / RESET MEME --- #
# library(profr)
# object.size() # get object size in RAM
# Rprof() # profiler to benchmark func
gc() # freeing up memory
