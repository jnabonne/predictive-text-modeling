# CORPUS
system.time(crps_blogs      <- loadFile2Quanteda(filepath_blogs,   TRUE))
system.time(crps_news       <- loadFile2Quanteda(filepath_news,    TRUE))
system.time(crps_twitter    <- loadFile2Quanteda(filepath_twitter, TRUE))
crps                        <- crps_blogs + crps_news + crps_twitter
#load(file=paste(PATH_RDATA, "crps/crps.Rdata",   sep=''))

# UNIGRAMS 
system.time({ #  79.550  14.798  89.834 
  ngram1            <- dfm(crps, ngrams=1, remove_numbers=TRUE, remove_punct=TRUE, remove_symbols=TRUE, remove_separators=TRUE, remove_hyphens=TRUE)
  ngram1_trim       <- dfm_trim(          ngram1,         min_term=MIN_FREQ)
  ngram1_filter     <- dfm_select(        ngram1_trim,    c('#*', '@*', profanities), select='remove')
  ngram1_freq       <- data.table(textstat_frequency(ngram1_filter)[,1:2]) })
save(ngram1,              file=paste(PATH_RDATA, "ngram1.Rdata",        sep=''))
save(ngram1_trim,         file=paste(PATH_RDATA, "ngram1_trim.Rdata",   sep=''))
save(ngram1_filter,       file=paste(PATH_RDATA, "ngram1_filter.Rdata", sep=''))
save(ngram1_freq,         file=paste(PATH_RDATA, "ngram1_freq.Rdata",   sep=''))

# UNIGRAMS WITHOUT STOPWORDS
system.time({ # 91.309  11.105  95.684
     ngram1wsw            <- dfm(crps, ngrams=1, remove_numbers=TRUE, remove_punct=TRUE, remove_symbols=TRUE, remove_separators=TRUE, remove_hyphens=TRUE)
     ngram1wsw_trim       <- dfm_trim(ngram1wsw, min_term=MIN_FREQ*2)
     ngram1wsw_SW         <- dfm_select(ngram1wsw_trim, stopwords("english"), selection = "remove", valuetype = "fixed")  # MODIF!
     ngram1wsw_filter     <- dfm_select(ngram1wsw_SW, c('#*', '@*', profanities), select='remove')
     ngram1wsw_freq       <- data.table(textstat_frequency(ngram1wsw_filter)[,1:2]) })
save(ngram1wsw,              file=paste(PATH_RDATA, "ngram1wsw.Rdata",        sep=''))
save(ngram1wsw_trim,         file=paste(PATH_RDATA, "ngram1wsw_trim.Rdata",   sep=''))
save(ngram1wsw_SW,           file=paste(PATH_RDATA, "ngram1wsw_SW.Rdata",     sep=''))
save(ngram1wsw_filter,       file=paste(PATH_RDATA, "ngram1wsw_filter.Rdata", sep=''))
save(ngram1wsw_freq,         file=paste(PATH_RDATA, "ngram1wsw_freq.Rdata",   sep=''))

# BIGRAMS
system.time({ # 373.688  35.744 339.525 
     ngram2            <- dfm(crps, ngrams=2, remove_numbers=TRUE, remove_punct=TRUE, remove_symbols=TRUE, remove_separators=TRUE, remove_hyphens=TRUE)
     ngram2_trim       <- dfm_trim(          ngram2,         min_term=MIN_FREQ)
     ngram2_filter     <- dfm_select(        ngram2_trim,    c('#*', '@*', profanities), select='remove')
     ngram2_freq       <- data.table(textstat_frequency(ngram2_filter)[,1:2]) })
save(ngram2,              file=paste(PATH_RDATA, "ngram2.Rdata",        sep=''))
save(ngram2_trim,         file=paste(PATH_RDATA, "ngram2_trim.Rdata",   sep=''))
save(ngram2_filter,       file=paste(PATH_RDATA, "ngram2_filter.Rdata", sep=''))
save(ngram2_freq,         file=paste(PATH_RDATA, "ngram2_freq.Rdata",   sep=''))

# TRIGRAMS
system.time({ #  911.855  180.478 1013.577 
     ngram3            <- dfm(crps, ngrams=3, remove_numbers=TRUE, remove_punct=TRUE, remove_symbols=TRUE, remove_separators=TRUE, remove_hyphens=TRUE)
     ngram3_trim       <- dfm_trim(          ngram3,         min_term=MIN_FREQ)
     ngram3_filter     <- dfm_select(        ngram3_trim,    c('#*', '@*', profanities), select='remove')
     ngram3_freq       <- data.table(textstat_frequency(ngram3_filter)[,1:2]) })
save(ngram3,              file=paste(PATH_RDATA, "ngram3.Rdata",        sep=''))
save(ngram3_trim,         file=paste(PATH_RDATA, "ngram3_trim.Rdata",   sep=''))
save(ngram3_filter,       file=paste(PATH_RDATA, "ngram3_filter.Rdata", sep=''))
save(ngram3_freq,         file=paste(PATH_RDATA, "ngram3_freq.Rdata",   sep=''))

# TETRAGRAMS
system.time({ # 1472.876  839.670 2584.288 
     ngram4            <- dfm(crps, ngrams=4, remove_numbers=TRUE, remove_punct=TRUE, remove_symbols=TRUE, remove_separators=TRUE, remove_hyphens=TRUE)
     ngram4_trim       <- dfm_trim(          ngram4,         min_term=MIN_FREQ)
     ngram4_filter     <- dfm_select(        ngram4_trim,    c('#*', '@*', profanities), select='remove')
     ngram4_freq       <- data.table(textstat_frequency(ngram4_filter)[,1:2]) })
save(ngram4,              file=paste(PATH_RDATA, "ngram4.Rdata",        sep=''))
save(ngram4_trim,         file=paste(PATH_RDATA, "ngram4_trim.Rdata",   sep=''))
save(ngram4_filter,       file=paste(PATH_RDATA, "ngram4_filter.Rdata", sep=''))
save(ngram4_freq,         file=paste(PATH_RDATA, "ngram4_freq.Rdata",   sep=''))

# PENTAGRAMS
system.time({ #  2844.842  8067.764 15610.563
     ngram5            <- dfm(crps, ngrams=5, remove_numbers=TRUE, remove_punct=TRUE, remove_symbols=TRUE, remove_separators=TRUE, remove_hyphens=TRUE)
     ngram5_trim       <- dfm_trim(          ngram5,         min_term=MIN_FREQ)
     ngram5_filter     <- dfm_select(        ngram5_trim,    c('#*', '@*', profanities), select='remove')
     ngram5_freq       <- data.table(textstat_frequency(ngram5_filter)[,1:2]) })
save(ngram5,              file=paste(PATH_RDATA, "ngram5.Rdata",        sep=''))
save(ngram5_trim,         file=paste(PATH_RDATA, "ngram5_trim.Rdata",   sep=''))
save(ngram5_filter,       file=paste(PATH_RDATA, "ngram5_filter.Rdata", sep=''))
save(ngram5_freq,         file=paste(PATH_RDATA, "ngram5_freq.Rdata",   sep=''))
