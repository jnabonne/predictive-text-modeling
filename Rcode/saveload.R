PATH_RDATA <- "~/Downloads/jhu-ds-capstone/saveRdata/twitter_30k/"

if (MODE == 'save') {
    save(crps,              file=paste(PATH_RDATA, "crps.Rdata",                sep=''))
    
    save(tkns_raw,          file=paste(PATH_RDATA, "tkns_raw.Rdata",            sep=''))
    save(tkns_clean,        file=paste(PATH_RDATA, "tkns_clean.Rdata",          sep=''))
    
    save(crps_dfm,          file=paste(PATH_RDATA, "crps_dfm.Rdata",            sep=''))
    save(crps_dfm_clean,    file=paste(PATH_RDATA, "crps_dfm_clean.Rdata",      sep=''))
    save(crps_dfm_twitless, file=paste(PATH_RDATA, "crps_dfm_twitless",         sep=''))
    save(crps_dfm_filter,   file=paste(PATH_RDATA, "crps_dfm_filter.Rdata",     sep=''))
    save(crps_dfm_stopword, file=paste(PATH_RDATA, "crps_dfm_stopword.Rdata",   sep=''))
    
    save(ngram,             file=paste(PATH_RDATA, "ngram.Rdata",               sep=''))
    save(ngram_1,           file=paste(PATH_RDATA, "ngram_1.Rdata",             sep=''))
    save(ngram_2,           file=paste(PATH_RDATA, "ngram_2.Rdata",             sep=''))
    save(ngram_3,           file=paste(PATH_RDATA, "ngram_3.Rdata",             sep=''))
    save(ngram_4,           file=paste(PATH_RDATA, "ngram_4.Rdata",             sep=''))
    
    save(pngram_1,          file=paste(PATH_RDATA, "pngram_1.Rdata",            sep=''))
    save(pngram_2,          file=paste(PATH_RDATA, "pngram_2.Rdata",            sep=''))
    save(pngram_3,          file=paste(PATH_RDATA, "pngram_3.Rdata",            sep=''))
    save(pngram_4,          file=paste(PATH_RDATA, "pngram_4.Rdata",            sep=''))
    
    save(pngram_1,          file=paste(PATH_RDATA, "pngram_blogs.Rdata",        sep=''))
    save(pngram_2,          file=paste(PATH_RDATA, "pngram_news.Rdata",         sep=''))
    save(pngram_3,          file=paste(PATH_RDATA, "pngram_twitter.Rdata",      sep=''))
    
    save(ngram_dfm,         file=paste(PATH_RDATA, "ngram_dfm.Rdata",           sep=''))
    save(ngram_1_dfm,       file=paste(PATH_RDATA, "ngram_1_dfm.Rdata",         sep=''))
    save(ngram_2_dfm,       file=paste(PATH_RDATA, "ngram_2_dfm.Rdata",         sep=''))
    save(ngram_3_dfm,       file=paste(PATH_RDATA, "ngram_3_dfm.Rdata",         sep=''))
    save(ngram_4_dfm,       file=paste(PATH_RDATA, "ngram_4_dfm.Rdata",         sep=''))
    
    save(ngram_1_stats,     file=paste(PATH_RDATA, "ngram_1_stats.Rdata",       sep=''))
    save(ngram_2_stats,     file=paste(PATH_RDATA, "ngram_2_stats.Rdata",       sep=''))
    save(ngram_3_stats,     file=paste(PATH_RDATA, "ngram_3_stats.Rdata",       sep=''))
    save(ngram_4_stats,     file=paste(PATH_RDATA, "ngram_4_stats.Rdata",       sep=''))
    
    save(ngram_1_stats_slim, file=paste(PATH_RDATA, "ngram_1_stats_slim.Rdata", sep=''))
    save(ngram_2_stats_slim, file=paste(PATH_RDATA, "ngram_2_stats_slim.Rdata", sep=''))
    save(ngram_3_stats_slim, file=paste(PATH_RDATA, "ngram_3_stats_slim.Rdata", sep=''))
    save(ngram_4_stats_slim, file=paste(PATH_RDATA, "ngram_4_stats_slim.Rdata", sep=''))

    save(ngram_1_slim_stats, file=paste(PATH_RDATA, "ngram_1_slim_stats.Rdata", sep=''))
    save(ngram_2_slim_stats, file=paste(PATH_RDATA, "ngram_2_slim_stats.Rdata", sep=''))
    save(ngram_3_slim_stats, file=paste(PATH_RDATA, "ngram_3_slim_stats.Rdata", sep=''))
    save(ngram_4_slim_stats, file=paste(PATH_RDATA, "ngram_4_slim_stats.Rdata", sep=''))
    
# --- from csv
    save(ngram1stats,       file=paste(PATH_RDATA, "from_csv/ngram1stats.Rdata",       sep=''))
    save(ngram2stats,       file=paste(PATH_RDATA, "from_csv/ngram2stats.Rdata",       sep=''))
    save(ngram3stats,       file=paste(PATH_RDATA, "from_csv/ngram3stats.Rdata",       sep=''))
    save(ngram4stats,       file=paste(PATH_RDATA, "from_csv/ngram4stats.Rdata",       sep=''))
    save(ngram1stats_light, file=paste(PATH_RDATA, "from_csv/ngram1stats_light.Rdata", sep=''))
    save(ngram2stats_light, file=paste(PATH_RDATA, "from_csv/ngram2stats_light.Rdata", sep=''))
    save(ngram3stats_light, file=paste(PATH_RDATA, "from_csv/ngram3stats_light.Rdata", sep=''))
    save(ngram4stats_light, file=paste(PATH_RDATA, "from_csv/ngram4stats_light.Rdata", sep=''))
    save(ngram1stats_slim,  file=paste(PATH_RDATA, "from_csv/ngram1stats_slim.Rdata",  sep=''))
    save(ngram2stats_slim,  file=paste(PATH_RDATA, "from_csv/ngram2stats_slim.Rdata",  sep=''))
    save(ngram3stats_slim,  file=paste(PATH_RDATA, "from_csv/ngram3stats_slim.Rdata",  sep=''))
    save(ngram4stats_slim,  file=paste(PATH_RDATA, "from_csv/ngram4stats_slim.Rdata",  sep=''))
}

if (MODE == 'load') {
    tryCatch( {
        load(file=paste(PATH_RDATA, "crps.Rdata",              sep=''), verbose=1)
        
        load(file=paste(PATH_RDATA, "tkns_raw.Rdata",          sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "tkns_clean.Rdata",        sep=''), verbose=1)
        
        load(file=paste(PATH_RDATA, "crps_dfm.Rdata",          sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "crps_dfm_clean.Rdata",    sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "crps_dfm_twitless",       sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "crps_dfm_filter.Rdata",   sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "crps_dfm_stopword.Rdata", sep=''), verbose=1)
        
        load(file=paste(PATH_RDATA, "ngram.Rdata",             sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_1.Rdata",           sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_2.Rdata",           sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_3.Rdata",           sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_4.Rdata",           sep=''), verbose=1)
        
        load(file=paste(PATH_RDATA, "pngram_1.Rdata",          sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "pngram_2.Rdata",          sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "pngram_3.Rdata",          sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "pngram_4.Rdata",          sep=''), verbose=1)
        
        load(file=paste(PATH_RDATA, "pngram_blogs.Rdata",      sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "pngram_news.Rdata",       sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "pngram_twitter.Rdata",    sep=''), verbose=1)
        
        load(file=paste(PATH_RDATA, "ngram_dfm.Rdata",          sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_1_dfm.Rdata",        sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_2_dfm.Rdata",        sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_3_dfm.Rdata",        sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_4_dfm.Rdata",        sep=''), verbose=1)
        
        load(file=paste(PATH_RDATA, "ngram_1_stats.Rdata",      sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_2_stats.Rdata",      sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_3_stats.Rdata",      sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_4_stats.Rdata",      sep=''), verbose=1)
        
        load(file=paste(PATH_RDATA, "ngram_1_stats_slim.Rdata", sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_2_stats_slim.Rdata", sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_3_stats_slim.Rdata", sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_4_stats_slim.Rdata", sep=''), verbose=1)
        
        load(file=paste(PATH_RDATA, "ngram_1_slim_stats.Rdata", sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_2_slim_stats.Rdata", sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_3_slim_stats.Rdata", sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "ngram_4_slim_stats.Rdata", sep=''), verbose=1)
        
# --- from csv
        load(file=paste(PATH_RDATA, "from_csv/ngram1stats_news.Rdata",       sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "from_csv/ngram2stats_news.Rdata",       sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "from_csv/ngram3stats_news.Rdata",       sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "from_csv/ngram4stats_news.Rdata",       sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "from_csv/ngram1stats_news_light.Rdata", sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "from_csv/ngram2stats_news_light.Rdata", sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "from_csv/ngram3stats_news_light.Rdata", sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "from_csv/ngram4stats_news_light.Rdata", sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "from_csv/ngram1stats_news_slim.Rdata",  sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "from_csv/ngram2stats_news_slim.Rdata",  sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "from_csv/ngram3stats_news_slim.Rdata",  sep=''), verbose=1)
        load(file=paste(PATH_RDATA, "from_csv/ngram4stats_news_slim.Rdata",  sep=''), verbose=1)
    }, warning = function(w) {
        print(paste('cannot load some object!'))
    })
}
