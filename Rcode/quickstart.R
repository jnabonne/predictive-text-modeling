# SET GLOBAL ENV & PATHS
#filepath_blogs   <- "~/Downloads/jhu-ds-capstone/dataset/en_US.blogs.1k.txt"
#filepath_news    <- "~/Downloads/jhu-ds-capstone/dataset/en_US.news.1k.txt"
filepath <- filepath_twitter <- "~/Downloads/jhu-ds-capstone/dataset/en_US.twitter.30k.txt"
# crps <-        loadFile2Quanteda(filepath_blogs,   TRUE)
# crps <- crps + loadFile2Quanteda(filepath_news,    TRUE)
# crps <- crps + loadFile2Quanteda(filepath_twitter, TRUE)

# LOAD SHIT
system.time(crps        <- loadFile2Quanteda(filepath, TRUE))
system.time(tkns_clean  <- tokens(crps, remove_numbers=T, remove_punct=T))
system.time(ngram_1     <- tokens_ngrams(tkns_clean, n=1))
system.time(ngram_2     <- tokens_ngrams(tkns_clean, n=2))
system.time(ngram_3     <- tokens_ngrams(tkns_clean, n=3))
system.time(ngram_4     <- tokens_ngrams(tkns_clean, n=4))
system.time(ngram_1_dfm <- dfm(ngram_1, remove=c('#*', '@*', profanities)))
system.time(ngram_2_dfm <- dfm(ngram_2, remove=c('#*', '@*', profanities)))
system.time(ngram_3_dfm <- dfm(ngram_3, remove=c('#*', '@*', profanities)))
system.time(ngram_4_dfm <- dfm(ngram_4, remove=c('#*', '@*', profanities)))

system.time(ngram_1_stats <- getDfmStats(ngram_1_dfm))
system.time(ngram_2_stats <- getDfmStats(ngram_2_dfm))
system.time(ngram_3_stats <- getDfmStats(ngram_3_dfm))
system.time(ngram_4_stats <- getDfmStats(ngram_4_dfm))

# CLEAN ALL BUT NGRAM_X_STATS
rm(filepath_blogs, filepath_news, filepath_twitter)
rm(crps, tkns_clean)
rm(ngram_1, ngram_2, ngram_3, ngram_4)
rm(profanities_url, profanities)
rm(ngram_1_dfm, ngram_2_dfm, ngram_3_dfm, ngram_4_dfm)
#rm(extractLines, getCoverage, loadFile2Quanteda, plotNgramDfm, getDfmStats)
