Comparative Sentiment Analyzer
================
Arafath Hossain
November 2018

A `Shiny` app that allows users to upload two text files of their choice
and compare them based on the sentiments they convey.

### Sample Data

The app comes pre-loaded with text files containing the speeces made by
the two main presidential candidates of 2016 US ellection: Donald Trump
and Hillary Clinton. As the app loads, it calculates sentiments and
populates charts to show the differences in the sentiments carried out
by the two candidates through their speeces.

### Methodology

To measure sentiments a `lexicon` based approach was taken. In lexicon
based approach, lexicon library, a pre-populated list of words along
with their emotions, are used to measure sentiments carried out by a
text script. Such lexicon libraries are mostly developed by linguistics
researchers.

This shiny app shows sentiment comparisons based on three most popular
lexicon libraries:
[Bing](https://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html),
[Afinn](http://www2.imm.dtu.dk/pubdb/pubs/6010-full.html), and
[NRC](http://saifmohammad.com/WebPages/NRC-Emotion-Lexicon.htm).

### Demo

The live app can be accessed
[here](https://curiousjoe.shinyapps.io/comparative_sentiment_analyzer/?_ga=2.237832896.1184595221.1617847202-1816151043.1617847202)
at Shinyapps.io platform.
