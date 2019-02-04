extractLines <- function (filepath, nb_lines=10) {
    con   <- file(filepath, 'r')
    mtext <- readLines(con, nb_lines)
    close(con)
    mtext
}

#' Create a quanteda corpus from the given file
#' optionaly display info about the file'
#' @param filepath the filepath to the file to load
#' @param info a boolean to display or not basic file info
#' @return the quanteda corpus populated with the file
#' @author jnabonne
#' @importFrom quanteda
loadFile2Quanteda <- function (filepath, info=FALSE) {
    print(paste("filename:",  filepath))
    print(paste("size:",      round(file.info(filepath)$size / 1024^2, 2), "MB"))
    print(paste("nb. lines:", R.utils::countLines(filepath)))
    #dc <- readtext(filepath)) ; max(nchar(dc))
    corpus <- corpus(readtext(filepath, docvarsfrom='filenames'))
    #metadoc(corpus, "language") <- lang      # useless with docsvarfrom
    #metadoc(corpus, "source")   <- filepath  # useless with docsvarfrom
    corpus
}

#' Plot a DFM
#' @param dfm the DFM to get features and stats from
#' @param title optional x-axis label override
#' @param n the number of features to plot
#' @author jnabonne
plotNgramDfm <- function (ngram_dfm, title='', n=25) {
    ggplot(data=textstat_frequency(ngram_dfm, n=n)[,1:2], 
            aes(y=frequency, x=reorder(feature, -frequency), fill=feature)) +
            geom_bar(stat='identity') + labs(x=title) +
            theme(axis.text.x=element_text(angle = 60, hjust = 1)) + guides(fill=F)
}

#' Get the number of feature needed to reach the given coverage
#' @param dfm the DFM to get features and stats from
#' @param cover the wanted coverage
#' @return the number of features needed to reach the coverage
#' @author jnabonne
getCoverage <- function (dfm, cover) {
    dfm_freq <- textstat_frequency(dfm)[,2]
    total    <- cover * sum(dfm_freq) ; counts <- 0 ; i <- 1
    while (counts < total | i < length(dfm_freq)) {
        counts <- counts + dfm_freq[i]
        i <- i+1
    }
    i
}

#' Build a complete dt with all required info on ngram based on a dfm completed with prob and cumulative frequency
#' also split features to get firsts and last terms (~ Markov optimization)'
#' @param dfm the ngram' DFM to get features and stats from (also work with token' DFM)
#' @param top the number of top features to consider (default:all)
#' @return a data.table with all info for the ngram
#' @author jnabonne
getDfmStats <- function (dfm, top=-1L) {
    dfm_freq   <- textstat_frequency(dfm)[,1:2]
    total      <- sum(dfm_freq[,2])
    words      <- data.table() ; counts <- 0
    limit      <- ifelse(top == -1, dim(dfm_freq)[1], top)
    for (i in 1:limit) {
        counts <- counts + dfm_freq[i,2][[1]]
        cuts   <- strsplit(dfm_freq[i,1][[1]], '_')[[1]]
        last   <- cuts[length(cuts)]
        firsts <- paste(cuts[1:length(cuts)-1], collapse='_')
        words  <- rbind(words, data.table(stringsAsFactors=F,
                                          feature=dfm_freq[i,1][[1]],
                                           firsts=firsts,
                                             last=as.character(last),
                                        frequency=dfm_freq[i,2][[1]], 
                                             prob=dfm_freq[i,2][[1]] / total,
                                          cumfreq=counts,
                                             cover=round(counts / total, 2)))
    }
    words
}

#' Build a complete dt with all required info on ngram based on a dfm_freqstats 
#' completed with prob and cumulative frequency also split features to get firsts 
#' and last terms (~ Markov optimization)'
#' @param dfm_freq the ngram' DFM to get features and stats from (also work with token' DFM)
#' @param top the number of top features to consider (default:all)
#' @return a data.table with all info for the ngram
#' @author jnabonne
getDfmFreqStats <- function (dfm_freq, top=-1L) {
    #dfm_freq   <- textstat_frequency(dfm)[,1:2]
    total      <- sum(dfm_freq[,2])
    words      <- data.table() ; counts <- 0
    limit      <- ifelse(top == -1, dim(dfm_freq)[1], top)
    for (i in 1:limit) {
        counts <- counts + dfm_freq[i,2][[1]]
        cuts   <- strsplit(dfm_freq[i,1][[1]], '_')[[1]]
        last   <- cuts[length(cuts)]
        firsts <- paste(cuts[1:length(cuts)-1], collapse='_')
        words  <- rbind(words, data.table(stringsAsFactors=F,
                                        # feature=dfm_freq[i,1][[1]],
                                          firsts=firsts,
                                          last=as.character(last),
                                          frequency=dfm_freq[i,2][[1]], 
                                          prob=dfm_freq[i,2][[1]] / total
                                        # cumfreq=counts,
                                        # cover=round(counts / total, 2)
                                        ))
    }
    words
}

#' Complete the data.table containing ngram frequencies with prob and separate terms into firsts/last
#' @param ngram_freq data.table with ngram frequencies
#' @param nlevel the n-level if the ngram
#' @return a data.table with all freq and stats for each ngrams in the data.table
#' @author jnabonne
completeDfmFreqWithStats <- function (ngram_freq, nlevel) {
    total  <- sum(ngram_freq[,2])
    ngram_freq %>% mutate(firsts = word(feature, sep='_',  1, (nlevel-1)),
                          last   = word(feature, sep='_', -1),
                          prob   = frequency / total) %>%
                  select(-feature)
}

#' Read DfmStat+ from a csv file
#' @param filepath filepath to the file
#' @param n the n-level of the ngram
#' @param source just used for output saved Rdata object
#' @param savepath path where to save intermediate R objects (default: PATH_RDATA)
#' @return the dfmstat+ table
#' @author jnabonne
readCsvStats <- function (filepath, n, source, savepath=PATH_RDATA) {
    system.time(ngramstats <- read.csv(file=filepath))
    ngramstats_light <- ngramstats[2:5]
    save(ngramstats,       file=paste(savepath, "/from_csv/ngram", n, 'stats', '_', source, ".Rdata",       sep=''))
    save(ngramstats_light, file=paste(savepath, "/from_csv/ngram", n, 'stats', '_' ,source, "_light.Rdata", sep=''))
    ngramstats_light
}

#' Drop entries under a given frequency or proba
#' @param ngram_stats the data.table containing all stats about a ngram
#' @param min_freq the minimum frequency under which to drop entries
#' @param min_prob the minimum proba under which to drop entries
#' @param mode filter per frequency only (1), per proba only (1) or both (2)
#' @return a data.table with all candidates
#' @author jnabonne
slimStats <- function(ngram_stats, min_freq=MIN_FREQ, min_prob=MIN_PROB, mode=0) {
    size_org <- object.size(ngram_stats)[1]
    if (mode==0 | mode==2) # filter per freq or both
        ngram_stats <- ngram_stats[ngram_stats$frequency >= min_freq,]
    if (mode==1 | mode==2) # filter per prob or both
        ngram_stats <- ngram_stats[ngram_stats$prob >= min_prob,]
    if (DEBUG) print(paste(-round((1-object.size(ngram_stats)[1]/size_org)*100,0), '% reduction'))
    ngram_stats
}

#' Return the n last term of a given string
#' @param input the string to get the n last terms from
#' @param n the number of last terms to retrieve
#' @param sep the separator character for the string (default: '_')
#' @return a string containing only the n last term
#' @author jnabonne
getLastTerms <- function (input, n, sep='_', withnb=FALSE) {
    cuts  <- strsplit(input, sep)[[1]]
    if (n <= 0 | n > length(cuts)) {
        lasts <- ''
        n <- 0
    } else { lasts <- paste(cuts[max((length(cuts)-n+1),0):length(cuts)], collapse='_') }
    if (withnb) c(terms=lasts, length=n)
    else lasts
}

#' Recursive function that Look in all ngram for the best candidates to complete the input sentences
#' for a input of n words it will look in the (n+1)-gram for next possible words (max tetragram)
#' it will then "backoff" with a recursive call to inferior ngram until the unigram
#' @param input sentence to complete with a next word (format a_b_c)
#' @param penalty the penalty for stupid-backoff (should not be set, used internaly during the recurrence)
#' @return a data.table with all candidates
#' @author jnabonne
getCandidates <- function (input, penalty=0) {
    candidates <- data.table()
    # get level to work with (n last words with (n+1)-gram)
    n_level <- sapply(strsplit(input, '_'), length)
    #print(paste(input, nb_lasts, penalty, sep=' / '))
    
    # select which ngram to look
    if (n_level >= 4) xgramstats <- STATS_NGRAM5 else { 
        if (n_level >= 3) xgramstats <- STATS_NGRAM4 else { 
            if (n_level >= 2) xgramstats <- STATS_NGRAM3 else { 
                if (n_level >= 1) xgramstats <- STATS_NGRAM2 else 
                    xgramstats <- STATS_NGRAM1 }}}
    # get best candidate (if any) and add it to our table (updating prob with penalty)
    candidate  <- xgramstats[xgramstats$firsts == input, c('last', 'prob')][1,]
    if (!is.na(candidate$last)) {
        candidates <- rbind(candidates,
                            data.table(terms=input, n_level, penalty,
                                       candidate,
                                       prob2= ifelse(penalty==0, candidate$prob, candidate$prob*penalty)))
    }
    
    # recursive call to get candidate for n-1 last terms in (n-1)gram
    if (n_level > 1) candidates <- rbind(candidates, 
                                         getCandidates(getLastTerms(input, n_level-1), ifelse(penalty==0, PENALTY, penalty^2)))
    # if no results, we return most frequent word in corpus
    else if (dim(candidates)[1] == 0) {
        penalty    <- ifelse(n_level==0, 0, ifelse(penalty==0, PENALTY, penalty^2))
        default    <- STATS_NGRAM1[c('last', 'prob')][1,]
        candidates <- rbind(candidates, data.table(terms=NA, n_level=0, penalty, default, 
                                                   prob2= ifelse(penalty==0, default$prob, default$prob*penalty)))
    }
    
    # return dt with all candidates
    candidates
}

#' Debug function to quickly find a phrases (a_b_c format) within all 4 ngrams stats
#' @param terms the terms to look for
#' @return a data.table with all occurence found
#' @author jnabonne
quickFindOLD <- function (terms) {
    rbind(data.table(firsts='5', last='', frequency=NA, prob=NA), 
          STATS_NGRAM5[grep(terms, STATS_NGRAM5$firsts),],
          data.table(firsts='4', last='', frequency=NA, prob=NA), 
          STATS_NGRAM4[grep(terms, STATS_NGRAM4$firsts),],
          data.table(firsts='3', last='', frequency=NA, prob=NA), 
          STATS_NGRAM3[grep(terms, STATS_NGRAM3$firsts),],
          data.table(firsts='2', last='', frequency=NA, prob=NA), 
          STATS_NGRAM2[grep(terms, STATS_NGRAM2$firsts),],
          data.table(firsts='1', last='', frequency=NA, prob=NA), 
          STATS_NGRAM1[grep(terms, STATS_NGRAM1$firsts),]
          )
}

#' Debug function to quickly find a phrases (a_b_c format) within all 4 ngrams stats
#' @param terms the terms to look for
#' #param idx q boolean
#' @return a data.table with all occurence found
#' @author jnabonne
quickFind <- function (terms, inpred=FALSE, idx=FALSE, res=2:3) {
  ncol <- ifelse(inpred, 3, 2) # 2=firsts / 3=last
  if (idx)
    rbind(ngram5=head(grep(terms, STATS_NGRAM5[,ncol])),
          ngram4=head(grep(terms, STATS_NGRAM4[,ncol])),
          ngram3=head(grep(terms, STATS_NGRAM3[,ncol])),
          ngram2=head(grep(terms, STATS_NGRAM2[,ncol])),
          ngram1=head(grep(terms, STATS_NGRAM1[,ncol]))
          )
  else
    rbind(ngram5=head(STATS_NGRAM5[grep(terms, STATS_NGRAM5[,ncol]),][res]),
          ngram4=head(STATS_NGRAM4[grep(terms, STATS_NGRAM4[,ncol]),][res]),
          ngram3=head(STATS_NGRAM3[grep(terms, STATS_NGRAM3[,ncol]),][res]),
          ngram2=head(STATS_NGRAM2[grep(terms, STATS_NGRAM2[,ncol]),][res]),
          ngram1=head(STATS_NGRAM1[grep(terms, STATS_NGRAM1[,ncol]),][res])
         )
}

translateSpaces <- function (terms, new_sep='_', old_sep=' ') {
    tolower(paste(strsplit(terms, old_sep)[[1]], collapse=new_sep))
}
