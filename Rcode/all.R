setwd("/Volumes/data/Dropbox/_COURS/MLAI/JHU/JHU-DS_Spe/10-capstone/swiftKey-trainingset")

# +----------------------------+ #
# |         LIBRARIES          | #
# +----------------------------+ #
library(quanteda) ; library(readtext)
library(ggplot2) ; library(gridExtra)


# +----------------------------+ #
# |      TEST / RESET MEME     | #
# +----------------------------+ #
#library(profr)
#object.size() # get object size in RAM
#Rprof() # profiler to benchmark func
#gc() # freeing up memory


# +----------------------------+ #
# |         GLOBAL VAR         | #
# +----------------------------+ #
setwd("/Volumes/data/Dropbox/_COURS/MLAI/JHU/JHU-DS_Spe/10-capstone/swiftKey-trainingset")

filepath_blogs   <- "dataset/en_US.blogs.sample.txt"
filepath_news    <- "dataset/en_US.news.sample.txt"
filepath_twitter <- "dataset/en_US.twitter.sample.txt"

profanities_url <- 'https://www.freewebheaders.com/download/files/wordpress-comment-blacklist-words-list_text-file_2018-08-17.zip'
download.file(profanities_url, destfile="profanities.zip", method="curl")
profanities <- read.csv(unzip("profanities.zip"), header=F , comment.char='#', colClasses='character')[[1]]


# +----------------------------+ #
# |         FUNCTIONS          | #
# +----------------------------+ #
extractLines <- function (filepath, nb_lines=10) {
    con <- file(filepath, 'r')
    mtext <- readLines(con, nb_lines)
    close(con)
    mtext
}

loadFile2Quanteda <- function (filepath, lang='en_US') {
    print(paste("filename:", filepath))
    print(paste("size:", round(file.info(filepath)$size / 1024^2, 2), "MB"))
    print(paste("nb. lines:", R.utils::countLines(filepath_twitter)))
    #dc <- readtext(filepath)) ; max(nchar(dc))
    corpus <- corpus(readtext(filepath, docvarsfrom='filenames'))
    #metadoc(corpus, "language") <- lang      # useless with docsvarfrom
    #metadoc(corpus, "source")   <- filepath  # useless with docsvarfrom
    corpus
}

plotNgramDfm <- function (ngram_dfm, title='', n=25) {
    ggplot(data=textstat_frequency(ngram_dfm, n=n)[,1:2], 
           aes(y=frequency, x=reorder(feature, -frequency), fill=feature)) +
        geom_bar(stat='identity') + labs(x=title) +
        theme(axis.text.x=element_text(angle = 60, hjust = 1)) + guides(fill=F)
}

coverage <- function (ngram, cover) {
    dfm_freq <- textstat_frequency(dfm(ngram, remove=c(stopwords('english'), profanities)))[,2]
    total <- cover * sum(dfm_freq) ; counts <- 0 ; i <- 1
    while (counts < total | i < length(dfm_freq)) {
        counts <- counts + dfm_freq[i]
        i <- i+1
    }
    i
}

getNgramStats <- function (ngram, top=-1L) {
    dfm_freq <- textstat_frequency(dfm(ngram, remove=c("#*", "@*", profanities)))[,1:2]
    total <- sum(dfm_freq[,2])
    words <- data.frame() ; counts <- 0
    limit <- ifelse(top == -1, dim(dfm_freq)[1], top)
    for (i in 1:limit) {
        counts  <- counts + dfm_freq[i,2][[1]]
        cuts <- strsplit(dfm_freq[i,1][[1]], '_')
        first   <- cuts[1]
        if (length(cuts) > 2) {
            last <- cuts[length(cuts)]
            feature_light <- paste(cuts[1], cuts[length(cuts)], '_')
        } else {
            last <- feature_light <- ''
        }
        words <- rbind(words, data.frame(feature=dfm_freq[i,1][[1]],
                                   feature_light=feature_light,
                                           first=first,
                                            last=last,
                                       frequency=dfm_freq[i,2][[1]], 
                                            prob=dfm_freq[i,2][[1]] / total,
                                         cumfreq=counts,
                                           cover=round(counts/total,2)))
    }
    words
}


# +----------------------------+ #
# |          TEXT EDA          | #
# +----------------------------+ #

# CREATE CORPUS
crps <- loadFile2Quanteda(filepath_blogs)
crps <- crps + loadFile2Quanteda(filepath_news)
crps <- crps + loadFile2Quanteda(filepath_twitter)
summary(crps, showmeta=T)

# TOKENIZATION AND TDM/DFM
tkns_raw   <- tokens(crps)
tkns_clean <- tokens(crps, remove_numbers=T, remove_punct=T)
crps_dfm          <- dfm(crps)
crps_dfm_clean    <- dfm(crps, remove_numbers=T, remove_punct=T)
crps_dfm_twitless <- dfm(crps, remove_numbers=T, remove_punct=T, remove=c('#*', '@*'))
crps_dfm_filter   <- dfm(crps, remove_numbers=T, remove_punct=T, remove=c('#*', '@*', profanities))
crps_dfm_stopword <- dfm(crps, remove_numbers=T, remove_punct=T, remove=c('#*', '@*', profanities, stopwords('english')))

# WORD COUNT
worcount <- data.frame(raw=ntoken(tkns_raw),
                 lowercase=ntoken(crps_dfm),
                   cleaned=ntoken(crps_dfm_clean),
                  twitless=ntoken(crps_dfm_twitless),
                  filtered=ntoken(crps_dfm_filter),
                stopworded=ntoken(crps_dfm_stopword))
# UNIQUE WORDS COUNT
uwordcount <- data.frame(raw=ntype(tkns_raw),
                   lowercase=ntype(crps_dfm),
                     cleaned=ntype(crps_dfm_clean),
                    twitless=ntype(crps_dfm_twitless),
                    filtered=ntype(crps_dfm_filter),
                   stopwords=ntype(crps_dfm_stopword))

# WORD RECURRENCY
cbind(lowercase=textstat_frequency(crps_dfm,          n=10)[,2:1],
       filtered=textstat_frequency(crps_dfm_filter,   n=10)[,2:1],
      stopwords=textstat_frequency(crps_dfm_stopword, n=10)[,2:1])

# CLOUDTAG
textplot_wordcloud(crps_dfm_stopword, max_words = 100)


# +----------------------------+ #
# |           NGRAM            | #
# +----------------------------+ #

# GENERATING N-GRAMS AND DFM
ngram_1 <- tokens_ngrams(tkns_clean, n=1)
ngram_2 <- tokens_ngrams(tkns_clean, n=2)
ngram_3 <- tokens_ngrams(tkns_clean, n=3)
ngram_4 <- tokens_ngrams(tkns_clean, n=4)
ngram_1_dfm <- dfm(ngram_1, remove=c(stopwords('english'), profanities))
ngram_2_dfm <- dfm(ngram_2, remove=c(stopwords('english'), profanities))
ngram_3_dfm <- dfm(ngram_3, remove=c(stopwords('english'), profanities))
ngram_4_dfm <- dfm(ngram_4, remove=c(stopwords('english'), profanities))

# NGRAM COUNTS
ngramcount <- data.frame(bigram=summary(ngram_2)[,1],
                        trigram=summary(ngram_3)[,1],
                      tetragram=summary(ngram_4)[,1])

# PLOTTING TOP NGRAM PER N
pngram_1 <- plotNgramDfm(ngram_1_dfm, "top unigram")
pngram_2 <- plotNgramDfm(ngram_2_dfm, "top bigram")
pngram_3 <- plotNgramDfm(ngram_3_dfm, "top trigram")
pngram_4 <- plotNgramDfm(ngram_4_dfm, "top tetragram")

# PLOTTING TOP NGRAM / SOURCE
pngram_4_blogs   <- plotNgramDfm(ngram_4_dfm[1], "top ngram from blogs")
pngram_4_newbs   <- plotNgramDfm(ngram_4_dfm[2], "top ngram from news")
pngram_4_twitter <- plotNgramDfm(ngram_4_dfm[3], "top ngram from twitter")

# +----------------------------+ #
# |      PROB / COVERAGE       | #
# +----------------------------+ #

# PLOTTING COVERAGE
pcov <- plot(data.frame(words=c(coverage(ngram_1,.5), coverage(ngram_1,.66),  coverage(ngram_1,.75), 
         coverage(ngram_1,.85), coverage(ngram_1,.9), coverage(ngram_1,.99)), coverage=c(50,66,75,85,90,99)), type='l')
