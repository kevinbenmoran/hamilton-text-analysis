setwd("~/Projects/HamiltonAnalysis")
library(tm)
library(SnowballC)
library(RColorBrewer)
library(wordcloud2)



lyrics <- readLines('master/lyrics.txt')


lyrics <- gsub("\t","",lyrics)
lyrics <- gsub("'","",lyrics)

text <- Corpus(VectorSource(lyrics))

# Convert the text to lower case
text <- tm_map(text, content_transformer(tolower))
# Remove numbers
text <- tm_map(text, removeNumbers)
# Remove english common stopwords
text <- tm_map(text, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
#text <- tm_map(text, removeWords, c("blabla1", "blabla2")) 
# Remove punctuations
text <- tm_map(text, removePunctuation)
# Eliminate extra white spaces
text <- tm_map(text, stripWhitespace)
# Text stemming
text <- tm_map(text, stemDocument)

dtm <- TermDocumentMatrix(text)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

set.seed(12345)
wordcloud2(d, figPath = 'C:/Users/Kevin/Documents/Projects/TonyAwardViz/star.png', 
           size=0.4, color = c('black','white'), backgroundColor = '#ba8d05')



