library(dplyr)
library(tidyr)



SentCount = function(file)({
  c = trimws(file)
  #removing special sighns (dollar sign)
  c = gsub("\\$","",c)
  #tokenize ['stringasfactor' command is really important!!!]
  c = data.frame(text=c,stringsAsFactors = FALSE)  %>% unnest_tokens(word, text) 
})


clinton = readLines('Sample Text/clinton_combined.txt')
trump = readLines('Sample Text/trump_combined.txt')

#end
