#___________________________________________________________
#sentiment analysis
#___________________________________________________________

ui = fluidPage(
  titlePanel(strong("Comparative Sentiment Analyzer")),
               sidebarLayout(
                 sidebarPanel ( 
                   
                  fileInput ('sa',strong('Upload text file to analyze sentiment'),
                                          multiple = F, accept= "text/plain",
                             placeholder = "Sample file-01: Hillary Clintons Presidential Debate script"),
                  actionButton("goButton",'Run-File01'),
                  
                  fileInput ('sa2',strong('Upload text file to analyze sentiment'),
                             multiple = F, accept= "text/plain",
                             placeholder = "Sample file-02: Donald Trumps Presidential Debate script"),
                  actionButton("goButton2", "Run-File02"),
                  hr(),
                  sliderInput("count",
                              "Choose number of words to show in tables of most frequent words",
                              min = 1,  max = 20, value = 5),
                  hr(),hr(),
                  
                  helpText ( strong ("Brief description of the lexicon libraries used: ")),
                  helpText("All three of these lexicons are based on unigrams (or single words).
                           These lexicons contain many English words and the words are assigned scores for positive/negative sentiment, and also possibly emotions like joy, anger, sadness, and so forth.
                           The nrc lexicon categorizes words in a binary fashion: yes/no into categories of positive, negative, anger, anticipation, disgust, fear, joy, sadness, surprise, and trust.
                           The bing lexicon categorizes words in a binary fashion into positive and negative categories. The AFINN lexicon assigns words with a score that runs between -5 and 5, 
                           with negative scores indicating negative sentiment and 
                           positive scores indicating positive sentiment."),
                  
                  helpText ( a("Learn more about 'NRC' lexicon",         
                               href="http://saifmohammad.com/WebPages/NRC-Emotion-Lexicon.htm", 
                               target="_blank"), ('|'),
                             a("Learn more about 'Afinn' lexicon",
                               href="http://www2.imm.dtu.dk/pubdb/views/publication_details.php?id=6010", 
                               target="_blank"), ('|'),
                             a("Learn more about 'Bing' lexicon",         
                               href="https://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html", 
                               target="_blank")),

                 helpText(strong('Source: '),
                          ('University of Cincinnati analytics R programing guide')),
                 br(),
                 helpText(strong('Feel free to connect with me through email: '), ('ahossa1@ilstu.edu'),
                          ('or '), a('LinkedIn', 
                                     href = 'https://www.linkedin.com/in/arafath-hossain/',
                                     target = 'b_blank'))
                 
                  
                 ),
                 
                 mainPanel(
                   plotOutput('Sa_plot1'),
                   br(), br(),
                   plotOutput('sa_plot2'),
                   br(), br(),
                   plotOutput('sa_plot3'),
                   br(), br(),
                   plotOutput('sa_plot4'),
                   br(), br(),
                   plotOutput('sa_plot5')
                   
                 ),
                 
                 position = ('right'),
                 
                 fluid = TRUE
               )
)
                   