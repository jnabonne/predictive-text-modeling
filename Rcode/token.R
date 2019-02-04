# TOKENIZATION AND TDM/DFM
tkns_raw          <- tokens(crps)
tkns_clean        <- tokens(crps, remove_numbers=T, remove_punct=T)
crps_dfm          <- dfm(crps)
crps_dfm_clean    <- dfm(crps, remove_numbers=T, remove_punct=T)
crps_dfm_twitless <- dfm(crps, remove_numbers=T, remove_punct=T, remove=c('#*', '@*'))
crps_dfm_filter   <- dfm(crps, remove_numbers=T, remove_punct=T, remove=c('#*', '@*', profanities))
crps_dfm_stopword <- dfm(crps, remove_numbers=T, remove_punct=T, remove=c('#*', '@*', profanities, stopwords('english')))

# WORD COUNT
cbind(raw=ntoken(tkns_raw),
                 lowercase=ntoken(crps_dfm),
                   cleaned=ntoken(crps_dfm_clean),
                  twitless=ntoken(crps_dfm_twitless),
                  filtered=ntoken(crps_dfm_filter),
                stopworded=ntoken(crps_dfm_stopword))
# UNIQUE WORDS COUNT
cbind(raw=ntype(tkns_raw),
      lowercase=ntype(crps_dfm),
      cleaned=ntype(crps_dfm_clean),
      twitless=ntype(crps_dfm_twitless),
      filtered=ntype(crps_dfm_filter),
      stopwords=ntype(crps_dfm_stopword))

# WORD RECURRENCY
cbind(lowercase=textstat_frequency(crps_dfm,          n=10)[,2:1],
      filtered=textstat_frequency(crps_dfm_filter,    n=10)[,2:1],
      stopwords=textstat_frequency(crps_dfm_stopword, n=10)[,2:1])

# CLOUDTAG
textplot_wordcloud(crps_dfm_stopword, max_words = 100)


# CLEANING
#rm(tkns_raw)
#rm(crps_dfm, crps_dfm_clean, crps_dfm_twitless, crps_dfm_filter, crps_dfm_stopword)