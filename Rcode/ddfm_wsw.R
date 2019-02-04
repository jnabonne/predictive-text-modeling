# CORPUS
system.time(crps_blogs      <- loadFile2Quanteda(filepath_blogs,   TRUE))
system.time(crps_news       <- loadFile2Quanteda(filepath_news,    TRUE))
system.time(crps_twitter    <- loadFile2Quanteda(filepath_twitter, TRUE))
crps                        <- crps_blogs + crps_news + crps_twitter
#load(file=paste(PATH_RDATA, "crps/crps.Rdata",   sep=''))

# UNIGRAMS WITHOUT STOPWORDS
system.time({ # 5.590   0.179   4.808
     load(file=paste(PATH_RDATA, "ngram1_trim.Rdata", sep=''))
     ngram1wsw_SW         <- dfm_select(ngram1_trim, stopwords("english"), selection = "remove", valuetype = "fixed")
     ngram1wsw_filter     <- dfm_select(ngram1wsw_SW, c('#*', '@*', profanities), select='remove')
     ngram1wsw_freq       <- data.table(textstat_frequency(ngram1wsw_filter)[,1:2])
})
save(ngram1wsw_SW,           file=paste(PATH_RDATA, "ngram1wsw_SW.Rdata",     sep=''))
save(ngram1wsw_filter,       file=paste(PATH_RDATA, "ngram1wsw_filter.Rdata", sep=''))
save(ngram1wsw_freq,         file=paste(PATH_RDATA, "ngram1wsw_freq.Rdata",   sep=''))

# BIGRAMS WITHOUT STOPWORDS
system.time({ # 70.947   2.205  71.238
     load(file=paste(PATH_RDATA, "ngram2_trim.Rdata", sep=''))
     ngram2wsw_SW         <- dfm_select(ngram2_trim, stopwords("english"), selection = "remove", valuetype = "fixed")
     ngram2wsw_filter     <- dfm_select(ngram2wsw_SW, c('#*', '@*', profanities), select='remove')
     ngram2wsw_freq       <- data.table(textstat_frequency(ngram2wsw_filter)[,1:2])
})
save(ngram2wsw_SW,           file=paste(PATH_RDATA, "ngram2wsw_SW.Rdata",     sep=''))
save(ngram2wsw_filter,       file=paste(PATH_RDATA, "ngram2wsw_filter.Rdata", sep=''))
save(ngram2wsw_freq,         file=paste(PATH_RDATA, "ngram2wsw_freq.Rdata",   sep=''))

# TRIGRAMS WITHOUT STOPWORDS
system.time({ # 99.044   3.535 100.794
     load(file=paste(PATH_RDATA, "ngram3_trim.Rdata", sep=''))
     ngram3wsw_SW         <- dfm_select(ngram3_trim, stopwords("english"), selection = "remove", valuetype = "fixed")
     ngram3wsw_filter     <- dfm_select(ngram3wsw_SW, c('#*', '@*', profanities), select='remove')
     ngram3wsw_freq       <- data.table(textstat_frequency(ngram3wsw_filter)[,1:2])
})
save(ngram3wsw_SW,           file=paste(PATH_RDATA, "ngram3wsw_SW.Rdata",     sep=''))
save(ngram3wsw_filter,       file=paste(PATH_RDATA, "ngram3wsw_filter.Rdata", sep=''))
save(ngram3wsw_freq,         file=paste(PATH_RDATA, "ngram3wsw_freq.Rdata",   sep=''))

# TETRAGRAMS WITHOUT STOPWORDS
system.time({ # 52.599   2.049  52.941
     load(file=paste(PATH_RDATA, "ngram4_trim.Rdata", sep=''))
     ngram4wsw_SW         <- dfm_select(ngram4_trim, stopwords("english"), selection = "remove", valuetype = "fixed")
     ngram4wsw_filter     <- dfm_select(ngram4wsw_SW, c('#*', '@*', profanities), select='remove')
     ngram4wsw_freq       <- data.table(textstat_frequency(ngram4wsw_filter)[,1:2])
})
save(ngram4wsw_SW,           file=paste(PATH_RDATA, "ngram4wsw_SW.Rdata",     sep=''))
save(ngram4wsw_filter,       file=paste(PATH_RDATA, "ngram4wsw_filter.Rdata", sep=''))
save(ngram4wsw_freq,         file=paste(PATH_RDATA, "ngram4wsw_freq.Rdata",   sep=''))

# PENTAGRAMS WITHOUT STOPWORDS
system.time({ # 19.687   0.655  18.856
     load(file=paste(PATH_RDATA, "ngram5_trim.Rdata", sep=''))
     ngram5wsw_SW         <- dfm_select(ngram5_trim, stopwords("english"), selection = "remove", valuetype = "fixed")
     ngram5wsw_filter     <- dfm_select(ngram5wsw_SW, c('#*', '@*', profanities), select='remove')
     ngram5wsw_freq       <- data.table(textstat_frequency(ngram5wsw_filter)[,1:2])
})
save(ngram5wsw_SW,           file=paste(PATH_RDATA, "ngram5wsw_SW.Rdata",     sep=''))
save(ngram5wsw_filter,       file=paste(PATH_RDATA, "ngram5wsw_filter.Rdata", sep=''))
save(ngram5wsw_freq,         file=paste(PATH_RDATA, "ngram5wsw_freq.Rdata",   sep=''))
