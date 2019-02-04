# CREATE CORPUS
crps <-        loadFile2Quanteda(filepath_blogs,   TRUE)
crps <- crps + loadFile2Quanteda(filepath_news,    TRUE)
crps <- crps + loadFile2Quanteda(filepath_twitter, TRUE)
summary(crps, showmeta=T)
