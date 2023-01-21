calc_unique_dna <- function(N){
    if(N %% 2 == 0){
        return(4^N/2 + 4^(N/2)/2)
    }else{
        return(4^N/2)
    }
}

# library(BioStrings)
# kmer3 <- DNAStringSet(mkAllStrings(DNA_BASES, 3))
# kmer3 == reverseComplement(kmer3)

# # N が奇数の場合、 4^N/2
# # N が偶数の場合、

# kmer2 <- DNAStringSet(mkAllStrings(DNA_BASES, 2))
# kmer2 == reverseComplement(kmer2)

# c <- 1
# for(i in 2:length(kmer2)){
#     if(! reverseComplement(kmer2[i]) %in% kmer2[1:(i-1)]){
#         c <- c + 1
#     }
# }
# print(c)

# N <- 6
# seqset <- DNAStringSet(mkAllStrings(DNA_BASES, N))

# c <- 1
# for(i in 2:length(seqset)){
#     if(! reverseComplement(seqset[i]) %in% seqset[1:(i-1)]){
#         c <- c + 1
#     }
# }
# print(c)


# N <- 4
# seqset <- DNAStringSet(mkAllStrings(DNA_BASES, N))

# c <- 1
# for(i in 2:length(seqset)){
#     if(! reverseComplement(seqset[i]) %in% seqset[1:(i-1)]){
#         c <- c + 1
#     }
# }
# print(c)

# 2080
# 4^6/2 + 4^3/2

