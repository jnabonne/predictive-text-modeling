# GENERATING N-GRAMS
ngram   <- tokens_ngrams(tkns_clean, n=2:4)
ngram_1 <- tokens_ngrams(tkns_clean, n=1)
ngram_2 <- tokens_ngrams(tkns_clean, n=2)
ngram_3 <- tokens_ngrams(tkns_clean, n=3)
ngram_4 <- tokens_ngrams(tkns_clean, n=4)

# GENERATING DFM
ngram_dfm   <- dfm(ngram,   remove=c('#*', '@*', profanities))
ngram_1_dfm <- dfm(ngram_1, remove=c('#*', '@*', profanities))
ngram_2_dfm <- dfm(ngram_2, remove=c('#*', '@*', profanities))
ngram_3_dfm <- dfm(ngram_3, remove=c('#*', '@*', profanities))
ngram_4_dfm <- dfm(ngram_4, remove=c('#*', '@*', profanities))

# NGRAM COUNTS
cind(bigram=summary(ngram_2)[,1],
    trigram=summary(ngram_3)[,1],
  tetragram=summary(ngram_4)[,1])

# PLOTTING
if (PLOTS_NGRAM == TRUE) {
	# PLOTTING TOP NGRAM PER N
	pngram_1 <- plotNgramDfm(ngram_1_dfm, "top unigram")
	pngram_2 <- plotNgramDfm(ngram_2_dfm, "top bigram")
	pngram_3 <- plotNgramDfm(ngram_3_dfm, "top trigram")
	pngram_4 <- plotNgramDfm(ngram_4_dfm, "top tetragram")

	# PLOTTING TOP NGRAM / SOURCE
	pngram_4_blogs   <- plotNgramDfm(ngram_4_dfm[1], "top ngram from blogs")
	pngram_4_newbs   <- plotNgramDfm(ngram_4_dfm[2], "top ngram from news")
	pngram_4_twitter <- plotNgramDfm(ngram_4_dfm[3], "top ngram from twitter")

	# PLOTTING COVERAGE
    pcov <- plot(data.table(feature=c(getCoverage(ngram_1_dfm, .5),
                                      getCoverage(ngram_1_dfm, .66),
                                      getCoverage(ngram_1_dfm, .75),
                                      getCoverage(ngram_1_dfm, .85),
                                      getCoverage(ngram_1_dfm, .9),
                                      getCoverage(ngram_1_dfm, .99)),
                            coverage=c(50, 66, 75, 85, 90, 99)),
                 type='l')
}