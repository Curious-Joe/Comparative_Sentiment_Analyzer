#___________________________________________________________
#sentiment analysis
#___________________________________________________________
library(shiny)
library(ggplot2)
library(tidyverse)
library(tidytext)

#___________________________________________________________
server = function(input, output, session) {

#creating first reactive value: sa_data
  sa_data = reactive({
    input$goButton
    isolate({
      withProgress({
        setProgress(message = "Processing text...")
        sa_file = input$sa
        if(!is.null(sa_file)) {
          sa_text = readLines(sa_file$datapath)
        }
        else
        {
          sa_text= clinton
          }
      SentCount(sa_text) 
            })
    })
  })

#creating second reactive value: sa_data2
  sa_data2 = reactive({
    input$goButton2
    isolate({
      withProgress({
        setProgress(message = "Processing text...")
        sa_file2 = input$sa2
        if(!is.null(sa_file2)) {
          sa_text2 = readLines(sa_file2$datapath)
        }
        else
        {
          sa_text2= trump
        }
        SentCount(sa_text2) 
      })
    })
  })
  
  
#_____________________________________________________
#creating Outputs 
  #Creating comparative plot of 'NRC'
  output$Sa_plot1 = renderPlot({ 
    withProgress({
      setProgress(message = 'Creating plot..')
      
      sa_corpus = sa_data()
      #matching tokens with 'sentiment lexicon-'nrc'(lexicon is a list of words having positive or negative sentiment)
      sa_corpus = sa_corpus %>%
        inner_join(get_sentiments('nrc')) %>%
        count(sentiment) 
      
      
      sa_corpus2 = sa_data2()
      sa_corpus2 = sa_corpus2 %>%
        inner_join(get_sentiments('nrc')) %>%
        count(sentiment) 
      
#creating pecentage column for better comparison
      sa_corpus$Perc_File01 <- sa_corpus$n / sum(sa_corpus$n) * 100
      sa_corpus2$Perc_File02 <- sa_corpus2$n / sum(sa_corpus2$n) * 100
      
#creating merged file to create stacked bar chart      
      merged = left_join(sa_corpus[-2], sa_corpus2[-2]) %>% 
        gather("File_name", "Percentage", 2:3)
      
#side by side stacked bar chart
      ggplot(merged, aes(sentiment,Percentage)) +   
        geom_bar(aes(fill = File_name), position = 'dodge', stat = 'identity')+ 
        ggtitle("Comparative sentivity analysis based on lexicon: 'NRC'")+
        theme(plot.title = element_text(size=18, face = 'bold'),
              axis.text=element_text(size=16),
              axis.title=element_text(size=14,face="bold"),
              legend.text = element_text(size = 12))
    })
  })
#____________________________________________________________
  #Creating comparative plot of 'Afinn'
  output$sa_plot2 = renderPlot({
    withProgress({
      setProgress(message = 'Creating plot..')
      
      sa_corpus3 = sa_data()
      #matching tokens with 'sentiment lexicon-'afinn'(lexicon is a list of words having positive or negative sentiment)
      sa_corpus3 = sa_corpus3 %>%
        inner_join(get_sentiments('afinn')) %>%
        count(value)
        
      
      sa_corpus4 = sa_data2()
      #matching tokens with 'sentiment lexicon-'afinn'(lexicon is a list of words having positive or negative sentiment)
      sa_corpus4 = sa_corpus4 %>%
        inner_join(get_sentiments('afinn')) %>%
        count(value)
      
      #creating pecentage column for better comparison      
      sa_corpus3$Perc_File01 <- sa_corpus3$n / sum(sa_corpus3$n) * 100
      sa_corpus4$Perc_File02 <- sa_corpus4$n / sum(sa_corpus4$n) * 100
      
      #creating merged file to create stacked bar chart
      merged_afinn = left_join(sa_corpus3[-2], sa_corpus4[-2]) %>% 
        gather("File_name", "Percentage", 2:3)
      
      #side by side stacked bar chart
      ggplot(merged_afinn, aes(value,Percentage)) +   
        geom_bar(aes(fill = File_name), position = 'dodge', stat = 'identity') + 
        ggtitle("Comparative sentivity analysis based on lexicon:'Afinn'")+
        theme(plot.title = element_text(size=18, face = 'bold'),
              axis.text=element_text(size=16),
              axis.title=element_text(size=14,face="bold"),
              legend.text = element_text(size = 12))
    })
  })
  
#__________________________________________________________________
  #Creating comparative plot of 'Bing'
  output$sa_plot3 = renderPlot({
    withProgress({
      setProgress(message = 'Creating plot..')
      
      sa_corpus5 = sa_data()
      #matching tokens with 'sentiment lexicon-'bing'(lexicon is a list of words having positive or negative sentiment)
      sa_corpus5 = sa_corpus5 %>%
                    inner_join(get_sentiments('bing')) %>%
                    count(sentiment)
      
      sa_corpus6 = sa_data2()
      #matching tokens with 'sentiment lexicon-'bing'(lexicon is a list of words having positive or negative sentiment)
      sa_corpus6 = sa_corpus6 %>%
        inner_join(get_sentiments('bing')) %>%
        count(sentiment)
      
      #creating pecentage column for better comparison 
      sa_corpus5$Perc_File01 <- sa_corpus5$n / sum(sa_corpus5$n) * 100
      sa_corpus6$Perc_File02 <- sa_corpus6$n / sum(sa_corpus6$n) * 100
      
      #creating merged file to create stacked bar chart
      merged_bing = left_join(sa_corpus5[-2], sa_corpus6[-2]) %>% 
        gather("File_name", "Percentage", 2:3)
      
      #side by side stacked bar chart
      ggplot(merged_bing, aes(sentiment, Percentage)) +   
        geom_bar(aes(fill = File_name), position = 'dodge', stat = 'identity')+ 
        ggtitle("Comparative sentivity analysis based on lexicon: 'Bing'")+
        theme(plot.title = element_text(size=18, face = 'bold'),
              axis.text=element_text(size=16),
              axis.title=element_text(size=14,face="bold"),
              legend.text = element_text(size = 12))
    })
  })

#______________________________________________________________
#Most frequent words
  #Most frequent words for first reactive data: sa_data
  output$sa_plot4 = renderPlot({
    withProgress({
      setProgress(message = 'Creating plot..')
      sa_corpus7 = sa_data()
#matching tokens
      sa_corpus7 = sa_corpus7 %>%
        inner_join(get_sentiments('bing')) %>%
        count(word, sentiment, sort = TRUE) %>%
        ungroup() 
      
#creating list of top 10 words
        sa_corpus7 %>%
          group_by(sentiment) %>%
          top_n(input$count) %>% 
#Creating plot
          ggplot(aes(reorder(word, n), n, fill = sentiment)) +
          geom_bar(alpha = 0.8, stat = "identity", show.legend = FALSE) +
          facet_wrap(~sentiment, scales = "free_y") +
          labs(title = 'File-01: 5 most frequent Positive vs Negative words according to lexicon: Bing',
               y = "Contribution to sentiment", x = NULL) +
          coord_flip()+
          theme(legend.position = 'none', 
                plot.title = element_text(size=18, face = 'bold'),
                axis.text=element_text(size=14),
                axis.title=element_text(size=14,face="bold"))
      
      })
  })
  
  #Most frequent words for first reactive data: sa_data2
  output$sa_plot5 = renderPlot({
    withProgress({
      setProgress(message = 'Creating plot..')
      sa_corpus8 = sa_data2()
      #matching tokens
      sa_corpus8 = sa_corpus8 %>%
        inner_join(get_sentiments('bing')) %>%
        count(word, sentiment, sort = TRUE) %>%
        ungroup()  
      
      #creating list of top 10 words
      sa_corpus8 %>%  
      group_by(sentiment) %>%
        top_n(input$count) %>% 
        
        #Creating plot
        ggplot(aes(reorder(word, n), n, fill = sentiment)) +
        geom_bar(alpha = 0.8, stat = "identity", show.legend = FALSE) +
        facet_wrap(~sentiment, scales = "free_y") +
        labs(title = 'File-02: 5 most frequent Positive vs Negative words according to lexicon: Bing',
             y = "Contribution to sentiment", x = NULL) +
        coord_flip()+
        theme(legend.position = 'none', plot.title = element_text(size=18, face = 'bold'),
              axis.text=element_text(size=14),
              axis.title=element_text(size=14,face="bold"))
      
    })
  })
  
}

