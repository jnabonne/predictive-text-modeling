#' Simple function tranforming word separator and converting to lower case
#' @param terms the sentence to translate into Word-O-Matic syntax (format: a_b_c)
#' @param new_sep the new word separator to use (WOM default is '_')
#' @param new_sep the old word separator to replace (default is ' ')
#' @return a string in lower case with the new word separator
#' @author jnabonne
translate2WOM <- function (terms, new_sep='_', old_sep=' ') {
    tolower(paste(strsplit(terms, old_sep)[[1]], collapse=new_sep))
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
    PENALTY  <- ifelse(exists('PENALTY'), PENALTY, 0.4)
    candidates <- data.table()
    # get level to work with (n last words with (n+1)-gram)
    n_level <- sapply(strsplit(input, '_'), length)
    
    # select which ngram to look
    if (n_level >= 4) xgramstats <- STATS_NGRAM5 else { 
        if (n_level >= 3) xgramstats <- STATS_NGRAM4 else { 
            if (n_level >= 2) xgramstats <- STATS_NGRAM3 else { 
                if (n_level >= 1) xgramstats <- STATS_NGRAM2 }}}
    # get best candidate (if any) and add it to our table (updating prob with penalty)
    candidate <- xgramstats[xgramstats$firsts == input, c('last', 'prob')][1,]
    if (!is.na(candidate$last)) {
        candidates <- rbind(candidates,
                            data.table(ngram=as.character(n_level+1), terms=input, candidate, penalty,
                                       probability= ifelse(penalty==0, candidate$prob, candidate$prob*penalty)))
    }
    
    # recursive call to get candidate for n-1 last terms in (n-1)gram
    if (n_level > 1) candidates <- rbind(candidates, getCandidates(getLastTerms(input, n_level-1), ifelse(penalty==0, PENALTY, penalty^2)))
    # if no results, we return most frequent word in corpus
    else if (dim(candidates)[1] == 0) {
        penalty    <- ifelse(n_level==0, 0, ifelse(penalty==0, PENALTY, penalty^2))
        default    <- STATS_NGRAM1[c('last', 'prob')][1,]
        candidates <- rbind(candidates, data.table(ngram='0', terms=NA, default, penalty, 
                                                   probability= ifelse(penalty==0, default$prob, default$prob*penalty)))
    }

    # return dt with all candidates
    candidates
}