# --- COMPUTE DFM STATS --- #
ngram_1_dfm_freq <- textstat_frequency(ngram_1_dfm)[,1:2]
ngram_2_dfm_freq <- textstat_frequency(ngram_2_dfm)[,1:2]
ngram_3_dfm_freq <- textstat_frequency(ngram_3_dfm)[,1:2]
ngram_4_dfm_freq <- >extstat_frequency(ngram_4_dfm)[,1:2]
ngram_1_dfm_freq_slim <- slimStats(ngram_1_dfm_freq)
ngram_2_dfm_freq_slim <- slimStats(ngram_2_dfm_freq)
ngram_3_dfm_freq_slim <- slimStats(ngram_3_dfm_freq)
ngram_4_dfm_freq_slim <- slimStats(ngram_4_dfm_freq)
ngram_1_slim_stats <- getDfmFreqStats(ngram_1_dfm_freq_slim)
ngram_2_slim_stats <- getDfmFreqStats(ngram_2_dfm_freq_slim)
ngram_3_slim_stats <- getDfmFreqStats(ngram_3_dfm_freq_slim)
ngram_4_slim_stats <- getDfmFreqStats(ngram_4_dfm_freq_slim)


# --- READ DFMSTATS FROM PY CSV --- #
system.time(ngram1stats_light <- readCsvStats("~/Downloads/jhu-ds-capstone/dataset/stats_csv/news1.csv", 1, 'news')) # b/n/t: -/-/-
system.time(ngram2stats_light <- readCsvStats("~/Downloads/jhu-ds-capstone/dataset/stats_csv/news2.csv", 2, 'news')) # b/n/t: -/-/-
system.time(ngram3stats_light <- readCsvStats("~/Downloads/jhu-ds-capstone/dataset/stats_csv/news3.csv", 3, 'news')) # b/n/t: -/-/-
system.time(ngram4stats_light <- readCsvStats("~/Downloads/jhu-ds-capstone/dataset/stats_csv/news4.csv", 4, 'news')) # b/n/t: -/-/-
# reduce size (cut low freq)
ngram1stats_slim <- slimStats(ngram1stats_light)
ngram2stats_slim <- slimStats(ngram2stats_light)
ngram3stats_slim <- slimStats(ngram3stats_light)
ngram4stats_slim <- slimStats(ngram4stats_light)
# print diff in size after filtering very low freq/prob
rbind( cbind(ngram=1, org=round(object.size(ngram1stats_light)/1024^2,2), light=round(object.size(ngram1stats_slim)/1024^2,2)),
       cbind(ngram=2, org=round(object.size(ngram2stats_light)/1024^2,2), light=round(object.size(ngram2stats_slim)/1024^2,2)),
       cbind(ngram=3, org=round(object.size(ngram3stats_light)/1024^2,2), light=round(object.size(ngram3stats_slim)/1024^2,2)),
       cbind(ngram=4, org=round(object.size(ngram4stats_light)/1024^2,2), light=round(object.size(ngram4stats_slim)/1024^2,2)))


# --- READ DFMFREQ FROM DFM DIRECT CALL ---#
load(file=paste(PATH_RDATA, "ngram1wsw_freq.Rdata",    sep=''))
load(file=paste(PATH_RDATA, "ngram2wsw_freq.Rdata",    sep=''))
load(file=paste(PATH_RDATA, "ngram3wsw_freq.Rdata",    sep=''))
load(file=paste(PATH_RDATA, "ngram4wsw_freq.Rdata",    sep=''))
load(file=paste(PATH_RDATA, "ngram5wsw_freq.Rdata",    sep=''))

ngram1wsw_stats    <- completeDfmFreqWithStats(ngram1wsw_freq, 1)
ngram2wsw_stats    <- completeDfmFreqWithStats(ngram2wsw_freq, 2)
ngram3wsw_stats    <- completeDfmFreqWithStats(ngram3wsw_freq, 3)
ngram4wsw_stats    <- completeDfmFreqWithStats(ngram4wsw_freq, 4)
ngram5wsw_stats    <- completeDfmFreqWithStats(ngram5wsw_freq, 5)

save(ngram1wsw_stats,    file=paste(PATH_RDATA, "ngram1wsw_stats.Rdata",    sep=''))
save(ngram2wsw_stats,    file=paste(PATH_RDATA, "ngram2wsw_stats.Rdata",    sep=''))
save(ngram3wsw_stats,    file=paste(PATH_RDATA, "ngram3wsw_stats.Rdata",    sep=''))
save(ngram4wsw_stats,    file=paste(PATH_RDATA, "ngram4wsw_stats.Rdata",    sep=''))
save(ngram5wsw_stats,    file=paste(PATH_RDATA, "ngram5wsw_stats.Rdata",    sep=''))
