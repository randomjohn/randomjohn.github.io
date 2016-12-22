---
layout: post
title: "Greenville on Twitter"
author: "John Johnson"
date: "December 21, 2016"
status: publish
published: true
categories: Greenville
tags: R text_mining twitter
---
 
 
 

 
In this blogpost, we use [R](http://www.r-project.org) to use [Twitter](http://www.twitter.com) data to analyze topics of interest to Greenville, SC. We will describe obtaining, manipulating, and summarizing the data.
 
[Twitter](http://www.twitter.com) is a "microblogging" service where users can, usually publicly, share links, pictures, or short comments (up to 140 characters) onto a timeline. The public timeline consists of all public tweets, but people can build their own private timelines to narrow content to just what they want to see. (They do this by "following" users.) Over the years, many companies, news organizations, and users have considered the social media site essential for sharing news and other information. (Or cat memes.) Twitter has some organizational tools such as replies/conversation threads, mentions (i.e. naming other users using the @ notation), and hashtags (naming a topic using # notation). Twitter has encouraged the use of these organizational tools by automatically making mentions and hashtags clickable links.
 
These organizational tools can make for some interesting analysis. For instance, a game show may encourage viewers to vote on a winner using hashtags. On their end, they create a filter for a particular hashtag (e.g. #votemyplayer) and count votes. This also makes Twitter data ripe for text mining (which they use to identify trending topics).
 
## Obtaining the Twitter data
 
Twitter makes it possible for software to obtain Twitter comments without having to resort to "web-scraping" techniques (i.e. downloading the data as a web page and then parsing the HTML). Instead, you can go through an Application Programming Interface (API) to obtain the comments directly. If you're interested, Twitter has a whole [subdomain](https://dev.twitter.com/) related to accessing their data, including documentation. There are a lot of technical details, but for the casual user probably the only ones of interest are API key and rate limits. This post won't fuss with rate limits, but more serious work may require some further understanding of these issues. However, you will need to create an API key. Follow [these instructions](http://bigcomputing.blogspot.com/2016/02/the-twitter-r-package-by-jeff-gentry-is.html), which are tailored for R users. It essentially consists of creating a token at [Twitter's app web site](http://apps.twitter.com) and running an R function with the token. I set variables `consumer_secret`, `consumer_key`, `access_token`, and `access_secret` in an R block just copying and pasting from the Twitter apps site, not echoed in this blog post for obvious reasons.
 

 
 
Fortunately, the [twitteR](https://cran.r-project.org/web/packages/twitteR/index.html) package makes obtaining data from Twitter easy. It's on CRAN, so grab it using `install.packages` (it will also install dependencies such as the `bit64` and `httr` packages if you don't have them already) before moving on.
 
We authenticate our R program to Twitter and then start with searching the public timeline for "Greenville". Note due to the changing nature of Twitter, your results will probably be different:
 

{% highlight r %}
library(twitteR)
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
{% endhighlight %}



{% highlight text %}
[1] "Using direct authentication"
{% endhighlight %}



{% highlight r %}
gvl_twitter <- searchTwitter("Greenville")
gvl_twitter_df <- twListToDF(gvl_twitter)

head(gvl_twitter_df)
{% endhighlight %}



{% highlight text %}
                                                                                                                                              text
1        RT @_Makada_: ANOTHER HATE HOAX: Black man arrested for burning Greenville church, spray painting <U+0091>Vote Trump<U+0092>\n\nhttps://t.co/uuF1uabpNh
2   RT @TEN_GOP: Hillary voter: set the #Greenville black church on fire and spray painted 'Vote Trump'. \n\nTrump supporters: raised $180K to re<U+0085>
3                                                                                                                          https://t.co/qIgqSrHWTe
4        RT @_Makada_: ANOTHER HATE HOAX: Black man arrested for burning Greenville church, spray painting <U+0091>Vote Trump<U+0092>\n\nhttps://t.co/uuF1uabpNh
  favorited favoriteCount replyToSN             created truncated
1     FALSE             0        NA 2016-12-22 01:53:17     FALSE
2     FALSE             0        NA 2016-12-22 01:53:13     FALSE
3     FALSE             0        NA 2016-12-22 01:53:12     FALSE
4     FALSE             0        NA 2016-12-22 01:53:06     FALSE
  replyToSID                 id replyToUID
1         NA 811751432756068354         NA
2         NA 811751416452775937         NA
3         NA 811751411016990720         NA
4         NA 811751383431004160         NA
                                                                          statusSource
1                   <a href="http://twitter.com" rel="nofollow">Twitter Web Client</a>
2 <a href="http://twitter.com/download/android" rel="nofollow">Twitter for Android</a>
3                <a href="http://www.facebook.com/twitter" rel="nofollow">Facebook</a>
4 <a href="http://twitter.com/download/android" rel="nofollow">Twitter for Android</a>
       screenName retweetCount isRetweet retweeted longitude latitude
1  conservamother         1133      TRUE     FALSE        NA       NA
2    mkinsella822          927      TRUE     FALSE        NA       NA
3         DDraft1            0     FALSE     FALSE        NA       NA
4    mkinsella822         1133      TRUE     FALSE        NA       NA
 [ reached getOption("max.print") -- omitted 2 rows ]
{% endhighlight %}
 
`searchTwitter` returns data as a list, which may or may not be desirable. As a default, it returns the last 25 items matching the query you pass (this can be changed by using the `n=` option to the function). I used `twListToDF` (part of the `twitteR` package) to convert to a data frame. The data frame contains a lot of useful information, such as the tweet, information about whether it's a reply and the tweet to which it's a reply, screen name, and date stamp. Thus, Twitter provides a rich data source to provide information on topics, interactions, and reactions.
 
## Analyzing the data
 
### Retweets
 
The first thing to notice is that many of these tweets may be "retweets", where a user posts the exact same tweet as a previous user to create a larger audience for the tweet. This data point may be interesting in its own right, but for now, because we are just analyzing the text, we will filter out retweets:
 

{% highlight r %}
library(dplyr)
gvl_twitter_unique <- gvl_twitter_df %>% filter(!isRetweet)

print(gvl_twitter_unique %>% select(text))
{% endhighlight %}



{% highlight text %}
                                                                                                                                    text
1                                                                                                                https://t.co/qIgqSrHWTe
2        ANOTHER HATE HOAX: Black man arrested for burning Greenville church, spray... https://t.co/xNzEj0wBAU by #KempBobbi via @c0nvey
3 ANOTHER HATE HOAX: Black man arrested for burning Greenville church, spray painting... https://t.co/Gn8SUcYooi by #AppSame via @c0nvey
4 ANOTHER HATE HOAX: Black man arrested for burning Greenville church, spray painting... https://t.co/eTtq32KdDU by #AppSame via @c0nvey
5 ANOTHER HATE HOAX: Black man arrested for burning Greenville church, spray painting... https://t.co/WN70YD05jU by #AppSame via @c0nvey
6        ANOTHER HATE HOAX: Black man arrested for burning Greenville church, spray... https://t.co/OS2QA1Fuz1 by #Dee2Glass via @c0nvey
{% endhighlight %}
 
The thing to notice here is that there are several different Greenvilles, so this makes analysis of the local area pretty hard. Many of the tweets can be about Greenville, NC or SC. In this particular dataset, there was even a Greenville Road in California (where there was a car fire). Rather than play a filtering game, it may be better to apply some knowledge specific to the area. For instance, local tweets will often be tagged with `#yeahThatgreenville`. So we will search again for the `#yeahthatgreenville` hashtag (and add a few more tweets as well). This time, we'll keep retweets:
 

{% highlight r %}
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)  # needed to knit the Rmd file, may not be necessary for you to reauthenticate in 1 session
{% endhighlight %}



{% highlight text %}
[1] "Using direct authentication"
{% endhighlight %}



{% highlight r %}
gvl_twitter_unique <- searchTwitter("#yeahthatgreenville", n = 200) %>% twListToDF()

gvl_twitter_nolink <- gvl_twitter_unique %>% mutate(text = gsub("https?://[\\w\\./]+", 
    "", text, perl = TRUE))
{% endhighlight %}
 
Here I do two separate queries and add them together using the `bind_rows` function from `dplyr`.
 
### Who is tweeting
 
The first thing we can do is get a list of users who tweet under this hastag as well as their number of tweets:
 

{% highlight r %}
library(ggplot2)

gvl_twitter_nolink %>% ggplot(aes(x = reorder(screenName, screenName, function(x) -length(x)))) + 
    geom_bar() + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + 
    xlab("")
{% endhighlight %}

![plot of chunk unnamed-chunk-5](/figures/unnamed-chunk-5-1.png)
 
So I snuck a trick into the above graph. In bar charts presenting counts, I usually prefer the order in descending bar length. That way I can identify the most and least common screen names quickly. I accomplish this by using `x=reorder(screenName,screenName,function (x) -length(x)))` in the `aes()` function above. Now we can see that `@GiovanniDodd` was the most prolific tweeter in the last 200 tweets I accessed. Some of the prolific tweeters appear to be businesses, such as `@CourtyardGreenville` or perhaps tourism accounts such as `@Greenville_SC`.
 
### What users are saying
 
To analyze what users are saying about "#yeahthatgreenville" and "#gvl", we use the `tidytext` package. There are a number of packages that can be used to analyze text, and `tm` used to be a favorite, but `tidytext` fits within the context of [tidy data](http://vita.had.co.nz/papers/tidy-data.pdf). We prefer the tidy data framework because it works with data in a specific format and has a number of powerful tools that have a specific focus but interoperate well, much like the UNIX ideal. Here, `tidytext` will allow us to use `dplyr` and similar tools using the pipe operator. The code will be easier to read and follow.
 

{% highlight r %}
library(tidytext)

tweet_words <- gvl_twitter_nolink %>% select(id, text) %>% unnest_tokens(word, 
    text)

head(tweet_words)
{% endhighlight %}



{% highlight text %}
                    id     word
1   811749098273538048  stretch
1.1 811749098273538048 yourself
1.2 811749098273538048       in
1.3 811749098273538048     more
1.4 811749098273538048     ways
1.5 811749098273538048     than
{% endhighlight %}
 
I used the `select` function from `dplyr` to keep only the `id` and `text` fields. The `unnest_tokens()` functions creates a long dataset with a single word replacing the text. All the other fields remain unchanged. We can now easily create a bar chart of the words used the most:
 

{% highlight r %}
tweet_words %>% ggplot(aes(x = reorder(word, word, function(x) -length(x)))) + 
    geom_bar() + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + 
    xlab("")
{% endhighlight %}

![plot of chunk unnamed-chunk-7](/figures/unnamed-chunk-7-1.png)
 
This plot is very busy, so we plot, say, the top 20 words:
 

{% highlight r %}
tweet_words %>% count(word, sort = TRUE) %>% slice(1:20) %>% ggplot(aes(x = reorder(word, 
    n, function(n) -n), y = n)) + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, 
    hjust = 1)) + xlab("")
{% endhighlight %}

![plot of chunk unnamed-chunk-8](/figures/unnamed-chunk-8-1.png)
 
Unfortunately, this is terribly unexciting. _Of course_ "a", "to", "for", and similar words are going to be at the top. In text mining, we create a list of "stop words", including these, which are so common they are usually not worth including in an analysis. The `tidytext` package includes a `stop_words` data frame to assist us:
 

{% highlight r %}
head(stop_words)
{% endhighlight %}



{% highlight text %}
# A tibble: 6 × 2
       word lexicon
      <chr>   <chr>
1         a   SMART
2       a's   SMART
3      able   SMART
4     about   SMART
5     above   SMART
6 according   SMART
{% endhighlight %}
 
We'll change `stop_words` slightly to be useful to us. This involves adding a column to help us filter out in the next step and adding some common, uninteresting words "https", "t.co", "yeahthatgreenville", and "amp". We filter these out for various reasons, e.g. "https" and "t.co" are used in URLs, "amp" is left over from tokening some HTML code, and we searched on "yeahthatgreenville". Augmenting stop words is a bit of an iterative process, which I'm not showing here, but I went back and forth a few times to get this list.
 

{% highlight r %}
my_stop_words <- stop_words %>% select(-lexicon) %>% bind_rows(data.frame(word = c("https", 
    "t.co", "yeahthatgreenville", "amp", "gvl")))
{% endhighlight %}
 
Now, we can determine which of the words above are stop words and thus not worth analyzing:
 

{% highlight r %}
tweet_words_interesting <- tweet_words %>% anti_join(my_stop_words)

head(tweet_words_interesting)
{% endhighlight %}



{% highlight text %}
                  id       word
1 811749098273538048    stretch
2 811749098273538048  volunteer
3 811749098273538048 strengthen
4 811749098273538048  community
5 811567485363294208  community
6 811749098273538048   becausey
{% endhighlight %}
 
The `anti_join` function is probably not familiar to most data scientists or statisticians. It is the opposite of a merge in a sense. Basically, the command above merges the `tweet_words` and `my_stop_words` data frames, and then _removes_ the rows that came from the `my_stop_words` dataset, leaving only the rows in `tweet_words` (the `id` and `word`) that does not match with something from `my_stop_words`. This is desirable because our `my_stop_words` dataset contains words we _do not_ want to analyze.
 
Now we can analyze the more interesting words:
 

{% highlight r %}
tweet_words_interesting %>% count(word, sort = TRUE) %>% slice(1:20) %>% ggplot(aes(x = reorder(word, 
    n, function(n) -n), y = n)) + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 60, 
    hjust = 1)) + xlab("")
{% endhighlight %}

![plot of chunk unnamed-chunk-12](/figures/unnamed-chunk-12-1.png)
 
 
## Sentiment analysis
 
Sentiment analysis is, in short, the quantitative study of the emotional content of text. The most sophisticated analysis, of course, is very difficult, but we can make a start using a simple procedure. Many of the ideas here can be found in a [vignette](https://cran.r-project.org/web/packages/tidytext/vignettes/tidytext.html) for the package written by Julia Silge and David Robinson.
 
As a start, we use the Bing lexicon, which maps a word to positive/negative according to whether its sentiment content is positive or negative. 
 

{% highlight r %}
bing_lex <- get_sentiments("bing")

head(bing_lex)
{% endhighlight %}



{% highlight text %}
# A tibble: 6 × 2
        word sentiment
       <chr>     <chr>
1    2-faced  negative
2    2-faces  negative
3         a+  positive
4   abnormal  negative
5    abolish  negative
6 abominable  negative
{% endhighlight %}
 
Sentiment analysis then is an exercise in an inner-join:
 

{% highlight r %}
gvl_sentiment <- tweet_words_interesting %>% left_join(bing_lex)

head(gvl_sentiment)
{% endhighlight %}



{% highlight text %}
                  id       word sentiment
1 811749098273538048    stretch      <NA>
2 811749098273538048  volunteer      <NA>
3 811749098273538048 strengthen      <NA>
4 811749098273538048  community      <NA>
5 811567485363294208  community      <NA>
6 811749098273538048   becausey      <NA>
{% endhighlight %}
 
Once you get to this point, sentiment analysis can start fairly easily:
 

{% highlight r %}
gvl_sentiment %>% filter(!is.na(sentiment)) %>% group_by(sentiment) %>% summarise(n = n())
{% endhighlight %}



{% highlight text %}
# A tibble: 2 × 2
  sentiment     n
      <chr> <int>
1  negative    14
2  positive    78
{% endhighlight %}
 
There are many more positive words than negative words, so the mood tilts positive in our crude analysis. We can also group by tweet, and see whether there more more positive or negative tweets:
 

{% highlight r %}
gvl_sent_anly2 <- gvl_sentiment %>% group_by(sentiment, id) %>% summarise(n = n()) %>% 
    ungroup() %>% group_by(sentiment) %>% summarise(n = mean(n, na.rm = TRUE))

gvl_sent_anly2
{% endhighlight %}



{% highlight text %}
# A tibble: 3 × 2
  sentiment        n
      <chr>    <dbl>
1  negative 1.000000
2  positive 1.344828
3      <NA> 6.733668
{% endhighlight %}
 
On average, there are 1.3448276 positive words per tweet and 1 negative words per tweet, if you accept the assumptions of the above analysis.
 
There is, of course, a lot more that can be done, but this will get you started. For some more sophisticated ideas you can check [Julia Silge's analysis of Reddit data](http://juliasilge.com/blog/Reddit-Responds/), for instance. Another kind of analysis looking at sentiment and emotional content can be found [here](https://mran.microsoft.com/posts/twitter.html) (with the caveat that it uses the predecessor to `dplyr` and thus runs somewhat less efficiently). Finally, it would probably be useful to supplement the above sentiment data frames with situation-specific sentiment analysis, such as making `goallllllll` in the above a positive word.
 
## Conclusions
 
The R packages `twitteR` and `tidytext` make analyzing content from Twitter easy. This is helpful if you want to analyze, for instance, real time reactions to events. Above we pulled content from Twitter, split it into words, and analyzed words by frequency while eliminating "uninteresting" words. Then we analyzed whether tweets were on the whole positive or negative using pre-made lexicons mapping words to positive or negative.
