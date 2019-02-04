# --- (TRY TO) PREDICT
# old step-by-step approach
#STATS_NGRAM1 <- ngram_1_slim_stats
#STATS_NGRAM2 <- ngram_2_slim_stats
#STATS_NGRAM3 <- ngram_3_slim_stats
#STATS_NGRAM4 <- ngram_4_slim_stats
# old py-csv approach
#STATS_NGRAM1 <- ngram1stats_slim
#STATS_NGRAM2 <- ngram2stats_slim
#STATS_NGRAM3 <- ngram3stats_slim
#STATS_NGRAM4 <- ngram4stats_slim

load(file=paste(PATH_MODELS, "ngram1_stats.Rdata",    sep=''))
load(file=paste(PATH_MODELS, "ngram1wsw_stats.Rdata", sep=''))
load(file=paste(PATH_MODELS, "ngram2_stats.Rdata",    sep=''))
load(file=paste(PATH_MODELS, "ngram3_stats.Rdata",    sep=''))
load(file=paste(PATH_MODELS, "ngram4_stats.Rdata",    sep=''))
load(file=paste(PATH_MODELS, "ngram5_stats.Rdata",    sep=''))

STATS_NGRAM1 <- ngram1_stats
STATS_NGRAM2 <- ngram2_stats
STATS_NGRAM3 <- ngram3_stats
STATS_NGRAM4 <- ngram4_stats
STATS_NGRAM5 <- ngram5_stats

saveRDS(STATS_NGRAM1,    file=paste(PATH_MODELS, "STATS_NGRAM1.rds",    sep=''))
saveRDS(STATS_NGRAM2,    file=paste(PATH_MODELS, "STATS_NGRAM2.rds",    sep=''))
saveRDS(STATS_NGRAM3,    file=paste(PATH_MODELS, "STATS_NGRAM3.rds",    sep=''))
saveRDS(STATS_NGRAM4,    file=paste(PATH_MODELS, "STATS_NGRAM4.rds",    sep=''))
saveRDS(STATS_NGRAM5,    file=paste(PATH_MODELS, "STATS_NGRAM5.rds",    sep=''))


rm(ngram1_stats, ngram1wsw_stats, ngram2_stats, ngram3_stats, ngram4_stats, ngram5_stats)
gc()

getCandidates('i_want_to')

quickFind('in_the')
