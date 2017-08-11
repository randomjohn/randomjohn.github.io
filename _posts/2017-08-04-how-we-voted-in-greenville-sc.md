---
layout:post
title: "How we voted in Greenville SC"
author: "John Johnson"
date: "August 4, 2017"
status: publish
published: true
categories: Greenville
tags: election maps
---
 

 
# Purpose
 
This post seeks to explore how Greenville, SC and surrounding areas voted in the 2016 election. It also demonstrates how to retrieve data from the [Data.World](http://data.world) site. To retrieve data from this site using the tools in this post, you have to create an account (easy to do if you have a Facebook, Twitter, or Github account). You can then get your own API key from your profile page. Furthermore, from R, you will need to get the `data.world` package (`install.packages("data.world")`). You can then load the API key into R using `saved_cfg <- data.world::save_config("YOUR_API_KEY")`. This is the same `saved_cfg` used below.
 
Furthermore, for purposes of map display we need to get the shapes of the districts in SC. I found one such collection on Github at [User nvelesko](https://github.com/nvkelso/election-geodata)'s Github page. I just downloaded as a zip file and extracted into a local directory I named `precinct_shp`. There are versions of these shape files for most states. I use the `readOGR` function from package `rgdal` to read them in.
 
# Setup and acquiring data
 
First, we load the shape files that were downloaded from the Github site above. The `readOGR` function seems to be a little strange, because I tried calling it with `precinct_shp` (the directory of the shape files) directly, but it gave errors. Eventually, I gave up and changed the working directly to read in the shape files, and then changed it back. Note that if you're doing this in an R Notebook or R markdown file, you'll get some strange messages about how changing the working directory in an R notebook works.
 

{% highlight r %}
library(data.world)
library(tidyverse)
library(rgdal)
set_config(saved_cfg) # saved_cfg was set in an invisible block which has my API key
owd <- getwd()
setwd(precinct_shp)
precinct_shapes <- readOGR(".","Statewide")
{% endhighlight %}



{% highlight text %}
## OGR data source with driver: ESRI Shapefile 
## Source: ".", layer: "Statewide"
## with 2155 features
## It has 4 fields
{% endhighlight %}



{% highlight r %}
setwd(owd)
{% endhighlight %}
 
To download the election data, we use the simplified commands from the `dwapi` package (automatically loaded by `data.world`). The `list_tables` command lists the available data tables for that site. Here there are two: one for the election itself and one for registration. For exploration, we download both. The data are located in the directory of user @tamilyn, and are named south-carolina-election-data. If you use Python or other common data analysis tool, data.world has released tools that connect your tool of choice with their API. As of the date on this blog post, the file size total was about 850 kB for both files.
 

{% highlight r %}
ds_url <- "tamilyn/south-carolina-election-data"
election_tables <- dwapi::list_tables(ds_url)
election_df <- dwapi::download_table_as_data_frame(ds_url,election_tables[1])
{% endhighlight %}



{% highlight text %}
## Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 14 kB     Downloading: 14 kB     Downloading: 14 kB     Downloading: 14 kB     Downloading: 14 kB     Downloading: 14 kB     Downloading: 14 kB     Downloading: 14 kB     Downloading: 30 kB     Downloading: 30 kB     Downloading: 34 kB     Downloading: 34 kB     Downloading: 34 kB     Downloading: 34 kB     Downloading: 34 kB     Downloading: 34 kB     Downloading: 34 kB     Downloading: 34 kB     Downloading: 34 kB     Downloading: 34 kB     Downloading: 34 kB     Downloading: 34 kB     Downloading: 34 kB     Downloading: 34 kB     Downloading: 50 kB     Downloading: 50 kB     Downloading: 50 kB     Downloading: 50 kB     Downloading: 50 kB     Downloading: 50 kB     Downloading: 55 kB     Downloading: 55 kB     Downloading: 55 kB     Downloading: 55 kB     Downloading: 55 kB     Downloading: 55 kB     Downloading: 62 kB     Downloading: 62 kB     Downloading: 68 kB     Downloading: 68 kB     Downloading: 68 kB     Downloading: 68 kB     Downloading: 68 kB     Downloading: 68 kB     Downloading: 68 kB     Downloading: 68 kB     Downloading: 68 kB     Downloading: 68 kB     Downloading: 68 kB     Downloading: 68 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 84 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 120 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 130 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 150 kB     Downloading: 170 kB     Downloading: 170 kB     Downloading: 170 kB     Downloading: 170 kB     Downloading: 170 kB     Downloading: 170 kB     Downloading: 170 kB     Downloading: 170 kB     Downloading: 170 kB     Downloading: 170 kB     Downloading: 170 kB     Downloading: 170 kB     Downloading: 170 kB     Downloading: 170 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 180 kB     Downloading: 200 kB     Downloading: 200 kB     Downloading: 200 kB     Downloading: 200 kB     Downloading: 200 kB     Downloading: 200 kB     Downloading: 200 kB     Downloading: 200 kB     Downloading: 200 kB     Downloading: 200 kB     Downloading: 200 kB     Downloading: 200 kB     Downloading: 200 kB     Downloading: 200 kB     Downloading: 200 kB     Downloading: 200 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 220 kB     Downloading: 230 kB     Downloading: 230 kB     Downloading: 230 kB     Downloading: 230 kB     Downloading: 230 kB     Downloading: 230 kB     Downloading: 230 kB     Downloading: 230 kB     Downloading: 230 kB     Downloading: 230 kB     Downloading: 230 kB     Downloading: 230 kB     Downloading: 230 kB     Downloading: 230 kB     Downloading: 230 kB     Downloading: 230 kB     Downloading: 250 kB     Downloading: 250 kB     Downloading: 250 kB     Downloading: 250 kB     Downloading: 250 kB     Downloading: 250 kB     Downloading: 250 kB     Downloading: 250 kB     Downloading: 250 kB     Downloading: 250 kB     Downloading: 250 kB     Downloading: 250 kB     Downloading: 260 kB     Downloading: 260 kB     Downloading: 260 kB     Downloading: 260 kB     Downloading: 260 kB     Downloading: 260 kB     Downloading: 260 kB     Downloading: 260 kB     Downloading: 280 kB     Downloading: 280 kB     Downloading: 280 kB     Downloading: 280 kB     Downloading: 300 kB     Downloading: 300 kB     Downloading: 300 kB     Downloading: 300 kB     Downloading: 300 kB     Downloading: 300 kB     Downloading: 300 kB     Downloading: 300 kB     Downloading: 310 kB     Downloading: 310 kB     Downloading: 310 kB     Downloading: 310 kB     Downloading: 310 kB     Downloading: 310 kB     Downloading: 310 kB     Downloading: 310 kB     Downloading: 330 kB     Downloading: 330 kB     Downloading: 330 kB     Downloading: 330 kB     Downloading: 350 kB     Downloading: 350 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 360 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 380 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 400 kB     Downloading: 410 kB     Downloading: 410 kB     Downloading: 410 kB     Downloading: 410 kB     Downloading: 410 kB     Downloading: 410 kB     Downloading: 410 kB     Downloading: 410 kB     Downloading: 410 kB     Downloading: 410 kB     Downloading: 410 kB     Downloading: 410 kB     Downloading: 410 kB     Downloading: 410 kB     Downloading: 410 kB     Downloading: 410 kB     Downloading: 430 kB     Downloading: 430 kB     Downloading: 430 kB     Downloading: 430 kB     Downloading: 430 kB     Downloading: 430 kB     Downloading: 430 kB     Downloading: 430 kB     Downloading: 430 kB     Downloading: 430 kB     Downloading: 430 kB     Downloading: 430 kB     Downloading: 430 kB     Downloading: 430 kB     Downloading: 430 kB     Downloading: 430 kB     Downloading: 440 kB     Downloading: 440 kB     Downloading: 440 kB     Downloading: 440 kB     Downloading: 440 kB     Downloading: 440 kB     Downloading: 440 kB     Downloading: 440 kB     Downloading: 440 kB     Downloading: 440 kB     Downloading: 440 kB     Downloading: 440 kB     Downloading: 460 kB     Downloading: 460 kB     Downloading: 460 kB     Downloading: 460 kB     Downloading: 460 kB     Downloading: 460 kB     Downloading: 460 kB     Downloading: 460 kB     Downloading: 460 kB     Downloading: 460 kB     Downloading: 480 kB     Downloading: 480 kB     Downloading: 490 kB     Downloading: 490 kB     Downloading: 510 kB     Downloading: 510 kB     Downloading: 510 kB     Downloading: 510 kB     Downloading: 510 kB     Downloading: 510 kB     Downloading: 510 kB     Downloading: 510 kB     Downloading: 530 kB     Downloading: 530 kB     Downloading: 530 kB     Downloading: 530 kB     Downloading: 530 kB     Downloading: 530 kB     Downloading: 540 kB     Downloading: 540 kB     Downloading: 560 kB     Downloading: 560 kB     Downloading: 560 kB     Downloading: 560 kB     Downloading: 560 kB     Downloading: 560 kB     Downloading: 560 kB     Downloading: 560 kB     Downloading: 580 kB     Downloading: 580 kB     Downloading: 580 kB     Downloading: 580 kB     Downloading: 580 kB     Downloading: 580 kB     Downloading: 590 kB     Downloading: 590 kB     Downloading: 590 kB     Downloading: 590 kB     Downloading: 590 kB     Downloading: 590 kB     Downloading: 610 kB     Downloading: 610 kB     Downloading: 620 kB     Downloading: 620 kB     Downloading: 620 kB     Downloading: 620 kB     Downloading: 640 kB     Downloading: 640 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 660 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 670 kB     Downloading: 690 kB     Downloading: 690 kB     Downloading: 690 kB     Downloading: 690 kB     Downloading: 690 kB     Downloading: 690 kB     Downloading: 690 kB     Downloading: 690 kB     Downloading: 690 kB     Downloading: 690 kB     Downloading: 690 kB     Downloading: 690 kB     Downloading: 710 kB     Downloading: 710 kB     Downloading: 710 kB     Downloading: 710 kB     Downloading: 710 kB     Downloading: 710 kB     Downloading: 710 kB     Downloading: 710 kB     Downloading: 710 kB     Downloading: 710 kB     Downloading: 710 kB     Downloading: 710 kB     Downloading: 710 kB     Downloading: 710 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 720 kB     Downloading: 740 kB     Downloading: 740 kB     Downloading: 740 kB     Downloading: 740 kB     Downloading: 740 kB     Downloading: 740 kB     Downloading: 740 kB     Downloading: 740 kB
{% endhighlight %}



{% highlight r %}
regis_df <- dwapi::download_table_as_data_frame(ds_url,election_tables[2])
{% endhighlight %}



{% highlight text %}
## Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 10 B     Downloading: 14 kB     Downloading: 14 kB     Downloading: 14 kB     Downloading: 14 kB     Downloading: 14 kB     Downloading: 14 kB     Downloading: 14 kB     Downloading: 14 kB     Downloading: 14 kB     Downloading: 14 kB     Downloading: 23 kB     Downloading: 23 kB     Downloading: 25 kB     Downloading: 25 kB     Downloading: 25 kB     Downloading: 25 kB     Downloading: 25 kB     Downloading: 25 kB     Downloading: 41 kB     Downloading: 41 kB     Downloading: 53 kB     Downloading: 53 kB     Downloading: 53 kB     Downloading: 53 kB     Downloading: 53 kB     Downloading: 53 kB     Downloading: 53 kB     Downloading: 53 kB     Downloading: 53 kB     Downloading: 53 kB     Downloading: 53 kB     Downloading: 53 kB     Downloading: 70 kB     Downloading: 70 kB     Downloading: 70 kB     Downloading: 70 kB     Downloading: 70 kB     Downloading: 70 kB     Downloading: 70 kB     Downloading: 70 kB     Downloading: 70 kB     Downloading: 70 kB     Downloading: 70 kB     Downloading: 70 kB     Downloading: 82 kB     Downloading: 82 kB     Downloading: 82 kB     Downloading: 82 kB     Downloading: 98 kB     Downloading: 98 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB     Downloading: 100 kB
{% endhighlight %}
# Showing the data
 
Plotting the precinct data using the standard R tools is easy:
 

{% highlight r %}
plot(precinct_shapes)
{% endhighlight %}

![plot of chunk unnamed-chunk-3](/figures//2017-08-04-how-we-voted-in-greenville-sc.Rmdunnamed-chunk-3-1.png)
 
This is because `plot` "knows" what to do with shape data. In fact, we can explore this a little bit further:
 

{% highlight r %}
class(precinct_shapes)
{% endhighlight %}



{% highlight text %}
## [1] "SpatialPolygonsDataFrame"
## attr(,"package")
## [1] "sp"
{% endhighlight %}
 
This shows that we have an object of class `sp`, which is a spatial data object defined using the `sp` package. It is also a `SpatialPolygonsDataFrame`. Behind the scenes, `plot` is calling a method that is defined just for these kinds of objects, which tells it how to render these kinds of shape data. We could also (and have on this blog) done this using the `ggplot2` package, but for this kind of exploration the quick plot is good. So don't give completely up on R base graphics.
 
The election data has a bit of an odd structure.
 

{% highlight r %}
knitr::kable(election_df %>% mutate(row=1:nrow(.)) %>% select(row,everything()) %>% slice(c(1:5,103:107)))
{% endhighlight %}



| row|county    |precinct        |office                       |district |party |candidate                                      | votes|
|---:|:---------|:---------------|:----------------------------|:--------|:-----|:----------------------------------------------|-----:|
|   1|Abbeville |Abbeville No. 1 |STRAIGHT PARTY               |NA       |DEM   |Democratic                                     |   139|
|   2|Abbeville |Abbeville No. 2 |STRAIGHT PARTY               |NA       |DEM   |Democratic                                     |   248|
|   3|Abbeville |Abbeville No. 3 |STRAIGHT PARTY               |NA       |DEM   |Democratic                                     |   134|
|   4|Abbeville |Abbeville No. 4 |STRAIGHT PARTY               |NA       |DEM   |Democratic                                     |    82|
|   5|Abbeville |Antreville      |STRAIGHT PARTY               |NA       |DEM   |Democratic                                     |    72|
| 103|Abbeville |Lebanon         |STRAIGHT PARTY               |NA       |LIB   |Libertarian                                    |     1|
| 104|Abbeville |Absentee        |STRAIGHT PARTY               |NA       |LIB   |Libertarian                                    |     4|
| 105|Abbeville |Abbeville No. 1 |President and Vice President |NA       |DEM   |Hillary Rodham Clinton / Timothy Michael Kaine |   245|
| 106|Abbeville |Abbeville No. 2 |President and Vice President |NA       |DEM   |Hillary Rodham Clinton / Timothy Michael Kaine |   373|
| 107|Abbeville |Abbeville No. 3 |President and Vice President |NA       |DEM   |Hillary Rodham Clinton / Timothy Michael Kaine |   214|
 
So the fancy stuff I did in `kable` above was basically to show the original row numbers and print them to the left of all the other variables. If I had not used the `select(row,everything())`, the row would have printed last. This is a nice example of how to do a quick custom column-sorting. But that's not why we're here. The election file shows how people voted in a rather raw fashion. Specifically, here I want to tally those people who voted for the different candidates for president. But it's not that straightforward, because I have to count the straight-ticket voters as well as the split-party voters who specifically noted their president's choice on the ballot.
 
The goal here is to get to the percentage of votes going to the big two parties. While it may be an interesting exercise to some to look at the third party votes, we're not going to do that here.
 

{% highlight r %}
total_pres_votes <- election_df %>% 
  filter(office %in% c("STRAIGHT PARTY","President and Vice President")) %>% 
  group_by(precinct) %>% 
  summarize(total_votes=sum(votes,nm.ra=TRUE))
knitr::kable(total_pres_votes %>% slice(1:5))
{% endhighlight %}



|precinct        | total_votes|
|:---------------|-----------:|
|Abbeville No. 1 |        1250|
|Abbeville No. 2 |        1054|
|Abbeville No. 3 |         744|
|Abbeville No. 4 |         611|
|Abel            |         731|
 
The first few results look ok, so we can get votes for the different parties and merge this back on to get the percentage.
 

{% highlight r %}
total_party_votes <- election_df %>% 
  dplyr::filter((office %in% c("STRAIGHT PARTY","President and Vice President")) & (party %in% c("DEM","REP"))) %>% 
  group_by(precinct,party) %>% 
  summarize(total_party_votes=sum(votes,nm.ra=TRUE)) %>% 
  left_join(total_pres_votes) %>% 
  mutate(party_perc=total_party_votes/total_votes*100)
{% endhighlight %}



{% highlight text %}
## Joining, by = "precinct"
{% endhighlight %}



{% highlight r %}
knitr::kable(total_party_votes %>% slice(1:10))
{% endhighlight %}



|precinct                           |party | total_party_votes| total_votes|  party_perc|
|:----------------------------------|:-----|-----------------:|-----------:|-----------:|
|Abbeville No. 1                    |DEM   |               385|        1250|  30.8000000|
|Abbeville No. 1                    |REP   |               818|        1250|  65.4400000|
|Abbeville No. 2                    |DEM   |               622|        1054|  59.0132827|
|Abbeville No. 2                    |REP   |               407|        1054|  38.6148008|
|Abbeville No. 3                    |DEM   |               349|         744|  46.9086022|
|Abbeville No. 3                    |REP   |               375|         744|  50.4032258|
|Abbeville No. 4                    |DEM   |               214|         611|  35.0245499|
|Abbeville No. 4                    |REP   |               381|         611|  62.3567921|
|Abel                               |DEM   |               418|         731|  57.1819425|
|Abel                               |REP   |               241|         731|  32.9685363|
|Abner Creek Baptist                |DEM   |               194|        1221|  15.8886159|
|Abner Creek Baptist                |REP   |               980|        1221|  80.2620803|
|Absentee                           |DEM   |            262853|      521425|  50.4105097|
|Absentee                           |REP   |            245203|      521425|  47.0255550|
|Absentee 1                         |DEM   |             28364|       56422|  50.2711708|
|Absentee 1                         |REP   |             26683|       56422|  47.2918365|
|ABSENTEE 1                         |DEM   |             13718|       29495|  46.5095779|
|ABSENTEE 1                         |REP   |             14802|       29495|  50.1847771|
|Absentee 2                         |DEM   |             59846|      107903|  55.4627768|
|Absentee 2                         |REP   |             45540|      107903|  42.2045726|
|ABSENTEE 2                         |DEM   |              6666|       16541|  40.2998610|
|ABSENTEE 2                         |REP   |              9363|       16541|  56.6048002|
|Absentee 3                         |DEM   |             13224|       26339|  50.2069175|
|Absentee 3                         |REP   |             12431|       26339|  47.1961730|
|Absentee 4                         |DEM   |              4707|       10693|  44.0194520|
|Absentee 4                         |REP   |              5672|       10693|  53.0440475|
|ADAMSBURG                          |DEM   |                92|         498|  18.4738956|
|ADAMSBURG                          |REP   |               391|         498|  78.5140562|
|ADAMSVILLE                         |DEM   |               124|         273|  45.4212454|
|ADAMSVILLE                         |REP   |               143|         273|  52.3809524|
|Adnah                              |DEM   |               185|         667|  27.7361319|
|Adnah                              |REP   |               448|         667|  67.1664168|
|ADRIAN                             |DEM   |               357|        1656|  21.5579710|
|ADRIAN                             |REP   |              1231|        1656|  74.3357488|
|AIKEN                              |DEM   |               414|         721|  57.4202497|
|AIKEN                              |REP   |               272|         721|  37.7253814|
|Aiken No. 1                        |DEM   |               209|         832|  25.1201923|
|Aiken No. 1                        |REP   |               555|         832|  66.7067308|
|Aiken No. 2                        |DEM   |               708|         913|  77.5465498|
|Aiken No. 2                        |REP   |               173|         913|  18.9485214|
|Aiken No. 3                        |DEM   |              1016|        1221|  83.2104832|
|Aiken No. 3                        |REP   |               162|        1221|  13.2678133|
|Aiken No. 4                        |DEM   |               453|         525|  86.2857143|
|Aiken No. 4                        |REP   |                56|         525|  10.6666667|
|Aiken No. 47                       |DEM   |               275|         790|  34.8101266|
|Aiken No. 47                       |REP   |               464|         790|  58.7341772|
|Aiken No. 5                        |DEM   |               434|         789|  55.0063371|
|Aiken No. 5                        |REP   |               319|         789|  40.4309252|
|Aiken No. 6                        |DEM   |               256|         917|  27.9171210|
|Aiken No. 6                        |REP   |               604|         917|  65.8669575|
|Airport                            |DEM   |               758|        2672|  28.3682635|
|Airport                            |REP   |              1779|        2672|  66.5793413|
|Albert R. Lewis                    |DEM   |                98|         991|   9.8890010|
|Albert R. Lewis                    |REP   |               846|         991|  85.3683148|
|Alcolu                             |DEM   |               323|         606|  53.3003300|
|Alcolu                             |REP   |               269|         606|  44.3894389|
|ALLENDALE #1                       |DEM   |               421|         543|  77.5322284|
|ALLENDALE #1                       |REP   |               104|         543|  19.1528545|
|ALLENDALE #2                       |DEM   |               526|         549|  95.8105647|
|ALLENDALE #2                       |REP   |                11|         549|   2.0036430|
|Allens                             |DEM   |                81|         859|   9.4295693|
|Allens                             |REP   |               744|         859|  86.6123399|
|Allie's Crossing                   |DEM   |               191|         656|  29.1158537|
|Allie's Crossing                   |REP   |               441|         656|  67.2256098|
|Allison Creek                      |DEM   |               517|        2188|  23.6288848|
|Allison Creek                      |REP   |              1555|        2188|  71.0694698|
|ALLSBROOK                          |DEM   |               112|         620|  18.0645161|
|ALLSBROOK                          |REP   |               503|         620|  81.1290323|
|Alma Mill                          |DEM   |               658|        1201|  54.7876769|
|Alma Mill                          |REP   |               509|        1201|  42.3813489|
|ALTAMONT FOREST                    |DEM   |               241|        1147|  21.0113339|
|ALTAMONT FOREST                    |REP   |               839|        1147|  73.1473409|
|Alvin                              |DEM   |               609|         939|  64.8562300|
|Alvin                              |REP   |               311|         939|  33.1203408|
|Amicks Ferry                       |DEM   |               399|        2412|  16.5422886|
|Amicks Ferry                       |REP   |              1905|        2412|  78.9800995|
|Anderson 1/1                       |DEM   |               380|        1030|  36.8932039|
|Anderson 1/1                       |REP   |               591|        1030|  57.3786408|
|Anderson 1/2                       |DEM   |               233|         937|  24.8665955|
|Anderson 1/2                       |REP   |               666|         937|  71.0779082|
|Anderson 2/1                       |DEM   |               244|         933|  26.1521972|
|Anderson 2/1                       |REP   |               626|         933|  67.0953912|
|Anderson 2/2                       |DEM   |               605|        1689|  35.8200118|
|Anderson 2/2                       |REP   |               992|        1689|  58.7329781|
|Anderson 3/1                       |DEM   |               323|         531|  60.8286252|
|Anderson 3/1                       |REP   |               176|         531|  33.1450094|
|Anderson 3/2                       |DEM   |              1334|        1848|  72.1861472|
|Anderson 3/2                       |REP   |               468|        1848|  25.3246753|
|Anderson 4/1                       |DEM   |               421|         524|  80.3435115|
|Anderson 4/1                       |REP   |                81|         524|  15.4580153|
|Anderson 4/2                       |DEM   |               523|         581|  90.0172117|
|Anderson 4/2                       |REP   |                45|         581|   7.7452668|
|Anderson 5/A                       |DEM   |               399|         539|  74.0259740|
|Anderson 5/A                       |REP   |               119|         539|  22.0779221|
|Anderson 5/B                       |DEM   |               757|         915|  82.7322404|
|Anderson 5/B                       |REP   |               138|         915|  15.0819672|
|Anderson 6/1                       |DEM   |               414|        1229|  33.6859235|
|Anderson 6/1                       |REP   |               725|        1229|  58.9910496|
|Anderson 6/2                       |DEM   |               272|         316|  86.0759494|
|Anderson 6/2                       |REP   |                33|         316|  10.4430380|
|Anderson Mill Elementary           |DEM   |              1028|        2737|  37.5593716|
|Anderson Mill Elementary           |REP   |              1545|        2737|  56.4486664|
|Anderson Pond No. 69               |DEM   |               251|        1160|  21.6379310|
|Anderson Pond No. 69               |REP   |               853|        1160|  73.5344828|
|Anderson Road                      |DEM   |              1246|        2386|  52.2212909|
|Anderson Road                      |REP   |               988|        2386|  41.4082146|
|ANDREWS                            |DEM   |               963|        1270|  75.8267717|
|ANDREWS                            |REP   |               277|        1270|  21.8110236|
|ANDREWS OUTSIDE                    |DEM   |               592|        1047|  56.5425024|
|ANDREWS OUTSIDE                    |REP   |               436|        1047|  41.6427889|
|ANGELUS-CARARRH                    |DEM   |               207|         565|  36.6371681|
|ANGELUS-CARARRH                    |REP   |               343|         565|  60.7079646|
|Antioch                            |DEM   |               322|        1375|  23.4181818|
|Antioch                            |REP   |              1008|        1375|  73.3090909|
|ANTIOCH                            |DEM   |               690|        1509|  45.7256461|
|ANTIOCH                            |REP   |               780|        1509|  51.6898608|
|Antioch and Kings Creek            |DEM   |               123|        1158|  10.6217617|
|Antioch and Kings Creek            |REP   |               978|        1158|  84.4559585|
|Antreville                         |DEM   |               178|         904|  19.6902655|
|Antreville                         |REP   |               706|         904|  78.0973451|
|Appleton-Equinox                   |DEM   |               287|         566|  50.7067138|
|Appleton-Equinox                   |REP   |               249|         566|  43.9929329|
|Arcadia                            |DEM   |               545|        1005|  54.2288557|
|Arcadia                            |REP   |               385|        1005|  38.3084577|
|Arcadia Elementary                 |DEM   |               338|         675|  50.0740741|
|Arcadia Elementary                 |REP   |               293|         675|  43.4074074|
|Archdale                           |DEM   |               433|         940|  46.0638298|
|Archdale                           |REP   |               456|         940|  48.5106383|
|Archdale 2                         |DEM   |               449|        1075|  41.7674419|
|Archdale 2                         |REP   |               570|        1075|  53.0232558|
|Ardincaple                         |DEM   |               367|         384|  95.5729167|
|Ardincaple                         |REP   |                11|         384|   2.8645833|
|Arial Mill                         |DEM   |               116|         843|  13.7603796|
|Arial Mill                         |REP   |               686|         843|  81.3760380|
|Ascauga Lake No. 63                |DEM   |               261|         849|  30.7420495|
|Ascauga Lake No. 63                |REP   |               542|         849|  63.8398115|
|Ascauga Lake No. 84                |DEM   |               235|         925|  25.4054054|
|Ascauga Lake No. 84                |REP   |               659|         925|  71.2432432|
|Ashborough East                    |DEM   |               318|         714|  44.5378151|
|Ashborough East                    |REP   |               348|         714|  48.7394958|
|Ashborough East 2                  |DEM   |               116|         703|  16.5007112|
|Ashborough East 2                  |REP   |               544|         703|  77.3826458|
|Ashborough West                    |DEM   |               103|         385|  26.7532468|
|Ashborough West                    |REP   |               243|         385|  63.1168831|
|Ashborough West 2                  |DEM   |               197|         934|  21.0920771|
|Ashborough West 2                  |REP   |               661|         934|  70.7708779|
|ASHETON LAKES                      |DEM   |               604|        2743|  22.0196865|
|ASHETON LAKES                      |REP   |              2003|        2743|  73.0222384|
|ASHLAND/STOKES BRIDGE              |DEM   |               131|         459|  28.5403050|
|ASHLAND/STOKES BRIDGE              |REP   |               312|         459|  67.9738562|
|Ashley River                       |DEM   |               745|        1768|  42.1380090|
|Ashley River                       |REP   |               917|        1768|  51.8665158|
|ASHTON-LODGE                       |DEM   |                98|         393|  24.9363868|
|ASHTON-LODGE                       |REP   |               279|         393|  70.9923664|
|ASHWOOD                            |DEM   |               192|         532|  36.0902256|
|ASHWOOD                            |REP   |               324|         532|  60.9022556|
|Ashworth                           |DEM   |                89|         956|   9.3096234|
|Ashworth                           |REP   |               842|         956|  88.0753138|
|ATLANTIC BEACH                     |DEM   |               114|         136|  83.8235294|
|ATLANTIC BEACH                     |REP   |                22|         136|  16.1764706|
|AUBURN                             |DEM   |               540|         673|  80.2377415|
|AUBURN                             |REP   |               115|         673|  17.0876672|
|AVON                               |DEM   |               384|        1389|  27.6457883|
|AVON                               |REP   |               925|        1389|  66.5946724|
|AWENDAW                            |DEM   |               569|         990|  57.4747475|
|AWENDAW                            |REP   |               397|         990|  40.1010101|
|AYNOR                              |DEM   |               218|        1328|  16.4156627|
|AYNOR                              |REP   |              1077|        1328|  81.0993976|
|BACK SWAMP                         |DEM   |               106|         389|  27.2493573|
|BACK SWAMP                         |REP   |               272|         389|  69.9228792|
|Bacons Bridge                      |DEM   |               420|        1339|  31.3666916|
|Bacons Bridge                      |REP   |               821|        1339|  61.3144137|
|Bacons Bridge 2                    |DEM   |               136|         438|  31.0502283|
|Bacons Bridge 2                    |REP   |               278|         438|  63.4703196|
|BAILEY                             |DEM   |               265|         749|  35.3805073|
|BAILEY                             |REP   |               446|         749|  59.5460614|
|BAKER CREEK                        |DEM   |               282|        1226|  23.0016313|
|BAKER CREEK                        |REP   |               897|        1226|  73.1647635|
|Baldwin Mill                       |DEM   |               429|         670|  64.0298507|
|Baldwin Mill                       |REP   |               220|         670|  32.8358209|
|Ballentine 1                       |DEM   |               319|        1010|  31.5841584|
|Ballentine 1                       |REP   |               606|        1010|  60.0000000|
|Ballentine 2                       |DEM   |               242|        1193|  20.2849958|
|Ballentine 2                       |REP   |               888|        1193|  74.4341995|
|Barker's Creek-McAdams             |DEM   |                37|         340|  10.8823529|
|Barker's Creek-McAdams             |REP   |               301|         340|  88.5294118|
|BARKSDALE-NARINE                   |DEM   |               215|         668|  32.1856287|
|BARKSDALE-NARINE                   |REP   |               430|         668|  64.3712575|
|BARNWELL 1                         |DEM   |               267|         487|  54.8254620|
|BARNWELL 1                         |REP   |               206|         487|  42.2997947|
|BARNWELL 2                         |DEM   |               422|        1097|  38.4685506|
|BARNWELL 2                         |REP   |               644|        1097|  58.7055606|
|BARNWELL 3                         |DEM   |               512|        1218|  42.0361248|
|BARNWELL 3                         |REP   |               647|        1218|  53.1198686|
|BARNWELL 4                         |DEM   |               656|        1011|  64.8862512|
|BARNWELL 4                         |REP   |               332|        1011|  32.8387735|
|Barr Road #1                       |DEM   |               241|        1061|  22.7144204|
|Barr Road #1                       |REP   |               771|        1061|  72.6672950|
|Barr Road #2                       |DEM   |               409|        2013|  20.3179334|
|Barr Road #2                       |REP   |              1471|        2013|  73.0750124|
|Barrineau                          |DEM   |                48|         480|  10.0000000|
|Barrineau                          |REP   |               431|         480|  89.7916667|
|Barrows Mill                       |DEM   |                50|         162|  30.8641975|
|Barrows Mill                       |REP   |               106|         162|  65.4320988|
|BATES                              |DEM   |               541|         558|  96.9534050|
|BATES                              |REP   |                12|         558|   2.1505376|
|Batesburg                          |DEM   |              1008|        1711|  58.9129164|
|Batesburg                          |REP   |               655|        1711|  38.2817066|
|Bath                               |DEM   |               323|         696|  46.4080460|
|Bath                               |REP   |               349|         696|  50.1436782|
|Baton Rouge                        |DEM   |                99|         476|  20.7983193|
|Baton Rouge                        |REP   |               360|         476|  75.6302521|
|Baxter                             |DEM   |               323|         971|  33.2646756|
|Baxter                             |REP   |               572|         971|  58.9083419|
|BAY SPRINGS                        |DEM   |                54|         314|  17.1974522|
|BAY SPRINGS                        |REP   |               246|         314|  78.3439490|
|BAYBORO-GURLEY                     |DEM   |               408|        1229|  33.1977217|
|BAYBORO-GURLEY                     |REP   |               782|        1229|  63.6289666|
|Beatty Road                        |DEM   |               609|         690|  88.2608696|
|Beatty Road                        |REP   |                58|         690|   8.4057971|
|BEAUFORT 1                         |DEM   |               359|         583|  61.5780446|
|BEAUFORT 1                         |REP   |               186|         583|  31.9039451|
|BEAUFORT 2                         |DEM   |               260|         621|  41.8679549|
|BEAUFORT 2                         |REP   |               314|         621|  50.5636071|
|BEAUFORT 3                         |DEM   |               240|         741|  32.3886640|
|BEAUFORT 3                         |REP   |               440|         741|  59.3792173|
|Beaumont Methodist                 |DEM   |               216|         473|  45.6659619|
|Beaumont Methodist                 |REP   |               238|         473|  50.3171247|
|Beckhamville                       |DEM   |               457|         878|  52.0501139|
|Beckhamville                       |REP   |               400|         878|  45.5580866|
|Beech Hill                         |DEM   |               194|         847|  22.9043684|
|Beech Hill                         |REP   |               615|         847|  72.6092090|
|Beech Hill 2                       |DEM   |               272|        1175|  23.1489362|
|Beech Hill 2                       |REP   |               808|        1175|  68.7659574|
|Beech Island                       |DEM   |               816|        1508|  54.1114058|
|Beech Island                       |REP   |               638|        1508|  42.3076923|
|Beech Springs Intermediate         |DEM   |               479|        1633|  29.3325168|
|Beech Springs Intermediate         |REP   |              1053|        1633|  64.4825475|
|BELFAIR                            |DEM   |               398|        1600|  24.8750000|
|BELFAIR                            |REP   |              1131|        1600|  70.6875000|
|BELLE MEADE                        |DEM   |              1475|        1576|  93.5913706|
|BELLE MEADE                        |REP   |                70|        1576|   4.4416244|
|BELLS                              |DEM   |                98|         238|  41.1764706|
|BELLS                              |REP   |               135|         238|  56.7226891|
|BELLS CROSSING                     |DEM   |               662|        2584|  25.6191950|
|BELLS CROSSING                     |REP   |              1745|        2584|  67.5309598|
|BELMONT                            |DEM   |               570|         837|  68.1003584|
|BELMONT                            |REP   |               242|         837|  28.9127838|
|Belton                             |DEM   |               342|        1364|  25.0733138|
|Belton                             |REP   |               969|        1364|  71.0410557|
|Belton Annex                       |DEM   |               369|        1484|  24.8652291|
|Belton Annex                       |REP   |              1049|        1484|  70.6873315|
|Belvedere No. 44                   |DEM   |               417|        1239|  33.6561743|
|Belvedere No. 44                   |REP   |               763|        1239|  61.5819209|
|Belvedere No. 62                   |DEM   |               539|         991|  54.3895055|
|Belvedere No. 62                   |REP   |               416|         991|  41.9778002|
|Belvedere No. 74                   |DEM   |               164|         552|  29.7101449|
|Belvedere No. 74                   |REP   |               363|         552|  65.7608696|
|Belvedere No. 9                    |DEM   |               659|        1424|  46.2780899|
|Belvedere No. 9                    |REP   |               686|        1424|  48.1741573|
|Ben Avon Methodist                 |DEM   |               254|         962|  26.4033264|
|Ben Avon Methodist                 |REP   |               656|         962|  68.1912682|
|BEREA                              |DEM   |               615|        1277|  48.1597494|
|BEREA                              |REP   |               599|        1277|  46.9068128|
|BEREA-SMOAKS                       |DEM   |               547|         858|  63.7529138|
|BEREA-SMOAKS                       |REP   |               297|         858|  34.6153846|
|BERMUDA                            |DEM   |                99|         224|  44.1964286|
|BERMUDA                            |REP   |               121|         224|  54.0178571|
|BETH-EDEN                          |DEM   |               126|         405|  31.1111111|
|BETH-EDEN                          |REP   |               245|         405|  60.4938272|
|Bethany                            |DEM   |               497|        2054|  24.1966894|
|Bethany                            |REP   |              1469|        2054|  71.5189873|
|Bethany Baptist                    |DEM   |               657|        1024|  64.1601562|
|Bethany Baptist                    |REP   |               316|        1024|  30.8593750|
|Bethany Wesleyan                   |DEM   |               487|        2215|  21.9864560|
|Bethany Wesleyan                   |REP   |              1642|        2215|  74.1309255|
|Bethel                             |DEM   |               364|        1232|  29.5454545|
|Bethel                             |REP   |               772|        1232|  62.6623377|
|BETHEL                             |DEM   |              1043|        2870|  36.3414634|
|BETHEL                             |REP   |              1753|        2870|  61.0801394|
|Bethel School                      |DEM   |               384|        1777|  21.6094541|
|Bethel School                      |REP   |              1303|        1777|  73.3258301|
|Bethera                            |DEM   |                20|         242|   8.2644628|
|Bethera                            |REP   |               213|         242|  88.0165289|
|Bethune                            |DEM   |               442|        1103|  40.0725295|
|Bethune                            |REP   |               614|        1103|  55.6663645|
|Beulah Church                      |DEM   |               227|        1767|  12.8466327|
|Beulah Church                      |REP   |              1466|        1767|  82.9654782|
|Beverly Hills                      |DEM   |               526|        1086|  48.4346225|
|Beverly Hills                      |REP   |               479|        1086|  44.1068140|
|Biltmore Pines                     |DEM   |               265|         861|  30.7781649|
|Biltmore Pines                     |REP   |               552|         861|  64.1114983|
|BIRNIE                             |DEM   |               706|         758|  93.1398417|
|BIRNIE                             |REP   |                26|         758|   3.4300792|
|Bishop's Branch                    |DEM   |               372|        1677|  22.1824687|
|Bishop's Branch                    |REP   |              1228|        1677|  73.2259988|
|BISHOPVILLE 1                      |DEM   |               431|         505|  85.3465347|
|BISHOPVILLE 1                      |REP   |                70|         505|  13.8613861|
|BISHOPVILLE 2                      |DEM   |               529|         614|  86.1563518|
|BISHOPVILLE 2                      |REP   |                68|         614|  11.0749186|
|BISHOPVILLE 3                      |DEM   |               364|         597|  60.9715243|
|BISHOPVILLE 3                      |REP   |               209|         597|  35.0083752|
|BISHOPVILLE 4                      |DEM   |               688|         829|  82.9915561|
|BISHOPVILLE 4                      |REP   |               127|         829|  15.3196622|
|Black Creek                        |DEM   |                54|         185|  29.1891892|
|Black Creek                        |REP   |               126|         185|  68.1081081|
|BLACK CREEK                        |DEM   |               119|         307|  38.7622150|
|BLACK CREEK                        |REP   |               180|         307|  58.6319218|
|BLACK CREEK-CLYDE                  |DEM   |               283|        1099|  25.7506824|
|BLACK CREEK-CLYDE                  |REP   |               791|        1099|  71.9745223|
|Black Horse Run                    |DEM   |               699|        2115|  33.0496454|
|Black Horse Run                    |REP   |              1304|        2115|  61.6548463|
|BLACK RIVER                        |DEM   |               368|        1344|  27.3809524|
|BLACK RIVER                        |REP   |               934|        1344|  69.4940476|
|BLACK ROCK                         |DEM   |               239|         383|  62.4020888|
|BLACK ROCK                         |REP   |               135|         383|  35.2480418|
|Blacksburg Ward No. 1              |DEM   |               218|         773|  28.2018111|
|Blacksburg Ward No. 1              |REP   |               539|         773|  69.7283312|
|Blacksburg Ward No. 2              |DEM   |               188|        1117|  16.8307968|
|Blacksburg Ward No. 2              |REP   |               885|        1117|  79.2300806|
|Blackstock                         |DEM   |               200|         474|  42.1940928|
|Blackstock                         |REP   |               254|         474|  53.5864979|
|BLACKSTOCK                         |DEM   |                54|          66|  81.8181818|
|BLACKSTOCK                         |REP   |                13|          66|  19.6969697|
|BLACKVILLE 1                       |DEM   |               609|         833|  73.1092437|
|BLACKVILLE 1                       |REP   |               207|         833|  24.8499400|
|BLACKVILLE 2                       |DEM   |               382|         532|  71.8045113|
|BLACKVILLE 2                       |REP   |               134|         532|  25.1879699|
|BLAIRS                             |DEM   |               445|         501|  88.8223553|
|BLAIRS                             |REP   |                50|         501|   9.9800399|
|BLENHEIM                           |DEM   |                94|         222|  42.3423423|
|BLENHEIM                           |REP   |               117|         222|  52.7027027|
|BLOOMINGVALE                       |DEM   |               601|         895|  67.1508380|
|BLOOMINGVALE                       |REP   |               265|         895|  29.6089385|
|Bloomville                         |DEM   |               129|         357|  36.1344538|
|Bloomville                         |REP   |               226|         357|  63.3053221|
|Bluff                              |DEM   |              1479|        1542|  95.9143969|
|Bluff                              |REP   |                40|        1542|   2.5940337|
|Bluffton 1A                        |DEM   |               455|        1040|  43.7500000|
|Bluffton 1A                        |REP   |               506|        1040|  48.6538462|
|Bluffton 1B                        |DEM   |               231|         710|  32.5352113|
|Bluffton 1B                        |REP   |               438|         710|  61.6901408|
|Bluffton 1C                        |DEM   |               301|        1072|  28.0783582|
|Bluffton 1C                        |REP   |               708|        1072|  66.0447761|
|Bluffton 1D                        |DEM   |               415|         954|  43.5010482|
|Bluffton 1D                        |REP   |               474|         954|  49.6855346|
|Bluffton 2A                        |DEM   |               271|         711|  38.1153305|
|Bluffton 2A                        |REP   |               405|         711|  56.9620253|
|Bluffton 2B                        |DEM   |               309|         782|  39.5140665|
|Bluffton 2B                        |REP   |               417|         782|  53.3248082|
|Bluffton 2C                        |DEM   |               459|        1671|  27.4685817|
|Bluffton 2C                        |REP   |              1103|        1671|  66.0083782|
|Bluffton 2D                        |DEM   |               486|        1770|  27.4576271|
|Bluffton 2D                        |REP   |              1180|        1770|  66.6666667|
|Bluffton 2E                        |DEM   |               473|         915|  51.6939891|
|Bluffton 2E                        |REP   |               387|         915|  42.2950820|
|Bluffton 3                         |DEM   |               136|         609|  22.3316913|
|Bluffton 3                         |REP   |               444|         609|  72.9064039|
|Bluffton 4A                        |DEM   |               132|         572|  23.0769231|
|Bluffton 4A                        |REP   |               422|         572|  73.7762238|
|Bluffton 4B                        |DEM   |               259|         947|  27.3495248|
|Bluffton 4B                        |REP   |               652|         947|  68.8489968|
|Bluffton 4C                        |DEM   |               476|        1259|  37.8077840|
|Bluffton 4C                        |REP   |               706|        1259|  56.0762510|
|Bluffton 4D                        |DEM   |               244|         928|  26.2931034|
|Bluffton 4D                        |REP   |               658|         928|  70.9051724|
|Bluffton 5A                        |DEM   |               214|         810|  26.4197531|
|Bluffton 5A                        |REP   |               575|         810|  70.9876543|
|Bluffton 5B                        |DEM   |               253|         712|  35.5337079|
|Bluffton 5B                        |REP   |               419|         712|  58.8483146|
|Blythewood 1                       |DEM   |               328|        1187|  27.6326874|
|Blythewood 1                       |REP   |               791|        1187|  66.6385847|
|Blythewood 2                       |DEM   |               753|        1670|  45.0898204|
|Blythewood 2                       |REP   |               842|        1670|  50.4191617|
|Blythewood 3                       |DEM   |               789|        1608|  49.0671642|
|Blythewood 3                       |REP   |               740|        1608|  46.0199005|
|Boiling Springs                    |DEM   |               262|        1550|  16.9032258|
|Boiling Springs                    |REP   |              1220|        1550|  78.7096774|
|BOILING SPRINGS                    |DEM   |               532|        1870|  28.4491979|
|BOILING SPRINGS                    |REP   |              1218|        1870|  65.1336898|
|Boiling Springs 9th Grade          |DEM   |               723|        2586|  27.9582367|
|Boiling Springs 9th Grade          |REP   |              1710|        2586|  66.1252900|
|Boiling Springs Elementary         |DEM   |               638|        2287|  27.8968080|
|Boiling Springs Elementary         |REP   |              1545|        2287|  67.5557499|
|Boiling Springs High School        |DEM   |               216|         934|  23.1263383|
|Boiling Springs High School        |REP   |               673|         934|  72.0556745|
|Boiling Springs Intermediate       |DEM   |               634|        1963|  32.2975038|
|Boiling Springs Intermediate       |REP   |              1248|        1963|  63.5761589|
|Boiling Springs South              |DEM   |               150|        1001|  14.9850150|
|Boiling Springs South              |REP   |               812|        1001|  81.1188811|
|BOLENTOWN                          |DEM   |               531|        1110|  47.8378378|
|BOLENTOWN                          |REP   |               558|        1110|  50.2702703|
|Boling Springs Jr. High            |DEM   |               124|         754|  16.4456233|
|Boling Springs Jr. High            |REP   |               590|         754|  78.2493369|
|BONHAM                             |DEM   |               248|         652|  38.0368098|
|BONHAM                             |REP   |               380|         652|  58.2822086|
|Bonneau                            |DEM   |               378|        1025|  36.8780488|
|Bonneau                            |REP   |               622|        1025|  60.6829268|
|Bonneau Beach                      |DEM   |               272|        1353|  20.1034738|
|Bonneau Beach                      |REP   |              1045|        1353|  77.2357724|
|Bonnett                            |DEM   |               206|         676|  30.4733728|
|Bonnett                            |REP   |               442|         676|  65.3846154|
|Bookman                            |DEM   |              1103|        1927|  57.2392320|
|Bookman                            |REP   |               700|        1927|  36.3258952|
|BOTANY WOODS                       |DEM   |               470|        1440|  32.6388889|
|BOTANY WOODS                       |REP   |               866|        1440|  60.1388889|
|Bountyland                         |DEM   |               245|        1179|  20.7803223|
|Bountyland                         |REP   |               876|        1179|  74.3002545|
|Bowling Green                      |DEM   |               281|        1748|  16.0755149|
|Bowling Green                      |REP   |              1384|        1748|  79.1762014|
|BOWMAN 1                           |DEM   |               886|        1206|  73.4660033|
|BOWMAN 1                           |REP   |               300|        1206|  24.8756219|
|BOWMAN 2                           |DEM   |               459|         782|  58.6956522|
|BOWMAN 2                           |REP   |               300|         782|  38.3631714|
|Bradley                            |DEM   |                72|         213|  33.8028169|
|Bradley                            |REP   |               130|         213|  61.0328638|
|BRANCHVILLE 1                      |DEM   |               411|         918|  44.7712418|
|BRANCHVILLE 1                      |REP   |               481|         918|  52.3965142|
|BRANCHVILLE 2                      |DEM   |               156|         432|  36.1111111|
|BRANCHVILLE 2                      |REP   |               263|         432|  60.8796296|
|Brandon 1                          |DEM   |               967|        1338|  72.2720478|
|Brandon 1                          |REP   |               304|        1338|  22.7204783|
|Brandon 2                          |DEM   |              1104|        1433|  77.0411724|
|Brandon 2                          |REP   |               221|        1433|  15.4221912|
|Brandymill                         |DEM   |               140|         515|  27.1844660|
|Brandymill                         |REP   |               327|         515|  63.4951456|
|Brandymill 2                       |DEM   |               349|        1015|  34.3842365|
|Brandymill 2                       |REP   |               591|        1015|  58.2266010|
|Breezy Hill                        |DEM   |               647|        1919|  33.7154768|
|Breezy Hill                        |REP   |              1189|        1919|  61.9593538|
|BREWERTON                          |DEM   |                43|         431|   9.9767981|
|BREWERTON                          |REP   |               369|         431|  85.6148492|
|Briarwood                          |DEM   |              1580|        2561|  61.6946505|
|Briarwood                          |REP   |               843|        2561|  32.9168294|
|Briarwood 2                        |DEM   |               247|         715|  34.5454545|
|Briarwood 2                        |REP   |               430|         715|  60.1398601|
|Briarwood 3                        |DEM   |               150|         593|  25.2951096|
|Briarwood 3                        |REP   |               398|         593|  67.1163575|
|Bridge Creek                       |DEM   |              1062|        1403|  75.6949394|
|Bridge Creek                       |REP   |               291|        1403|  20.7412687|
|BRIDGE FORK                        |DEM   |               394|        1546|  25.4851229|
|BRIDGE FORK                        |REP   |              1098|        1546|  71.0219922|
|BRIGHTSVILLE                       |DEM   |               265|         512|  51.7578125|
|BRIGHTSVILLE                       |REP   |               233|         512|  45.5078125|
|BRITTON'S NECK                     |DEM   |               926|        1308|  70.7951070|
|BRITTON'S NECK                     |REP   |               360|        1308|  27.5229358|
|Broadmouth                         |DEM   |               104|         435|  23.9080460|
|Broadmouth                         |REP   |               315|         435|  72.4137931|
|Broadview                          |DEM   |               369|         556|  66.3669065|
|Broadview                          |REP   |               175|         556|  31.4748201|
|Broadway                           |DEM   |               369|        1045|  35.3110048|
|Broadway                           |REP   |               632|        1045|  60.4784689|
|BROCKS MILL                        |DEM   |               725|        1145|  63.3187773|
|BROCKS MILL                        |REP   |               400|        1145|  34.9344978|
|BROOKDALE                          |DEM   |               875|         909|  96.2596260|
|BROOKDALE                          |REP   |                24|         909|   2.6402640|
|BROOKGLENN                         |DEM   |               368|        1120|  32.8571429|
|BROOKGLENN                         |REP   |               677|        1120|  60.4464286|
|BROOKGREEN                         |DEM   |               440|         558|  78.8530466|
|BROOKGREEN                         |REP   |               111|         558|  19.8924731|
|BROOKSVILLE #1                     |DEM   |               657|        2327|  28.2337774|
|BROOKSVILLE #1                     |REP   |              1585|        2327|  68.1134508|
|BROOKSVILLE #2                     |DEM   |               304|         869|  34.9827388|
|BROOKSVILLE #2                     |REP   |               534|         869|  61.4499425|
|BROWN'S FERRY                      |DEM   |              1318|        1589|  82.9452486|
|BROWN'S FERRY                      |REP   |               245|        1589|  15.4185022|
|BROWNSVILLE                        |DEM   |                84|         275|  30.5454545|
|BROWNSVILLE                        |REP   |               187|         275|  68.0000000|
|BROWNWAY                           |DEM   |               189|        1380|  13.6956522|
|BROWNWAY                           |REP   |              1146|        1380|  83.0434783|
|Brunson                            |DEM   |               541|         976|  55.4303279|
|Brunson                            |REP   |               401|         976|  41.0860656|
|Brushy Creek                       |DEM   |               599|        3445|  17.3875181|
|Brushy Creek                       |REP   |              2698|        3445|  78.3164006|
|Buffalo                            |DEM   |               170|         844|  20.1421801|
|Buffalo                            |REP   |               659|         844|  78.0805687|
|BUFFALO BOX 1                      |DEM   |               146|         638|  22.8840125|
|BUFFALO BOX 1                      |REP   |               452|         638|  70.8463950|
|Bullocks Creek                     |DEM   |                66|         361|  18.2825485|
|Bullocks Creek                     |REP   |               283|         361|  78.3933518|
|BUNRS-DOWNS                        |DEM   |               223|         619|  36.0258481|
|BUNRS-DOWNS                        |REP   |               376|         619|  60.7431341|
|BURGESS #1                         |DEM   |               460|        1823|  25.2331322|
|BURGESS #1                         |REP   |              1297|        1823|  71.1464619|
|BURGESS #2                         |DEM   |               706|        2849|  24.7806248|
|BURGESS #2                         |REP   |              2061|        2849|  72.3411723|
|BURGESS #3                         |DEM   |               658|        2695|  24.4155844|
|BURGESS #3                         |REP   |              1943|        2695|  72.0964750|
|BURGESS #4                         |DEM   |               392|        1625|  24.1230769|
|BURGESS #4                         |REP   |              1179|        1625|  72.5538462|
|BURNT BRANCH                       |DEM   |               190|         584|  32.5342466|
|BURNT BRANCH                       |REP   |               376|         584|  64.3835616|
|BURTON 1A                          |DEM   |               370|        1093|  33.8517841|
|BURTON 1A                          |REP   |               667|        1093|  61.0247027|
|BURTON 1B                          |DEM   |               569|         749|  75.9679573|
|BURTON 1B                          |REP   |               147|         749|  19.6261682|
|BURTON 1C                          |DEM   |               480|         943|  50.9013786|
|BURTON 1C                          |REP   |               408|         943|  43.2661718|
|BURTON 1D                          |DEM   |               171|         457|  37.4179431|
|BURTON 1D                          |REP   |               259|         457|  56.6739606|
|BURTON 2A                          |DEM   |               305|         980|  31.1224490|
|BURTON 2A                          |REP   |               620|         980|  63.2653061|
|BURTON 2B                          |DEM   |               481|        1205|  39.9170124|
|BURTON 2B                          |REP   |               646|        1205|  53.6099585|
|BURTON 2C                          |DEM   |               349|        1232|  28.3279221|
|BURTON 2C                          |REP   |               825|        1232|  66.9642857|
|BURTON 3                           |DEM   |               212|         380|  55.7894737|
|BURTON 3                           |REP   |               136|         380|  35.7894737|
|Bush River                         |DEM   |               536|        1265|  42.3715415|
|Bush River                         |REP   |               638|        1265|  50.4347826|
|BUSH RIVER                         |DEM   |                71|         239|  29.7071130|
|BUSH RIVER                         |REP   |               164|         239|  68.6192469|
|Butternut                          |DEM   |               420|        1256|  33.4394904|
|Butternut                          |REP   |               755|        1256|  60.1114650|
|C.C. Woodson Recreation            |DEM   |              1022|        1068|  95.6928839|
|C.C. Woodson Recreation            |REP   |                33|        1068|   3.0898876|
|CADES                              |DEM   |               282|         454|  62.1145374|
|CADES                              |REP   |               169|         454|  37.2246696|
|Cainhoy                            |DEM   |               814|         976|  83.4016393|
|Cainhoy                            |REP   |               149|         976|  15.2663934|
|Calhoun                            |DEM   |               355|         737|  48.1682497|
|Calhoun                            |REP   |               307|         737|  41.6553596|
|Calhoun Falls                      |DEM   |               916|        1538|  59.5578674|
|Calhoun Falls                      |REP   |               585|        1538|  38.0364109|
|Callison                           |DEM   |               174|         787|  22.1092757|
|Callison                           |REP   |               583|         787|  74.0787802|
|Calvary                            |DEM   |               398|         488|  81.5573770|
|Calvary                            |REP   |                81|         488|  16.5983607|
|Camden No. 1                       |DEM   |               534|         945|  56.5079365|
|Camden No. 1                       |REP   |               372|         945|  39.3650794|
|Camden No. 2 & 3                   |DEM   |                79|         195|  40.5128205|
|Camden No. 2 & 3                   |REP   |               104|         195|  53.3333333|
|Camden No. 5                       |DEM   |               148|         486|  30.4526749|
|Camden No. 5                       |REP   |               314|         486|  64.6090535|
|Camden No. 5-A                     |DEM   |               274|         394|  69.5431472|
|Camden No. 5-A                     |REP   |               115|         394|  29.1878173|
|Camden No. 6                       |DEM   |               101|         270|  37.4074074|
|Camden No. 6                       |REP   |               153|         270|  56.6666667|
|CAMERON                            |DEM   |               337|         624|  54.0064103|
|CAMERON                            |REP   |               257|         624|  41.1858974|
|Camp Creek                         |DEM   |                98|         657|  14.9162861|
|Camp Creek                         |REP   |               544|         657|  82.8006088|
|Canaan                             |DEM   |               274|         876|  31.2785388|
|Canaan                             |REP   |               561|         876|  64.0410959|
|CANADYS                            |DEM   |               179|         424|  42.2169811|
|CANADYS                            |REP   |               222|         424|  52.3584906|
|Cane Bay                           |DEM   |               871|        2995|  29.0818030|
|Cane Bay                           |REP   |              1946|        2995|  64.9749583|
|CANEBRAKE                          |DEM   |               689|        2471|  27.8834480|
|CANEBRAKE                          |REP   |              1654|        2471|  66.9364630|
|Cannon Mill                        |DEM   |               279|         980|  28.4693878|
|Cannon Mill                        |REP   |               638|         980|  65.1020408|
|Cannons Elementary                 |DEM   |               259|         799|  32.4155194|
|Cannons Elementary                 |REP   |               511|         799|  63.9549437|
|CARLISLE                           |DEM   |               452|         497|  90.9456740|
|CARLISLE                           |REP   |                36|         497|   7.2434608|
|Carlisle Fosters Grove             |DEM   |               221|        1513|  14.6067416|
|Carlisle Fosters Grove             |REP   |              1234|        1513|  81.5598149|
|Carmel                             |DEM   |               210|         458|  45.8515284|
|Carmel                             |REP   |               244|         458|  53.2751092|
|Carnes Cross Road 1                |DEM   |               250|        2075|  12.0481928|
|Carnes Cross Road 1                |REP   |              1723|        2075|  83.0361446|
|Carnes Cross Road 2                |DEM   |               325|         903|  35.9911406|
|Carnes Cross Road 2                |REP   |               531|         903|  58.8039867|
|Carolina                           |DEM   |               891|        2220|  40.1351351|
|Carolina                           |REP   |              1204|        2220|  54.2342342|
|CAROLINA                           |DEM   |              1045|        1400|  74.6428571|
|CAROLINA                           |REP   |               324|        1400|  23.1428571|
|CAROLINA BAYS                      |DEM   |               380|        1545|  24.5954693|
|CAROLINA BAYS                      |REP   |              1112|        1545|  71.9741100|
|CAROLINA FOREST #1                 |DEM   |               641|        2406|  26.6417290|
|CAROLINA FOREST #1                 |REP   |              1655|        2406|  68.7863674|
|CAROLINA FOREST #2                 |DEM   |               468|        1574|  29.7331639|
|CAROLINA FOREST #2                 |REP   |              1031|        1574|  65.5019060|
|Carolina Heights                   |DEM   |               668|         982|  68.0244399|
|Carolina Heights                   |REP   |               267|         982|  27.1894094|
|Carolina Springs                   |DEM   |               374|        1307|  28.6151492|
|Carolina Springs                   |REP   |               844|        1307|  64.5753634|
|CARTERSVILLE                       |DEM   |               312|         715|  43.6363636|
|CARTERSVILLE                       |REP   |               387|         715|  54.1258741|
|CARVER'S BAY                       |DEM   |                38|         171|  22.2222222|
|CARVER'S BAY                       |REP   |               125|         171|  73.0994152|
|CASH                               |DEM   |               525|         899|  58.3982202|
|CASH                               |REP   |               361|         899|  40.1557286|
|Cassatt                            |DEM   |               344|        1171|  29.3766012|
|Cassatt                            |REP   |               772|        1171|  65.9265585|
|CASTLE ROCK                        |DEM   |               379|        2287|  16.5719283|
|CASTLE ROCK                        |REP   |              1811|        2287|  79.1867075|
|Catawba                            |DEM   |               473|        1968|  24.0345528|
|Catawba                            |REP   |              1435|        1968|  72.9166667|
|Caughman Road                      |DEM   |               892|        1230|  72.5203252|
|Caughman Road                      |REP   |               298|        1230|  24.2276423|
|CAUSEWAY BRANCH 1                  |DEM   |               293|         878|  33.3712984|
|CAUSEWAY BRANCH 1                  |REP   |               531|         878|  60.4783599|
|CAUSEWAY BRANCH 2                  |DEM   |               191|         524|  36.4503817|
|CAUSEWAY BRANCH 2                  |REP   |               310|         524|  59.1603053|
|Cavins Hobbysville                 |DEM   |               129|         828|  15.5797101|
|Cavins Hobbysville                 |REP   |               682|         828|  82.3671498|
|Cayce Ward 2-A                     |DEM   |               341|         995|  34.2713568|
|Cayce Ward 2-A                     |REP   |               598|         995|  60.1005025|
|Cayce Ward No.1                    |DEM   |               482|         975|  49.4358974|
|Cayce Ward No.1                    |REP   |               399|         975|  40.9230769|
|Cayce Ward No.2                    |DEM   |               818|        1365|  59.9267399|
|Cayce Ward No.2                    |REP   |               469|        1365|  34.3589744|
|Cayce Ward No.3                    |DEM   |               214|         563|  38.0106572|
|Cayce Ward No.3                    |REP   |               309|         563|  54.8845471|
|CEDAR CREEK                        |DEM   |               231|         801|  28.8389513|
|CEDAR CREEK                        |REP   |               550|         801|  68.6641698|
|Cedar Creek No. 64                 |DEM   |               203|         967|  20.9927611|
|Cedar Creek No. 64                 |REP   |               732|         967|  75.6980352|
|Cedar Grove                        |DEM   |               207|        1124|  18.4163701|
|Cedar Grove                        |REP   |               886|        1124|  78.8256228|
|CEDAR GROVE                        |DEM   |                96|         746|  12.8686327|
|CEDAR GROVE                        |REP   |               634|         746|  84.9865952|
|Cedar Grove Baptist                |DEM   |               919|        1093|  84.0805124|
|Cedar Grove Baptist                |REP   |               148|        1093|  13.5407136|
|Cedar Rock                         |DEM   |               116|        1124|  10.3202847|
|Cedar Rock                         |REP   |               981|        1124|  87.2775801|
|CEDAR SWAMP                        |DEM   |               127|         260|  48.8461538|
|CEDAR SWAMP                        |REP   |               126|         260|  48.4615385|
|Cedarcrest                         |DEM   |               404|        1299|  31.1008468|
|Cedarcrest                         |REP   |               807|        1299|  62.1247113|
|CENTENARY                          |DEM   |               807|        1138|  70.9138840|
|CENTENARY                          |REP   |               296|        1138|  26.0105448|
|CENTENNIAL                         |DEM   |                98|         403|  24.3176179|
|CENTENNIAL                         |REP   |               286|         403|  70.9677419|
|CENTER GROVE-WINZO                 |DEM   |               498|         860|  57.9069767|
|CENTER GROVE-WINZO                 |REP   |               351|         860|  40.8139535|
|CENTER HILL                        |DEM   |               539|         973|  55.3956835|
|CENTER HILL                        |REP   |               400|         973|  41.1099692|
|Center Rock                        |DEM   |               395|        1881|  20.9994684|
|Center Rock                        |REP   |              1428|        1881|  75.9170654|
|CENTERVILLE                        |DEM   |                93|         298|  31.2080537|
|CENTERVILLE                        |REP   |               201|         298|  67.4496644|
|Centerville Station A              |DEM   |               501|        2093|  23.9369326|
|Centerville Station A              |REP   |              1517|        2093|  72.4796942|
|Centerville Station B              |DEM   |               568|        2001|  28.3858071|
|Centerville Station B              |REP   |              1338|        2001|  66.8665667|
|Central                            |DEM   |               979|        2797|  35.0017876|
|Central                            |REP   |              1631|        2797|  58.3124777|
|CENTRAL                            |DEM   |               532|         806|  66.0049628|
|CENTRAL                            |REP   |               260|         806|  32.2580645|
|Central 2                          |DEM   |               356|        1008|  35.3174603|
|Central 2                          |REP   |               597|        1008|  59.2261905|
|Chalk Hill                         |DEM   |              1794|        2323|  77.2277228|
|Chalk Hill                         |REP   |               460|        2323|  19.8019802|
|Challedon                          |DEM   |               693|        1294|  53.5548686|
|Challedon                          |REP   |               500|        1294|  38.6398764|
|Chapin                             |DEM   |               585|        2349|  24.9042146|
|Chapin                             |REP   |              1653|        2349|  70.3703704|
|Chapman Elementary                 |DEM   |               402|        1141|  35.2322524|
|Chapman Elementary                 |REP   |               672|        1141|  58.8957055|
|Chapman High School                |DEM   |               622|        2002|  31.0689311|
|Chapman High School                |REP   |              1307|        2002|  65.2847153|
|CHAPPELLS                          |DEM   |               196|         622|  31.5112540|
|CHAPPELLS                          |REP   |               401|         622|  64.4694534|
|CHARLESTON 1                       |DEM   |               187|         586|  31.9112628|
|CHARLESTON 1                       |REP   |               360|         586|  61.4334471|
|CHARLESTON 10                      |DEM   |               312|         431|  72.3897912|
|CHARLESTON 10                      |REP   |                72|         431|  16.7053364|
|CHARLESTON 11                      |DEM   |               528|         872|  60.5504587|
|CHARLESTON 11                      |REP   |               244|         872|  27.9816514|
|CHARLESTON 12                      |DEM   |               690|         909|  75.9075908|
|CHARLESTON 12                      |REP   |               156|         909|  17.1617162|
|CHARLESTON 13                      |DEM   |               645|         799|  80.7259074|
|CHARLESTON 13                      |REP   |                92|         799|  11.5143930|
|CHARLESTON 14                      |DEM   |               505|         687|  73.5080058|
|CHARLESTON 14                      |REP   |               123|         687|  17.9039301|
|CHARLESTON 15                      |DEM   |               854|         940|  90.8510638|
|CHARLESTON 15                      |REP   |                36|         940|   3.8297872|
|CHARLESTON 16                      |DEM   |               689|         839|  82.1215733|
|CHARLESTON 16                      |REP   |                81|         839|   9.6543504|
|CHARLESTON 17                      |DEM   |               518|         678|  76.4011799|
|CHARLESTON 17                      |REP   |                99|         678|  14.6017699|
|CHARLESTON 18                      |DEM   |               921|        1034|  89.0715667|
|CHARLESTON 18                      |REP   |                69|        1034|   6.6731141|
|CHARLESTON 19                      |DEM   |               550|         658|  83.5866261|
|CHARLESTON 19                      |REP   |                66|         658|  10.0303951|
|CHARLESTON 2                       |DEM   |               244|         631|  38.6687797|
|CHARLESTON 2                       |REP   |               347|         631|  54.9920761|
|CHARLESTON 20                      |DEM   |               632|         920|  68.6956522|
|CHARLESTON 20                      |REP   |               205|         920|  22.2826087|
|CHARLESTON 21                      |DEM   |               481|         550|  87.4545455|
|CHARLESTON 21                      |REP   |                47|         550|   8.5454545|
|CHARLESTON 3                       |DEM   |               337|         676|  49.8520710|
|CHARLESTON 3                       |REP   |               279|         676|  41.2721893|
|CHARLESTON 4                       |DEM   |               356|         634|  56.1514196|
|CHARLESTON 4                       |REP   |               217|         634|  34.2271293|
|CHARLESTON 5                       |DEM   |               311|         582|  53.4364261|
|CHARLESTON 5                       |REP   |               228|         582|  39.1752577|
|CHARLESTON 6                       |DEM   |               412|         716|  57.5418994|
|CHARLESTON 6                       |REP   |               238|         716|  33.2402235|
|CHARLESTON 7                       |DEM   |               475|         842|  56.4133017|
|CHARLESTON 7                       |REP   |               286|         842|  33.9667458|
|CHARLESTON 8                       |DEM   |               673|         788|  85.4060914|
|CHARLESTON 8                       |REP   |                52|         788|   6.5989848|
|CHARLESTON 9                       |DEM   |               431|         597|  72.1943049|
|CHARLESTON 9                       |REP   |               119|         597|  19.9329983|
|Charlotte Thompson                 |DEM   |               517|        1146|  45.1134380|
|Charlotte Thompson                 |REP   |               591|        1146|  51.5706806|
|CHECHESSEE 1                       |DEM   |               354|        1214|  29.1598023|
|CHECHESSEE 1                       |REP   |               806|        1214|  66.3920923|
|CHECHESSEE 2                       |DEM   |               303|        1088|  27.8492647|
|CHECHESSEE 2                       |REP   |               735|        1088|  67.5551471|
|CHERAW NO. 1                       |DEM   |               431|        1045|  41.2440191|
|CHERAW NO. 1                       |REP   |               573|        1045|  54.8325359|
|CHERAW NO. 2                       |DEM   |               397|         764|  51.9633508|
|CHERAW NO. 2                       |REP   |               338|         764|  44.2408377|
|CHERAW NO. 3                       |DEM   |              1057|        1378|  76.7053701|
|CHERAW NO. 3                       |REP   |               288|        1378|  20.8998549|
|CHERAW NO. 4                       |DEM   |               590|        1019|  57.8999019|
|CHERAW NO. 4                       |REP   |               390|        1019|  38.2728165|
|Cherokee Springs Fire Station      |DEM   |               247|        1159|  21.3114754|
|Cherokee Springs Fire Station      |REP   |               852|        1159|  73.5116480|
|CHERRY GROVE #1                    |DEM   |               334|        1434|  23.2914923|
|CHERRY GROVE #1                    |REP   |              1059|        1434|  73.8493724|
|CHERRY GROVE #2                    |DEM   |               443|        1741|  25.4451465|
|CHERRY GROVE #2                    |REP   |              1243|        1741|  71.3957496|
|CHERRYVALE                         |DEM   |               357|         568|  62.8521127|
|CHERRYVALE                         |REP   |               195|         568|  34.3309859|
|Chesnee Elementary                 |DEM   |               549|        2200|  24.9545455|
|Chesnee Elementary                 |REP   |              1556|        2200|  70.7272727|
|Chester Ward 1                     |DEM   |               583|         827|  70.4957678|
|Chester Ward 1                     |REP   |               215|         827|  25.9975816|
|Chester Ward 2                     |DEM   |               447|         539|  82.9313544|
|Chester Ward 2                     |REP   |                80|         539|  14.8423006|
|Chester Ward 3                     |DEM   |               375|         672|  55.8035714|
|Chester Ward 3                     |REP   |               270|         672|  40.1785714|
|Chester Ward 4                     |DEM   |               477|         633|  75.3554502|
|Chester Ward 4                     |REP   |               136|         633|  21.4849921|
|Chester Ward 5                     |DEM   |               176|         404|  43.5643564|
|Chester Ward 5                     |REP   |               216|         404|  53.4653465|
|Chesterfield Ave                   |DEM   |               596|         744|  80.1075269|
|Chesterfield Ave                   |REP   |               118|         744|  15.8602151|
|CHESTNUT HILLS                     |DEM   |               677|        1391|  48.6700216|
|CHESTNUT HILLS                     |REP   |               634|        1391|  45.5787203|
|China Springs                      |DEM   |               827|        1168|  70.8047945|
|China Springs                      |REP   |               303|        1168|  25.9417808|
|Chiquola Mill                      |DEM   |               209|         481|  43.4511435|
|Chiquola Mill                      |REP   |               252|         481|  52.3908524|
|CHOPPEE                            |DEM   |               637|         837|  76.1051374|
|CHOPPEE                            |REP   |               188|         837|  22.4611708|
|CHRIST CHURCH                      |DEM   |               400|         704|  56.8181818|
|CHRIST CHURCH                      |REP   |               279|         704|  39.6306818|
|CIRCLE CREEK                       |DEM   |               636|        2373|  26.8015171|
|CIRCLE CREEK                       |REP   |              1616|        2373|  68.0994522|
|Civic Center                       |DEM   |               519|         869|  59.7238205|
|Civic Center                       |REP   |               326|         869|  37.5143843|
|Clark's Hill                       |DEM   |               291|         519|  56.0693642|
|Clark's Hill                       |REP   |               217|         519|  41.8111753|
|CLAUSSEN                           |DEM   |               412|        1296|  31.7901235|
|CLAUSSEN                           |REP   |               856|        1296|  66.0493827|
|CLEAR CREEK                        |DEM   |               240|        1561|  15.3747598|
|CLEAR CREEK                        |REP   |              1219|        1561|  78.0909673|
|Clearwater                         |DEM   |               246|         528|  46.5909091|
|Clearwater                         |REP   |               272|         528|  51.5151515|
|Clemson                            |DEM   |               719|        2186|  32.8911253|
|Clemson                            |REP   |              1319|        2186|  60.3385178|
|Clemson 2                          |DEM   |               379|        1384|  27.3843931|
|Clemson 2                          |REP   |               918|        1384|  66.3294798|
|Clemson 3                          |DEM   |               324|         983|  32.9603255|
|Clemson 3                          |REP   |               612|         983|  62.2583927|
|Cleveland Elementary               |DEM   |               848|         986|  86.0040568|
|Cleveland Elementary               |REP   |               110|         986|  11.1561866|
|Clifdale Elementary                |DEM   |               169|         620|  27.2580645|
|Clifdale Elementary                |REP   |               421|         620|  67.9032258|
|CLINTON 1                          |DEM   |               422|         985|  42.8426396|
|CLINTON 1                          |REP   |               509|         985|  51.6751269|
|CLINTON 2                          |DEM   |               390|         881|  44.2678774|
|CLINTON 2                          |REP   |               432|         881|  49.0351873|
|CLINTON 3                          |DEM   |               292|        1115|  26.1883408|
|CLINTON 3                          |REP   |               783|        1115|  70.2242152|
|CLINTON MILL                       |DEM   |               675|        1053|  64.1025641|
|CLINTON MILL                       |REP   |               320|        1053|  30.3893637|
|CLIO                               |DEM   |               717|        1013|  70.7798618|
|CLIO                               |REP   |               272|        1013|  26.8509378|
|Clover                             |DEM   |               239|        1089|  21.9467401|
|Clover                             |REP   |               798|        1089|  73.2782369|
|CLYDE                              |DEM   |                26|         221|  11.7647059|
|CLYDE                              |REP   |               183|         221|  82.8054299|
|Coastal                            |DEM   |               434|         841|  51.6052319|
|Coastal                            |REP   |               329|         841|  39.1200951|
|Coastal 2                          |DEM   |               438|        1212|  36.1386139|
|Coastal 2                          |REP   |               700|        1212|  57.7557756|
|Coastal 3                          |DEM   |               194|         516|  37.5968992|
|Coastal 3                          |REP   |               276|         516|  53.4883721|
|COASTAL CAROLINA                   |DEM   |               484|        1219|  39.7046760|
|COASTAL CAROLINA                   |REP   |               652|        1219|  53.4864643|
|COASTAL LANE #1                    |DEM   |               770|         893|  86.2262038|
|COASTAL LANE #1                    |REP   |                96|         893|  10.7502800|
|COASTAL LANE #2                    |DEM   |               690|         980|  70.4081633|
|COASTAL LANE #2                    |REP   |               247|         980|  25.2040816|
|Cokesbury                          |DEM   |               452|         877|  51.5393387|
|Cokesbury                          |REP   |               397|         877|  45.2679590|
|Cold Springs                       |DEM   |               137|         658|  20.8206687|
|Cold Springs                       |REP   |               504|         658|  76.5957447|
|Coldstream                         |DEM   |               530|        1481|  35.7866307|
|Coldstream                         |REP   |               849|        1481|  57.3261310|
|COLES CR ROADS                     |DEM   |               614|        1597|  38.4470883|
|COLES CR ROADS                     |REP   |               902|        1597|  56.4809017|
|College Acres                      |DEM   |               366|        1345|  27.2118959|
|College Acres                      |REP   |               891|        1345|  66.2453532|
|College Place                      |DEM   |              1144|        1207|  94.7804474|
|College Place                      |REP   |                31|        1207|   2.5683513|
|COLSTON                            |DEM   |                53|         167|  31.7365269|
|COLSTON                            |REP   |               111|         167|  66.4670659|
|Concrete                           |DEM   |               488|        2493|  19.5748095|
|Concrete                           |REP   |              1897|        2493|  76.0930606|
|CONESTEE                           |DEM   |               896|        1960|  45.7142857|
|CONESTEE                           |REP   |               975|        1960|  49.7448980|
|Congaree #1                        |DEM   |               265|        1386|  19.1197691|
|Congaree #1                        |REP   |              1069|        1386|  77.1284271|
|Congaree #2                        |DEM   |               242|         855|  28.3040936|
|Congaree #2                        |REP   |               586|         855|  68.5380117|
|CONSOLIDATED #5                    |DEM   |               252|         832|  30.2884615|
|CONSOLIDATED #5                    |REP   |               545|         832|  65.5048077|
|Converse Fire Station              |DEM   |               282|         936|  30.1282051|
|Converse Fire Station              |REP   |               631|         936|  67.4145299|
|COOKS                              |DEM   |               546|        1878|  29.0734824|
|COOKS                              |REP   |              1232|        1878|  65.6017039|
|COOL SPRINGS                       |DEM   |                87|         391|  22.2506394|
|COOL SPRINGS                       |REP   |               297|         391|  75.9590793|
|Cooley Springs Baptist             |DEM   |               408|        1853|  22.0183486|
|Cooley Springs Baptist             |REP   |              1363|        1853|  73.5563950|
|Cooper                             |DEM   |               285|         757|  37.6486129|
|Cooper                             |REP   |               419|         757|  55.3500661|
|Coosaw                             |DEM   |               527|        1410|  37.3758865|
|Coosaw                             |REP   |               783|        1410|  55.5319149|
|Coosaw 2                           |DEM   |               677|        1531|  44.2194644|
|Coosaw 2                           |REP   |               757|        1531|  49.4448073|
|Coosaw 3                           |DEM   |               364|        1052|  34.6007605|
|Coosaw 3                           |REP   |               630|        1052|  59.8859316|
|Coosawhatchie                      |DEM   |               240|         346|  69.3641618|
|Coosawhatchie                      |REP   |                89|         346|  25.7225434|
|COPE                               |DEM   |               292|         638|  45.7680251|
|COPE                               |REP   |               328|         638|  51.4106583|
|Cordesville                        |DEM   |               328|         946|  34.6723044|
|Cordesville                        |REP   |               578|         946|  61.0993658|
|CORDOVA 1                          |DEM   |               599|        1248|  47.9967949|
|CORDOVA 1                          |REP   |               625|        1248|  50.0801282|
|CORDOVA 2                          |DEM   |               785|        1268|  61.9085174|
|CORDOVA 2                          |REP   |               461|        1268|  36.3564669|
|Cornerstone Baptist                |DEM   |               712|        1130|  63.0088496|
|Cornerstone Baptist                |REP   |               366|        1130|  32.3893805|
|Coronaca                           |DEM   |               169|        1117|  15.1298120|
|Coronaca                           |REP   |               907|        1117|  81.1996419|
|COTTAGEVILLE                       |DEM   |               294|        1073|  27.3998136|
|COTTAGEVILLE                       |REP   |               726|        1073|  67.6607642|
|Cotton Belt                        |DEM   |               213|        1232|  17.2889610|
|Cotton Belt                        |REP   |               967|        1232|  78.4902597|
|Couchton                           |DEM   |               371|        1042|  35.6046065|
|Couchton                           |REP   |               619|        1042|  59.4049904|
|COURTHOUSE                         |DEM   |               436|        1234|  35.3322528|
|COURTHOUSE                         |REP   |               768|        1234|  62.2366288|
|COWARDS NO. 1                      |DEM   |               204|         675|  30.2222222|
|COWARDS NO. 1                      |REP   |               447|         675|  66.2222222|
|COWARDS NO. 2                      |DEM   |               180|         732|  24.5901639|
|COWARDS NO. 2                      |REP   |               536|         732|  73.2240437|
|Cowpens Depot Museum               |DEM   |               351|        1011|  34.7181009|
|Cowpens Depot Museum               |REP   |               633|        1011|  62.6112760|
|Cowpens Fire Station               |DEM   |               270|        1427|  18.9208129|
|Cowpens Fire Station               |REP   |              1097|        1427|  76.8745620|
|Cox's Creek                        |DEM   |               148|         633|  23.3807267|
|Cox's Creek                        |REP   |               441|         633|  69.6682464|
|Craytonville                       |DEM   |                74|         914|   8.0962801|
|Craytonville                       |REP   |               813|         914|  88.9496718|
|Crescent Hill                      |DEM   |                89|         940|   9.4680851|
|Crescent Hill                      |REP   |               806|         940|  85.7446809|
|CRESENT                            |DEM   |               335|        1391|  24.0833932|
|CRESENT                            |REP   |               981|        1391|  70.5248023|
|CRESTON                            |DEM   |                85|         199|  42.7135678|
|CRESTON                            |REP   |               110|         199|  55.2763819|
|Crestview                          |DEM   |               149|         987|  15.0962513|
|Crestview                          |REP   |               791|         987|  80.1418440|
|Crocket-Miley                      |DEM   |               174|         406|  42.8571429|
|Crocket-Miley                      |REP   |               215|         406|  52.9556650|
|Croft Baptist                      |DEM   |               532|         975|  54.5641026|
|Croft Baptist                      |REP   |               412|         975|  42.2564103|
|Cromer                             |DEM   |               288|        1051|  27.4024738|
|Cromer                             |REP   |               702|        1051|  66.7935300|
|Cross                              |DEM   |               388|         861|  45.0638792|
|Cross                              |REP   |               450|         861|  52.2648084|
|Cross Anchor Fire Station          |DEM   |               155|         711|  21.8002813|
|Cross Anchor Fire Station          |REP   |               537|         711|  75.5274262|
|CROSS HILL                         |DEM   |               502|        1368|  36.6959064|
|CROSS HILL                         |REP   |               820|        1368|  59.9415205|
|CROSS KEYS                         |DEM   |               247|         687|  35.9534207|
|CROSS KEYS                         |REP   |               423|         687|  61.5720524|
|Crossroads                         |DEM   |               115|        1113|  10.3324349|
|Crossroads                         |REP   |               956|        1113|  85.8939802|
|Crosswell                          |DEM   |               208|        1346|  15.4531947|
|Crosswell                          |REP   |              1087|        1346|  80.7578009|
|CROSSWELL                          |DEM   |               807|        1005|  80.2985075|
|CROSSWELL                          |REP   |               183|        1005|  18.2089552|
|Cudd Memorial                      |DEM   |               498|         989|  50.3538928|
|Cudd Memorial                      |REP   |               441|         989|  44.5904954|
|Cummings                           |DEM   |               370|         662|  55.8912387|
|Cummings                           |REP   |               278|         662|  41.9939577|
|Cypress                            |DEM   |               576|        1688|  34.1232227|
|Cypress                            |REP   |              1001|        1688|  59.3009479|
|CYPRESS                            |DEM   |               311|         450|  69.1111111|
|CYPRESS                            |REP   |               129|         450|  28.6666667|
|Cypress 2                          |DEM   |               122|         539|  22.6345083|
|Cypress 2                          |REP   |               385|         539|  71.4285714|
|Dacusville                         |DEM   |               132|        1018|  12.9666012|
|Dacusville                         |REP   |               859|        1018|  84.3811395|
|DAISY                              |DEM   |               231|        1098|  21.0382514|
|DAISY                              |REP   |               835|        1098|  76.0473588|
|DALE LOBECO                        |DEM   |               566|         856|  66.1214953|
|DALE LOBECO                        |REP   |               260|         856|  30.3738318|
|DALZELL 1                          |DEM   |               425|        1020|  41.6666667|
|DALZELL 1                          |REP   |               541|        1020|  53.0392157|
|DALZELL 2                          |DEM   |               359|         777|  46.2033462|
|DALZELL 2                          |REP   |               380|         777|  48.9060489|
|Daniel Island 1                    |DEM   |               294|        1231|  23.8830219|
|Daniel Island 1                    |REP   |               887|        1231|  72.0552396|
|Daniel Island 2                    |DEM   |               474|        1259|  37.6489277|
|Daniel Island 2                    |REP   |               698|        1259|  55.4408261|
|Daniel Island 3                    |DEM   |               457|        1282|  35.6474259|
|Daniel Island 3                    |REP   |               747|        1282|  58.2683307|
|Daniel Island 4                    |DEM   |               569|        1792|  31.7522321|
|Daniel Island 4                    |REP   |              1099|        1792|  61.3281250|
|Daniel Morgan Technology Center    |DEM   |               230|         854|  26.9320843|
|Daniel Morgan Technology Center    |REP   |               567|         854|  66.3934426|
|DARBY RIDGE                        |DEM   |               333|        2143|  15.5389641|
|DARBY RIDGE                        |REP   |              1689|        2143|  78.8147457|
|DARLINGTON NO. 1                   |DEM   |               132|         233|  56.6523605|
|DARLINGTON NO. 1                   |REP   |                90|         233|  38.6266094|
|DARLINGTON NO. 2                   |DEM   |               775|        1111|  69.7569757|
|DARLINGTON NO. 2                   |REP   |               321|        1111|  28.8928893|
|DARLINGTON NO. 3                   |DEM   |               693|        1648|  42.0509709|
|DARLINGTON NO. 3                   |REP   |               897|        1648|  54.4296117|
|DARLINGTON NO. 4                   |DEM   |               640|         907|  70.5622933|
|DARLINGTON NO. 4                   |REP   |               246|         907|  27.1223815|
|DARLINGTON NO. 5                   |DEM   |              1119|        1204|  92.9401993|
|DARLINGTON NO. 5                   |REP   |                57|        1204|   4.7342193|
|DARLINGTON NO. 6                   |DEM   |               600|        1197|  50.1253133|
|DARLINGTON NO. 6                   |REP   |               564|        1197|  47.1177945|
|DAUFUSKIE                          |DEM   |               106|         339|  31.2684366|
|DAUFUSKIE                          |REP   |               221|         339|  65.1917404|
|Davis Station                      |DEM   |               481|        1155|  41.6450216|
|Davis Station                      |REP   |               637|        1155|  55.1515152|
|Dayton Fire Station                |DEM   |               408|         833|  48.9795918|
|Dayton Fire Station                |REP   |               384|         833|  46.0984394|
|DEER PARK 1A                       |DEM   |               502|         841|  59.6908442|
|DEER PARK 1A                       |REP   |               264|         841|  31.3912010|
|DEER PARK 1B                       |DEM   |               742|        1553|  47.7784932|
|DEER PARK 1B                       |REP   |               670|        1553|  43.1423052|
|DEER PARK 2A                       |DEM   |               871|        1768|  49.2647059|
|DEER PARK 2A                       |REP   |               813|        1768|  45.9841629|
|DEER PARK 2B                       |DEM   |               591|        1161|  50.9043928|
|DEER PARK 2B                       |REP   |               496|        1161|  42.7217916|
|DEER PARK 2C                       |DEM   |               308|         693|  44.4444444|
|DEER PARK 2C                       |REP   |               347|         693|  50.0721501|
|DEER PARK 3                        |DEM   |               767|        1293|  59.3194122|
|DEER PARK 3                        |REP   |               440|        1293|  34.0293890|
|DEERFIELD                          |DEM   |               544|        2246|  24.2208370|
|DEERFIELD                          |REP   |              1615|        2246|  71.9056100|
|DEL NORTE                          |DEM   |               807|        2000|  40.3500000|
|DEL NORTE                          |REP   |              1076|        2000|  53.8000000|
|DELAINE                            |DEM   |               868|        1079|  80.4448563|
|DELAINE                            |REP   |               173|        1079|  16.0333642|
|Delemars                           |DEM   |               529|         640|  82.6562500|
|Delemars                           |REP   |               103|         640|  16.0937500|
|DELMAE NO. 1                       |DEM   |               733|        1448|  50.6215470|
|DELMAE NO. 1                       |REP   |               637|        1448|  43.9917127|
|DELMAE NO. 2                       |DEM   |               284|        1234|  23.0145867|
|DELMAE NO. 2                       |REP   |               899|        1234|  72.8525122|
|DELMAR                             |DEM   |                42|         354|  11.8644068|
|DELMAR                             |REP   |               298|         354|  84.1807910|
|Delphia                            |DEM   |               266|        1398|  19.0271817|
|Delphia                            |REP   |              1071|        1398|  76.6094421|
|Dennyside                          |DEM   |               514|         917|  56.0523446|
|Dennyside                          |REP   |               296|         917|  32.2791712|
|Dentsville                         |DEM   |              1320|        1435|  91.9860627|
|Dentsville                         |REP   |                93|        1435|   6.4808362|
|Denver-Sandy Springs               |DEM   |               218|        1061|  20.5466541|
|Denver-Sandy Springs               |REP   |               793|        1061|  74.7408106|
|DEVENGER                           |DEM   |               360|        1613|  22.3186609|
|DEVENGER                           |REP   |              1128|        1613|  69.9318041|
|Devon Forest 1                     |DEM   |               585|        1626|  35.9778598|
|Devon Forest 1                     |REP   |               921|        1626|  56.6420664|
|Devon Forest 2                     |DEM   |               431|        1289|  33.4367727|
|Devon Forest 2                     |REP   |               776|        1289|  60.2017067|
|Discovery                          |DEM   |               562|        1346|  41.7533432|
|Discovery                          |REP   |               689|        1346|  51.1887073|
|DIXIE                              |DEM   |              1152|        1483|  77.6803776|
|DIXIE                              |REP   |               299|        1483|  20.1618341|
|Doby's Mill                        |DEM   |               487|        1559|  31.2379731|
|Doby's Mill                        |REP   |              1001|        1559|  64.2078255|
|Dobys Bridge                       |DEM   |               473|        1826|  25.9036145|
|Dobys Bridge                       |REP   |              1230|        1826|  67.3603505|
|DOGBLUFF                           |DEM   |               100|         865|  11.5606936|
|DOGBLUFF                           |REP   |               745|         865|  86.1271676|
|DOGWOOD                            |DEM   |               500|        1222|  40.9165303|
|DOGWOOD                            |REP   |               671|        1222|  54.9099836|
|Donalds                            |DEM   |                67|         438|  15.2968037|
|Donalds                            |REP   |               359|         438|  81.9634703|
|DONALDSON                          |DEM   |               616|         843|  73.0723606|
|DONALDSON                          |REP   |               202|         843|  23.9620403|
|Dorchester                         |DEM   |               212|         651|  32.5652842|
|Dorchester                         |REP   |               380|         651|  58.3717358|
|Dorchester 2                       |DEM   |               148|         615|  24.0650407|
|Dorchester 2                       |REP   |               411|         615|  66.8292683|
|Douglas                            |DEM   |               550|        1222|  45.0081833|
|Douglas                            |REP   |               627|        1222|  51.3093290|
|DOVE TREE                          |DEM   |               447|        1554|  28.7644788|
|DOVE TREE                          |REP   |               985|        1554|  63.3848134|
|DOVESVILLE                         |DEM   |               909|        1381|  65.8218682|
|DOVESVILLE                         |REP   |               445|        1381|  32.2230268|
|Draytonville                       |DEM   |               284|        1208|  23.5099338|
|Draytonville                       |REP   |               880|        1208|  72.8476821|
|Dreher Island                      |DEM   |               155|        1355|  11.4391144|
|Dreher Island                      |REP   |              1155|        1355|  85.2398524|
|DUDLEY-MANGUM                      |DEM   |               191|         768|  24.8697917|
|DUDLEY-MANGUM                      |REP   |               559|         768|  72.7864583|
|Due West                           |DEM   |               389|        1159|  33.5634167|
|Due West                           |REP   |               719|        1159|  62.0362381|
|Duncan United Methodist            |DEM   |               556|        1280|  43.4375000|
|Duncan United Methodist            |REP   |               670|        1280|  52.3437500|
|DUNES #1                           |DEM   |               537|        2361|  22.7445997|
|DUNES #1                           |REP   |              1773|        2361|  75.0952986|
|DUNES #2                           |DEM   |               370|        1563|  23.6724248|
|DUNES #2                           |REP   |              1148|        1563|  73.4484965|
|DUNES #3                           |DEM   |               291|         896|  32.4776786|
|DUNES #3                           |REP   |               573|         896|  63.9508929|
|DUNKLIN                            |DEM   |               271|        2062|  13.1425800|
|DUNKLIN                            |REP   |              1715|        2062|  83.1716780|
|Dutch Fork 1                       |DEM   |               215|         904|  23.7831858|
|Dutch Fork 1                       |REP   |               621|         904|  68.6946903|
|Dutch Fork 2                       |DEM   |               375|         951|  39.4321767|
|Dutch Fork 2                       |REP   |               502|         951|  52.7865405|
|Dutch Fork 3                       |DEM   |               404|        1538|  26.2678804|
|Dutch Fork 3                       |REP   |              1031|        1538|  67.0351105|
|Dutch Fork 4                       |DEM   |               421|        1280|  32.8906250|
|Dutch Fork 4                       |REP   |               779|        1280|  60.8593750|
|Dutchman Shores                    |DEM   |               221|        1605|  13.7694704|
|Dutchman Shores                    |REP   |              1295|        1605|  80.6853583|
|DUTCHMANS CREEK                    |DEM   |               257|        1043|  24.6404602|
|DUTCHMANS CREEK                    |REP   |               745|        1043|  71.4285714|
|Dwight                             |DEM   |               207|        1345|  15.3903346|
|Dwight                             |REP   |              1081|        1345|  80.3717472|
|E BENNETTSVILLE                    |DEM   |               530|         776|  68.2989691|
|E BENNETTSVILLE                    |REP   |               230|         776|  29.6391753|
|E. Camden-Hermitage                |DEM   |               125|         373|  33.5120643|
|E. Camden-Hermitage                |REP   |               221|         373|  59.2493298|
|E.P. Todd Elementary               |DEM   |               757|        1581|  47.8810879|
|E.P. Todd Elementary               |REP   |               773|        1581|  48.8931056|
|Eadytown                           |DEM   |               456|         625|  72.9600000|
|Eadytown                           |REP   |               161|         625|  25.7600000|
|EARLES                             |DEM   |               138|         563|  24.5115453|
|EARLES                             |REP   |               413|         563|  73.3570160|
|Earles Grove                       |DEM   |               100|         736|  13.5869565|
|Earles Grove                       |REP   |               617|         736|  83.8315217|
|Early Branch                       |DEM   |               157|         286|  54.8951049|
|Early Branch                       |REP   |               125|         286|  43.7062937|
|Easley                             |DEM   |               208|         957|  21.7345873|
|Easley                             |REP   |               703|         957|  73.4587252|
|EAST BUFFALO                       |DEM   |               201|         269|  74.7211896|
|EAST BUFFALO                       |REP   |                59|         269|  21.9330855|
|EAST CONWAY                        |DEM   |               250|         852|  29.3427230|
|EAST CONWAY                        |REP   |               554|         852|  65.0234742|
|EAST DENMARK                       |DEM   |              1272|        1508|  84.3501326|
|EAST DENMARK                       |REP   |               212|        1508|  14.0583554|
|EAST DILLON                        |DEM   |               259|        1257|  20.6046142|
|EAST DILLON                        |REP   |               962|        1257|  76.5314240|
|East Forest Acres                  |DEM   |               234|         761|  30.7490145|
|East Forest Acres                  |REP   |               463|         761|  60.8409987|
|East Liberty                       |DEM   |               146|         973|  15.0051387|
|East Liberty                       |REP   |               784|         973|  80.5755396|
|EAST LORIS                         |DEM   |               785|        2235|  35.1230425|
|EAST LORIS                         |REP   |              1373|        2235|  61.4317673|
|EAST MCCOLL                        |DEM   |               125|         528|  23.6742424|
|EAST MCCOLL                        |REP   |               392|         528|  74.2424242|
|East Pickens                       |DEM   |                83|         974|   8.5215606|
|East Pickens                       |REP   |               848|         974|  87.0636550|
|Eastover                           |DEM   |               984|        1080|  91.1111111|
|Eastover                           |REP   |                69|        1080|   6.3888889|
|EASTSIDE                           |DEM   |               558|        1976|  28.2388664|
|EASTSIDE                           |REP   |              1309|        1976|  66.2449393|
|Eastside Baptist                   |DEM   |               404|        1070|  37.7570093|
|Eastside Baptist                   |REP   |               630|        1070|  58.8785047|
|Ebenezer                           |DEM   |               230|         911|  25.2469813|
|Ebenezer                           |REP   |               628|         911|  68.9352360|
|EBENEZER                           |DEM   |               734|        3787|  19.3820966|
|EBENEZER                           |REP   |              2936|        3787|  77.5283866|
|EBENEZER 1                         |DEM   |               535|         996|  53.7148594|
|EBENEZER 1                         |REP   |               416|         996|  41.7670683|
|EBENEZER 2                         |DEM   |               498|        1000|  49.8000000|
|EBENEZER 2                         |REP   |               461|        1000|  46.1000000|
|Ebenezer Baptist                   |DEM   |               643|         677|  94.9778434|
|Ebenezer Baptist                   |REP   |                17|         677|   2.5110783|
|EBENEZER NO. 1                     |DEM   |               661|        2489|  26.5568501|
|EBENEZER NO. 1                     |REP   |              1709|        2489|  68.6621133|
|EBENEZER NO. 2                     |DEM   |               590|        1623|  36.3524338|
|EBENEZER NO. 2                     |REP   |               969|        1623|  59.7042514|
|EBENEZER NO. 3                     |DEM   |               232|         850|  27.2941176|
|EBENEZER NO. 3                     |REP   |               586|         850|  68.9411765|
|Ebinport                           |DEM   |               745|        1962|  37.9714577|
|Ebinport                           |REP   |              1092|        1962|  55.6574924|
|Edenwood                           |DEM   |               615|        1714|  35.8809802|
|Edenwood                           |REP   |              1008|        1714|  58.8098016|
|Edgefield No.1                     |DEM   |               258|         655|  39.3893130|
|Edgefield No.1                     |REP   |               372|         655|  56.7938931|
|Edgefield No.2                     |DEM   |               624|        1163|  53.6543422|
|Edgefield No.2                     |REP   |               502|        1163|  43.1642304|
|Edgemoor                           |DEM   |               254|         926|  27.4298056|
|Edgemoor                           |REP   |               632|         926|  68.2505400|
|Edgewood                           |DEM   |              2710|        3008|  90.0930851|
|Edgewood                           |REP   |               213|        3008|   7.0811170|
|Edgewood Station A                 |DEM   |               524|        1452|  36.0881543|
|Edgewood Station A                 |REP   |               852|        1452|  58.6776860|
|Edgewood Station B                 |DEM   |               331|        1483|  22.3196224|
|Edgewood Station B                 |REP   |              1083|        1483|  73.0276467|
|EDISTO                             |DEM   |               513|        1541|  33.2900714|
|EDISTO                             |REP   |               987|        1541|  64.0493186|
|EDISTO BEACH                       |DEM   |               182|         880|  20.6818182|
|EDISTO BEACH                       |REP   |               679|         880|  77.1590909|
|EDISTO ISLAND                      |DEM   |               608|        1203|  50.5403159|
|EDISTO ISLAND                      |REP   |               546|        1203|  45.3865337|
|Edmund #1                          |DEM   |               236|         840|  28.0952381|
|Edmund #1                          |REP   |               550|         840|  65.4761905|
|Edmund #2                          |DEM   |               169|        1253|  13.4876297|
|Edmund #2                          |REP   |              1012|        1253|  80.7661612|
|EDWARDS FOREST                     |DEM   |               503|        1943|  25.8878024|
|EDWARDS FOREST                     |REP   |              1313|        1943|  67.5759135|
|EFFINGHAM                          |DEM   |               108|         547|  19.7440585|
|EFFINGHAM                          |REP   |               427|         547|  78.0621572|
|EHRHARDT                           |DEM   |               310|         670|  46.2686567|
|EHRHARDT                           |REP   |               344|         670|  51.3432836|
|EKOM                               |DEM   |                63|         467|  13.4903640|
|EKOM                               |REP   |               381|         467|  81.5845824|
|Elgin                              |DEM   |               378|        1053|  35.8974359|
|Elgin                              |REP   |               633|        1053|  60.1139601|
|Elgin No. 1                        |DEM   |               452|        1744|  25.9174312|
|Elgin No. 1                        |REP   |              1190|        1744|  68.2339450|
|Elgin No. 2                        |DEM   |               403|        1251|  32.2142286|
|Elgin No. 2                        |REP   |               786|        1251|  62.8297362|
|Elgin No. 3                        |DEM   |               347|         988|  35.1214575|
|Elgin No. 3                        |REP   |               596|         988|  60.3238866|
|Elgin No. 4                        |DEM   |               501|        1532|  32.7023499|
|Elgin No. 4                        |REP   |               958|        1532|  62.5326371|
|Elgin No. 5                        |DEM   |               324|        1137|  28.4960422|
|Elgin No. 5                        |REP   |               769|        1137|  67.6341249|
|Elgin No. 6                        |DEM   |               395|         926|  42.6565875|
|Elgin No. 6                        |REP   |               476|         926|  51.4038877|
|ELIM-GLENWOOD                      |DEM   |               290|        1145|  25.3275109|
|ELIM-GLENWOOD                      |REP   |               833|        1145|  72.7510917|
|ELKO                               |DEM   |               263|         537|  48.9757914|
|ELKO                               |REP   |               261|         537|  48.6033520|
|ELLIOTT                            |DEM   |               489|         530|  92.2641509|
|ELLIOTT                            |REP   |                30|         530|   5.6603774|
|ELLOREE 1                          |DEM   |               398|         800|  49.7500000|
|ELLOREE 1                          |REP   |               378|         800|  47.2500000|
|ELLOREE 2                          |DEM   |               540|         672|  80.3571429|
|ELLOREE 2                          |REP   |               128|         672|  19.0476190|
|Emerald                            |DEM   |               371|         470|  78.9361702|
|Emerald                            |REP   |                79|         470|  16.8085106|
|EMERALD FOREST #1                  |DEM   |               585|        1773|  32.9949239|
|EMERALD FOREST #1                  |REP   |              1079|        1773|  60.8573040|
|EMERALD FOREST #2                  |DEM   |               824|        2729|  30.1942103|
|EMERALD FOREST #2                  |REP   |              1756|        2729|  64.3459143|
|EMERALD FOREST #3                  |DEM   |               526|        1992|  26.4056225|
|EMERALD FOREST #3                  |REP   |              1369|        1992|  68.7248996|
|Emerald High                       |DEM   |                85|         384|  22.1354167|
|Emerald High                       |REP   |               281|         384|  73.1770833|
|Emergency                          |DEM   |               410|        1076|  38.1040892|
|Emergency                          |REP   |               635|        1076|  59.0148699|
|Emergency 1                        |DEM   |                82|         157|  52.2292994|
|Emergency 1                        |REP   |                73|         157|  46.4968153|
|Emergency 2                        |DEM   |               127|         338|  37.5739645|
|Emergency 2                        |REP   |               205|         338|  60.6508876|
|Emergency 3                        |DEM   |                 5|           6|  83.3333333|
|Emergency 3                        |REP   |                 2|           6|  33.3333333|
|Emergency 4                        |REP   |                 2|           2| 100.0000000|
|Emmanuel Church                    |DEM   |               389|        1698|  22.9093051|
|Emmanuel Church                    |REP   |              1208|        1698|  71.1425206|
|ENOREE                             |DEM   |               696|        2231|  31.1967727|
|ENOREE                             |REP   |              1420|        2231|  63.6485881|
|Enoree First Baptist               |DEM   |               232|        1146|  20.2443281|
|Enoree First Baptist               |REP   |               867|        1146|  75.6544503|
|ENTERPRISE                         |DEM   |               774|        2918|  26.5250171|
|ENTERPRISE                         |REP   |              2026|        2918|  69.4311172|
|Epworth                            |DEM   |                92|         560|  16.4285714|
|Epworth                            |REP   |               455|         560|  81.2500000|
|Erwin Farm                         |DEM   |               535|        1040|  51.4423077|
|Erwin Farm                         |REP   |               455|        1040|  43.7500000|
|Estates                            |DEM   |               840|        1525|  55.0819672|
|Estates                            |REP   |               599|        1525|  39.2786885|
|Estill                             |DEM   |              1243|        1571|  79.1215786|
|Estill                             |REP   |               276|        1571|  17.5684278|
|Eureka                             |DEM   |               288|        1222|  23.5679214|
|Eureka                             |REP   |               879|        1222|  71.9312602|
|Eureka Mill                        |DEM   |               595|         933|  63.7727760|
|Eureka Mill                        |REP   |               303|         933|  32.4758842|
|EUTAWVILLE 1                       |DEM   |               564|        1286|  43.8569207|
|EUTAWVILLE 1                       |REP   |               700|        1286|  54.4323484|
|EUTAWVILLE 2                       |DEM   |              1084|        1375|  78.8363636|
|EUTAWVILLE 2                       |REP   |               264|        1375|  19.2000000|
|EVERGREEN                          |DEM   |               221|         796|  27.7638191|
|EVERGREEN                          |REP   |               550|         796|  69.0954774|
|EXCELSIOR                          |DEM   |               468|        1004|  46.6135458|
|EXCELSIOR                          |REP   |               516|        1004|  51.3944223|
|Ezells and Butler                  |DEM   |               189|        1197|  15.7894737|
|Ezells and Butler                  |REP   |               966|        1197|  80.7017544|
|Failsafe                           |DEM   |              2467|        4293|  57.4656417|
|Failsafe                           |REP   |              1656|        4293|  38.5744235|
|Failsafe / Provisional 1           |DEM   |                80|         250|  32.0000000|
|Failsafe / Provisional 1           |REP   |               157|         250|  62.8000000|
|Failsafe 1                         |DEM   |               379|         803|  47.1980075|
|Failsafe 1                         |REP   |               386|         803|  48.0697385|
|FAILSAFE 1                         |DEM   |               269|         428|  62.8504673|
|FAILSAFE 1                         |REP   |               126|         428|  29.4392523|
|Failsafe 2                         |DEM   |               503|         788|  63.8324873|
|Failsafe 2                         |REP   |               251|         788|  31.8527919|
|FAILSAFE 2                         |DEM   |               120|         194|  61.8556701|
|FAILSAFE 2                         |REP   |                61|         194|  31.4432990|
|Failsafe 3                         |DEM   |               190|         279|  68.1003584|
|Failsafe 3                         |REP   |                82|         279|  29.3906810|
|Failsafe 4                         |DEM   |               109|         153|  71.2418301|
|Failsafe 4                         |REP   |                36|         153|  23.5294118|
|FAILSAFE PR                        |DEM   |               588|        1489|  39.4895903|
|FAILSAFE PR                        |REP   |               816|        1489|  54.8018805|
|Failsafe Prov 1                    |DEM   |               461|        1061|  43.4495759|
|Failsafe Prov 1                    |REP   |               539|        1061|  50.8011310|
|Failsafe Provisional               |DEM   |              1026|        2158|  47.5440222|
|Failsafe Provisional               |REP   |              1023|        2158|  47.4050046|
|Failsafe/Provisional               |DEM   |               261|         522|  50.0000000|
|Failsafe/Provisional               |REP   |               223|         522|  42.7203065|
|Fair Play                          |DEM   |                98|         823|  11.9076549|
|Fair Play                          |REP   |               708|         823|  86.0267315|
|FAIRFAX #1                         |DEM   |               245|         386|  63.4715026|
|FAIRFAX #1                         |REP   |               122|         386|  31.6062176|
|FAIRFAX #2                         |DEM   |               699|         803|  87.0485679|
|FAIRFAX #2                         |REP   |                86|         803|  10.7098381|
|Fairforest Elementary              |DEM   |               412|        1775|  23.2112676|
|Fairforest Elementary              |REP   |              1302|        1775|  73.3521127|
|Fairforest Middle School           |DEM   |               678|        1850|  36.6486486|
|Fairforest Middle School           |REP   |              1080|        1850|  58.3783784|
|Fairgrounds                        |DEM   |              1029|        1222|  84.2062193|
|Fairgrounds                        |REP   |               158|        1222|  12.9296236|
|Fairlawn                           |DEM   |              1470|        1849|  79.5024337|
|Fairlawn                           |REP   |               296|        1849|  16.0086533|
|Fairview                           |DEM   |               266|        1183|  22.4852071|
|Fairview                           |REP   |               873|        1183|  73.7954353|
|FAIRVIEW                           |DEM   |               214|        1191|  17.9680940|
|FAIRVIEW                           |REP   |               936|        1191|  78.5894207|
|Fairwold                           |DEM   |               630|         649|  97.0724191|
|Fairwold                           |REP   |                13|         649|   2.0030817|
|Faith Church                       |DEM   |               290|         996|  29.1164659|
|Faith Church                       |REP   |               622|         996|  62.4497992|
|FALL BRANCH                        |DEM   |               209|         458|  45.6331878|
|FALL BRANCH                        |REP   |               239|         458|  52.1834061|
|FEASTER                            |DEM   |               381|         974|  39.1170431|
|FEASTER                            |REP   |               533|         974|  54.7227926|
|FEASTERVILLE                       |DEM   |               207|         282|  73.4042553|
|FEASTERVILLE                       |REP   |                73|         282|  25.8865248|
|Ferry Branch                       |DEM   |               165|         790|  20.8860759|
|Ferry Branch                       |REP   |               578|         790|  73.1645570|
|Fewell Park                        |DEM   |               247|         785|  31.4649682|
|Fewell Park                        |REP   |               480|         785|  61.1464968|
|Filbert                            |DEM   |               209|        1250|  16.7200000|
|Filbert                            |REP   |               980|        1250|  78.4000000|
|Five Forks                         |DEM   |               339|        1412|  24.0084986|
|Five Forks                         |REP   |              1029|        1412|  72.8753541|
|Flat Rock                          |DEM   |               384|        2261|  16.9836356|
|Flat Rock                          |REP   |              1776|        2261|  78.5493145|
|FLORENCE NO. 1                     |DEM   |               860|         892|  96.4125561|
|FLORENCE NO. 1                     |REP   |                19|         892|   2.1300448|
|FLORENCE NO. 10                    |DEM   |               420|         444|  94.5945946|
|FLORENCE NO. 10                    |REP   |                14|         444|   3.1531532|
|FLORENCE NO. 11                    |DEM   |               252|         598|  42.1404682|
|FLORENCE NO. 11                    |REP   |               316|         598|  52.8428094|
|FLORENCE NO. 12                    |DEM   |               328|        1286|  25.5054432|
|FLORENCE NO. 12                    |REP   |               883|        1286|  68.6625194|
|FLORENCE NO. 14                    |DEM   |               352|        1087|  32.3827047|
|FLORENCE NO. 14                    |REP   |               687|        1087|  63.2014719|
|FLORENCE NO. 15                    |DEM   |               266|         330|  80.6060606|
|FLORENCE NO. 15                    |REP   |                58|         330|  17.5757576|
|FLORENCE NO. 2                     |DEM   |               733|         774|  94.7028424|
|FLORENCE NO. 2                     |REP   |                27|         774|   3.4883721|
|FLORENCE NO. 3                     |DEM   |               926|         954|  97.0649895|
|FLORENCE NO. 3                     |REP   |                 7|         954|   0.7337526|
|FLORENCE NO. 4                     |DEM   |               220|         454|  48.4581498|
|FLORENCE NO. 4                     |REP   |               201|         454|  44.2731278|
|FLORENCE NO. 5                     |DEM   |               481|         707|  68.0339463|
|FLORENCE NO. 5                     |REP   |               193|         707|  27.2984441|
|FLORENCE NO. 6                     |DEM   |               166|         515|  32.2330097|
|FLORENCE NO. 6                     |REP   |               332|         515|  64.4660194|
|FLORENCE NO. 7                     |DEM   |               372|        1137|  32.7176781|
|FLORENCE NO. 7                     |REP   |               703|        1137|  61.8293755|
|FLORENCE NO. 8                     |DEM   |               226|        1047|  21.5854823|
|FLORENCE NO. 8                     |REP   |               767|        1047|  73.2569245|
|FLORENCE NO. 9                     |DEM   |              1074|        1095|  98.0821918|
|FLORENCE NO. 9                     |REP   |                 9|        1095|   0.8219178|
|Flowertown                         |DEM   |               257|         949|  27.0811380|
|Flowertown                         |REP   |               633|         949|  66.7017914|
|Flowertown 2                       |DEM   |               414|        1045|  39.6172249|
|Flowertown 2                       |REP   |               558|        1045|  53.3971292|
|Flowertown 3                       |DEM   |               293|         881|  33.2576617|
|Flowertown 3                       |REP   |               519|         881|  58.9103292|
|FLOYDALE                           |DEM   |               129|         501|  25.7485030|
|FLOYDALE                           |REP   |               358|         501|  71.4570858|
|FOLLY BEACH 1                      |DEM   |               315|         774|  40.6976744|
|FOLLY BEACH 1                      |REP   |               392|         774|  50.6459948|
|FOLLY BEACH 2                      |DEM   |               402|         981|  40.9785933|
|FOLLY BEACH 2                      |REP   |               503|         981|  51.2742100|
|FOLLY GROVE                        |DEM   |               229|         842|  27.1971496|
|FOLLY GROVE                        |REP   |               598|         842|  71.0213777|
|FOLSOM PARK                        |DEM   |               880|        1034|  85.1063830|
|FOLSOM PARK                        |REP   |               120|        1034|  11.6054159|
|Forest Acres                       |DEM   |               183|         753|  24.3027888|
|Forest Acres                       |REP   |               535|         753|  71.0491368|
|FORESTBROOK                        |DEM   |               759|        2668|  28.4482759|
|FORESTBROOK                        |REP   |              1790|        2668|  67.0914543|
|FORK                               |DEM   |               113|         382|  29.5811518|
|FORK                               |REP   |               264|         382|  69.1099476|
|Fork No.1                          |DEM   |               222|        1062|  20.9039548|
|Fork No.1                          |REP   |               814|        1062|  76.6478343|
|Fork No.2                          |DEM   |               203|        1275|  15.9215686|
|Fork No.2                          |REP   |              1016|        1275|  79.6862745|
|FORK SHOALS                        |DEM   |               273|        1805|  15.1246537|
|FORK SHOALS                        |REP   |              1459|        1805|  80.8310249|
|Fort Lawn                          |DEM   |               501|        1269|  39.4799054|
|Fort Lawn                          |REP   |               736|        1269|  57.9984240|
|Fort Mill No. 1                    |DEM   |               697|        2291|  30.4233959|
|Fort Mill No. 1                    |REP   |              1440|        2291|  62.8546486|
|Fort Mill No. 2                    |DEM   |               624|        2400|  26.0000000|
|Fort Mill No. 2                    |REP   |              1640|        2400|  68.3333333|
|Fort Mill No. 3                    |DEM   |               685|        1628|  42.0761671|
|Fort Mill No. 3                    |REP   |               829|        1628|  50.9213759|
|Fort Mill No. 4                    |DEM   |               631|        1277|  49.4126860|
|Fort Mill No. 4                    |REP   |               593|        1277|  46.4369616|
|Fort Mill No. 5                    |DEM   |               554|        1671|  33.1538001|
|Fort Mill No. 5                    |REP   |              1022|        1671|  61.1609814|
|Fort Mill No. 6                    |DEM   |               421|        1412|  29.8158640|
|Fort Mill No. 6                    |REP   |               863|        1412|  61.1189802|
|FORT MOTTE                         |DEM   |               140|         241|  58.0912863|
|FORT MOTTE                         |REP   |                96|         241|  39.8340249|
|Foster Creek 1                     |DEM   |               106|         303|  34.9834983|
|Foster Creek 1                     |REP   |               176|         303|  58.0858086|
|Foster Creek 2                     |DEM   |               575|        1701|  33.8036449|
|Foster Creek 2                     |REP   |              1008|        1701|  59.2592593|
|Foster Creek 3                     |DEM   |               475|        1251|  37.9696243|
|Foster Creek 3                     |REP   |               688|        1251|  54.9960032|
|FOUNTAIN INN 1                     |DEM   |              1259|        2808|  44.8361823|
|FOUNTAIN INN 1                     |REP   |              1416|        2808|  50.4273504|
|FOUNTAIN INN 2                     |DEM   |               354|        1227|  28.8508557|
|FOUNTAIN INN 2                     |REP   |               812|        1227|  66.1776691|
|Four Hole                          |DEM   |               439|         944|  46.5042373|
|Four Hole                          |REP   |               475|         944|  50.3177966|
|FOUR HOLES                         |DEM   |               185|         547|  33.8208410|
|FOUR HOLES                         |REP   |               355|         547|  64.8994516|
|FOUR MILE                          |DEM   |               420|        1579|  26.5991134|
|FOUR MILE                          |REP   |              1102|        1579|  69.7910070|
|Fox Bank                           |DEM   |               516|        1499|  34.4229486|
|Fox Bank                           |REP   |               876|        1499|  58.4389593|
|FOX CHASE                          |DEM   |               294|        1770|  16.6101695|
|FOX CHASE                          |REP   |              1387|        1770|  78.3615819|
|Fox Creek No. 58                   |DEM   |               271|        1231|  22.0146223|
|Fox Creek No. 58                   |REP   |               910|        1231|  73.9236393|
|Fox Creek No. 73                   |DEM   |               218|        1242|  17.5523349|
|Fox Creek No. 73                   |REP   |               969|        1242|  78.0193237|
|Friarsgate 1                       |DEM   |               676|        1280|  52.8125000|
|Friarsgate 1                       |REP   |               515|        1280|  40.2343750|
|Friarsgate 2                       |DEM   |               499|        1076|  46.3754647|
|Friarsgate 2                       |REP   |               504|        1076|  46.8401487|
|FRIENDFIELD                        |DEM   |                67|         438|  15.2968037|
|FRIENDFIELD                        |REP   |               362|         438|  82.6484018|
|Friendship                         |DEM   |               691|        3295|  20.9711684|
|Friendship                         |REP   |              2424|        3295|  73.5660091|
|FRIENDSHIP                         |DEM   |               285|         888|  32.0945946|
|FRIENDSHIP                         |REP   |               586|         888|  65.9909910|
|Friendship Baptist                 |DEM   |               577|        3094|  18.6489981|
|Friendship Baptist                 |REP   |              2391|        3094|  77.2786037|
|FROHAWK                            |DEM   |               272|        1482|  18.3535762|
|FROHAWK                            |REP   |              1138|        1482|  76.7881242|
|FRUIT HILL                         |DEM   |               470|         677|  69.4239291|
|FRUIT HILL                         |REP   |               190|         677|  28.0649926|
|Fruit Mountain                     |DEM   |               134|         826|  16.2227603|
|Fruit Mountain                     |REP   |               654|         826|  79.1767554|
|Furman                             |DEM   |               266|         370|  71.8918919|
|Furman                             |REP   |                99|         370|  26.7567568|
|FURMAN                             |DEM   |               896|        3344|  26.7942584|
|FURMAN                             |REP   |              2286|        3344|  68.3612440|
|Gable Middle School                |DEM   |               512|        2171|  23.5836020|
|Gable Middle School                |REP   |              1574|        2171|  72.5011515|
|GADDY'S MILL                       |DEM   |                74|         192|  38.5416667|
|GADDY'S MILL                       |REP   |               116|         192|  60.4166667|
|Gadsden                            |DEM   |              1005|        1077|  93.3147632|
|Gadsden                            |REP   |                56|        1077|   5.1996286|
|Gaffney Ward No. 1                 |DEM   |               417|         570|  73.1578947|
|Gaffney Ward No. 1                 |REP   |               138|         570|  24.2105263|
|Gaffney Ward No. 2                 |DEM   |               724|         909|  79.6479648|
|Gaffney Ward No. 2                 |REP   |               161|         909|  17.7117712|
|Gaffney Ward No. 3                 |DEM   |               612|         725|  84.4137931|
|Gaffney Ward No. 3                 |REP   |                95|         725|  13.1034483|
|Gaffney Ward No. 4                 |DEM   |               557|        1014|  54.9309665|
|Gaffney Ward No. 4                 |REP   |               425|        1014|  41.9132150|
|Gaffney Ward No. 5                 |DEM   |               290|         760|  38.1578947|
|Gaffney Ward No. 5                 |REP   |               439|         760|  57.7631579|
|Gaffney Ward No. 6                 |DEM   |               234|         849|  27.5618375|
|Gaffney Ward No. 6                 |REP   |               592|         849|  69.7290931|
|GALLIVANTS FERRY                   |DEM   |                32|         178|  17.9775281|
|GALLIVANTS FERRY                   |REP   |               144|         178|  80.8988764|
|GARDEN CITY #1                     |DEM   |               409|        1863|  21.9538379|
|GARDEN CITY #1                     |REP   |              1411|        1863|  75.7380569|
|GARDEN CITY #2                     |DEM   |               201|        1233|  16.3017032|
|GARDEN CITY #2                     |REP   |              1006|        1233|  81.5896188|
|GARDEN CITY #3                     |DEM   |               503|        1545|  32.5566343|
|GARDEN CITY #3                     |REP   |               988|        1545|  63.9482201|
|GARDEN CITY #4                     |DEM   |               316|        1101|  28.7011807|
|GARDEN CITY #4                     |REP   |               746|        1101|  67.7565849|
|Gardendale                         |DEM   |               660|        1236|  53.3980583|
|Gardendale                         |REP   |               515|        1236|  41.6666667|
|Garners                            |DEM   |               429|         682|  62.9032258|
|Garners                            |REP   |               227|         682|  33.2844575|
|Garnett                            |DEM   |               150|         167|  89.8203593|
|Garnett                            |REP   |                18|         167|  10.7784431|
|Gaston #1                          |DEM   |               179|        1044|  17.1455939|
|Gaston #1                          |REP   |               814|        1044|  77.9693487|
|Gaston #2                          |DEM   |               387|        1330|  29.0977444|
|Gaston #2                          |REP   |               869|        1330|  65.3383459|
|Gates Ford                         |DEM   |                33|         270|  12.2222222|
|Gates Ford                         |REP   |               230|         270|  85.1851852|
|Gem Lakes No. 60                   |DEM   |               206|         948|  21.7299578|
|Gem Lakes No. 60                   |REP   |               682|         948|  71.9409283|
|Gem Lakes No. 77                   |DEM   |               222|        1088|  20.4044118|
|Gem Lakes No. 77                   |REP   |               785|        1088|  72.1507353|
|Georges Creek                      |DEM   |               177|         976|  18.1352459|
|Georges Creek                      |REP   |               769|         976|  78.7909836|
|Georgetown                         |DEM   |               307|         681|  45.0807636|
|Georgetown                         |REP   |               340|         681|  49.9265786|
|GEORGETOWN NO. 1                   |DEM   |               208|         507|  41.0256410|
|GEORGETOWN NO. 1                   |REP   |               278|         507|  54.8323471|
|GEORGETOWN NO. 2-DREAM KEEPERS     |DEM   |               768|         798|  96.2406015|
|GEORGETOWN NO. 2-DREAM KEEPERS     |REP   |                15|         798|   1.8796992|
|GEORGETOWN NO. 3                   |DEM   |               769|         874|  87.9862700|
|GEORGETOWN NO. 3                   |REP   |                78|         874|   8.9244851|
|GEORGETOWN NO. 4                   |DEM   |               119|         321|  37.0716511|
|GEORGETOWN NO. 4                   |REP   |               185|         321|  57.6323988|
|GEORGETOWN NO. 5                   |DEM   |               422|        1072|  39.3656716|
|GEORGETOWN NO. 5                   |REP   |               610|        1072|  56.9029851|
|Germantown                         |DEM   |               282|         895|  31.5083799|
|Germantown                         |REP   |               568|         895|  63.4636872|
|Gideon's Way                       |DEM   |               330|         582|  56.7010309|
|Gideon's Way                       |REP   |               237|         582|  40.7216495|
|Gifford                            |DEM   |               359|         390|  92.0512821|
|Gifford                            |REP   |                30|         390|   7.6923077|
|Gilbert                            |DEM   |               208|        1494|  13.9223561|
|Gilbert                            |REP   |              1219|        1494|  81.5930388|
|GILBERT                            |DEM   |              1177|        1371|  85.8497447|
|GILBERT                            |REP   |               160|        1371|  11.6703136|
|Gillisonville                      |DEM   |               230|         450|  51.1111111|
|Gillisonville                      |REP   |               202|         450|  44.8888889|
|Givhans                            |DEM   |               277|         786|  35.2417303|
|Givhans                            |REP   |               484|         786|  61.5776081|
|Givhans 2                          |DEM   |               303|         784|  38.6479592|
|Givhans 2                          |REP   |               454|         784|  57.9081633|
|GLADDE3N GROVE                     |DEM   |                21|          63|  33.3333333|
|GLADDE3N GROVE                     |REP   |                38|          63|  60.3174603|
|Glassy Mountain                    |DEM   |                86|         993|   8.6606244|
|Glassy Mountain                    |REP   |               865|         993|  87.1097684|
|Glendale                           |DEM   |               201|        1032|  19.4767442|
|Glendale                           |REP   |               781|        1032|  75.6782946|
|Glendale Fire Station              |DEM   |               171|        1174|  14.5655877|
|Glendale Fire Station              |REP   |               960|        1174|  81.7717206|
|GLENNS BAY                         |DEM   |               441|        1763|  25.0141804|
|GLENNS BAY                         |REP   |              1230|        1763|  69.7674419|
|Glenview                           |DEM   |               441|        1377|  32.0261438|
|Glenview                           |REP   |               863|        1377|  62.6724764|
|Gloverville                        |DEM   |               173|         865|  20.0000000|
|Gloverville                        |REP   |               649|         865|  75.0289017|
|Gluck Mill                         |DEM   |               159|         340|  46.7647059|
|Gluck Mill                         |REP   |               167|         340|  49.1176471|
|Gold Hill                          |DEM   |               645|        2035|  31.6953317|
|Gold Hill                          |REP   |              1276|        2035|  62.7027027|
|Gooch's Cross Roads                |DEM   |               621|        1124|  55.2491103|
|Gooch's Cross Roads                |REP   |               467|        1124|  41.5480427|
|Goucher and Thicketty              |DEM   |               125|         973|  12.8468654|
|Goucher and Thicketty              |REP   |               819|         973|  84.1726619|
|GOVAN                              |DEM   |               107|         156|  68.5897436|
|GOVAN                              |REP   |                47|         156|  30.1282051|
|GOWENSVILLE                        |DEM   |               259|        1791|  14.4611949|
|GOWENSVILLE                        |REP   |              1469|        1791|  82.0212172|
|Grahamville 1                      |DEM   |               282|         758|  37.2031662|
|Grahamville 1                      |REP   |               437|         758|  57.6517150|
|Grahamville 2                      |DEM   |               784|        1215|  64.5267490|
|Grahamville 2                      |REP   |               383|        1215|  31.5226337|
|Gramling Methodist                 |DEM   |               132|        1282|  10.2964119|
|Gramling Methodist                 |REP   |              1108|        1282|  86.4274571|
|GRANITE CREEK                      |DEM   |               739|        2310|  31.9913420|
|GRANITE CREEK                      |REP   |              1461|        2310|  63.2467532|
|Graniteville                       |DEM   |               361|         930|  38.8172043|
|Graniteville                       |REP   |               522|         930|  56.1290323|
|GRANTS MILL                        |DEM   |               337|         942|  35.7749469|
|GRANTS MILL                        |REP   |               567|         942|  60.1910828|
|Grassy Pond                        |DEM   |               355|        1655|  21.4501511|
|Grassy Pond                        |REP   |              1250|        1655|  75.5287009|
|GRAY COURT                         |DEM   |               395|         992|  39.8185484|
|GRAY COURT                         |REP   |               554|         992|  55.8467742|
|Grays                              |DEM   |               161|         574|  28.0487805|
|Grays                              |REP   |               397|         574|  69.1637631|
|GRAZE BRANCH                       |DEM   |               361|        1415|  25.5123675|
|GRAZE BRANCH                       |REP   |               999|        1415|  70.6007067|
|Great Falls                        |DEM   |               426|         897|  47.4916388|
|Great Falls                        |REP   |               439|         897|  48.9409142|
|Greater St. James                  |DEM   |               431|        1665|  25.8858859|
|Greater St. James                  |REP   |              1149|        1665|  69.0090090|
|GREELEYVILLE                       |DEM   |               977|        1218|  80.2134647|
|GREELEYVILLE                       |REP   |               220|        1218|  18.0623974|
|GREEN POND                         |DEM   |               581|         762|  76.2467192|
|GREEN POND                         |REP   |               161|         762|  21.1286089|
|Green Pond Station A               |DEM   |               408|        1987|  20.5334675|
|Green Pond Station A               |REP   |              1505|        1987|  75.7423251|
|GREEN SEA                          |DEM   |               257|         796|  32.2864322|
|GREEN SEA                          |REP   |               523|         796|  65.7035176|
|GREEN SWAMP                        |DEM   |               561|        1176|  47.7040816|
|GREEN SWAMP                        |REP   |               564|        1176|  47.9591837|
|GREEN SWAMP 2                      |DEM   |               106|         539|  19.6660482|
|GREEN SWAMP 2                      |REP   |               410|         539|  76.0667904|
|GREENBRIAR                         |DEM   |               558|        1586|  35.1828499|
|GREENBRIAR                         |REP   |               950|        1586|  59.8991173|
|GREENBRIER                         |DEM   |               978|        1366|  71.5959004|
|GREENBRIER                         |REP   |               339|        1366|  24.8169839|
|Greenhurst                         |DEM   |               272|         779|  34.9165597|
|Greenhurst                         |REP   |               436|         779|  55.9691913|
|GREENPOND                          |DEM   |               257|        1389|  18.5025198|
|GREENPOND                          |REP   |              1076|        1389|  77.4658027|
|Greenview                          |DEM   |              1292|        1328|  97.2891566|
|Greenview                          |REP   |                 8|        1328|   0.6024096|
|GREENVILLE 1                       |DEM   |               447|        1376|  32.4854651|
|GREENVILLE 1                       |REP   |               798|        1376|  57.9941860|
|GREENVILLE 10                      |DEM   |               944|        1742|  54.1905855|
|GREENVILLE 10                      |REP   |               665|        1742|  38.1745121|
|GREENVILLE 14                      |DEM   |              1269|        1374|  92.3580786|
|GREENVILLE 14                      |REP   |                70|        1374|   5.0946143|
|GREENVILLE 16                      |DEM   |               540|        1529|  35.3172008|
|GREENVILLE 16                      |REP   |               887|        1529|  58.0117724|
|GREENVILLE 17                      |DEM   |               426|        1274|  33.4379906|
|GREENVILLE 17                      |REP   |               768|        1274|  60.2825746|
|GREENVILLE 18                      |DEM   |               368|        1219|  30.1886792|
|GREENVILLE 18                      |REP   |               774|        1219|  63.4946678|
|GREENVILLE 19                      |DEM   |              1366|        1670|  81.7964072|
|GREENVILLE 19                      |REP   |               226|        1670|  13.5329341|
|GREENVILLE 20                      |DEM   |               335|        1021|  32.8109696|
|GREENVILLE 20                      |REP   |               629|        1021|  61.6062684|
|GREENVILLE 21                      |DEM   |               432|        1136|  38.0281690|
|GREENVILLE 21                      |REP   |               578|        1136|  50.8802817|
|GREENVILLE 22                      |DEM   |               629|        1966|  31.9938962|
|GREENVILLE 22                      |REP   |              1207|        1966|  61.3936928|
|GREENVILLE 23                      |DEM   |               371|        1581|  23.4661607|
|GREENVILLE 23                      |REP   |              1138|        1581|  71.9797596|
|GREENVILLE 24                      |DEM   |              1084|        2522|  42.9817605|
|GREENVILLE 24                      |REP   |              1257|        2522|  49.8413957|
|GREENVILLE 25                      |DEM   |               650|        1463|  44.4292550|
|GREENVILLE 25                      |REP   |               689|        1463|  47.0950103|
|GREENVILLE 26                      |DEM   |               882|        1428|  61.7647059|
|GREENVILLE 26                      |REP   |               442|        1428|  30.9523810|
|GREENVILLE 27                      |DEM   |               130|         933|  13.9335477|
|GREENVILLE 27                      |REP   |               690|         933|  73.9549839|
|GREENVILLE 28                      |DEM   |               394|         815|  48.3435583|
|GREENVILLE 28                      |REP   |               341|         815|  41.8404908|
|GREENVILLE 29                      |DEM   |              1100|        1465|  75.0853242|
|GREENVILLE 29                      |REP   |               281|        1465|  19.1808874|
|GREENVILLE 3                       |DEM   |               854|        1952|  43.7500000|
|GREENVILLE 3                       |REP   |               930|        1952|  47.6434426|
|GREENVILLE 4                       |DEM   |              1238|        1893|  65.3988378|
|GREENVILLE 4                       |REP   |               518|        1893|  27.3639725|
|GREENVILLE 5                       |DEM   |              1103|        1964|  56.1608961|
|GREENVILLE 5                       |REP   |               705|        1964|  35.8961303|
|GREENVILLE 6                       |DEM   |               317|         404|  78.4653465|
|GREENVILLE 6                       |REP   |                73|         404|  18.0693069|
|GREENVILLE 7                       |DEM   |              1112|        1327|  83.7980407|
|GREENVILLE 7                       |REP   |               158|        1327|  11.9065561|
|GREENVILLE 8                       |DEM   |              1312|        1824|  71.9298246|
|GREENVILLE 8                       |REP   |               390|        1824|  21.3815789|
|Greenwave                          |DEM   |               314|         747|  42.0348059|
|Greenwave                          |REP   |               397|         747|  53.1459170|
|GREENWOOD                          |DEM   |               576|        1260|  45.7142857|
|GREENWOOD                          |REP   |               636|        1260|  50.4761905|
|Greenwood High                     |DEM   |               216|         654|  33.0275229|
|Greenwood High                     |REP   |               404|         654|  61.7737003|
|Greenwood Mill                     |DEM   |               143|         534|  26.7790262|
|Greenwood Mill                     |REP   |               355|         534|  66.4794007|
|Greenwood No. 1                    |DEM   |               463|         558|  82.9749104|
|Greenwood No. 1                    |REP   |                70|         558|  12.5448029|
|Greenwood No. 2                    |DEM   |               665|         704|  94.4602273|
|Greenwood No. 2                    |REP   |                30|         704|   4.2613636|
|Greenwood No. 3                    |DEM   |               314|         765|  41.0457516|
|Greenwood No. 3                    |REP   |               402|         765|  52.5490196|
|Greenwood No. 4                    |DEM   |               442|         876|  50.4566210|
|Greenwood No. 4                    |REP   |               397|         876|  45.3196347|
|Greenwood No. 5                    |DEM   |               306|         399|  76.6917293|
|Greenwood No. 5                    |REP   |                81|         399|  20.3007519|
|Greenwood No. 6                    |DEM   |               415|         656|  63.2621951|
|Greenwood No. 6                    |REP   |               220|         656|  33.5365854|
|Greenwood No. 7                    |DEM   |               451|         728|  61.9505495|
|Greenwood No. 7                    |REP   |               233|         728|  32.0054945|
|Greenwood No. 8                    |DEM   |               270|         697|  38.7374462|
|Greenwood No. 8                    |REP   |               391|         697|  56.0975610|
|Gregg Park                         |DEM   |               756|        1284|  58.8785047|
|Gregg Park                         |REP   |               464|        1284|  36.1370717|
|Grenadier                          |DEM   |               848|        1447|  58.6040083|
|Grenadier                          |REP   |               509|        1447|  35.1762267|
|GRIER'S                            |DEM   |               467|         557|  83.8420108|
|GRIER'S                            |REP   |                87|         557|  15.6193896|
|Griffin                            |DEM   |               121|        1288|   9.3944099|
|Griffin                            |REP   |              1111|        1288|  86.2577640|
|GROVE                              |DEM   |               814|        1335|  60.9737828|
|GROVE                              |REP   |               471|        1335|  35.2808989|
|Grove School                       |DEM   |                59|         483|  12.2153209|
|Grove School                       |REP   |               417|         483|  86.3354037|
|Grover                             |DEM   |               354|         726|  48.7603306|
|Grover                             |REP   |               351|         726|  48.3471074|
|Hall                               |DEM   |               260|        1080|  24.0740741|
|Hall                               |REP   |               785|        1080|  72.6851852|
|Hall's Store                       |DEM   |               220|         588|  37.4149660|
|Hall's Store                       |REP   |               359|         588|  61.0544218|
|Halsellville                       |DEM   |               128|         217|  58.9861751|
|Halsellville                       |REP   |                87|         217|  40.0921659|
|HAMER                              |DEM   |               279|         606|  46.0396040|
|HAMER                              |REP   |               307|         606|  50.6600660|
|Hammond Annex                      |DEM   |               273|        1165|  23.4334764|
|Hammond Annex                      |REP   |               833|        1165|  71.5021459|
|Hammond No. 48                     |DEM   |               272|         863|  31.5179606|
|Hammond No. 48                     |REP   |               563|         863|  65.2375435|
|Hammond No. 81                     |DEM   |               305|         871|  35.0172216|
|Hammond No. 81                     |REP   |               537|         871|  61.6532721|
|Hammond School                     |DEM   |               374|        1652|  22.6392252|
|Hammond School                     |REP   |              1184|        1652|  71.6707022|
|Hampton                            |DEM   |               738|        1199|  61.5512927|
|Hampton                            |REP   |               348|        1199|  29.0241868|
|Hampton Courthouse No.1            |DEM   |               351|         707|  49.6463932|
|Hampton Courthouse No.1            |REP   |               328|         707|  46.3932107|
|Hampton Courthouse No.2            |DEM   |               460|         923|  49.8374865|
|Hampton Courthouse No.2            |REP   |               440|         923|  47.6706392|
|Hampton Mill                       |DEM   |               234|         994|  23.5412475|
|Hampton Mill                       |REP   |               712|         994|  71.6297787|
|HAMPTON PARK                       |DEM   |               179|         471|  38.0042463|
|HAMPTON PARK                       |REP   |               258|         471|  54.7770701|
|Hanahan 1                          |DEM   |               385|        1822|  21.1306257|
|Hanahan 1                          |REP   |              1326|        1822|  72.7771679|
|Hanahan 2                          |DEM   |               383|        1008|  37.9960317|
|Hanahan 2                          |REP   |               554|        1008|  54.9603175|
|Hanahan 3                          |DEM   |               271|        1027|  26.3875365|
|Hanahan 3                          |REP   |               677|        1027|  65.9201558|
|Hanahan 4                          |DEM   |               473|        1101|  42.9609446|
|Hanahan 4                          |REP   |               537|        1101|  48.7738420|
|Hanahan 5                          |DEM   |               201|        1031|  19.4956353|
|Hanahan 5                          |REP   |               776|        1031|  75.2667313|
|HANNAH                             |DEM   |                66|         586|  11.2627986|
|HANNAH                             |REP   |               506|         586|  86.3481229|
|Harbison 1                         |DEM   |               992|        1532|  64.7519582|
|Harbison 1                         |REP   |               429|        1532|  28.0026110|
|Harbison 2                         |DEM   |               582|         969|  60.0619195|
|Harbison 2                         |REP   |               325|         969|  33.5397317|
|Harbour Lake                       |DEM   |               881|        1377|  63.9796659|
|Harbour Lake                       |REP   |               417|        1377|  30.2832244|
|Hardeeville 1                      |DEM   |               489|        1009|  48.4638256|
|Hardeeville 1                      |REP   |               463|        1009|  45.8870168|
|Hardeeville 2                      |DEM   |               484|         689|  70.2467344|
|Hardeeville 2                      |REP   |               196|         689|  28.4470247|
|Harleyville                        |DEM   |               256|         624|  41.0256410|
|Harleyville                        |REP   |               342|         624|  54.8076923|
|Harmony                            |DEM   |               459|        1176|  39.0306122|
|Harmony                            |REP   |               690|        1176|  58.6734694|
|HARMONY                            |DEM   |                98|         331|  29.6072508|
|HARMONY                            |REP   |               230|         331|  69.4864048|
|Harris                             |DEM   |               202|         504|  40.0793651|
|Harris                             |REP   |               274|         504|  54.3650794|
|Harrisburg                         |DEM   |               863|        2520|  34.2460317|
|Harrisburg                         |REP   |              1525|        2520|  60.5158730|
|HARTFORD                           |DEM   |               374|         803|  46.5753425|
|HARTFORD                           |REP   |               392|         803|  48.8169365|
|HARTSVILLE NO. 1                   |DEM   |               219|         909|  24.0924092|
|HARTSVILLE NO. 1                   |REP   |               620|         909|  68.2068207|
|HARTSVILLE NO. 4                   |DEM   |               591|         798|  74.0601504|
|HARTSVILLE NO. 4                   |REP   |               180|         798|  22.5563910|
|HARTSVILLE NO. 5                   |DEM   |               664|        1626|  40.8364084|
|HARTSVILLE NO. 5                   |REP   |               876|        1626|  53.8745387|
|HARTSVILLE NO. 6                   |DEM   |              1248|        1271|  98.1904013|
|HARTSVILLE NO. 6                   |REP   |                16|        1271|   1.2588513|
|HARTSVILLE NO. 7                   |DEM   |               416|         861|  48.3159117|
|HARTSVILLE NO. 7                   |REP   |               413|         861|  47.9674797|
|HARTSVILLE NO. 8                   |DEM   |               445|        2112|  21.0700758|
|HARTSVILLE NO. 8                   |REP   |              1579|        2112|  74.7632576|
|HARTSVILLE NO. 9                   |DEM   |               600|        1440|  41.6666667|
|HARTSVILLE NO. 9                   |REP   |               785|        1440|  54.5138889|
|Harvest                            |DEM   |               293|         920|  31.8478261|
|Harvest                            |REP   |               569|         920|  61.8478261|
|Hayne Baptist                      |DEM   |               563|        1008|  55.8531746|
|Hayne Baptist                      |REP   |               388|        1008|  38.4920635|
|Hazelwood                          |DEM   |               154|         561|  27.4509804|
|Hazelwood                          |REP   |               383|         561|  68.2709447|
|HEALING SPRINGS                    |DEM   |               643|         794|  80.9823678|
|HEALING SPRINGS                    |REP   |               137|         794|  17.2544081|
|Heath Springs                      |DEM   |               336|         943|  35.6309650|
|Heath Springs                      |REP   |               569|         943|  60.3393425|
|HEBRON                             |DEM   |                71|         498|  14.2570281|
|HEBRON                             |REP   |               416|         498|  83.5341365|
|HELENA                             |DEM   |               632|         735|  85.9863946|
|HELENA                             |REP   |                89|         735|  12.1088435|
|HEMINGWAY                          |DEM   |               885|        1343|  65.8972450|
|HEMINGWAY                          |REP   |               440|        1343|  32.7624721|
|HENDERSONVILLE                     |DEM   |               539|         829|  65.0180941|
|HENDERSONVILLE                     |REP   |               262|         829|  31.6043426|
|Hendrix Elementary                 |DEM   |              1061|        2520|  42.1031746|
|Hendrix Elementary                 |REP   |              1294|        2520|  51.3492063|
|HENRY-POPLAR HILL                  |DEM   |               276|         549|  50.2732240|
|HENRY-POPLAR HILL                  |REP   |               262|         549|  47.7231330|
|Hickory Grove                      |DEM   |               204|         889|  22.9471316|
|Hickory Grove                      |REP   |               649|         889|  73.0033746|
|HICKORY GROVE                      |DEM   |               218|        1347|  16.1841128|
|HICKORY GROVE                      |REP   |              1070|        1347|  79.4357832|
|HICKORY HILL                       |DEM   |               214|         493|  43.4077079|
|HICKORY HILL                       |REP   |               268|         493|  54.3610548|
|HICKORY RIDGE                      |DEM   |               527|         737|  71.5061058|
|HICKORY RIDGE                      |REP   |               192|         737|  26.0515604|
|HICKORY TAVERN                     |DEM   |               271|        1812|  14.9558499|
|HICKORY TAVERN                     |REP   |              1439|        1812|  79.4150110|
|Hicks                              |DEM   |                92|         539|  17.0686456|
|Hicks                              |REP   |               440|         539|  81.6326531|
|HIGGINS-ZOAR                       |DEM   |               288|         516|  55.8139535|
|HIGGINS-ZOAR                       |REP   |               217|         516|  42.0542636|
|HIGH HILL                          |DEM   |              1132|        2429|  46.6035406|
|HIGH HILL                          |REP   |              1222|        2429|  50.3087690|
|High Point                         |DEM   |                67|         518|  12.9343629|
|High Point                         |REP   |               437|         518|  84.3629344|
|Highland Park                      |DEM   |               527|         932|  56.5450644|
|Highland Park                      |REP   |               359|         932|  38.5193133|
|HIGHTOWERS MILL                    |DEM   |                60|          92|  65.2173913|
|HIGHTOWERS MILL                    |REP   |                31|          92|  33.6956522|
|HILDA                              |DEM   |                91|         760|  11.9736842|
|HILDA                              |REP   |               654|         760|  86.0526316|
|HILLCREST                          |DEM   |              1055|        2945|  35.8234295|
|HILLCREST                          |REP   |              1736|        2945|  58.9473684|
|Hilton Cross Rd                    |DEM   |               671|        1256|  53.4235669|
|Hilton Cross Rd                    |REP   |               542|        1256|  43.1528662|
|HILTON HEAD 10                     |DEM   |               554|        1317|  42.0652999|
|HILTON HEAD 10                     |REP   |               709|        1317|  53.8344723|
|HILTON HEAD 11                     |DEM   |               283|         873|  32.4169530|
|HILTON HEAD 11                     |REP   |               558|         873|  63.9175258|
|HILTON HEAD 12                     |DEM   |               251|         676|  37.1301775|
|HILTON HEAD 12                     |REP   |               407|         676|  60.2071006|
|HILTON HEAD 13                     |DEM   |               322|         916|  35.1528384|
|HILTON HEAD 13                     |REP   |               527|         916|  57.5327511|
|HILTON HEAD 14                     |DEM   |               223|         780|  28.5897436|
|HILTON HEAD 14                     |REP   |               529|         780|  67.8205128|
|HILTON HEAD 15A                    |DEM   |               157|         478|  32.8451883|
|HILTON HEAD 15A                    |REP   |               308|         478|  64.4351464|
|HILTON HEAD 15B                    |DEM   |               207|         758|  27.3087071|
|HILTON HEAD 15B                    |REP   |               532|         758|  70.1846966|
|HILTON HEAD 1A                     |DEM   |               433|         961|  45.0572320|
|HILTON HEAD 1A                     |REP   |               467|         961|  48.5952133|
|HILTON HEAD 1B                     |DEM   |               413|         848|  48.7028302|
|HILTON HEAD 1B                     |REP   |               408|         848|  48.1132075|
|HILTON HEAD 2A                     |DEM   |               490|        1133|  43.2480141|
|HILTON HEAD 2A                     |REP   |               601|        1133|  53.0450132|
|HILTON HEAD 2B                     |DEM   |               588|         999|  58.8588589|
|HILTON HEAD 2B                     |REP   |               332|         999|  33.2332332|
|HILTON HEAD 2C                     |DEM   |               335|        1311|  25.5530130|
|HILTON HEAD 2C                     |REP   |               951|        1311|  72.5400458|
|HILTON HEAD 3                      |DEM   |               189|         713|  26.5077139|
|HILTON HEAD 3                      |REP   |               491|         713|  68.8639551|
|HILTON HEAD 4A                     |DEM   |               171|         606|  28.2178218|
|HILTON HEAD 4A                     |REP   |               406|         606|  66.9966997|
|HILTON HEAD 4B                     |DEM   |               323|        1055|  30.6161137|
|HILTON HEAD 4B                     |REP   |               691|        1055|  65.4976303|
|HILTON HEAD 4C                     |DEM   |               317|         856|  37.0327103|
|HILTON HEAD 4C                     |REP   |               502|         856|  58.6448598|
|HILTON HEAD 4D                     |DEM   |               304|         929|  32.7233584|
|HILTON HEAD 4D                     |REP   |               586|         929|  63.0785791|
|HILTON HEAD 5A                     |DEM   |               304|         926|  32.8293737|
|HILTON HEAD 5A                     |REP   |               593|         926|  64.0388769|
|HILTON HEAD 5B                     |DEM   |               251|         830|  30.2409639|
|HILTON HEAD 5B                     |REP   |               545|         830|  65.6626506|
|HILTON HEAD 5C                     |DEM   |               246|         801|  30.7116105|
|HILTON HEAD 5C                     |REP   |               518|         801|  64.6691635|
|HILTON HEAD 6                      |DEM   |               324|        1115|  29.0582960|
|HILTON HEAD 6                      |REP   |               728|        1115|  65.2914798|
|HILTON HEAD 7A                     |DEM   |               298|         924|  32.2510823|
|HILTON HEAD 7A                     |REP   |               590|         924|  63.8528139|
|HILTON HEAD 7B                     |DEM   |               318|         982|  32.3828921|
|HILTON HEAD 7B                     |REP   |               629|         982|  64.0529532|
|HILTON HEAD 8                      |DEM   |               231|         683|  33.8213763|
|HILTON HEAD 8                      |REP   |               410|         683|  60.0292826|
|HILTON HEAD 9A                     |DEM   |               421|        1233|  34.1443633|
|HILTON HEAD 9A                     |REP   |               729|        1233|  59.1240876|
|HILTON HEAD 9B                     |DEM   |               187|        1084|  17.2509225|
|HILTON HEAD 9B                     |REP   |               865|        1084|  79.7970480|
|Hitchcock No. 66                   |DEM   |               224|         809|  27.6885043|
|Hitchcock No. 66                   |REP   |               557|         809|  68.8504326|
|Hobkirk's Hill                     |DEM   |               389|         971|  40.0617920|
|Hobkirk's Hill                     |REP   |               520|         971|  53.5530381|
|Hodges                             |DEM   |               249|        1074|  23.1843575|
|Hodges                             |REP   |               793|        1074|  73.8361266|
|Hollis Lakes                       |DEM   |               618|        1421|  43.4904996|
|Hollis Lakes                       |REP   |               716|        1421|  50.3870514|
|Hollow Creek                       |DEM   |               518|        2713|  19.0932547|
|Hollow Creek                       |REP   |              2070|        2713|  76.2992997|
|HOLLY                              |DEM   |                91|         843|  10.7947805|
|HOLLY                              |REP   |               724|         843|  85.8837485|
|Holly Grove-Buffalo                |DEM   |               107|        1038|  10.3082852|
|Holly Grove-Buffalo                |REP   |               886|        1038|  85.3564547|
|HOLLY HILL 1                       |DEM   |               869|        1530|  56.7973856|
|HOLLY HILL 1                       |REP   |               626|        1530|  40.9150327|
|HOLLY HILL 2                       |DEM   |              1340|        1575|  85.0793651|
|HOLLY HILL 2                       |REP   |               218|        1575|  13.8412698|
|Holly Springs                      |DEM   |               205|        1522|  13.4691196|
|Holly Springs                      |REP   |              1250|        1522|  82.1287779|
|Holly Springs Baptist              |DEM   |               268|        2381|  11.2557749|
|Holly Springs Baptist              |REP   |              2002|        2381|  84.0823184|
|HOLLY TREE                         |DEM   |               307|        1198|  25.6260434|
|HOLLY TREE                         |REP   |               834|        1198|  69.6160267|
|HOLLYWOOD                          |DEM   |               127|        1001|  12.6873127|
|HOLLYWOOD                          |REP   |               835|        1001|  83.4165834|
|HOLSTONS                           |DEM   |               351|         856|  41.0046729|
|HOLSTONS                           |REP   |               477|         856|  55.7242991|
|Holy Communion                     |DEM   |               879|        1362|  64.5374449|
|Holy Communion                     |REP   |               417|        1362|  30.6167401|
|Home Branch                        |DEM   |                53|         304|  17.4342105|
|Home Branch                        |REP   |               249|         304|  81.9078947|
|Homeland Park                      |DEM   |               803|        1806|  44.4629014|
|Homeland Park                      |REP   |               921|        1806|  50.9966777|
|HOMEWOOD                           |DEM   |               388|        1231|  31.5190902|
|HOMEWOOD                           |REP   |               803|        1231|  65.2315191|
|Honea Path                         |DEM   |               235|        1212|  19.3894389|
|Honea Path                         |REP   |               938|        1212|  77.3927393|
|Hook'S Store                       |DEM   |               615|        1513|  40.6477198|
|Hook'S Store                       |REP   |               818|        1513|  54.0647720|
|Hopewell                           |DEM   |               491|        2117|  23.1931979|
|Hopewell                           |REP   |              1519|        2117|  71.7524799|
|Hopkins 1                          |DEM   |               818|         928|  88.1465517|
|Hopkins 1                          |REP   |                92|         928|   9.9137931|
|Hopkins 2                          |DEM   |               813|         955|  85.1308901|
|Hopkins 2                          |REP   |               115|         955|  12.0418848|
|HORATIO                            |DEM   |               361|         423|  85.3427896|
|HORATIO                            |REP   |                57|         423|  13.4751773|
|HOREB-GLENN                        |DEM   |               264|         317|  83.2807571|
|HOREB-GLENN                        |REP   |                43|         317|  13.5646688|
|Horrell Hill                       |DEM   |               850|        1572|  54.0712468|
|Horrell Hill                       |REP   |               654|        1572|  41.6030534|
|HORRY                              |DEM   |               109|         987|  11.0435664|
|HORRY                              |REP   |               844|         987|  85.5116515|
|Horse Gall                         |DEM   |                 4|          74|   5.4054054|
|Horse Gall                         |REP   |                68|          74|  91.8918919|
|HORSE PEN                          |DEM   |               148|         522|  28.3524904|
|HORSE PEN                          |REP   |               351|         522|  67.2413793|
|Howe Hall 1                        |DEM   |               839|        1580|  53.1012658|
|Howe Hall 1                        |REP   |               640|        1580|  40.5063291|
|Howe Hall 2                        |DEM   |               386|         894|  43.1767338|
|Howe Hall 2                        |REP   |               419|         894|  46.8680089|
|HUDSON MILL                        |DEM   |               124|         424|  29.2452830|
|HUDSON MILL                        |REP   |               284|         424|  66.9811321|
|Huger                              |DEM   |               714|        1080|  66.1111111|
|Huger                              |REP   |               333|        1080|  30.8333333|
|Hunt Meadows                       |DEM   |               538|        3471|  15.4998559|
|Hunt Meadows                       |REP   |              2789|        3471|  80.3514837|
|HUNTER'S CHAPEL                    |DEM   |               114|         228|  50.0000000|
|HUNTER'S CHAPEL                    |REP   |               112|         228|  49.1228070|
|Hunting Creek                      |DEM   |               148|         344|  43.0232558|
|Hunting Creek                      |REP   |               187|         344|  54.3604651|
|Hyde Park                          |DEM   |               361|        1041|  34.6781940|
|Hyde Park                          |REP   |               637|        1041|  61.1911623|
|Independence                       |DEM   |               149|         736|  20.2445652|
|Independence                       |REP   |               558|         736|  75.8152174|
|India Hook                         |DEM   |               417|        1257|  33.1742243|
|India Hook                         |REP   |               759|        1257|  60.3818616|
|INDIAN BRANCH                      |DEM   |               169|         540|  31.2962963|
|INDIAN BRANCH                      |REP   |               348|         540|  64.4444444|
|Indian Field                       |DEM   |               316|         466|  67.8111588|
|Indian Field                       |REP   |               137|         466|  29.3991416|
|Indian Field 2                     |DEM   |               383|         708|  54.0960452|
|Indian Field 2                     |REP   |               306|         708|  43.2203390|
|INDIANTOWN                         |DEM   |              1076|        1266|  84.9921011|
|INDIANTOWN                         |REP   |               177|        1266|  13.9810427|
|INLAND                             |DEM   |               170|         392|  43.3673469|
|INLAND                             |REP   |               216|         392|  55.1020408|
|IONIA                              |DEM   |               223|         524|  42.5572519|
|IONIA                              |REP   |               295|         524|  56.2977099|
|Irmo                               |DEM   |               685|        1513|  45.2742895|
|Irmo                               |REP   |               715|        1513|  47.2571051|
|Irongate                           |DEM   |                93|         563|  16.5186501|
|Irongate                           |REP   |               428|         563|  76.0213144|
|Irongate 2                         |DEM   |               130|         331|  39.2749245|
|Irongate 2                         |REP   |               173|         331|  52.2658610|
|Irongate 3                         |DEM   |               118|         474|  24.8945148|
|Irongate 3                         |REP   |               312|         474|  65.8227848|
|ISLE OF PALMS 1A                   |DEM   |               244|         790|  30.8860759|
|ISLE OF PALMS 1A                   |REP   |               481|         790|  60.8860759|
|ISLE OF PALMS 1B                   |DEM   |               315|        1053|  29.9145299|
|ISLE OF PALMS 1B                   |REP   |               662|        1053|  62.8679962|
|ISLE OF PALMS 1C                   |DEM   |               280|         988|  28.3400810|
|ISLE OF PALMS 1C                   |REP   |               653|         988|  66.0931174|
|Issaqueena                         |DEM   |               277|         613|  45.1876020|
|Issaqueena                         |REP   |               280|         613|  45.6769984|
|Iva                                |DEM   |               241|        1262|  19.0966719|
|Iva                                |REP   |               966|        1262|  76.5451664|
|Jackson                            |DEM   |               257|        1314|  19.5585997|
|Jackson                            |REP   |              1020|        1314|  77.6255708|
|JACKSON BLUFF                      |DEM   |               112|         473|  23.6786469|
|JACKSON BLUFF                      |REP   |               325|         473|  68.7103594|
|Jackson Mill                       |DEM   |                80|         615|  13.0081301|
|Jackson Mill                       |REP   |               501|         615|  81.4634146|
|JACKSONBORO                        |DEM   |               306|         378|  80.9523810|
|JACKSONBORO                        |REP   |                66|         378|  17.4603175|
|Jacksonham                         |DEM   |               371|        1088|  34.0992647|
|Jacksonham                         |REP   |               685|        1088|  62.9595588|
|JAMES ISLAND 10                    |DEM   |               459|        1051|  43.6726927|
|JAMES ISLAND 10                    |REP   |               490|        1051|  46.6222645|
|JAMES ISLAND 11                    |DEM   |               430|        1122|  38.3244207|
|JAMES ISLAND 11                    |REP   |               591|        1122|  52.6737968|
|JAMES ISLAND 12                    |DEM   |               261|         789|  33.0798479|
|JAMES ISLAND 12                    |REP   |               452|         789|  57.2877060|
|JAMES ISLAND 13                    |DEM   |               365|         869|  42.0023015|
|JAMES ISLAND 13                    |REP   |               438|         869|  50.4027618|
|JAMES ISLAND 14                    |DEM   |               254|         706|  35.9773371|
|JAMES ISLAND 14                    |REP   |               398|         706|  56.3739377|
|JAMES ISLAND 15                    |DEM   |               514|        1172|  43.8566553|
|JAMES ISLAND 15                    |REP   |               551|        1172|  47.0136519|
|JAMES ISLAND 17                    |DEM   |               574|        1141|  50.3067485|
|JAMES ISLAND 17                    |REP   |               443|        1141|  38.8255916|
|JAMES ISLAND 19                    |DEM   |               503|        1058|  47.5425331|
|JAMES ISLAND 19                    |REP   |               449|        1058|  42.4385633|
|JAMES ISLAND 1A                    |DEM   |               647|        1347|  48.0326652|
|JAMES ISLAND 1A                    |REP   |               581|        1347|  43.1328879|
|JAMES ISLAND 1B                    |DEM   |               450|         550|  81.8181818|
|JAMES ISLAND 1B                    |REP   |                80|         550|  14.5454545|
|JAMES ISLAND 20                    |DEM   |               507|        1032|  49.1279070|
|JAMES ISLAND 20                    |REP   |               432|        1032|  41.8604651|
|JAMES ISLAND 22                    |DEM   |               464|         992|  46.7741935|
|JAMES ISLAND 22                    |REP   |               421|         992|  42.4395161|
|JAMES ISLAND 3                     |DEM   |               533|         627|  85.0079745|
|JAMES ISLAND 3                     |REP   |                72|         627|  11.4832536|
|JAMES ISLAND 5A                    |DEM   |               302|         865|  34.9132948|
|JAMES ISLAND 5A                    |REP   |               479|         865|  55.3757225|
|JAMES ISLAND 5B                    |DEM   |               139|         475|  29.2631579|
|JAMES ISLAND 5B                    |REP   |               306|         475|  64.4210526|
|JAMES ISLAND 6                     |DEM   |               533|        1070|  49.8130841|
|JAMES ISLAND 6                     |REP   |               475|        1070|  44.3925234|
|JAMES ISLAND 7                     |DEM   |               531|        1191|  44.5843829|
|JAMES ISLAND 7                     |REP   |               567|        1191|  47.6070529|
|JAMES ISLAND 8A                    |DEM   |               445|         772|  57.6424870|
|JAMES ISLAND 8A                    |REP   |               277|         772|  35.8808290|
|JAMES ISLAND 8B                    |DEM   |               601|        1282|  46.8798752|
|JAMES ISLAND 8B                    |REP   |               566|        1282|  44.1497660|
|JAMES ISLAND 9                     |DEM   |               478|        1078|  44.3413729|
|JAMES ISLAND 9                     |REP   |               505|        1078|  46.8460111|
|Jamestown                          |DEM   |               315|         534|  58.9887640|
|Jamestown                          |REP   |               200|         534|  37.4531835|
|JAMESTOWN                          |DEM   |               920|        2332|  39.4511149|
|JAMESTOWN                          |REP   |              1322|        2332|  56.6895369|
|JAMISON                            |DEM   |               968|        1331|  72.7272727|
|JAMISON                            |REP   |               332|        1331|  24.9436514|
|JEFFERSON                          |DEM   |               650|        1490|  43.6241611|
|JEFFERSON                          |REP   |               797|        1490|  53.4899329|
|JENKINSVILLE                       |DEM   |               524|         612|  85.6209150|
|JENKINSVILLE                       |REP   |                77|         612|  12.5816993|
|JENNINGS MILL                      |DEM   |               263|        1454|  18.0880330|
|JENNINGS MILL                      |REP   |              1111|        1454|  76.4099037|
|JERIGANS CROSSROADS                |DEM   |               108|         660|  16.3636364|
|JERIGANS CROSSROADS                |REP   |               532|         660|  80.6060606|
|Jesse Bobo Elementary              |DEM   |              1008|        1342|  75.1117735|
|Jesse Bobo Elementary              |REP   |               276|        1342|  20.5663189|
|Jesse Boyd Elementary              |DEM   |               536|         998|  53.7074148|
|Jesse Boyd Elementary              |REP   |               404|         998|  40.4809619|
|JET PORT #1                        |DEM   |               427|        1326|  32.2021116|
|JET PORT #1                        |REP   |               856|        1326|  64.5550528|
|JET PORT #2                        |DEM   |               986|        3162|  31.1827957|
|JET PORT #2                        |REP   |              2060|        3162|  65.1486401|
|JOANNA                             |DEM   |               328|        1416|  23.1638418|
|JOANNA                             |REP   |              1027|        1416|  72.5282486|
|JOHNS ISLAND 1A                    |DEM   |               372|        1100|  33.8181818|
|JOHNS ISLAND 1A                    |REP   |               682|        1100|  62.0000000|
|JOHNS ISLAND 1B                    |DEM   |               632|        1078|  58.6270872|
|JOHNS ISLAND 1B                    |REP   |               385|        1078|  35.7142857|
|JOHNS ISLAND 2                     |DEM   |              1006|        2484|  40.4991948|
|JOHNS ISLAND 2                     |REP   |              1279|        2484|  51.4895330|
|JOHNS ISLAND 3A                    |DEM   |               686|        1815|  37.7961433|
|JOHNS ISLAND 3A                    |REP   |               983|        1815|  54.1597796|
|JOHNS ISLAND 3B                    |DEM   |               626|        1202|  52.0798669|
|JOHNS ISLAND 3B                    |REP   |               528|        1202|  43.9267887|
|JOHNS ISLAND 4                     |DEM   |               421|         761|  55.3219448|
|JOHNS ISLAND 4                     |REP   |               296|         761|  38.8961892|
|JOHNSONVILLE                       |DEM   |               572|        1794|  31.8840580|
|JOHNSONVILLE                       |REP   |              1178|        1794|  65.6633222|
|Johnston No.1                      |DEM   |               811|        1188|  68.2659933|
|Johnston No.1                      |REP   |               347|        1188|  29.2087542|
|Johnston No.2                      |DEM   |               619|        1053|  58.7844255|
|Johnston No.2                      |REP   |               406|        1053|  38.5565052|
|JOHNSTONE                          |DEM   |               148|         399|  37.0927318|
|JOHNSTONE                          |REP   |               236|         399|  59.1478697|
|JONES                              |DEM   |               412|        1256|  32.8025478|
|JONES                              |REP   |               794|        1256|  63.2165605|
|JONESVILLE BOX 1                   |DEM   |               230|         852|  26.9953052|
|JONESVILLE BOX 1                   |REP   |               594|         852|  69.7183099|
|JONESVILLE BOX 2                   |DEM   |               369|         933|  39.5498392|
|JONESVILLE BOX 2                   |REP   |               532|         933|  57.0203644|
|Jordan                             |DEM   |               297|        1157|  25.6698358|
|Jordan                             |REP   |               823|        1157|  71.1322385|
|JORDANVILLE                        |DEM   |                25|         538|   4.6468401|
|JORDANVILLE                        |REP   |               500|         538|  92.9368030|
|JOYNER SWAMP                       |DEM   |                64|         387|  16.5374677|
|JOYNER SWAMP                       |REP   |               317|         387|  81.9121447|
|JUNIPER BAY                        |DEM   |               269|        1516|  17.7440633|
|JUNIPER BAY                        |REP   |              1185|        1516|  78.1662269|
|Kanawha                            |DEM   |               392|        1249|  31.3851081|
|Kanawha                            |REP   |               787|        1249|  63.0104083|
|KEARSE                             |DEM   |                 6|         113|   5.3097345|
|KEARSE                             |REP   |               107|         113|  94.6902655|
|Keels 1                            |DEM   |               934|        1094|  85.3747715|
|Keels 1                            |REP   |               120|        1094|  10.9689214|
|Keels 2                            |DEM   |               799|         911|  87.7058178|
|Keels 2                            |REP   |                80|         911|   8.7815587|
|Keenan                             |DEM   |               804|        1169|  68.7767322|
|Keenan                             |REP   |               300|        1169|  25.6629598|
|KELLEYTOWN                         |DEM   |               245|        1463|  16.7464115|
|KELLEYTOWN                         |REP   |              1165|        1463|  79.6308954|
|Kelly Mill                         |DEM   |               734|        1373|  53.4595776|
|Kelly Mill                         |REP   |               578|        1373|  42.0975965|
|KELTON                             |DEM   |               307|         803|  38.2316314|
|KELTON                             |REP   |               459|         803|  57.1606476|
|KEMPER                             |DEM   |               220|         375|  58.6666667|
|KEMPER                             |REP   |               147|         375|  39.2000000|
|KENSINGTON                         |DEM   |               148|         721|  20.5270458|
|KENSINGTON                         |REP   |               550|         721|  76.2829404|
|Keowee                             |DEM   |               369|        2158|  17.0991659|
|Keowee                             |REP   |              1704|        2158|  78.9620019|
|Kershaw North                      |DEM   |               495|        1207|  41.0107705|
|Kershaw North                      |REP   |               669|        1207|  55.4266777|
|Kershaw South                      |DEM   |               223|        1117|  19.9641898|
|Kershaw South                      |REP   |               855|        1117|  76.5443151|
|KIAWAH ISLAND                      |DEM   |               342|        1188|  28.7878788|
|KIAWAH ISLAND                      |REP   |               777|        1188|  65.4040404|
|KILGORE FARMS                      |DEM   |               676|        2071|  32.6412361|
|KILGORE FARMS                      |REP   |              1284|        2071|  61.9990343|
|Killian                            |DEM   |               902|        1427|  63.2095305|
|Killian                            |REP   |               448|        1427|  31.3945340|
|KINARDS JALAPA                     |DEM   |               126|         397|  31.7380353|
|KINARDS JALAPA                     |REP   |               260|         397|  65.4911839|
|King's Grant                       |DEM   |               494|        1345|  36.7286245|
|King's Grant                       |REP   |               782|        1345|  58.1412639|
|King's Grant 2                     |DEM   |               490|        1287|  38.0730381|
|King's Grant 2                     |REP   |               743|        1287|  57.7311577|
|KINGSBURG-STONE                    |DEM   |               560|         955|  58.6387435|
|KINGSBURG-STONE                    |REP   |               379|         955|  39.6858639|
|KINGSTREE NO.1                     |DEM   |              1065|        2112|  50.4261364|
|KINGSTREE NO.1                     |REP   |               999|        2112|  47.3011364|
|KINGSTREE NO.2                     |DEM   |               575|         611|  94.1080196|
|KINGSTREE NO.2                     |REP   |                18|         611|   2.9459902|
|KINGSTREE NO.3                     |DEM   |              1335|        1453|  91.8788713|
|KINGSTREE NO.3                     |REP   |                87|        1453|   5.9876118|
|KINGSTREE NO.4                     |DEM   |               709|         899|  78.8654060|
|KINGSTREE NO.4                     |REP   |               166|         899|  18.4649611|
|Kingswood                          |DEM   |              1828|        2118|  86.3078376|
|Kingswood                          |REP   |               227|        2118|  10.7176582|
|Kitti Wake                         |DEM   |               472|        1492|  31.6353887|
|Kitti Wake                         |REP   |               927|        1492|  62.1313673|
|KLINE                              |DEM   |               208|         493|  42.1906694|
|KLINE                              |REP   |               271|         493|  54.9695740|
|Knightsville                       |DEM   |               264|         898|  29.3986637|
|Knightsville                       |REP   |               591|         898|  65.8129176|
|La France                          |DEM   |               203|         753|  26.9588313|
|La France                          |REP   |               515|         753|  68.3930943|
|Laco                               |DEM   |               358|        1098|  32.6047359|
|Laco                               |REP   |               692|        1098|  63.0236794|
|LADSON                             |DEM   |              1041|        1827|  56.9786535|
|LADSON                             |REP   |               670|        1827|  36.6721401|
|Ladys Island 1A                    |DEM   |               361|        1043|  34.6116970|
|Ladys Island 1A                    |REP   |               603|        1043|  57.8139981|
|Ladys Island 1B                    |DEM   |               421|        1036|  40.6370656|
|Ladys Island 1B                    |REP   |               577|        1036|  55.6949807|
|Ladys Island 2A                    |DEM   |               254|        1134|  22.3985891|
|Ladys Island 2A                    |REP   |               815|        1134|  71.8694885|
|Ladys Island 2B                    |DEM   |               244|         842|  28.9786223|
|Ladys Island 2B                    |REP   |               553|         842|  65.6769596|
|Ladys Island 2C                    |DEM   |               219|         705|  31.0638298|
|Ladys Island 2C                    |REP   |               432|         705|  61.2765957|
|Ladys Island 3A                    |DEM   |               189|         645|  29.3023256|
|Ladys Island 3A                    |REP   |               429|         645|  66.5116279|
|Ladys Island 3B                    |DEM   |               197|         762|  25.8530184|
|Ladys Island 3B                    |REP   |               527|         762|  69.1601050|
|Ladys Island 3C                    |DEM   |               183|         670|  27.3134328|
|Ladys Island 3C                    |REP   |               445|         670|  66.4179104|
|Lake Bowen Baptist                 |DEM   |               383|        2910|  13.1615120|
|Lake Bowen Baptist                 |REP   |              2421|        2910|  83.1958763|
|Lake Carolina                      |DEM   |               956|        1951|  49.0005126|
|Lake Carolina                      |REP   |               892|        1951|  45.7201435|
|LAKE CITY NO. 1                    |DEM   |               880|        1135|  77.5330396|
|LAKE CITY NO. 1                    |REP   |               227|        1135|  20.0000000|
|LAKE CITY NO. 2                    |DEM   |               366|         963|  38.0062305|
|LAKE CITY NO. 2                    |REP   |               561|         963|  58.2554517|
|LAKE CITY NO. 3                    |DEM   |               772|        1230|  62.7642276|
|LAKE CITY NO. 3                    |REP   |               420|        1230|  34.1463415|
|LAKE CITY NO. 4                    |DEM   |              1475|        1532|  96.2793734|
|LAKE CITY NO. 4                    |REP   |                37|        1532|   2.4151436|
|Lake House                         |DEM   |               541|        1574|  34.3710292|
|Lake House                         |REP   |               972|        1574|  61.7534943|
|Lake Murray #1                     |DEM   |               242|        1600|  15.1250000|
|Lake Murray #1                     |REP   |              1259|        1600|  78.6875000|
|Lake Murray #2                     |DEM   |               462|        2204|  20.9618875|
|Lake Murray #2                     |REP   |              1611|        2204|  73.0943739|
|LAKE PARK                          |DEM   |              1107|        3697|  29.9431972|
|LAKE PARK                          |REP   |              2421|        3697|  65.4855288|
|LAKE SWAMP                         |DEM   |               538|        1235|  43.5627530|
|LAKE SWAMP                         |REP   |               650|        1235|  52.6315789|
|LAKE VIEW                          |DEM   |               487|        1035|  47.0531401|
|LAKE VIEW                          |REP   |               522|        1035|  50.4347826|
|Lakeshore                          |DEM   |               551|        1755|  31.3960114|
|Lakeshore                          |REP   |              1111|        1755|  63.3048433|
|Lakeside                           |DEM   |               754|        1817|  41.4969730|
|Lakeside                           |REP   |               999|        1817|  54.9807375|
|LAKEVIEW                           |DEM   |               849|        1970|  43.0964467|
|LAKEVIEW                           |REP   |               987|        1970|  50.1015228|
|Lakewood                           |DEM   |               294|        1180|  24.9152542|
|Lakewood                           |REP   |               824|        1180|  69.8305085|
|LAMAR NO. 1                        |DEM   |               514|         791|  64.9810367|
|LAMAR NO. 1                        |REP   |               267|         791|  33.7547408|
|LAMAR NO. 2                        |DEM   |               583|        1429|  40.7977607|
|LAMAR NO. 2                        |REP   |               810|        1429|  56.6829951|
|Lancaster East                     |DEM   |               632|         939|  67.3056443|
|Lancaster East                     |REP   |               278|         939|  29.6059638|
|Lancaster West                     |DEM   |               320|         562|  56.9395018|
|Lancaster West                     |REP   |               207|         562|  36.8327402|
|Lando/Lansford                     |DEM   |               236|         818|  28.8508557|
|Lando/Lansford                     |REP   |               556|         818|  67.9706601|
|Landrum High School                |DEM   |               313|        1909|  16.3960189|
|Landrum High School                |REP   |              1531|        1909|  80.1990571|
|Landrum United Methodist           |DEM   |               485|        2272|  21.3468310|
|Landrum United Methodist           |REP   |              1717|        2272|  75.5721831|
|LANE                               |DEM   |               802|         872|  91.9724771|
|LANE                               |REP   |                65|         872|   7.4541284|
|Langley                            |DEM   |               227|         974|  23.3059548|
|Langley                            |REP   |               689|         974|  70.7392197|
|Larne                              |DEM   |               283|         953|  29.6956978|
|Larne                              |REP   |               615|         953|  64.5330535|
|LATTA                              |DEM   |              1039|        1834|  56.6521265|
|LATTA                              |REP   |               743|        1834|  40.5125409|
|Laurel Creek                       |DEM   |               251|        1046|  23.9961759|
|Laurel Creek                       |REP   |               759|        1046|  72.5621415|
|LAUREL RIDGE                       |DEM   |               545|        2007|  27.1549576|
|LAUREL RIDGE                       |REP   |              1359|        2007|  67.7130045|
|LAURENS 1                          |DEM   |               325|         479|  67.8496868|
|LAURENS 1                          |REP   |               137|         479|  28.6012526|
|LAURENS 2                          |DEM   |               329|         386|  85.2331606|
|LAURENS 2                          |REP   |                44|         386|  11.3989637|
|LAURENS 3                          |DEM   |               318|         593|  53.6256324|
|LAURENS 3                          |REP   |               255|         593|  43.0016863|
|LAURENS 4                          |DEM   |               469|         580|  80.8620690|
|LAURENS 4                          |REP   |                86|         580|  14.8275862|
|LAURENS 5                          |DEM   |               326|         922|  35.3579176|
|LAURENS 5                          |REP   |               565|         922|  61.2798265|
|LAURENS 6                          |DEM   |               200|         704|  28.4090909|
|LAURENS 6                          |REP   |               480|         704|  68.1818182|
|Lawrence Chapel                    |DEM   |               233|        1041|  22.3823247|
|Lawrence Chapel                    |REP   |               735|        1041|  70.6051873|
|Leaphart Road                      |DEM   |               307|         768|  39.9739583|
|Leaphart Road                      |REP   |               403|         768|  52.4739583|
|LEAWOOD                            |DEM   |               697|        1803|  38.6577926|
|LEAWOOD                            |REP   |               995|        1803|  55.1858014|
|Lebanon                            |DEM   |               298|        1320|  22.5757576|
|Lebanon                            |REP   |               973|        1320|  73.7121212|
|LEBANON                            |DEM   |               288|         518|  55.5984556|
|LEBANON                            |REP   |               216|         518|  41.6988417|
|Leesville                          |DEM   |               788|        1842|  42.7795874|
|Leesville                          |REP   |               991|        1842|  53.8002172|
|LEMIRA                             |DEM   |               818|         976|  83.8114754|
|LEMIRA                             |REP   |               127|         976|  13.0122951|
|Lenhart                            |DEM   |               197|         931|  21.1600430|
|Lenhart                            |REP   |               700|         931|  75.1879699|
|LEO                                |DEM   |               116|         293|  39.5904437|
|LEO                                |REP   |               171|         293|  58.3617747|
|LEON                               |DEM   |               746|        1418|  52.6093089|
|LEON                               |REP   |               624|        1418|  44.0056417|
|Lesslie                            |DEM   |               178|        1127|  15.7941437|
|Lesslie                            |REP   |               899|        1127|  79.7692990|
|Levels No. 52                      |DEM   |               410|        1007|  40.7149950|
|Levels No. 52                      |REP   |               534|        1007|  53.0287984|
|Levels No. 72                      |DEM   |               286|         752|  38.0319149|
|Levels No. 72                      |REP   |               398|         752|  52.9255319|
|Levels No. 83                      |DEM   |               191|         451|  42.3503326|
|Levels No. 83                      |REP   |               221|         451|  49.0022173|
|Levy                               |DEM   |               834|        1362|  61.2334802|
|Levy                               |REP   |               478|        1362|  35.0954479|
|Lexington #3                       |DEM   |               367|        1617|  22.6963513|
|Lexington #3                       |REP   |              1126|        1617|  69.6351268|
|Lexington #4                       |DEM   |               614|        2137|  28.7318671|
|Lexington #4                       |REP   |              1377|        2137|  64.4361254|
|Lexington No. 1                    |DEM   |               476|        1829|  26.0251504|
|Lexington No. 1                    |REP   |              1217|        1829|  66.5390924|
|Lexington No. 2                    |DEM   |               407|        1204|  33.8039867|
|Lexington No. 2                    |REP   |               717|        1204|  59.5514950|
|Liberty                            |DEM   |               347|         640|  54.2187500|
|Liberty                            |REP   |               273|         640|  42.6562500|
|Liberty Hall                       |DEM   |               809|        1812|  44.6467991|
|Liberty Hall                       |REP   |               846|        1812|  46.6887417|
|Liberty Hill                       |DEM   |               107|         424|  25.2358491|
|Liberty Hill                       |REP   |               305|         424|  71.9339623|
|LIMESTONE 1                        |DEM   |              1249|        1685|  74.1246291|
|LIMESTONE 1                        |REP   |               408|        1685|  24.2136499|
|LIMESTONE 2                        |DEM   |               512|         805|  63.6024845|
|LIMESTONE 2                        |REP   |               275|         805|  34.1614907|
|Limestone Mill                     |DEM   |               288|         573|  50.2617801|
|Limestone Mill                     |REP   |               266|         573|  46.4223386|
|Lincoln                            |DEM   |               755|        1137|  66.4028144|
|Lincoln                            |REP   |               328|        1137|  28.8478452|
|Lincolnshire                       |DEM   |              1653|        1719|  96.1605585|
|Lincolnshire                       |REP   |                30|        1719|   1.7452007|
|LINCOLNVILLE                       |DEM   |               641|        1226|  52.2838499|
|LINCOLNVILLE                       |REP   |               511|        1226|  41.6802610|
|Lincreek                           |DEM   |               536|        1534|  34.9413299|
|Lincreek                           |REP   |               918|        1534|  59.8435463|
|LITTLE MOUNTAIN                    |DEM   |               255|         842|  30.2850356|
|LITTLE MOUNTAIN                    |REP   |               571|         842|  67.8147268|
|LITTLE RIVER #1                    |DEM   |               314|        1416|  22.1751412|
|LITTLE RIVER #1                    |REP   |              1045|        1416|  73.7994350|
|LITTLE RIVER #2                    |DEM   |               606|        2330|  26.0085837|
|LITTLE RIVER #2                    |REP   |              1633|        2330|  70.0858369|
|LITTLE RIVER #3                    |DEM   |               452|        1865|  24.2359249|
|LITTLE RIVER #3                    |REP   |              1359|        1865|  72.8686327|
|LITTLE ROCK                        |DEM   |               421|         615|  68.4552846|
|LITTLE ROCK                        |REP   |               182|         615|  29.5934959|
|LITTLE SWAMP                       |DEM   |                13|         120|  10.8333333|
|LITTLE SWAMP                       |REP   |               108|         120|  90.0000000|
|Littlejohn's and Sarratt's         |DEM   |                27|         325|   8.3076923|
|Littlejohn's and Sarratt's         |REP   |               294|         325|  90.4615385|
|LIVE OAK                           |DEM   |               229|         659|  34.7496206|
|LIVE OAK                           |REP   |               407|         659|  61.7602428|
|LOCKHART                           |DEM   |               119|         549|  21.6757741|
|LOCKHART                           |REP   |               397|         549|  72.3132969|
|LOCUST HILL                        |DEM   |               214|        1450|  14.7586207|
|LOCUST HILL                        |REP   |              1179|        1450|  81.3103448|
|LONE STAR                          |DEM   |               396|         845|  46.8639053|
|LONE STAR                          |REP   |               435|         845|  51.4792899|
|LONG BRANCH                        |DEM   |               181|         959|  18.8738269|
|LONG BRANCH                        |REP   |               734|         959|  76.5380605|
|Long Creek                         |DEM   |                84|         349|  24.0687679|
|Long Creek                         |REP   |               240|         349|  68.7679083|
|LONG CREEK                         |DEM   |               342|        1285|  26.6147860|
|LONG CREEK                         |REP   |               872|        1285|  67.8599222|
|Longcreek                          |DEM   |              1092|        2719|  40.1618242|
|Longcreek                          |REP   |              1472|        2719|  54.1375506|
|Longleaf                           |DEM   |              1094|        1275|  85.8039216|
|Longleaf                           |REP   |               146|        1275|  11.4509804|
|LORING                             |DEM   |               547|         642|  85.2024922|
|LORING                             |REP   |                81|         642|  12.6168224|
|Lower Lake                         |DEM   |               126|         896|  14.0625000|
|Lower Lake                         |REP   |               744|         896|  83.0357143|
|Lowndesville                       |DEM   |               137|         863|  15.8748552|
|Lowndesville                       |REP   |               706|         863|  81.8076477|
|Lowrys                             |DEM   |               185|         739|  25.0338295|
|Lowrys                             |REP   |               522|         739|  70.6359946|
|Lugoff No. 1                       |DEM   |               281|         831|  33.8146811|
|Lugoff No. 1                       |REP   |               510|         831|  61.3718412|
|Lugoff No. 2                       |DEM   |               317|        1279|  24.7849883|
|Lugoff No. 2                       |REP   |               900|        1279|  70.3674746|
|Lugoff No. 3                       |DEM   |               266|        1172|  22.6962457|
|Lugoff No. 3                       |REP   |               830|        1172|  70.8191126|
|Lugoff No. 4                       |DEM   |               196|        1020|  19.2156863|
|Lugoff No. 4                       |REP   |               778|        1020|  76.2745098|
|LYDIA                              |DEM   |               513|         717|  71.5481172|
|LYDIA                              |REP   |               190|         717|  26.4993026|
|LYDIA MILL                         |DEM   |               503|         831|  60.5294826|
|LYDIA MILL                         |REP   |               284|         831|  34.1756919|
|Lykesland                          |DEM   |               857|        1270|  67.4803150|
|Lykesland                          |REP   |               365|        1270|  28.7401575|
|Lyman Town Hall                    |DEM   |               658|        2836|  23.2016925|
|Lyman Town Hall                    |REP   |              2079|        2836|  73.3074753|
|LYNCHBURG                          |DEM   |               688|         774|  88.8888889|
|LYNCHBURG                          |REP   |                77|         774|   9.9483204|
|Lynwood                            |DEM   |               186|         757|  24.5706737|
|Lynwood                            |REP   |               536|         757|  70.8058124|
|Lynwood Drive                      |DEM   |               569|        1501|  37.9080613|
|Lynwood Drive                      |REP   |               873|        1501|  58.1612258|
|Macedonia                          |DEM   |               320|        2742|  11.6703136|
|Macedonia                          |REP   |              2330|        2742|  84.9744712|
|Mack-Edisto                        |DEM   |               130|         667|  19.4902549|
|Mack-Edisto                        |REP   |               506|         667|  75.8620690|
|MADDENS                            |DEM   |               240|         896|  26.7857143|
|MADDENS                            |REP   |               619|         896|  69.0848214|
|Madison                            |DEM   |                47|         549|   8.5610200|
|Madison                            |REP   |               482|         549|  87.7959927|
|MAGNOLIA-HARMONY                   |DEM   |               400|         463|  86.3930886|
|MAGNOLIA-HARMONY                   |REP   |                58|         463|  12.5269978|
|Mallet Hill                        |DEM   |              1135|        1664|  68.2091346|
|Mallet Hill                        |REP   |               460|        1664|  27.6442308|
|Malvern Hill                       |DEM   |               495|        1064|  46.5225564|
|Malvern Hill                       |REP   |               519|        1064|  48.7781955|
|Manchester                         |DEM   |               415|         956|  43.4100418|
|Manchester                         |REP   |               482|         956|  50.4184100|
|MANCHESTER FOREST                  |DEM   |               552|        1135|  48.6343612|
|MANCHESTER FOREST                  |REP   |               553|        1135|  48.7224670|
|MANNING                            |DEM   |               107|         243|  44.0329218|
|MANNING                            |REP   |               129|         243|  53.0864198|
|Manning No. 1                      |DEM   |               251|         398|  63.0653266|
|Manning No. 1                      |REP   |               138|         398|  34.6733668|
|Manning No. 2                      |DEM   |               308|         536|  57.4626866|
|Manning No. 2                      |REP   |               214|         536|  39.9253731|
|Manning No. 3                      |DEM   |               232|         720|  32.2222222|
|Manning No. 3                      |REP   |               460|         720|  63.8888889|
|Manning No. 4                      |DEM   |               489|         575|  85.0434783|
|Manning No. 4                      |REP   |                80|         575|  13.9130435|
|Manning No. 5                      |DEM   |               328|         619|  52.9886914|
|Manning No. 5                      |REP   |               274|         619|  44.2649435|
|MANVILLE                           |DEM   |               447|         585|  76.4102564|
|MANVILLE                           |REP   |               124|         585|  21.1965812|
|MAPLE                              |DEM   |               333|        1243|  26.7900241|
|MAPLE                              |REP   |               881|        1243|  70.8769107|
|MAPLE CANE                         |DEM   |               115|         701|  16.4051355|
|MAPLE CANE                         |REP   |               548|         701|  78.1740371|
|MAPLE CREEK                        |DEM   |               521|        1718|  30.3259604|
|MAPLE CREEK                        |REP   |              1116|        1718|  64.9592549|
|MARIDELL                           |DEM   |               353|        1760|  20.0568182|
|MARIDELL                           |REP   |              1328|        1760|  75.4545455|
|MARION NO. 1                       |DEM   |               653|         909|  71.8371837|
|MARION NO. 1                       |REP   |               221|         909|  24.3124312|
|MARION NO. 2                       |DEM   |               453|         952|  47.5840336|
|MARION NO. 2                       |REP   |               462|         952|  48.5294118|
|MARION NORTH                       |DEM   |               624|        1139|  54.7848990|
|MARION NORTH                       |REP   |               473|        1139|  41.5276558|
|MARION SOUTH                       |DEM   |              1679|        2098|  80.0285987|
|MARION SOUTH                       |REP   |               383|        2098|  18.2554814|
|MARION WEST                        |DEM   |               415|         943|  44.0084836|
|MARION WEST                        |REP   |               508|         943|  53.8706257|
|MARLOWE #1                         |DEM   |               549|        2200|  24.9545455|
|MARLOWE #1                         |REP   |              1572|        2200|  71.4545455|
|MARLOWE #2                         |DEM   |               711|        2612|  27.2205207|
|MARLOWE #2                         |REP   |              1830|        2612|  70.0612557|
|MARLOWE #3                         |DEM   |               392|        1397|  28.0601288|
|MARLOWE #3                         |REP   |               953|        1397|  68.2176092|
|MARS BLUFF NO. 1                   |DEM   |               713|        1522|  46.8462549|
|MARS BLUFF NO. 1                   |REP   |               757|        1522|  49.7371879|
|MARS BLUFF NO. 2                   |DEM   |               351|        1062|  33.0508475|
|MARS BLUFF NO. 2                   |REP   |               674|        1062|  63.4651601|
|Marshall Oaks                      |DEM   |               316|         412|  76.6990291|
|Marshall Oaks                      |REP   |                79|         412|  19.1747573|
|MARTIN                             |DEM   |               228|         289|  78.8927336|
|MARTIN                             |REP   |                54|         289|  18.6851211|
|MARTINS-POPLAR SPRINGS             |DEM   |                74|         603|  12.2719735|
|MARTINS-POPLAR SPRINGS             |REP   |               507|         603|  84.0796020|
|MASHAWVILLE                        |DEM   |               326|         561|  58.1105169|
|MASHAWVILLE                        |REP   |               221|         561|  39.3939394|
|MAULDIN 1                          |DEM   |               709|        1732|  40.9353349|
|MAULDIN 1                          |REP   |               911|        1732|  52.5981524|
|MAULDIN 2                          |DEM   |              1027|        2963|  34.6608167|
|MAULDIN 2                          |REP   |              1742|        2963|  58.7917651|
|MAULDIN 3                          |DEM   |              1201|        2224|  54.0017986|
|MAULDIN 3                          |REP   |               909|        2224|  40.8723022|
|MAULDIN 4                          |DEM   |               967|        2535|  38.1459566|
|MAULDIN 4                          |REP   |              1434|        2535|  56.5680473|
|MAULDIN 5                          |DEM   |               898|        2237|  40.1430487|
|MAULDIN 5                          |REP   |              1186|        2237|  53.0174341|
|MAULDIN 6                          |DEM   |               793|        1980|  40.0505051|
|MAULDIN 6                          |REP   |              1099|        1980|  55.5050505|
|MAULDIN 7                          |DEM   |               536|        1660|  32.2891566|
|MAULDIN 7                          |REP   |               995|        1660|  59.9397590|
|Maxwellton Pike                    |DEM   |                82|         596|  13.7583893|
|Maxwellton Pike                    |REP   |               490|         596|  82.2147651|
|MAYBINTON                          |DEM   |                63|          79|  79.7468354|
|MAYBINTON                          |REP   |                17|          79|  21.5189873|
|MAYESVILLE                         |DEM   |               500|         590|  84.7457627|
|MAYESVILLE                         |REP   |                84|         590|  14.2372881|
|MAYEWOOD                           |DEM   |               450|        1051|  42.8163654|
|MAYEWOOD                           |REP   |               572|        1051|  54.4243578|
|Mayo Elementary                    |DEM   |               159|        1330|  11.9548872|
|Mayo Elementary                    |REP   |              1127|        1330|  84.7368421|
|MAYSON                             |DEM   |               105|         378|  27.7777778|
|MAYSON                             |REP   |               261|         378|  69.0476190|
|McAllister                         |DEM   |               183|         825|  22.1818182|
|McAllister                         |REP   |               606|         825|  73.4545455|
|MCALLISTER MILL                    |DEM   |               213|         623|  34.1894061|
|MCALLISTER MILL                    |REP   |               398|         623|  63.8844302|
|MCBEE                              |DEM   |               573|        1447|  39.5991707|
|MCBEE                              |REP   |               821|        1447|  56.7380788|
|McBeth                             |DEM   |               276|         804|  34.3283582|
|McBeth                             |REP   |               503|         804|  62.5621891|
|MCCLELLANVILLE                     |DEM   |               971|        1375|  70.6181818|
|MCCLELLANVILLE                     |REP   |               355|        1375|  25.8181818|
|MCCOLL                             |DEM   |               326|         703|  46.3726885|
|MCCOLL                             |REP   |               348|         703|  49.5021337|
|McConnells                         |DEM   |               338|        1225|  27.5918367|
|McConnells                         |REP   |               840|        1225|  68.5714286|
|McCormick No. 1                    |DEM   |               470|         743|  63.2570659|
|McCormick No. 1                    |REP   |               244|         743|  32.8398385|
|McCormick No. 2                    |DEM   |               414|         582|  71.1340206|
|McCormick No. 2                    |REP   |               156|         582|  26.8041237|
|MCCRAYS MILL 1                     |DEM   |               389|        1000|  38.9000000|
|MCCRAYS MILL 1                     |REP   |               588|        1000|  58.8000000|
|MCCRAYS MILL 2                     |DEM   |               388|        1107|  35.0496838|
|MCCRAYS MILL 2                     |REP   |               685|        1107|  61.8789521|
|McEntire                           |DEM   |               332|         580|  57.2413793|
|McEntire                           |REP   |               225|         580|  38.7931034|
|McKissick                          |DEM   |               261|        1013|  25.7650543|
|McKissick                          |REP   |               712|        1013|  70.2862784|
|Meadowfield                        |DEM   |               486|        1126|  43.1616341|
|Meadowfield                        |REP   |               574|        1126|  50.9769094|
|Meadowlake                         |DEM   |              1413|        1473|  95.9266802|
|Meadowlake                         |REP   |                28|        1473|   1.9008826|
|MECHANICSVILLE                     |DEM   |               708|        1266|  55.9241706|
|MECHANICSVILLE                     |REP   |               531|        1266|  41.9431280|
|Medway                             |DEM   |              1236|        2643|  46.7650397|
|Medway                             |REP   |              1199|        2643|  45.3651154|
|Melton                             |DEM   |               150|         599|  25.0417362|
|Melton                             |REP   |               416|         599|  69.4490818|
|Merriweather No.1                  |DEM   |               358|        2029|  17.6441597|
|Merriweather No.1                  |REP   |              1592|        2029|  78.4622967|
|Merriweather No.2                  |DEM   |               432|        2389|  18.0828799|
|Merriweather No.2                  |REP   |              1853|        2389|  77.5638342|
|METHODIST-MILL SWAMP               |DEM   |                28|         745|   3.7583893|
|METHODIST-MILL SWAMP               |REP   |               700|         745|  93.9597315|
|MIDDENDORF                         |DEM   |                80|         607|  13.1795717|
|MIDDENDORF                         |REP   |               508|         607|  83.6902801|
|Midland Valley No. 51              |DEM   |               458|        1583|  28.9324068|
|Midland Valley No. 51              |REP   |              1057|        1583|  66.7719520|
|Midland Valley No. 71              |DEM   |               408|        1537|  26.5452180|
|Midland Valley No. 71              |REP   |              1078|        1537|  70.1366298|
|Midway                             |DEM   |              1673|        3274|  51.0995724|
|Midway                             |REP   |              1435|        3274|  43.8301772|
|MIDWAY                             |DEM   |               113|         552|  20.4710145|
|MIDWAY                             |REP   |               426|         552|  77.1739130|
|Miles/Jamison                      |DEM   |               461|        1402|  32.8815977|
|Miles/Jamison                      |REP   |               845|        1402|  60.2710414|
|MILL BRANCH                        |DEM   |               426|         616|  69.1558442|
|MILL BRANCH                        |REP   |               172|         616|  27.9220779|
|Mill Creek                         |DEM   |               879|        1811|  48.5367200|
|Mill Creek                         |REP   |               853|        1811|  47.1010491|
|Millbrook                          |DEM   |               362|        1273|  28.4367636|
|Millbrook                          |REP   |               834|        1273|  65.5145326|
|MILLWOOD                           |DEM   |               223|         487|  45.7905544|
|MILLWOOD                           |REP   |               224|         487|  45.9958932|
|Mimosa Crest                       |DEM   |               176|         525|  33.5238095|
|Mimosa Crest                       |REP   |               324|         525|  61.7142857|
|Mims                               |DEM   |               228|        1088|  20.9558824|
|Mims                               |REP   |               819|        1088|  75.2757353|
|MINTURN                            |DEM   |               115|         174|  66.0919540|
|MINTURN                            |REP   |                55|         174|  31.6091954|
|MISSION                            |DEM   |               549|        1997|  27.4912369|
|MISSION                            |REP   |              1342|        1997|  67.2008012|
|Misty Lakes                        |DEM   |               502|        1421|  35.3272343|
|Misty Lakes                        |REP   |               857|        1421|  60.3096411|
|MITFORD                            |DEM   |               385|         704|  54.6875000|
|MITFORD                            |REP   |               306|         704|  43.4659091|
|Modoc                              |DEM   |                19|         248|   7.6612903|
|Modoc                              |REP   |               225|         248|  90.7258065|
|MONARCH BOX 1                      |DEM   |               202|         840|  24.0476190|
|MONARCH BOX 1                      |REP   |               577|         840|  68.6904762|
|MONARCH BOX 2                      |DEM   |                91|         252|  36.1111111|
|MONARCH BOX 2                      |REP   |               156|         252|  61.9047619|
|MONAVIEW                           |DEM   |               645|        1402|  46.0057061|
|MONAVIEW                           |REP   |               655|        1402|  46.7189729|
|Moncks Corner 1                    |DEM   |               464|        1193|  38.8935457|
|Moncks Corner 1                    |REP   |               685|        1193|  57.4182733|
|Moncks Corner 2                    |DEM   |               533|        1165|  45.7510730|
|Moncks Corner 2                    |REP   |               579|        1165|  49.6995708|
|Moncks Corner 3                    |DEM   |               722|        1478|  48.8497970|
|Moncks Corner 3                    |REP   |               685|        1478|  46.3464141|
|Moncks Corner 4                    |DEM   |               346|        1527|  22.6588081|
|Moncks Corner 4                    |REP   |              1116|        1527|  73.0844794|
|Monetta                            |DEM   |               545|        1074|  50.7448790|
|Monetta                            |REP   |               501|        1074|  46.6480447|
|Monticello                         |DEM   |               900|        1631|  55.1808706|
|Monticello                         |REP   |               688|        1631|  42.1827100|
|MONTICELLO                         |DEM   |               396|         513|  77.1929825|
|MONTICELLO                         |REP   |                97|         513|  18.9083821|
|Montmorenci No. 22                 |DEM   |               428|        1326|  32.2775264|
|Montmorenci No. 22                 |REP   |               834|        1326|  62.8959276|
|Montmorenci No. 78                 |DEM   |               272|         768|  35.4166667|
|Montmorenci No. 78                 |REP   |               456|         768|  59.3750000|
|MOORE CREEK                        |DEM   |              1112|        2699|  41.2004446|
|MOORE CREEK                        |REP   |              1450|        2699|  53.7236013|
|Morgan                             |DEM   |               120|        1063|  11.2888053|
|Morgan                             |REP   |               919|        1063|  86.4534337|
|Morningside Baptist                |DEM   |               411|        1301|  31.5910838|
|Morningside Baptist                |REP   |               841|        1301|  64.6425826|
|MORRIS COLLEGE                     |DEM   |               671|         723|  92.8077455|
|MORRIS COLLEGE                     |REP   |                39|         723|   5.3941909|
|Morrison                           |DEM   |               360|         878|  41.0022779|
|Morrison                           |REP   |               417|         878|  47.4943052|
|MORRISVILLE                        |DEM   |               250|         261|  95.7854406|
|MORRISVILLE                        |REP   |                10|         261|   3.8314176|
|MOSS CREEK                         |DEM   |               463|        1430|  32.3776224|
|MOSS CREEK                         |REP   |               902|        1430|  63.0769231|
|Mossy Oaks 1A                      |DEM   |               224|         717|  31.2412831|
|Mossy Oaks 1A                      |REP   |               459|         717|  64.0167364|
|Mossy Oaks 1B                      |DEM   |               224|         828|  27.0531401|
|Mossy Oaks 1B                      |REP   |               553|         828|  66.7874396|
|Mossy Oaks 2                       |DEM   |               291|         792|  36.7424242|
|Mossy Oaks 2                       |REP   |               444|         792|  56.0606061|
|Motlow Creek Baptist               |DEM   |               120|         950|  12.6315789|
|Motlow Creek Baptist               |REP   |               796|         950|  83.7894737|
|Moultrie                           |DEM   |               914|        1142|  80.0350263|
|Moultrie                           |REP   |               200|        1142|  17.5131349|
|Mount Horeb                        |DEM   |               261|        1469|  17.7671886|
|Mount Horeb                        |REP   |              1113|        1469|  75.7658271|
|MOUNT OLIVE                        |DEM   |               103|         884|  11.6515837|
|MOUNT OLIVE                        |REP   |               760|         884|  85.9728507|
|Mount Tabor                        |DEM   |               493|        1922|  25.6503642|
|Mount Tabor                        |REP   |              1366|        1922|  71.0718002|
|MOUNT VERNON                       |DEM   |               245|         392|  62.5000000|
|MOUNT VERNON                       |REP   |               133|         392|  33.9285714|
|Mountain Creek                     |DEM   |               243|         946|  25.6871036|
|Mountain Creek                     |REP   |               670|         946|  70.8245243|
|MOUNTAIN CREEK                     |DEM   |               317|        1948|  16.2731006|
|MOUNTAIN CREEK                     |REP   |              1519|        1948|  77.9774127|
|Mountain Laurel                    |DEM   |               354|         672|  52.6785714|
|Mountain Laurel                    |REP   |               278|         672|  41.3690476|
|Mountain Rest                      |DEM   |               147|         776|  18.9432990|
|Mountain Rest                      |REP   |               599|         776|  77.1907216|
|Mountain View                      |DEM   |               160|        1059|  15.1085930|
|Mountain View                      |REP   |               860|        1059|  81.2086874|
|MOUNTAIN VIEW                      |DEM   |               239|        2060|  11.6019417|
|MOUNTAIN VIEW                      |REP   |              1753|        2060|  85.0970874|
|Mountain View Baptist              |DEM   |               123|         930|  13.2258065|
|Mountain View Baptist              |REP   |               763|         930|  82.0430108|
|MOUNTVILLE                         |DEM   |               202|         553|  36.5280289|
|MOUNTVILLE                         |REP   |               331|         553|  59.8553345|
|Mt Hebron                          |DEM   |               343|        1049|  32.6978074|
|Mt Hebron                          |REP   |               648|        1049|  61.7731173|
|Mt. Airy                           |DEM   |               315|        2115|  14.8936170|
|Mt. Airy                           |REP   |              1729|        2115|  81.7494090|
|MT. BETHERL GARMANY                |DEM   |               493|         834|  59.1127098|
|MT. BETHERL GARMANY                |REP   |               322|         834|  38.6091127|
|MT. CALVARY                        |DEM   |              1094|        1564|  69.9488491|
|MT. CALVARY                        |REP   |               417|        1564|  26.6624041|
|Mt. Calvary Presbyterian           |DEM   |               216|        2175|   9.9310345|
|Mt. Calvary Presbyterian           |REP   |              1872|        2175|  86.0689655|
|Mt. Carmel                         |DEM   |               207|         239|  86.6108787|
|Mt. Carmel                         |REP   |                30|         239|  12.5523013|
|MT. CLIO                           |DEM   |               208|         240|  86.6666667|
|MT. CLIO                           |REP   |                28|         240|  11.6666667|
|Mt. Gallant                        |DEM   |               317|        1275|  24.8627451|
|Mt. Gallant                        |REP   |               903|        1275|  70.8235294|
|MT. GROGHAN                        |DEM   |                83|         293|  28.3276451|
|MT. GROGHAN                        |REP   |               202|         293|  68.9419795|
|Mt. Holly                          |DEM   |               942|        2061|  45.7059680|
|Mt. Holly                          |REP   |              1030|        2061|  49.9757399|
|Mt. Moriah Baptist                 |DEM   |               783|         923|  84.8320693|
|Mt. Moriah Baptist                 |REP   |               108|         923|  11.7009751|
|MT. OLIVE                          |DEM   |               227|         822|  27.6155718|
|MT. OLIVE                          |REP   |               573|         822|  69.7080292|
|MT. PLEASANT                       |DEM   |              1073|        1348|  79.5994065|
|MT. PLEASANT                       |REP   |               225|        1348|  16.6913947|
|MT. PLEASANT 1                     |DEM   |               422|         976|  43.2377049|
|MT. PLEASANT 1                     |REP   |               490|         976|  50.2049180|
|MT. PLEASANT 10                    |DEM   |               174|         604|  28.8079470|
|MT. PLEASANT 10                    |REP   |               382|         604|  63.2450331|
|MT. PLEASANT 11                    |DEM   |               268|         713|  37.5876578|
|MT. PLEASANT 11                    |REP   |               386|         713|  54.1374474|
|MT. PLEASANT 12                    |DEM   |               484|        1284|  37.6947040|
|MT. PLEASANT 12                    |REP   |               703|        1284|  54.7507788|
|MT. PLEASANT 13                    |DEM   |               281|         742|  37.8706199|
|MT. PLEASANT 13                    |REP   |               390|         742|  52.5606469|
|MT. PLEASANT 14                    |DEM   |               386|         944|  40.8898305|
|MT. PLEASANT 14                    |REP   |               473|         944|  50.1059322|
|MT. PLEASANT 15                    |DEM   |               595|        1390|  42.8057554|
|MT. PLEASANT 15                    |REP   |               706|        1390|  50.7913669|
|MT. PLEASANT 16                    |DEM   |               132|         444|  29.7297297|
|MT. PLEASANT 16                    |REP   |               275|         444|  61.9369369|
|MT. PLEASANT 17                    |DEM   |               480|        1538|  31.2093628|
|MT. PLEASANT 17                    |REP   |               935|        1538|  60.7932380|
|MT. PLEASANT 18                    |DEM   |               234|         814|  28.7469287|
|MT. PLEASANT 18                    |REP   |               508|         814|  62.4078624|
|MT. PLEASANT 19                    |DEM   |               476|        1176|  40.4761905|
|MT. PLEASANT 19                    |REP   |               593|        1176|  50.4251701|
|MT. PLEASANT 2                     |DEM   |               228|         601|  37.9367720|
|MT. PLEASANT 2                     |REP   |               304|         601|  50.5823627|
|MT. PLEASANT 20                    |DEM   |               446|         990|  45.0505051|
|MT. PLEASANT 20                    |REP   |               476|         990|  48.0808081|
|MT. PLEASANT 21                    |DEM   |               292|         794|  36.7758186|
|MT. PLEASANT 21                    |REP   |               437|         794|  55.0377834|
|MT. PLEASANT 22                    |DEM   |               331|         738|  44.8509485|
|MT. PLEASANT 22                    |REP   |               357|         738|  48.3739837|
|MT. PLEASANT 23                    |DEM   |               539|        1114|  48.3842011|
|MT. PLEASANT 23                    |REP   |               475|        1114|  42.6391382|
|MT. PLEASANT 24                    |DEM   |               177|         483|  36.6459627|
|MT. PLEASANT 24                    |REP   |               262|         483|  54.2443064|
|MT. PLEASANT 25                    |DEM   |               144|         497|  28.9738431|
|MT. PLEASANT 25                    |REP   |               318|         497|  63.9839034|
|MT. PLEASANT 26                    |DEM   |               382|         401|  95.2618454|
|MT. PLEASANT 26                    |REP   |                13|         401|   3.2418953|
|MT. PLEASANT 27                    |DEM   |               531|        1637|  32.4373855|
|MT. PLEASANT 27                    |REP   |               975|        1637|  59.5601710|
|MT. PLEASANT 28                    |DEM   |               241|         795|  30.3144654|
|MT. PLEASANT 28                    |REP   |               469|         795|  58.9937107|
|MT. PLEASANT 29                    |DEM   |                69|         194|  35.5670103|
|MT. PLEASANT 29                    |REP   |               115|         194|  59.2783505|
|MT. PLEASANT 3                     |DEM   |               423|         975|  43.3846154|
|MT. PLEASANT 3                     |REP   |               469|         975|  48.1025641|
|MT. PLEASANT 30                    |DEM   |               534|        1597|  33.4376957|
|MT. PLEASANT 30                    |REP   |               957|        1597|  59.9248591|
|MT. PLEASANT 31                    |DEM   |               324|         804|  40.2985075|
|MT. PLEASANT 31                    |REP   |               445|         804|  55.3482587|
|MT. PLEASANT 32                    |DEM   |               469|        1588|  29.5340050|
|MT. PLEASANT 32                    |REP   |              1026|        1588|  64.6095718|
|MT. PLEASANT 33                    |DEM   |               616|        2335|  26.3811563|
|MT. PLEASANT 33                    |REP   |              1573|        2335|  67.3661670|
|MT. PLEASANT 34                    |DEM   |               306|         895|  34.1899441|
|MT. PLEASANT 34                    |REP   |               535|         895|  59.7765363|
|MT. PLEASANT 35                    |DEM   |               823|        2678|  30.7318895|
|MT. PLEASANT 35                    |REP   |              1660|        2678|  61.9865571|
|MT. PLEASANT 36                    |DEM   |               487|        1213|  40.1483924|
|MT. PLEASANT 36                    |REP   |               615|        1213|  50.7007420|
|MT. PLEASANT 37                    |DEM   |              1073|        2206|  48.6400725|
|MT. PLEASANT 37                    |REP   |              1001|        2206|  45.3762466|
|MT. PLEASANT 38                    |DEM   |               233|         907|  25.6890849|
|MT. PLEASANT 38                    |REP   |               609|         907|  67.1444322|
|MT. PLEASANT 39                    |DEM   |               460|        1539|  29.8895387|
|MT. PLEASANT 39                    |REP   |              1001|        1539|  65.0422352|
|MT. PLEASANT 4                     |DEM   |               397|        1006|  39.4632207|
|MT. PLEASANT 4                     |REP   |               530|        1006|  52.6838966|
|MT. PLEASANT 5                     |DEM   |               286|         845|  33.8461538|
|MT. PLEASANT 5                     |REP   |               493|         845|  58.3431953|
|MT. PLEASANT 6                     |DEM   |               459|        1269|  36.1702128|
|MT. PLEASANT 6                     |REP   |               698|        1269|  55.0039401|
|MT. PLEASANT 7                     |DEM   |               225|         580|  38.7931034|
|MT. PLEASANT 7                     |REP   |               310|         580|  53.4482759|
|MT. PLEASANT 8                     |DEM   |               222|         551|  40.2903811|
|MT. PLEASANT 8                     |REP   |               293|         551|  53.1760436|
|MT. PLEASANT 9                     |DEM   |               204|         647|  31.5301391|
|MT. PLEASANT 9                     |REP   |               393|         647|  60.7418856|
|MT. VERNON                         |DEM   |                73|         581|  12.5645439|
|MT. VERNON                         |REP   |               494|         581|  85.0258176|
|MT. WILLING                        |DEM   |                49|         202|  24.2574257|
|MT. WILLING                        |REP   |               150|         202|  74.2574257|
|Mt. Zion Gospel Baptist            |DEM   |               347|         594|  58.4175084|
|Mt. Zion Gospel Baptist            |REP   |               230|         594|  38.7205387|
|MUDDY CREEK                        |DEM   |               257|         778|  33.0334190|
|MUDDY CREEK                        |REP   |               496|         778|  63.7532134|
|MULBERRY                           |DEM   |               482|         668|  72.1556886|
|MULBERRY                           |REP   |               167|         668|  25.0000000|
|MURPH MILL                         |DEM   |               198|         359|  55.1532033|
|MURPH MILL                         |REP   |               155|         359|  43.1754875|
|Murraywood                         |DEM   |               509|        1490|  34.1610738|
|Murraywood                         |REP   |               893|        1490|  59.9328859|
|MURRELL'S INLET NO. 1              |DEM   |               633|        2616|  24.1972477|
|MURRELL'S INLET NO. 1              |REP   |              1898|        2616|  72.5535168|
|MURRELL'S INLET NO. 2              |DEM   |               445|        1620|  27.4691358|
|MURRELL'S INLET NO. 2              |REP   |              1125|        1620|  69.4444444|
|MURRELL'S INLET NO. 3              |DEM   |               172|         641|  26.8330733|
|MURRELL'S INLET NO. 3              |REP   |               456|         641|  71.1388456|
|MURRELL'S INLET NO. 4              |DEM   |               193|        1220|  15.8196721|
|MURRELL'S INLET NO. 4              |REP   |               985|        1220|  80.7377049|
|Musgrove Mill                      |DEM   |               282|         993|  28.3987915|
|Musgrove Mill                      |REP   |               683|         993|  68.7814703|
|MYERSVILLE                         |DEM   |               465|         508|  91.5354331|
|MYERSVILLE                         |REP   |                38|         508|   7.4803150|
|MYRTLE TRACE                       |DEM   |               329|        1209|  27.2125724|
|MYRTLE TRACE                       |REP   |               817|        1209|  67.5765095|
|MYRTLEWOOD #1                      |DEM   |               348|        1029|  33.8192420|
|MYRTLEWOOD #1                      |REP   |               627|        1029|  60.9329446|
|MYRTLEWOOD #2                      |DEM   |               435|        1461|  29.7741273|
|MYRTLEWOOD #2                      |REP   |               987|        1461|  67.5564682|
|MYRTLEWOOD #3                      |DEM   |               388|        1542|  25.1621271|
|MYRTLEWOOD #3                      |REP   |              1095|        1542|  71.0116732|
|N BENNETTSVILLE                    |DEM   |               547|        1037|  52.7483124|
|N BENNETTSVILLE                    |REP   |               463|        1037|  44.6480231|
|N EAST MULLINS                     |DEM   |               949|        1408|  67.4005682|
|N EAST MULLINS                     |REP   |               415|        1408|  29.4744318|
|N WEST MULLINS                     |DEM   |               971|        1262|  76.9413629|
|N WEST MULLINS                     |REP   |               266|        1262|  21.0776545|
|N. Augusta No. 25                  |DEM   |               417|        1075|  38.7906977|
|N. Augusta No. 25                  |REP   |               597|        1075|  55.5348837|
|N. Augusta No. 26                  |DEM   |               391|         888|  44.0315315|
|N. Augusta No. 26                  |REP   |               456|         888|  51.3513514|
|N. Augusta No. 27                  |DEM   |               185|        1325|  13.9622642|
|N. Augusta No. 27                  |REP   |              1079|        1325|  81.4339623|
|N. Augusta No. 28                  |DEM   |               198|         999|  19.8198198|
|N. Augusta No. 28                  |REP   |               752|         999|  75.2752753|
|N. Augusta No. 29                  |DEM   |               278|         986|  28.1947262|
|N. Augusta No. 29                  |REP   |               647|         986|  65.6186613|
|N. Augusta No. 54                  |DEM   |               535|         986|  54.2596349|
|N. Augusta No. 54                  |REP   |               405|         986|  41.0750507|
|N. Augusta No. 55                  |DEM   |               199|         888|  22.4099099|
|N. Augusta No. 55                  |REP   |               627|         888|  70.6081081|
|N. Augusta No. 67                  |DEM   |               198|        1033|  19.1674734|
|N. Augusta No. 67                  |REP   |               773|        1033|  74.8305905|
|N. Augusta No. 68                  |DEM   |               349|        1759|  19.8408186|
|N. Augusta No. 68                  |REP   |              1319|        1759|  74.9857874|
|N. Augusta No. 80                  |DEM   |               152|         680|  22.3529412|
|N. Augusta No. 80                  |REP   |               491|         680|  72.2058824|
|Nation Ford                        |DEM   |               690|        1995|  34.5864662|
|Nation Ford                        |REP   |              1193|        1995|  59.7994987|
|Neal's Creek                       |DEM   |               499|        1442|  34.6047157|
|Neal's Creek                       |REP   |               885|        1442|  61.3730929|
|NEELY FARMS                        |DEM   |               961|        3152|  30.4885787|
|NEELY FARMS                        |REP   |              2025|        3152|  64.2449239|
|Neelys Creek                       |DEM   |               200|         783|  25.5427842|
|Neelys Creek                       |REP   |               546|         783|  69.7318008|
|NEESES-LIVINGSTON                  |DEM   |               349|         871|  40.0688863|
|NEESES-LIVINGSTON                  |REP   |               502|         871|  57.6349024|
|NESMITH                            |DEM   |               507|         586|  86.5187713|
|NESMITH                            |REP   |                59|         586|  10.0682594|
|New Castle                         |DEM   |               152|         709|  21.4386460|
|New Castle                         |REP   |               524|         709|  73.9069111|
|New Ellenton                       |DEM   |               697|        1447|  48.1686247|
|New Ellenton                       |REP   |               701|        1447|  48.4450587|
|New Holland                        |DEM   |               136|         668|  20.3592814|
|New Holland                        |REP   |               500|         668|  74.8502994|
|NEW HOLLY                          |DEM   |               126|         314|  40.1273885|
|NEW HOLLY                          |REP   |               184|         314|  58.5987261|
|New Home                           |DEM   |               451|        1732|  26.0392610|
|New Home                           |REP   |              1203|        1732|  69.4572748|
|New Hope                           |DEM   |               213|        1431|  14.8846960|
|New Hope                           |REP   |              1151|        1431|  80.4332635|
|NEW HOPE                           |DEM   |                22|          57|  38.5964912|
|NEW HOPE                           |REP   |                34|          57|  59.6491228|
|New Market                         |DEM   |               312|         742|  42.0485175|
|New Market                         |REP   |               408|         742|  54.9865229|
|NEW MARKET                         |DEM   |               112|         905|  12.3756906|
|NEW MARKET                         |REP   |               762|         905|  84.1988950|
|New Zion                           |DEM   |               163|         425|  38.3529412|
|New Zion                           |REP   |               255|         425|  60.0000000|
|NEWBERRY WD 1                      |DEM   |               172|         282|  60.9929078|
|NEWBERRY WD 1                      |REP   |               102|         282|  36.1702128|
|NEWBERRY WD 2                      |DEM   |               211|         621|  33.9774557|
|NEWBERRY WD 2                      |REP   |               362|         621|  58.2930757|
|NEWBERRY WD 3                      |DEM   |               348|         599|  58.0968280|
|NEWBERRY WD 3                      |REP   |               224|         599|  37.3956594|
|NEWBERRY WD 4                      |DEM   |               354|         402|  88.0597015|
|NEWBERRY WD 4                      |REP   |                43|         402|  10.6965174|
|NEWBERRY WD 5                      |DEM   |               481|         547|  87.9341865|
|NEWBERRY WD 5                      |REP   |                43|         547|   7.8610603|
|NEWBERRY WD 6                      |DEM   |               367|         685|  53.5766423|
|NEWBERRY WD 6                      |REP   |               288|         685|  42.0437956|
|Newington                          |DEM   |               226|         877|  25.7696693|
|Newington                          |REP   |               593|         877|  67.6168757|
|Newington 2                        |DEM   |               103|         509|  20.2357564|
|Newington 2                        |REP   |               372|         509|  73.0844794|
|Newport                            |DEM   |               393|        1314|  29.9086758|
|Newport                            |REP   |               842|        1314|  64.0791476|
|Newry-Corinth                      |DEM   |                61|         221|  27.6018100|
|Newry-Corinth                      |REP   |               152|         221|  68.7782805|
|NICHOLS                            |DEM   |               261|         602|  43.3554817|
|NICHOLS                            |REP   |               314|         602|  52.1594684|
|Nine Forks                         |DEM   |               105|        1158|   9.0673575|
|Nine Forks                         |REP   |              1016|        1158|  87.7374784|
|Ninety Nine and Cherokee Falls     |DEM   |                65|         721|   9.0152566|
|Ninety Nine and Cherokee Falls     |REP   |               636|         721|  88.2108183|
|Ninety Six                         |DEM   |               278|         651|  42.7035330|
|Ninety Six                         |REP   |               345|         651|  52.9953917|
|Ninety Six Mill                    |DEM   |                79|         593|  13.3220911|
|Ninety Six Mill                    |REP   |               487|         593|  82.1247892|
|NIX                                |DEM   |              1066|        1089|  97.8879706|
|NIX                                |REP   |                 9|        1089|   0.8264463|
|NIXONS XROADS #1                   |DEM   |               394|        1484|  26.5498652|
|NIXONS XROADS #1                   |REP   |              1046|        1484|  70.4851752|
|NIXONS XROADS #2                   |DEM   |               886|        2296|  38.5888502|
|NIXONS XROADS #2                   |REP   |              1336|        2296|  58.1881533|
|NIXONS XROADS #3                   |DEM   |               454|        1467|  30.9475119|
|NIXONS XROADS #3                   |REP   |               967|        1467|  65.9168371|
|Norris                             |DEM   |               151|        1047|  14.4221585|
|Norris                             |REP   |               869|        1047|  82.9990449|
|NORTH 1                            |DEM   |               618|        1059|  58.3569405|
|NORTH 1                            |REP   |               424|        1059|  40.0377715|
|NORTH 2                            |DEM   |               531|        1090|  48.7155963|
|NORTH 2                            |REP   |               536|        1090|  49.1743119|
|NORTH BAMBERG                      |DEM   |               677|        1337|  50.6357517|
|NORTH BAMBERG                      |REP   |               622|        1337|  46.5220643|
|North Central                      |DEM   |               221|         912|  24.2324561|
|North Central                      |REP   |               630|         912|  69.0789474|
|NORTH CHARLESTON 1                 |DEM   |               606|         645|  93.9534884|
|NORTH CHARLESTON 1                 |REP   |                20|         645|   3.1007752|
|NORTH CHARLESTON 10                |DEM   |               771|         982|  78.5132383|
|NORTH CHARLESTON 10                |REP   |               159|         982|  16.1914460|
|NORTH CHARLESTON 11                |DEM   |               264|         627|  42.1052632|
|NORTH CHARLESTON 11                |REP   |               300|         627|  47.8468900|
|NORTH CHARLESTON 12                |DEM   |               262|         549|  47.7231330|
|NORTH CHARLESTON 12                |REP   |               210|         549|  38.2513661|
|NORTH CHARLESTON 13                |DEM   |               622|         704|  88.3522727|
|NORTH CHARLESTON 13                |REP   |                60|         704|   8.5227273|
|NORTH CHARLESTON 14                |DEM   |               287|         443|  64.7855530|
|NORTH CHARLESTON 14                |REP   |               119|         443|  26.8623025|
|NORTH CHARLESTON 15                |DEM   |               681|         829|  82.1471653|
|NORTH CHARLESTON 15                |REP   |               104|         829|  12.5452352|
|NORTH CHARLESTON 16                |DEM   |               497|         616|  80.6818182|
|NORTH CHARLESTON 16                |REP   |                98|         616|  15.9090909|
|NORTH CHARLESTON 17                |DEM   |               445|         500|  89.0000000|
|NORTH CHARLESTON 17                |REP   |                38|         500|   7.6000000|
|NORTH CHARLESTON 18                |DEM   |               868|        1102|  78.7658802|
|NORTH CHARLESTON 18                |REP   |               182|        1102|  16.5154265|
|NORTH CHARLESTON 19                |DEM   |               547|         667|  82.0089955|
|NORTH CHARLESTON 19                |REP   |                97|         667|  14.5427286|
|NORTH CHARLESTON 2                 |DEM   |               269|         288|  93.4027778|
|NORTH CHARLESTON 2                 |REP   |                13|         288|   4.5138889|
|NORTH CHARLESTON 20                |DEM   |               235|         471|  49.8938429|
|NORTH CHARLESTON 20                |REP   |               215|         471|  45.6475584|
|NORTH CHARLESTON 21                |DEM   |               557|         805|  69.1925466|
|NORTH CHARLESTON 21                |REP   |               204|         805|  25.3416149|
|NORTH CHARLESTON 22                |DEM   |               698|         963|  72.4818276|
|NORTH CHARLESTON 22                |REP   |               223|         963|  23.1568017|
|NORTH CHARLESTON 23                |DEM   |               667|        1145|  58.2532751|
|NORTH CHARLESTON 23                |REP   |               417|        1145|  36.4192140|
|NORTH CHARLESTON 24                |DEM   |              1052|        1500|  70.1333333|
|NORTH CHARLESTON 24                |REP   |               366|        1500|  24.4000000|
|NORTH CHARLESTON 25                |DEM   |               427|         503|  84.8906561|
|NORTH CHARLESTON 25                |REP   |                53|         503|  10.5367793|
|NORTH CHARLESTON 26                |DEM   |               331|         382|  86.6492147|
|NORTH CHARLESTON 26                |REP   |                44|         382|  11.5183246|
|NORTH CHARLESTON 27                |DEM   |               519|         705|  73.6170213|
|NORTH CHARLESTON 27                |REP   |               157|         705|  22.2695035|
|NORTH CHARLESTON 28                |DEM   |               365|         458|  79.6943231|
|NORTH CHARLESTON 28                |REP   |                70|         458|  15.2838428|
|NORTH CHARLESTON 29                |DEM   |               379|         565|  67.0796460|
|NORTH CHARLESTON 29                |REP   |               162|         565|  28.6725664|
|NORTH CHARLESTON 3                 |DEM   |               329|         859|  38.3003492|
|NORTH CHARLESTON 3                 |REP   |               477|         859|  55.5296857|
|NORTH CHARLESTON 30                |DEM   |               951|        1320|  72.0454545|
|NORTH CHARLESTON 30                |REP   |               300|        1320|  22.7272727|
|NORTH CHARLESTON 4                 |DEM   |               649|         751|  86.4181092|
|NORTH CHARLESTON 4                 |REP   |                81|         751|  10.7856192|
|NORTH CHARLESTON 5                 |DEM   |              1133|        1224|  92.5653595|
|NORTH CHARLESTON 5                 |REP   |                55|        1224|   4.4934641|
|NORTH CHARLESTON 6                 |DEM   |               908|         981|  92.5586137|
|NORTH CHARLESTON 6                 |REP   |                34|         981|   3.4658512|
|NORTH CHARLESTON 7                 |DEM   |               923|        1011|  91.2957468|
|NORTH CHARLESTON 7                 |REP   |                63|        1011|   6.2314540|
|NORTH CHARLESTON 8                 |DEM   |               273|         520|  52.5000000|
|NORTH CHARLESTON 8                 |REP   |               198|         520|  38.0769231|
|NORTH CHARLESTON 9                 |DEM   |               590|         975|  60.5128205|
|NORTH CHARLESTON 9                 |REP   |               303|         975|  31.0769231|
|NORTH CONWAY #1                    |DEM   |               514|        1136|  45.2464789|
|NORTH CONWAY #1                    |REP   |               572|        1136|  50.3521127|
|NORTH CONWAY #2                    |DEM   |               266|         919|  28.9445049|
|NORTH CONWAY #2                    |REP   |               610|         919|  66.3764962|
|North Forest Acres                 |DEM   |               477|         921|  51.7915309|
|North Forest Acres                 |REP   |               376|         921|  40.8251900|
|North Liberty                      |DEM   |               150|         925|  16.2162162|
|North Liberty                      |REP   |               729|         925|  78.8108108|
|North Pickens                      |DEM   |                82|        1010|   8.1188119|
|North Pickens                      |REP   |               882|        1010|  87.3267327|
|North Pointe                       |DEM   |               241|        1205|  20.0000000|
|North Pointe                       |REP   |               906|        1205|  75.1867220|
|North Side                         |DEM   |               235|         401|  58.6034913|
|North Side                         |REP   |               159|         401|  39.6508728|
|North Springs 1                    |DEM   |               482|         816|  59.0686275|
|North Springs 1                    |REP   |               294|         816|  36.0294118|
|North Springs 2                    |DEM   |               965|        1693|  56.9994093|
|North Springs 2                    |REP   |               620|        1693|  36.6213822|
|North Springs 3                    |DEM   |              1156|        1495|  77.3244147|
|North Springs 3                    |REP   |               271|        1495|  18.1270903|
|North Summerville                  |DEM   |               108|         292|  36.9863014|
|North Summerville                  |REP   |               171|         292|  58.5616438|
|North Summerville 2                |DEM   |               599|         830|  72.1686747|
|North Summerville 2                |REP   |               192|         830|  23.1325301|
|Northside                          |DEM   |               469|         913|  51.3691128|
|Northside                          |REP   |               354|         913|  38.7732749|
|Northwestern                       |DEM   |               379|        1522|  24.9014455|
|Northwestern                       |REP   |              1059|        1522|  69.5795007|
|NORTHWOOD                          |DEM   |               451|        1720|  26.2209302|
|NORTHWOOD                          |REP   |              1139|        1720|  66.2209302|
|NORWAY                             |DEM   |               803|        1203|  66.7497922|
|NORWAY                             |REP   |               371|        1203|  30.8395677|
|O'NEAL                             |DEM   |               194|        1054|  18.4060721|
|O'NEAL                             |REP   |               818|        1054|  77.6091082|
|Oak Grove                          |DEM   |               178|         873|  20.3894616|
|Oak Grove                          |REP   |               653|         873|  74.7995418|
|OAK GROVE                          |DEM   |               230|         690|  33.3333333|
|OAK GROVE                          |REP   |               439|         690|  63.6231884|
|OAK GROVE-SARDIS                   |DEM   |               159|         883|  18.0067950|
|OAK GROVE-SARDIS                   |REP   |               700|         883|  79.2751982|
|Oak Pointe 1                       |DEM   |               425|        1006|  42.2465209|
|Oak Pointe 1                       |REP   |               516|        1006|  51.2922465|
|Oak Pointe 2                       |DEM   |               220|         588|  37.4149660|
|Oak Pointe 2                       |REP   |               328|         588|  55.7823129|
|Oak Pointe 3                       |DEM   |               411|         831|  49.4584838|
|Oak Pointe 3                       |REP   |               351|         831|  42.2382671|
|Oakatie                            |DEM   |               411|         913|  45.0164294|
|Oakatie                            |REP   |               443|         913|  48.5213582|
|Oakbrook                           |DEM   |               749|        1776|  42.1734234|
|Oakbrook                           |REP   |               895|        1776|  50.3941441|
|Oakbrook 2                         |DEM   |               374|         995|  37.5879397|
|Oakbrook 2                         |REP   |               553|         995|  55.5778894|
|Oakdale                            |DEM   |               162|         286|  56.6433566|
|Oakdale                            |REP   |               119|         286|  41.6083916|
|OAKLAND                            |DEM   |               930|        1297|  71.7039322|
|OAKLAND                            |REP   |               319|        1297|  24.5952197|
|Oakland Elementary                 |DEM   |               241|        1539|  15.6595192|
|Oakland Elementary                 |REP   |              1216|        1539|  79.0123457|
|OAKLAND PLANTATION 1               |DEM   |               357|         835|  42.7544910|
|OAKLAND PLANTATION 1               |REP   |               442|         835|  52.9341317|
|OAKLAND PLANTATION 2               |DEM   |               266|         691|  38.4949349|
|OAKLAND PLANTATION 2               |REP   |               398|         691|  57.5976845|
|Oakridge                           |DEM   |               519|        1895|  27.3878628|
|Oakridge                           |REP   |              1313|        1895|  69.2875989|
|OAKVIEW                            |DEM   |               620|        2488|  24.9196141|
|OAKVIEW                            |REP   |              1725|        2488|  69.3327974|
|Oakway                             |DEM   |               158|        1105|  14.2986425|
|Oakway                             |REP   |               901|        1105|  81.5384615|
|Oakwood                            |DEM   |              1231|        3859|  31.8994558|
|Oakwood                            |REP   |              2367|        3859|  61.3371340|
|OATES                              |DEM   |               364|         936|  38.8888889|
|OATES                              |REP   |               548|         936|  58.5470085|
|OCEAN DRIVE #1                     |DEM   |               412|        1732|  23.7875289|
|OCEAN DRIVE #1                     |REP   |              1254|        1732|  72.4018476|
|OCEAN DRIVE #2                     |DEM   |               515|        2628|  19.5966514|
|OCEAN DRIVE #2                     |REP   |              2061|        2628|  78.4246575|
|OCEAN FOREST #1                    |DEM   |               337|        1279|  26.3487099|
|OCEAN FOREST #1                    |REP   |               894|        1279|  69.8983581|
|OCEAN FOREST #2                    |DEM   |               393|        1374|  28.6026201|
|OCEAN FOREST #2                    |REP   |               922|        1374|  67.1033479|
|OCEAN FOREST #3                    |DEM   |               373|         893|  41.7693169|
|OCEAN FOREST #3                    |REP   |               463|         893|  51.8477044|
|Ogden                              |DEM   |               811|        1708|  47.4824356|
|Ogden                              |REP   |               828|        1708|  48.4777518|
|OLANTA                             |DEM   |               578|        1231|  46.9536962|
|OLANTA                             |REP   |               617|        1231|  50.1218522|
|OLAR                               |DEM   |               157|         339|  46.3126844|
|OLAR                               |REP   |               177|         339|  52.2123894|
|Old 52                             |DEM   |               217|         587|  36.9676320|
|Old 52                             |REP   |               339|         587|  57.7512777|
|Old Barnwell Rd                    |DEM   |               407|        1171|  34.7566183|
|Old Barnwell Rd                    |REP   |               686|        1171|  58.5824082|
|Old Friarsgate                     |DEM   |               518|         986|  52.5354970|
|Old Friarsgate                     |REP   |               415|         986|  42.0892495|
|Old Lexington                      |DEM   |               392|        2280|  17.1929825|
|Old Lexington                      |REP   |              1734|        2280|  76.0526316|
|Old Pointe                         |DEM   |               522|        1228|  42.5081433|
|Old Pointe                         |REP   |               624|        1228|  50.8143322|
|Olympia                            |DEM   |               887|        1352|  65.6065089|
|Olympia                            |REP   |               355|        1352|  26.2573964|
|ONEAL                              |DEM   |               372|        2498|  14.8919135|
|ONEAL                              |REP   |              2026|        2498|  81.1048839|
|ORA-LANFORD                        |DEM   |               253|         753|  33.5989376|
|ORA-LANFORD                        |REP   |               467|         753|  62.0185923|
|ORANGEBURG WD 1                    |DEM   |               329|         541|  60.8133087|
|ORANGEBURG WD 1                    |REP   |               198|         541|  36.5988909|
|ORANGEBURG WD 10                   |DEM   |               337|         546|  61.7216117|
|ORANGEBURG WD 10                   |REP   |               195|         546|  35.7142857|
|ORANGEBURG WD 2                    |DEM   |               414|         439|  94.3052392|
|ORANGEBURG WD 2                    |REP   |                23|         439|   5.2391800|
|ORANGEBURG WD 3                    |DEM   |               761|         794|  95.8438287|
|ORANGEBURG WD 3                    |REP   |                27|         794|   3.4005038|
|ORANGEBURG WD 4                    |DEM   |              1165|        1206|  96.6003317|
|ORANGEBURG WD 4                    |REP   |                13|        1206|   1.0779436|
|ORANGEBURG WD 5                    |DEM   |               355|         386|  91.9689119|
|ORANGEBURG WD 5                    |REP   |                26|         386|   6.7357513|
|ORANGEBURG WD 6                    |DEM   |               442|         559|  79.0697674|
|ORANGEBURG WD 6                    |REP   |               103|         559|  18.4257603|
|ORANGEBURG WD 8                    |DEM   |               242|         445|  54.3820225|
|ORANGEBURG WD 8                    |REP   |               193|         445|  43.3707865|
|ORANGEBURG WD 9                    |DEM   |               321|         432|  74.3055556|
|ORANGEBURG WD 9                    |REP   |                99|         432|  22.9166667|
|Orchard Park                       |DEM   |               490|        1565|  31.3099042|
|Orchard Park                       |REP   |               952|        1565|  60.8306709|
|ORNAGEBURG WD 7                    |DEM   |               299|         517|  57.8336557|
|ORNAGEBURG WD 7                    |REP   |               208|         517|  40.2321083|
|Osceola                            |DEM   |               731|        2189|  33.3942439|
|Osceola                            |REP   |              1356|        2189|  61.9460941|
|OSWEGO                             |DEM   |               323|         843|  38.3155397|
|OSWEGO                             |REP   |               498|         843|  59.0747331|
|OUSLEYDALE                         |DEM   |                83|         618|  13.4304207|
|OUSLEYDALE                         |REP   |               506|         618|  81.8770227|
|OWINGS                             |DEM   |               212|         691|  30.6801737|
|OWINGS                             |REP   |               448|         691|  64.8335745|
|Pacolet Elementary                 |DEM   |               533|        1863|  28.6097692|
|Pacolet Elementary                 |REP   |              1278|        1863|  68.5990338|
|PAGELAND NO. 1                     |DEM   |               709|        1461|  48.5284052|
|PAGELAND NO. 1                     |REP   |               719|        1461|  49.2128679|
|PAGELAND NO. 2                     |DEM   |               595|        1353|  43.9763489|
|PAGELAND NO. 2                     |REP   |               711|        1353|  52.5498891|
|Palmetto                           |DEM   |               646|        1881|  34.3434343|
|Palmetto                           |REP   |              1106|        1881|  58.7985114|
|PALMETTO                           |DEM   |              1299|        3072|  42.2851562|
|PALMETTO                           |REP   |              1601|        3072|  52.1158854|
|PALMETTO BAYS                      |DEM   |               673|        2700|  24.9259259|
|PALMETTO BAYS                      |REP   |              1923|        2700|  71.2222222|
|PALMETTO PARK                      |DEM   |               381|         727|  52.4071527|
|PALMETTO PARK                      |REP   |               314|         727|  43.1911967|
|PAMPLICO NO. 1                     |DEM   |               272|         910|  29.8901099|
|PAMPLICO NO. 1                     |REP   |               616|         910|  67.6923077|
|PAMPLICO NO. 2                     |DEM   |               473|         632|  74.8417722|
|PAMPLICO NO. 2                     |REP   |               141|         632|  22.3101266|
|Panola                             |DEM   |               165|         216|  76.3888889|
|Panola                             |REP   |                48|         216|  22.2222222|
|PARIS MOUNTAIN                     |DEM   |               284|        1191|  23.8455080|
|PARIS MOUNTAIN                     |REP   |               826|        1191|  69.3534845|
|Park Hills Elementary              |DEM   |              1090|        1308|  83.3333333|
|Park Hills Elementary              |REP   |               178|        1308|  13.6085627|
|Park Road #1                       |DEM   |               329|        1290|  25.5038760|
|Park Road #1                       |REP   |               861|        1290|  66.7441860|
|Park Road #2                       |DEM   |               180|         718|  25.0696379|
|Park Road #2                       |REP   |               496|         718|  69.0807799|
|Parkridge 1                        |DEM   |               315|         610|  51.6393443|
|Parkridge 1                        |REP   |               251|         610|  41.1475410|
|Parkridge 2                        |DEM   |               394|         658|  59.8784195|
|Parkridge 2                        |REP   |               222|         658|  33.7386018|
|Parksville                         |DEM   |                20|         163|  12.2699387|
|Parksville                         |REP   |               137|         163|  84.0490798|
|Parkway 1                          |DEM   |              1329|        1689|  78.6856128|
|Parkway 1                          |REP   |               283|        1689|  16.7554766|
|Parkway 2                          |DEM   |              1060|        1515|  69.9669967|
|Parkway 2                          |REP   |               374|        1515|  24.6864686|
|Parkway 3                          |DEM   |              1086|        1252|  86.7412141|
|Parkway 3                          |REP   |               125|        1252|   9.9840256|
|Parson's Mill                      |DEM   |               203|         582|  34.8797251|
|Parson's Mill                      |REP   |               341|         582|  58.5910653|
|PATRICK                            |DEM   |               219|         558|  39.2473118|
|PATRICK                            |REP   |               308|         558|  55.1971326|
|Patriot                            |DEM   |               780|        1103|  70.7162285|
|Patriot                            |REP   |               269|        1103|  24.3880326|
|Pauline Glenn Springs Elementary   |DEM   |               131|         919|  14.2546246|
|Pauline Glenn Springs Elementary   |REP   |               765|         919|  83.2426551|
|PAWLEY'S ISLAND NO. 1              |DEM   |               513|        1959|  26.1868300|
|PAWLEY'S ISLAND NO. 1              |REP   |              1368|        1959|  69.8315467|
|PAWLEY'S ISLAND NO. 2              |DEM   |               827|        2040|  40.5392157|
|PAWLEY'S ISLAND NO. 2              |REP   |              1124|        2040|  55.0980392|
|PAWLEY'S ISLAND NO. 3              |DEM   |               392|        1559|  25.1443233|
|PAWLEY'S ISLAND NO. 3              |REP   |              1105|        1559|  70.8787684|
|PAWLEY'S ISLAND NO. 4              |DEM   |               304|        1494|  20.3480589|
|PAWLEY'S ISLAND NO. 4              |REP   |              1106|        1494|  74.0294511|
|PAWLEY'S ISLAND NO. 5              |DEM   |               405|        1720|  23.5465116|
|PAWLEY'S ISLAND NO. 5              |REP   |              1247|        1720|  72.5000000|
|PAWLEYS SWAMP                      |DEM   |                74|         551|  13.4301270|
|PAWLEYS SWAMP                      |REP   |               451|         551|  81.8511797|
|Paxville                           |DEM   |               440|         756|  58.2010582|
|Paxville                           |REP   |               274|         756|  36.2433862|
|PEAK                               |DEM   |                27|         108|  25.0000000|
|PEAK                               |REP   |                78|         108|  72.2222222|
|PEBBLE CREEK                       |DEM   |               451|        1916|  23.5386221|
|PEBBLE CREEK                       |REP   |              1364|        1916|  71.1899791|
|PEE DEE                            |DEM   |                47|         242|  19.4214876|
|PEE DEE                            |REP   |               193|         242|  79.7520661|
|PEEPLES                            |DEM   |               312|         763|  40.8912189|
|PEEPLES                            |REP   |               424|         763|  55.5701180|
|PELHAM FALLS                       |DEM   |               270|        1030|  26.2135922|
|PELHAM FALLS                       |REP   |               697|        1030|  67.6699029|
|Pelham Fire Station                |DEM   |               446|        1575|  28.3174603|
|Pelham Fire Station                |REP   |              1027|        1575|  65.2063492|
|Pelion #1                          |DEM   |               134|        1078|  12.4304267|
|Pelion #1                          |REP   |               894|        1078|  82.9313544|
|Pelion #2                          |DEM   |               225|        1176|  19.1326531|
|Pelion #2                          |REP   |               891|        1176|  75.7653061|
|Pelzer                             |DEM   |                76|         671|  11.3263785|
|Pelzer                             |REP   |               560|         671|  83.4575261|
|Pendleton                          |DEM   |              1108|        3066|  36.1382909|
|Pendleton                          |REP   |              1767|        3066|  57.6320939|
|PENIEL                             |DEM   |               244|         561|  43.4937611|
|PENIEL                             |REP   |               284|         561|  50.6238859|
|Pennington 1                       |DEM   |               166|         799|  20.7759700|
|Pennington 1                       |REP   |               591|         799|  73.9674593|
|Pennington 2                       |DEM   |               399|         939|  42.4920128|
|Pennington 2                       |REP   |               461|         939|  49.0947817|
|PENNY ROYAL                        |DEM   |               122|         358|  34.0782123|
|PENNY ROYAL                        |REP   |               233|         358|  65.0837989|
|PERGAMOS                           |DEM   |                98|         218|  44.9541284|
|PERGAMOS                           |REP   |               118|         218|  54.1284404|
|Perry                              |DEM   |               256|         769|  33.2899870|
|Perry                              |REP   |               474|         769|  61.6384915|
|PETITS                             |DEM   |                61|         182|  33.5164835|
|PETITS                             |REP   |               108|         182|  59.3406593|
|Pickensville                       |DEM   |               174|         899|  19.3548387|
|Pickensville                       |REP   |               680|         899|  75.6395996|
|Piedmont                           |DEM   |               152|         734|  20.7084469|
|Piedmont                           |REP   |               549|         734|  74.7956403|
|PIEDMONT                           |DEM   |               690|        2181|  31.6368638|
|PIEDMONT                           |REP   |              1375|        2181|  63.0444750|
|Piercetown                         |DEM   |               259|        1710|  15.1461988|
|Piercetown                         |REP   |              1373|        1710|  80.2923977|
|Pike                               |DEM   |               284|         800|  35.5000000|
|Pike                               |REP   |               454|         800|  56.7500000|
|Pilgrim Church                     |DEM   |               420|        1941|  21.6383308|
|Pilgrim Church                     |REP   |              1373|        1941|  70.7367336|
|Pimlico                            |DEM   |               657|        2403|  27.3408240|
|Pimlico                            |REP   |              1592|        2403|  66.2505202|
|Pine Forest                        |DEM   |               276|        1493|  18.4862693|
|Pine Forest                        |REP   |              1151|        1493|  77.0931011|
|Pine Grove                         |DEM   |              1088|        1241|  87.6712329|
|Pine Grove                         |REP   |               119|        1241|   9.5890411|
|PINE HILL                          |DEM   |               585|         955|  61.2565445|
|PINE HILL                          |REP   |               349|         955|  36.5445026|
|Pine Lakes 1                       |DEM   |               657|         748|  87.8342246|
|Pine Lakes 1                       |REP   |                55|         748|   7.3529412|
|Pine Lakes 2                       |DEM   |               827|         938|  88.1663113|
|Pine Lakes 2                       |REP   |                79|         938|   8.4221748|
|Pinecrest                          |DEM   |               238|         669|  35.5754858|
|Pinecrest                          |REP   |               396|         669|  59.1928251|
|Pineland                           |DEM   |               417|         494|  84.4129555|
|Pineland                           |REP   |                47|         494|   9.5141700|
|Pineridge #1                       |DEM   |               252|         961|  26.2226847|
|Pineridge #1                       |REP   |               639|         961|  66.4932362|
|Pineridge #2                       |DEM   |               563|        1599|  35.2095059|
|Pineridge #2                       |REP   |               978|        1599|  61.1632270|
|Pineview                           |DEM   |               334|        1320|  25.3030303|
|Pineview                           |REP   |               911|        1320|  69.0151515|
|PINEVIEW                           |DEM   |               167|        1056|  15.8143939|
|PINEVIEW                           |REP   |               848|        1056|  80.3030303|
|Pinewood                           |DEM   |               976|        1193|  81.8105616|
|Pinewood                           |REP   |               163|        1193|  13.6630344|
|PINEWOOD                           |DEM   |               733|        1415|  51.8021201|
|PINEWOOD                           |REP   |               649|        1415|  45.8657244|
|PINEY FOREST                       |DEM   |                13|         403|   3.2258065|
|PINEY FOREST                       |REP   |               383|         403|  95.0372208|
|Pinopolis                          |DEM   |               231|        1370|  16.8613139|
|Pinopolis                          |REP   |              1103|        1370|  80.5109489|
|PLANTERSVILLE                      |DEM   |               562|         695|  80.8633094|
|PLANTERSVILLE                      |REP   |               128|         695|  18.4172662|
|Platt Springs 1                    |DEM   |               219|        1088|  20.1286765|
|Platt Springs 1                    |REP   |               813|        1088|  74.7242647|
|Platt Springs 2                    |DEM   |               773|        1921|  40.2394586|
|Platt Springs 2                    |REP   |              1040|        1921|  54.1384695|
|PLEASANT CROSS                     |DEM   |               116|         212|  54.7169811|
|PLEASANT CROSS                     |REP   |                97|         212|  45.7547170|
|Pleasant Grove                     |DEM   |               384|         754|  50.9283820|
|Pleasant Grove                     |REP   |               357|         754|  47.3474801|
|PLEASANT GROVE                     |DEM   |                79|         586|  13.4812287|
|PLEASANT GROVE                     |REP   |               493|         586|  84.1296928|
|Pleasant Hill                      |DEM   |               330|         938|  35.1812367|
|Pleasant Hill                      |REP   |               571|         938|  60.8742004|
|PLEASANT HILL                      |DEM   |               346|         945|  36.6137566|
|PLEASANT HILL                      |REP   |               562|         945|  59.4708995|
|Pleasant Meadows                   |DEM   |               408|         566|  72.0848057|
|Pleasant Meadows                   |REP   |               145|         566|  25.6183746|
|Pleasant Road                      |DEM   |               455|        1496|  30.4144385|
|Pleasant Road                      |REP   |               983|        1496|  65.7085561|
|Pleasant Valley                    |DEM   |               880|        2408|  36.5448505|
|Pleasant Valley                    |REP   |              1380|        2408|  57.3089701|
|PLEASANT VIEW                      |DEM   |                45|         232|  19.3965517|
|PLEASANT VIEW                      |REP   |               185|         232|  79.7413793|
|Plum Branch                        |DEM   |               348|         632|  55.0632911|
|Plum Branch                        |REP   |               266|         632|  42.0886076|
|POCOTALIGO 1                       |DEM   |               462|        1201|  38.4679434|
|POCOTALIGO 1                       |REP   |               701|        1201|  58.3680266|
|POCOTALIGO 2                       |DEM   |               496|         925|  53.6216216|
|POCOTALIGO 2                       |REP   |               403|         925|  43.5675676|
|POINSETT                           |DEM   |               595|        2006|  29.6610169|
|POINSETT                           |REP   |              1286|        2006|  64.1076770|
|Pole Branch                        |DEM   |               353|        1340|  26.3432836|
|Pole Branch                        |REP   |               910|        1340|  67.9104478|
|Polo Road                          |DEM   |              1086|        1540|  70.5194805|
|Polo Road                          |REP   |               385|        1540|  25.0000000|
|PONARIA                            |DEM   |               147|         530|  27.7358491|
|PONARIA                            |REP   |               360|         530|  67.9245283|
|Pond Branch                        |DEM   |               240|        1532|  15.6657963|
|Pond Branch                        |REP   |              1207|        1532|  78.7859008|
|Pontiac 1                          |DEM   |               835|        1537|  54.3266103|
|Pontiac 1                          |REP   |               648|        1537|  42.1600520|
|Pontiac 2                          |DEM   |               388|         919|  42.2198041|
|Pontiac 2                          |REP   |               470|         919|  51.1425462|
|Pope Field                         |DEM   |               178|         733|  24.2837653|
|Pope Field                         |REP   |               520|         733|  70.9413370|
|POPLAR HILL                        |DEM   |                71|         746|   9.5174263|
|POPLAR HILL                        |REP   |               658|         746|  88.2037534|
|Poplar Springs Fire Station        |DEM   |               446|        1850|  24.1081081|
|Poplar Springs Fire Station        |REP   |              1335|        1850|  72.1621622|
|PORT HARRELSON                     |DEM   |               782|         850|  92.0000000|
|PORT HARRELSON                     |REP   |                53|         850|   6.2352941|
|PORT ROYAL 1                       |DEM   |               322|         764|  42.1465969|
|PORT ROYAL 1                       |REP   |               399|         764|  52.2251309|
|PORT ROYAL 2                       |DEM   |               365|         762|  47.9002625|
|PORT ROYAL 2                       |REP   |               349|         762|  45.8005249|
|Possum Hollow                      |DEM   |               633|        1970|  32.1319797|
|Possum Hollow                      |REP   |              1245|        1970|  63.1979695|
|POTATO BED FERRY                   |DEM   |               291|         678|  42.9203540|
|POTATO BED FERRY                   |REP   |               370|         678|  54.5722714|
|Powdersville                       |DEM   |               523|        2498|  20.9367494|
|Powdersville                       |REP   |              1879|        2498|  75.2201761|
|Powell Saxon Una                   |DEM   |               850|        1185|  71.7299578|
|Powell Saxon Una                   |REP   |               286|        1185|  24.1350211|
|Praters Creek                      |DEM   |                46|         754|   6.1007958|
|Praters Creek                      |REP   |               680|         754|  90.1856764|
|PRINCETON                          |DEM   |                29|         239|  12.1338912|
|PRINCETON                          |REP   |               198|         239|  82.8451883|
|PRIVATEER                          |DEM   |               308|        1202|  25.6239601|
|PRIVATEER                          |REP   |               839|        1202|  69.8003328|
|PROSPECT                           |DEM   |                20|         337|   5.9347181|
|PROSPECT                           |REP   |               306|         337|  90.8011869|
|PROSPERITY                         |DEM   |               609|        1324|  45.9969789|
|PROSPERITY                         |REP   |               672|        1324|  50.7552870|
|PROVIDENCE                         |DEM   |               804|        1084|  74.1697417|
|PROVIDENCE                         |REP   |               269|        1084|  24.8154982|
|Providence Church                  |DEM   |               284|        1795|  15.8217270|
|Providence Church                  |REP   |              1419|        1795|  79.0529248|
|Provisional                        |DEM   |              1119|        2449|  45.6921192|
|Provisional                        |REP   |              1222|        2449|  49.8979175|
|Provisional 1                      |DEM   |                52|         161|  32.2981366|
|Provisional 1                      |REP   |               105|         161|  65.2173913|
|PROVISIONAL 1                      |DEM   |                71|         199|  35.6783920|
|PROVISIONAL 1                      |REP   |               113|         199|  56.7839196|
|Provisional 2                      |DEM   |               162|         309|  52.4271845|
|Provisional 2                      |REP   |               134|         309|  43.3656958|
|PROVISIONAL 2                      |DEM   |                41|         123|  33.3333333|
|PROVISIONAL 2                      |REP   |                77|         123|  62.6016260|
|Provisional 3                      |DEM   |                49|         117|  41.8803419|
|Provisional 3                      |REP   |                65|         117|  55.5555556|
|Provisional 4                      |DEM   |                 8|          46|  17.3913043|
|Provisional 4                      |REP   |                35|          46|  76.0869565|
|Pumpkintown                        |DEM   |               213|        1305|  16.3218391|
|Pumpkintown                        |REP   |              1041|        1305|  79.7701149|
|PUTMAN                             |DEM   |                93|         547|  17.0018282|
|PUTMAN                             |REP   |               436|         547|  79.7074954|
|Quail Hollow                       |DEM   |               448|        1307|  34.2769702|
|Quail Hollow                       |REP   |               766|        1307|  58.6074981|
|Quail Valley                       |DEM   |               651|        1579|  41.2286257|
|Quail Valley                       |REP   |               840|        1579|  53.1982267|
|QUICKS X ROADS                     |DEM   |               335|         590|  56.7796610|
|QUICKS X ROADS                     |REP   |               232|         590|  39.3220339|
|QUINBY                             |DEM   |               499|         682|  73.1671554|
|QUINBY                             |REP   |               162|         682|  23.7536657|
|R.D. Anderson Vocational           |DEM   |               190|        1392|  13.6494253|
|R.D. Anderson Vocational           |REP   |              1149|        1392|  82.5431034|
|Rabon's X Roads                    |DEM   |               277|        1417|  19.5483416|
|Rabon's X Roads                    |REP   |              1092|        1417|  77.0642202|
|RACEPATH #1                        |DEM   |               497|         938|  52.9850746|
|RACEPATH #1                        |REP   |               405|         938|  43.1769723|
|RACEPATH #2                        |DEM   |              1084|        1173|  92.4126172|
|RACEPATH #2                        |REP   |                64|        1173|   5.4560955|
|RAINS                              |DEM   |               514|         698|  73.6389685|
|RAINS                              |REP   |               162|         698|  23.2091691|
|RAINTREE                           |DEM   |               877|        2531|  34.6503358|
|RAINTREE                           |REP   |              1507|        2531|  59.5416831|
|RANCH CREEK                        |DEM   |              1265|        2398|  52.7522936|
|RANCH CREEK                        |REP   |              1007|        2398|  41.9933278|
|RATTLESNAKE SPRINGS                |DEM   |               187|         348|  53.7356322|
|RATTLESNAKE SPRINGS                |REP   |               154|         348|  44.2528736|
|Ravenel                            |DEM   |               588|        1805|  32.5761773|
|Ravenel                            |REP   |              1132|        1805|  62.7146814|
|Rebirth Missionary Baptist         |DEM   |               589|        2615|  22.5239006|
|Rebirth Missionary Baptist         |REP   |              1876|        2615|  71.7399618|
|Red Bank                           |DEM   |               555|        2308|  24.0467938|
|Red Bank                           |REP   |              1628|        2308|  70.5372617|
|Red Bank South #1                  |DEM   |               320|        1622|  19.7287300|
|Red Bank South #1                  |REP   |              1219|        1622|  75.1541307|
|RED BLUFF                          |DEM   |               414|         917|  45.1472192|
|RED BLUFF                          |REP   |               471|         917|  51.3631407|
|RED HILL                           |DEM   |               304|         640|  47.5000000|
|RED HILL                           |REP   |               325|         640|  50.7812500|
|RED HILL #1                        |DEM   |               231|         941|  24.5483528|
|RED HILL #1                        |REP   |               652|         941|  69.2879915|
|RED HILL #2                        |DEM   |               620|        1972|  31.4401623|
|RED HILL #2                        |REP   |              1270|        1972|  64.4016227|
|Redbank South #2                   |DEM   |               345|        1283|  26.8901013|
|Redbank South #2                   |REP   |               859|        1283|  66.9524552|
|Redds Branch                       |DEM   |               287|         918|  31.2636166|
|Redds Branch                       |REP   |               579|         918|  63.0718954|
|REEDY FORK                         |DEM   |               787|        1730|  45.4913295|
|REEDY FORK                         |REP   |               877|        1730|  50.6936416|
|Reevesville                        |DEM   |               456|         879|  51.8771331|
|Reevesville                        |REP   |               398|         879|  45.2787258|
|Reidville Elementary               |DEM   |               514|        2506|  20.5107741|
|Reidville Elementary               |REP   |              1891|        2506|  75.4588986|
|Reidville Fire Station             |DEM   |               630|        2457|  25.6410256|
|Reidville Fire Station             |REP   |              1715|        2457|  69.8005698|
|REMBERT                            |DEM   |              1296|        1511|  85.7710126|
|REMBERT                            |REP   |               194|        1511|  12.8391794|
|Return                             |DEM   |                77|         639|  12.0500782|
|Return                             |REP   |               544|         639|  85.1330203|
|Rice Creek 1                       |DEM   |               974|        1199|  81.2343620|
|Rice Creek 1                       |REP   |               181|        1199|  15.0959133|
|Rice Creek 2                       |DEM   |              1254|        1679|  74.6873139|
|Rice Creek 2                       |REP   |               350|        1679|  20.8457415|
|RICE PATCH                         |DEM   |               186|         485|  38.3505155|
|RICE PATCH                         |REP   |               277|         485|  57.1134021|
|Rices Creek                        |DEM   |               117|        1052|  11.1216730|
|Rices Creek                        |REP   |               899|        1052|  85.4562738|
|Rich Hill                          |DEM   |               127|         861|  14.7502904|
|Rich Hill                          |REP   |               702|         861|  81.5331010|
|Richburg                           |DEM   |               405|        1103|  36.7180417|
|Richburg                           |REP   |               653|        1103|  59.2021759|
|Richland                           |DEM   |               142|         871|  16.3030999|
|Richland                           |REP   |               687|         871|  78.8748565|
|RICHLAND                           |DEM   |               119|         542|  21.9557196|
|RICHLAND                           |REP   |               409|         542|  75.4612546|
|Ridge Road                         |DEM   |               200|        1618|  12.3609394|
|Ridge Road                         |REP   |              1349|        1618|  83.3745365|
|RIDGE SPRING - MONETTA             |DEM   |               460|         772|  59.5854922|
|RIDGE SPRING - MONETTA             |REP   |               290|         772|  37.5647668|
|Ridge View 1                       |DEM   |              1007|        1412|  71.3172805|
|Ridge View 1                       |REP   |               344|        1412|  24.3626062|
|Ridge View 2                       |DEM   |              1268|        1764|  71.8820862|
|Ridge View 2                       |REP   |               402|        1764|  22.7891156|
|Ridgeland 1                        |DEM   |               193|         633|  30.4897314|
|Ridgeland 1                        |REP   |               412|         633|  65.0868878|
|Ridgeland 2                        |DEM   |               319|         660|  48.3333333|
|Ridgeland 2                        |REP   |               308|         660|  46.6666667|
|Ridgeland 3                        |DEM   |               167|         486|  34.3621399|
|Ridgeland 3                        |REP   |               296|         486|  60.9053498|
|Ridgeville                         |DEM   |               324|         699|  46.3519313|
|Ridgeville                         |REP   |               351|         699|  50.2145923|
|Ridgeville 2                       |DEM   |               328|         610|  53.7704918|
|Ridgeville 2                       |REP   |               265|         610|  43.4426230|
|RIDGEWAY                           |DEM   |              1099|        1607|  68.3883012|
|RIDGEWAY                           |REP   |               464|        1607|  28.8736777|
|Ridgewood                          |DEM   |               557|         587|  94.8892675|
|Ridgewood                          |REP   |                14|         587|   2.3850085|
|Riley                              |DEM   |                74|         186|  39.7849462|
|Riley                              |REP   |               110|         186|  59.1397849|
|RITTER                             |DEM   |               418|         582|  71.8213058|
|RITTER                             |REP   |               154|         582|  26.4604811|
|River's Edge                       |DEM   |               330|        1454|  22.6960110|
|River's Edge                       |REP   |              1036|        1454|  71.2517194|
|River Bluff                        |DEM   |               431|        1794|  24.0245262|
|River Bluff                        |REP   |              1215|        1794|  67.7257525|
|River Hills                        |DEM   |               480|        1773|  27.0727580|
|River Hills                        |REP   |              1232|        1773|  69.4867456|
|RIVER OAKS                         |DEM   |               405|        1730|  23.4104046|
|RIVER OAKS                         |REP   |              1260|        1730|  72.8323699|
|River Ridge Elementary             |DEM   |               524|        1673|  31.3209803|
|River Ridge Elementary             |REP   |              1068|        1673|  63.8374178|
|River Road                         |DEM   |               440|        1533|  28.7018917|
|River Road                         |REP   |              1043|        1533|  68.0365297|
|Riverdale                          |DEM   |               564|         660|  85.4545455|
|Riverdale                          |REP   |                81|         660|  12.2727273|
|Rivers Mill                        |DEM   |                40|          65|  61.5384615|
|Rivers Mill                        |REP   |                21|          65|  32.3076923|
|Riverside                          |DEM   |              1032|        1697|  60.8131998|
|Riverside                          |REP   |               571|        1697|  33.6476134|
|RIVERSIDE                          |DEM   |               713|        2016|  35.3670635|
|RIVERSIDE                          |REP   |              1174|        2016|  58.2341270|
|Riversprings 1                     |DEM   |               206|         809|  25.4635352|
|Riversprings 1                     |REP   |               539|         809|  66.6254635|
|Riversprings 2                     |DEM   |               543|        1112|  48.8309353|
|Riversprings 2                     |REP   |               515|        1112|  46.3129496|
|Riversprings 3                     |DEM   |               382|         966|  39.5445135|
|Riversprings 3                     |REP   |               537|         966|  55.5900621|
|Riverview                          |DEM   |               351|        1107|  31.7073171|
|Riverview                          |REP   |               680|        1107|  61.4272809|
|Riverwalk                          |DEM   |              1148|        1906|  60.2308499|
|Riverwalk                          |REP   |               655|        1906|  34.3651626|
|RIVERWALK                          |DEM   |               565|        2347|  24.0732850|
|RIVERWALK                          |REP   |              1660|        2347|  70.7285897|
|Rock Creek                         |DEM   |               260|        1205|  21.5767635|
|Rock Creek                         |REP   |               894|        1205|  74.1908714|
|ROCK HILL                          |DEM   |               752|        1982|  37.9414733|
|ROCK HILL                          |REP   |              1091|        1982|  55.0454087|
|Rock Hill No. 2                    |DEM   |               938|         982|  95.5193483|
|Rock Hill No. 2                    |REP   |                22|         982|   2.2403259|
|Rock Hill No. 3                    |DEM   |              1412|        1566|  90.1660281|
|Rock Hill No. 3                    |REP   |               111|        1566|   7.0881226|
|Rock Hill No. 4                    |DEM   |               714|        1284|  55.6074766|
|Rock Hill No. 4                    |REP   |               492|        1284|  38.3177570|
|Rock Hill No. 5                    |DEM   |               506|        1045|  48.4210526|
|Rock Hill No. 5                    |REP   |               455|        1045|  43.5406699|
|Rock Hill No. 6                    |DEM   |               796|        1012|  78.6561265|
|Rock Hill No. 6                    |REP   |               178|        1012|  17.5889328|
|Rock Hill No. 7                    |DEM   |               862|        1656|  52.0531401|
|Rock Hill No. 7                    |REP   |               689|        1656|  41.6062802|
|Rock Hill No. 8                    |DEM   |               673|         763|  88.2044561|
|Rock Hill No. 8                    |REP   |                64|         763|   8.3879423|
|Rock Mill                          |DEM   |               164|         934|  17.5588865|
|Rock Mill                          |REP   |               748|         934|  80.0856531|
|Rock Spring                        |DEM   |               170|         668|  25.4491018|
|Rock Spring                        |REP   |               476|         668|  71.2574850|
|Rock Springs                       |DEM   |               195|        1023|  19.0615836|
|Rock Springs                       |REP   |               785|        1023|  76.7350929|
|ROCKY CREEK                        |DEM   |               640|        1647|  38.8585307|
|ROCKY CREEK                        |REP   |               911|        1647|  55.3126897|
|Rodman                             |DEM   |               257|         812|  31.6502463|
|Rodman                             |REP   |               525|         812|  64.6551724|
|Roebuck Bethlehem                  |DEM   |               450|         987|  45.5927052|
|Roebuck Bethlehem                  |REP   |               503|         987|  50.9625127|
|Roebuck Elementary                 |DEM   |               929|        1911|  48.6132915|
|Roebuck Elementary                 |REP   |               913|        1911|  47.7760335|
|ROLLING GREEN                      |DEM   |               373|        1492|  25.0000000|
|ROLLING GREEN                      |REP   |              1063|        1492|  71.2466488|
|Roosevelt                          |DEM   |               468|        1127|  41.5261757|
|Roosevelt                          |REP   |               611|        1127|  54.2147294|
|ROSE HILL                          |DEM   |               349|        1504|  23.2047872|
|ROSE HILL                          |REP   |              1088|        1504|  72.3404255|
|Rosewood                           |DEM   |              1158|        2346|  49.3606138|
|Rosewood                           |REP   |              1028|        2346|  43.8192668|
|Rosinville                         |DEM   |               578|        1178|  49.0662139|
|Rosinville                         |REP   |               572|        1178|  48.5568761|
|Rosses                             |DEM   |               364|         876|  41.5525114|
|Rosses                             |REP   |               487|         876|  55.5936073|
|Rossville                          |DEM   |               120|         356|  33.7078652|
|Rossville                          |REP   |               231|         356|  64.8876404|
|Round Hill                         |DEM   |               582|        2599|  22.3932282|
|Round Hill                         |REP   |              1859|        2599|  71.5275106|
|ROUND O                            |DEM   |               231|         675|  34.2222222|
|ROUND O                            |REP   |               414|         675|  61.3333333|
|Round Top                          |DEM   |               406|         601|  67.5540765|
|Round Top                          |REP   |               175|         601|  29.1181364|
|ROWESVILLE                         |DEM   |               358|         578|  61.9377163|
|ROWESVILLE                         |REP   |               214|         578|  37.0242215|
|ROYAL OAKS                         |DEM   |              1130|        1291|  87.5290473|
|ROYAL OAKS                         |REP   |               122|        1291|   9.4500387|
|Royle                              |DEM   |               363|        1060|  34.2452830|
|Royle                              |REP   |               636|        1060|  60.0000000|
|RUBY                               |DEM   |               332|         781|  42.5096031|
|RUBY                               |REP   |               426|         781|  54.5454545|
|RUFFIN                             |DEM   |                99|         211|  46.9194313|
|RUFFIN                             |REP   |               109|         211|  51.6587678|
|Russellville                       |DEM   |               818|         990|  82.6262626|
|Russellville                       |REP   |               145|         990|  14.6464646|
|Rutherford Shoals                  |DEM   |               230|         643|  35.7698289|
|Rutherford Shoals                  |REP   |               396|         643|  61.5863142|
|S BENNETTSVILLE                    |DEM   |               489|         552|  88.5869565|
|S BENNETTSVILLE                    |REP   |                41|         552|   7.4275362|
|S EAST MULLINS                     |DEM   |               315|         932|  33.7982833|
|S EAST MULLINS                     |REP   |               577|         932|  61.9098712|
|S WEST MULLINS                     |DEM   |               763|        1133|  67.3433363|
|S WEST MULLINS                     |REP   |               344|        1133|  30.3618711|
|Saint Helena 1A                    |DEM   |               707|         880|  80.3409091|
|Saint Helena 1A                    |REP   |               151|         880|  17.1590909|
|Saint Helena 1B                    |DEM   |               785|        1011|  77.6458952|
|Saint Helena 1B                    |REP   |               203|        1011|  20.0791296|
|Saint Helena 1C                    |DEM   |               314|        1112|  28.2374101|
|Saint Helena 1C                    |REP   |               749|        1112|  67.3561151|
|Saint Helena 2A                    |DEM   |               537|         918|  58.4967320|
|Saint Helena 2A                    |REP   |               355|         918|  38.6710240|
|Saint Helena 2B                    |DEM   |               715|         970|  73.7113402|
|Saint Helena 2B                    |REP   |               223|         970|  22.9896907|
|Saint Helena 2C                    |DEM   |               244|         889|  27.4465692|
|Saint Helena 2C                    |REP   |               618|         889|  69.5163105|
|Salem                              |DEM   |               191|        1515|  12.6072607|
|Salem                              |REP   |              1270|        1515|  83.8283828|
|SALEM                              |DEM   |               708|        2595|  27.2832370|
|SALEM                              |REP   |              1757|        2595|  67.7071291|
|Salley                             |DEM   |               391|         667|  58.6206897|
|Salley                             |REP   |               258|         667|  38.6806597|
|Salt Pond                          |DEM   |               282|        1157|  24.3733794|
|Salt Pond                          |REP   |               820|        1157|  70.8729473|
|SALTERS                            |DEM   |               840|         981|  85.6269113|
|SALTERS                            |REP   |               122|         981|  12.4362895|
|SALTERSTOWN                        |DEM   |               285|         656|  43.4451220|
|SALTERSTOWN                        |REP   |               344|         656|  52.4390244|
|Saluda                             |DEM   |               216|        1067|  20.2436739|
|Saluda                             |REP   |               810|        1067|  75.9137769|
|SALUDA                             |DEM   |               460|        1364|  33.7243402|
|SALUDA                             |REP   |               842|        1364|  61.7302053|
|SALUDA NO. 1                       |DEM   |               789|        1072|  73.6007463|
|SALUDA NO. 1                       |REP   |               256|        1072|  23.8805970|
|SALUDA NO. 2                       |DEM   |               396|         868|  45.6221198|
|SALUDA NO. 2                       |REP   |               437|         868|  50.3456221|
|Saluda River                       |DEM   |               585|        1274|  45.9183673|
|Saluda River                       |REP   |               583|        1274|  45.7613815|
|SAMPIT                             |DEM   |               755|         919|  82.1545158|
|SAMPIT                             |REP   |               149|         919|  16.2132753|
|Sandhill                           |DEM   |               388|        1255|  30.9163347|
|Sandhill                           |REP   |               806|        1255|  64.2231076|
|Sandlapper                         |DEM   |              1423|        1839|  77.3790103|
|Sandlapper                         |REP   |               341|        1839|  18.5426862|
|Sandridge                          |DEM   |                90|         589|  15.2801358|
|Sandridge                          |REP   |               484|         589|  82.1731749|
|Sandstone No. 70                   |DEM   |               316|        1033|  30.5905131|
|Sandstone No. 70                   |REP   |               642|        1033|  62.1490803|
|Sandstone No. 79                   |DEM   |               180|         527|  34.1555977|
|Sandstone No. 79                   |REP   |               319|         527|  60.5313093|
|SANDY BAY                          |DEM   |                86|         326|  26.3803681|
|SANDY BAY                          |REP   |               237|         326|  72.6993865|
|SANDY FLAT                         |DEM   |               426|        2994|  14.2284569|
|SANDY FLAT                         |REP   |              2422|        2994|  80.8951236|
|Sandy Run                          |DEM   |               248|         777|  31.9176319|
|Sandy Run                          |REP   |               498|         777|  64.0926641|
|SANDY RUN                          |DEM   |               366|        1471|  24.8810333|
|SANDY RUN                          |REP   |              1061|        1471|  72.1278042|
|Sangaree 1                         |DEM   |               281|         846|  33.2151300|
|Sangaree 1                         |REP   |               501|         846|  59.2198582|
|Sangaree 2                         |DEM   |               419|        1199|  34.9457882|
|Sangaree 2                         |REP   |               722|        1199|  60.2168474|
|Sangaree 3                         |DEM   |               366|        1083|  33.7950139|
|Sangaree 3                         |REP   |               649|        1083|  59.9261311|
|SANTEE                             |DEM   |               819|         978|  83.7423313|
|SANTEE                             |REP   |               143|         978|  14.6216769|
|SANTEE 1                           |DEM   |               439|        1145|  38.3406114|
|SANTEE 1                           |REP   |               681|        1145|  59.4759825|
|SANTEE 2                           |DEM   |              1107|        1161|  95.3488372|
|SANTEE 2                           |REP   |                38|        1161|   3.2730405|
|SANTUCK                            |DEM   |               478|         728|  65.6593407|
|SANTUCK                            |REP   |               222|         728|  30.4945055|
|Sardina-Gable                      |DEM   |               267|         374|  71.3903743|
|Sardina-Gable                      |REP   |               106|         374|  28.3422460|
|SARDIS                             |DEM   |                38|         445|   8.5393258|
|SARDIS                             |REP   |               388|         445|  87.1910112|
|Satchelford                        |DEM   |               344|         985|  34.9238579|
|Satchelford                        |REP   |               580|         985|  58.8832487|
|Saul Dam                           |DEM   |                77|         324|  23.7654321|
|Saul Dam                           |REP   |               224|         324|  69.1358025|
|SAVAGE-GLOVER                      |DEM   |               440|         454|  96.9162996|
|SAVAGE-GLOVER                      |REP   |                 4|         454|   0.8810573|
|Savannah                           |DEM   |               147|         844|  17.4170616|
|Savannah                           |REP   |               676|         844|  80.0947867|
|SAVANNAH GROVE                     |DEM   |              1173|        2298|  51.0443864|
|SAVANNAH GROVE                     |REP   |              1058|        2298|  46.0400348|
|Sawmill Branch                     |DEM   |               277|        1027|  26.9717624|
|Sawmill Branch                     |REP   |               663|        1027|  64.5569620|
|SCHROCKS MILL/LUCKNOW              |DEM   |               205|         427|  48.0093677|
|SCHROCKS MILL/LUCKNOW              |REP   |               216|         427|  50.5854801|
|Scotia                             |DEM   |               314|         351|  89.4586895|
|Scotia                             |REP   |                26|         351|   7.4074074|
|SCRANTON                           |DEM   |               348|         772|  45.0777202|
|SCRANTON                           |REP   |               416|         772|  53.8860104|
|SEA OATS #1                        |DEM   |               447|        1230|  36.3414634|
|SEA OATS #1                        |REP   |               725|        1230|  58.9430894|
|SEA OATS #2                        |DEM   |               695|        1332|  52.1771772|
|SEA OATS #2                        |REP   |               581|        1332|  43.6186186|
|SEA WINDS                          |DEM   |               814|        2824|  28.8243626|
|SEA WINDS                          |REP   |              1909|        2824|  67.5991501|
|SEABROOK 1                         |DEM   |               337|         760|  44.3421053|
|SEABROOK 1                         |REP   |               388|         760|  51.0526316|
|SEABROOK 2                         |DEM   |               483|         680|  71.0294118|
|SEABROOK 2                         |REP   |               175|         680|  25.7352941|
|SEABROOK 3                         |DEM   |               591|        1071|  55.1820728|
|SEABROOK 3                         |REP   |               431|        1071|  40.2427638|
|SECOND MILL                        |DEM   |               179|        1004|  17.8286853|
|SECOND MILL                        |REP   |               768|        1004|  76.4940239|
|Sedgefield 1                       |DEM   |               513|        1198|  42.8213689|
|Sedgefield 1                       |REP   |               622|        1198|  51.9198664|
|Sedgefield 2                       |DEM   |               301|         754|  39.9204244|
|Sedgefield 2                       |REP   |               394|         754|  52.2546419|
|SELLERS                            |DEM   |               174|         224|  77.6785714|
|SELLERS                            |REP   |                48|         224|  21.4285714|
|Seneca 1                           |DEM   |               830|        1898|  43.7302424|
|Seneca 1                           |REP   |               963|        1898|  50.7376185|
|Seneca 2                           |DEM   |               436|        1384|  31.5028902|
|Seneca 2                           |REP   |               862|        1384|  62.2832370|
|Seneca 3                           |DEM   |               243|         945|  25.7142857|
|Seneca 3                           |REP   |               656|         945|  69.4179894|
|Seneca 4                           |DEM   |               819|        1845|  44.3902439|
|Seneca 4                           |REP   |               927|        1845|  50.2439024|
|Seven Oaks                         |DEM   |               590|        1231|  47.9285134|
|Seven Oaks                         |REP   |               544|        1231|  44.1917141|
|Seventy Eight                      |DEM   |               408|        1044|  39.0804598|
|Seventy Eight                      |REP   |               549|        1044|  52.5862069|
|SEVIER                             |DEM   |               522|        2243|  23.2724030|
|SEVIER                             |REP   |              1572|        2243|  70.0847080|
|Sharon                             |DEM   |               337|        1132|  29.7703180|
|Sharon                             |REP   |               738|        1132|  65.1943463|
|Sharpe'S Hill                      |DEM   |               404|        1497|  26.9873079|
|Sharpe'S Hill                      |REP   |              1020|        1497|  68.1362725|
|SHAW                               |DEM   |                54|         179|  30.1675978|
|SHAW                               |REP   |               109|         179|  60.8938547|
|Shaws Fork                         |DEM   |               127|         579|  21.9343696|
|Shaws Fork                         |REP   |               420|         579|  72.5388601|
|Shaylor's Hill                     |DEM   |               233|         605|  38.5123967|
|Shaylor's Hill                     |REP   |               350|         605|  57.8512397|
|Sheffield                          |DEM   |               234|        1105|  21.1764706|
|Sheffield                          |REP   |               837|        1105|  75.7466063|
|SHELDON 1                          |DEM   |               493|         876|  56.2785388|
|SHELDON 1                          |REP   |               360|         876|  41.0958904|
|SHELDON 2                          |DEM   |               559|         632|  88.4493671|
|SHELDON 2                          |REP   |                57|         632|   9.0189873|
|SHELL                              |DEM   |               126|        1052|  11.9771863|
|SHELL                              |REP   |               877|        1052|  83.3650190|
|Shelley Mullis                     |DEM   |               545|        1595|  34.1692790|
|Shelley Mullis                     |REP   |               938|        1595|  58.8087774|
|Shiloh                             |DEM   |               689|        2376|  28.9983165|
|Shiloh                             |REP   |              1588|        2376|  66.8350168|
|SHILOH                             |DEM   |               175|         500|  35.0000000|
|SHILOH                             |REP   |               309|         500|  61.8000000|
|Shirley's Store                    |DEM   |               141|         717|  19.6652720|
|Shirley's Store                    |REP   |               558|         717|  77.8242678|
|Shoals Junction                    |DEM   |                66|         281|  23.4875445|
|Shoals Junction                    |REP   |               201|         281|  71.5302491|
|Shoreline                          |DEM   |               606|        1792|  33.8169643|
|Shoreline                          |REP   |              1088|        1792|  60.7142857|
|Shulerville                        |DEM   |               180|         389|  46.2724936|
|Shulerville                        |REP   |               197|         389|  50.6426735|
|SIDNEYS                            |DEM   |                97|         443|  21.8961625|
|SIDNEYS                            |REP   |               334|         443|  75.3950339|
|Silver Bluff                       |DEM   |               818|        1457|  56.1427591|
|Silver Bluff                       |REP   |               595|        1457|  40.8373370|
|SILVERLEAF                         |DEM   |               431|        1803|  23.9046034|
|SILVERLEAF                         |REP   |              1249|        1803|  69.2734332|
|SILVERSTREET                       |DEM   |               210|         561|  37.4331551|
|SILVERSTREET                       |REP   |               327|         561|  58.2887701|
|Simpson                            |DEM   |               443|         855|  51.8128655|
|Simpson                            |REP   |               369|         855|  43.1578947|
|SIMPSON                            |DEM   |               452|         770|  58.7012987|
|SIMPSON                            |REP   |               288|         770|  37.4025974|
|Simpsonville                       |DEM   |               356|        2204|  16.1524501|
|Simpsonville                       |REP   |              1750|        2204|  79.4010889|
|SIMPSONVILLE 1                     |DEM   |               681|        2069|  32.9144514|
|SIMPSONVILLE 1                     |REP   |              1271|        2069|  61.4306428|
|SIMPSONVILLE 2                     |DEM   |               516|        1439|  35.8582349|
|SIMPSONVILLE 2                     |REP   |               823|        1439|  57.1924948|
|SIMPSONVILLE 3                     |DEM   |               514|        2037|  25.2331861|
|SIMPSONVILLE 3                     |REP   |              1427|        2037|  70.0540010|
|SIMPSONVILLE 4                     |DEM   |               632|        1670|  37.8443114|
|SIMPSONVILLE 4                     |REP   |               938|        1670|  56.1676647|
|SIMPSONVILLE 5                     |DEM   |               775|        1701|  45.5614345|
|SIMPSONVILLE 5                     |REP   |               820|        1701|  48.2069371|
|SIMPSONVILLE 6                     |DEM   |               808|        2326|  34.7377472|
|SIMPSONVILLE 6                     |REP   |              1394|        2326|  59.9312124|
|SINGLETARY                         |DEM   |               206|         250|  82.4000000|
|SINGLETARY                         |REP   |                39|         250|  15.6000000|
|Sitton                             |DEM   |               257|        1239|  20.7425343|
|Sitton                             |REP   |               935|        1239|  75.4640839|
|Six Mile                           |DEM   |               295|        2216|  13.3122744|
|Six Mile                           |REP   |              1821|        2216|  82.1750903|
|Six Mile Mountain                  |DEM   |               163|        1219|  13.3716161|
|Six Mile Mountain                  |REP   |               990|        1219|  81.2141099|
|Six Points No. 35                  |DEM   |               361|         968|  37.2933884|
|Six Points No. 35                  |REP   |               555|         968|  57.3347107|
|Six Points No. 46                  |DEM   |               868|         964|  90.0414938|
|Six Points No. 46                  |REP   |                70|         964|   7.2614108|
|Skelton                            |DEM   |                89|         957|   9.2998955|
|Skelton                            |REP   |               831|         957|  86.8338558|
|Skyland                            |DEM   |               531|         792|  67.0454545|
|Skyland                            |REP   |               193|         792|  24.3686869|
|SKYLAND                            |DEM   |               185|        2266|   8.1641659|
|SKYLAND                            |REP   |              1993|        2266|  87.9523389|
|SLATER MARIETTA                    |DEM   |               337|        2555|  13.1898239|
|SLATER MARIETTA                    |REP   |              2080|        2555|  81.4090020|
|Sleepy Hollow No. 65               |DEM   |               293|        1527|  19.1879502|
|Sleepy Hollow No. 65               |REP   |              1160|        1527|  75.9659463|
|Smith Grove                        |DEM   |               142|         826|  17.1912833|
|Smith Grove                        |REP   |               636|         826|  76.9975787|
|Smyrna                             |DEM   |                63|         580|  10.8620690|
|Smyrna                             |REP   |               491|         580|  84.6551724|
|SNELLING                           |DEM   |               502|        1031|  48.6905917|
|SNELLING                           |REP   |               513|        1031|  49.7575170|
|SNIDERS                            |DEM   |               128|         459|  27.8867102|
|SNIDERS                            |REP   |               319|         459|  69.4989107|
|SNOW HILL-VAUGHN                   |DEM   |                84|         382|  21.9895288|
|SNOW HILL-VAUGHN                   |REP   |               276|         382|  72.2513089|
|SOCASTEE #1                        |DEM   |               589|        2202|  26.7484105|
|SOCASTEE #1                        |REP   |              1502|        2202|  68.2107175|
|SOCASTEE #2                        |DEM   |               263|        1411|  18.6392629|
|SOCASTEE #2                        |REP   |              1095|        1411|  77.6045358|
|SOCASTEE #3                        |DEM   |               716|        3001|  23.8587138|
|SOCASTEE #3                        |REP   |              2142|        3001|  71.3762079|
|SOCASTEE #4                        |DEM   |               871|        2976|  29.2674731|
|SOCASTEE #4                        |REP   |              1980|        2976|  66.5322581|
|SOCIETY HILL                       |DEM   |               587|         827|  70.9794438|
|SOCIETY HILL                       |REP   |               224|         827|  27.0858525|
|South Aiken No. 75                 |DEM   |               386|        1327|  29.0881688|
|South Aiken No. 75                 |REP   |               873|        1327|  65.7874906|
|South Aiken No. 76                 |DEM   |               354|        1525|  23.2131148|
|South Aiken No. 76                 |REP   |              1057|        1525|  69.3114754|
|SOUTH BAMBERG                      |DEM   |              1269|        1650|  76.9090909|
|SOUTH BAMBERG                      |REP   |               336|        1650|  20.3636364|
|South Beltline                     |DEM   |               630|         910|  69.2307692|
|South Beltline                     |REP   |               229|         910|  25.1648352|
|South Central                      |DEM   |               363|         893|  40.6494961|
|South Central                      |REP   |               456|         893|  51.0638298|
|SOUTH DILLON                       |DEM   |               910|        1112|  81.8345324|
|SOUTH DILLON                       |REP   |               170|        1112|  15.2877698|
|SOUTH FLORENCE NO. 1               |DEM   |               543|        1218|  44.5812808|
|SOUTH FLORENCE NO. 1               |REP   |               611|        1218|  50.1642036|
|SOUTH FLORENCE NO. 2               |DEM   |               975|        1230|  79.2682927|
|SOUTH FLORENCE NO. 2               |REP   |               211|        1230|  17.1544715|
|South Forest Acres                 |DEM   |               416|         997|  41.7251755|
|South Forest Acres                 |REP   |               526|         997|  52.7582748|
|SOUTH LIBERTY                      |DEM   |               270|         338|  79.8816568|
|SOUTH LIBERTY                      |REP   |                59|         338|  17.4556213|
|SOUTH LYNCHBURG                    |DEM   |               303|         384|  78.9062500|
|SOUTH LYNCHBURG                    |REP   |                75|         384|  19.5312500|
|South Pickens                      |DEM   |               213|         867|  24.5674740|
|South Pickens                      |REP   |               612|         867|  70.5882353|
|SOUTH RED BAY                      |DEM   |               688|         737|  93.3514247|
|SOUTH RED BAY                      |REP   |                37|         737|   5.0203528|
|South Union                        |DEM   |               198|        1246|  15.8908507|
|South Union                        |REP   |               982|        1246|  78.8121990|
|SOUTH WINNSBORO                    |DEM   |               461|         550|  83.8181818|
|SOUTH WINNSBORO                    |REP   |                75|         550|  13.6363636|
|SOUTHSIDE                          |DEM   |               828|        1632|  50.7352941|
|SOUTHSIDE                          |REP   |               741|        1632|  45.4044118|
|Southside Baptist                  |DEM   |               622|         772|  80.5699482|
|Southside Baptist                  |REP   |               112|         772|  14.5077720|
|Spann                              |DEM   |               224|         937|  23.9060832|
|Spann                              |REP   |               641|         937|  68.4098186|
|Sparrows Grace                     |DEM   |               134|        1030|  13.0097087|
|Sparrows Grace                     |REP   |               866|        1030|  84.0776699|
|SPARROWS POINT                     |DEM   |               609|        1999|  30.4652326|
|SPARROWS POINT                     |REP   |              1266|        1999|  63.3316658|
|Spartanburg High School            |DEM   |               635|        1518|  41.8313570|
|Spartanburg High School            |REP   |               793|        1518|  52.2397892|
|SPAULDING                          |DEM   |               803|         855|  93.9181287|
|SPAULDING                          |REP   |                38|         855|   4.4444444|
|SPECTRUM                           |DEM   |               470|         675|  69.6296296|
|SPECTRUM                           |REP   |               189|         675|  28.0000000|
|SPRING BRANCH                      |DEM   |                57|         346|  16.4739884|
|SPRING BRANCH                      |REP   |               277|         346|  80.0578035|
|SPRING FOREST                      |DEM   |               635|        1574|  40.3430750|
|SPRING FOREST                      |REP   |               826|        1574|  52.4777637|
|SPRING GULLY                       |DEM   |               642|        1221|  52.5798526|
|SPRING GULLY                       |REP   |               545|        1221|  44.6355446|
|Spring Hill                        |DEM   |               400|        2420|  16.5289256|
|Spring Hill                        |REP   |              1925|        2420|  79.5454545|
|SPRING HILL                        |DEM   |               462|         628|  73.5668790|
|SPRING HILL                        |REP   |               151|         628|  24.0445860|
|Spring Valley                      |DEM   |               879|        1615|  54.4272446|
|Spring Valley                      |REP   |               644|        1615|  39.8761610|
|Spring Valley West                 |DEM   |              1374|        1824|  75.3289474|
|Spring Valley West                 |REP   |               348|        1824|  19.0789474|
|Springdale                         |DEM   |              1332|        3544|  37.5846501|
|Springdale                         |REP   |              1997|        3544|  56.3487585|
|Springdale South                   |DEM   |               167|         560|  29.8214286|
|Springdale South                   |REP   |               355|         560|  63.3928571|
|Springfield                        |DEM   |               431|        1741|  24.7558874|
|Springfield                        |REP   |              1225|        1741|  70.3618610|
|SPRINGFIELD                        |DEM   |               578|        1048|  55.1526718|
|SPRINGFIELD                        |REP   |               448|        1048|  42.7480916|
|Springville 1                      |DEM   |               266|        1344|  19.7916667|
|Springville 1                      |REP   |               995|        1344|  74.0327381|
|Springville 2                      |DEM   |               185|        1161|  15.9345392|
|Springville 2                      |REP   |               880|        1161|  75.7967270|
|St Davids                          |DEM   |               493|        2033|  24.2498770|
|St Davids                          |REP   |              1399|        2033|  68.8145598|
|ST PHILLIPS JOLLY ST.              |DEM   |               304|         817|  37.2093023|
|ST PHILLIPS JOLLY ST.              |REP   |               483|         817|  59.1187271|
|St. Andrews                        |DEM   |               694|         934|  74.3040685|
|St. Andrews                        |REP   |               200|         934|  21.4132762|
|ST. ANDREWS 1                      |DEM   |               227|         379|  59.8944591|
|ST. ANDREWS 1                      |REP   |               122|         379|  32.1899736|
|ST. ANDREWS 10                     |DEM   |               409|         739|  55.3450609|
|ST. ANDREWS 10                     |REP   |               272|         739|  36.8064953|
|ST. ANDREWS 11                     |DEM   |               210|         577|  36.3951473|
|ST. ANDREWS 11                     |REP   |               316|         577|  54.7660312|
|ST. ANDREWS 12                     |DEM   |               250|         623|  40.1284109|
|ST. ANDREWS 12                     |REP   |               298|         623|  47.8330658|
|ST. ANDREWS 13                     |DEM   |               313|         700|  44.7142857|
|ST. ANDREWS 13                     |REP   |               326|         700|  46.5714286|
|ST. ANDREWS 14                     |DEM   |               456|         970|  47.0103093|
|ST. ANDREWS 14                     |REP   |               421|         970|  43.4020619|
|ST. ANDREWS 15                     |DEM   |               504|         671|  75.1117735|
|ST. ANDREWS 15                     |REP   |               119|         671|  17.7347243|
|ST. ANDREWS 16                     |DEM   |               228|         645|  35.3488372|
|ST. ANDREWS 16                     |REP   |               344|         645|  53.3333333|
|ST. ANDREWS 17                     |DEM   |               398|        1066|  37.3358349|
|ST. ANDREWS 17                     |REP   |               575|        1066|  53.9399625|
|ST. ANDREWS 18                     |DEM   |               770|        1143|  67.3665792|
|ST. ANDREWS 18                     |REP   |               298|        1143|  26.0717410|
|ST. ANDREWS 19                     |DEM   |               166|         194|  85.5670103|
|ST. ANDREWS 19                     |REP   |                19|         194|   9.7938144|
|ST. ANDREWS 2                      |DEM   |               431|         713|  60.4488079|
|ST. ANDREWS 2                      |REP   |               209|         713|  29.3127630|
|ST. ANDREWS 20                     |DEM   |               846|        1461|  57.9055441|
|ST. ANDREWS 20                     |REP   |               486|        1461|  33.2648871|
|ST. ANDREWS 21                     |DEM   |               249|         512|  48.6328125|
|ST. ANDREWS 21                     |REP   |               215|         512|  41.9921875|
|ST. ANDREWS 22                     |DEM   |               246|         603|  40.7960199|
|ST. ANDREWS 22                     |REP   |               311|         603|  51.5754561|
|ST. ANDREWS 23                     |DEM   |               310|         620|  50.0000000|
|ST. ANDREWS 23                     |REP   |               248|         620|  40.0000000|
|ST. ANDREWS 24                     |DEM   |               444|         693|  64.0692641|
|ST. ANDREWS 24                     |REP   |               198|         693|  28.5714286|
|ST. ANDREWS 25                     |DEM   |               406|         703|  57.7524893|
|ST. ANDREWS 25                     |REP   |               226|         703|  32.1479374|
|ST. ANDREWS 26                     |DEM   |               404|         794|  50.8816121|
|ST. ANDREWS 26                     |REP   |               323|         794|  40.6801008|
|ST. ANDREWS 27                     |DEM   |              1044|        2188|  47.7148080|
|ST. ANDREWS 27                     |REP   |               964|        2188|  44.0585009|
|ST. ANDREWS 28                     |DEM   |               700|        1490|  46.9798658|
|ST. ANDREWS 28                     |REP   |               682|        1490|  45.7718121|
|ST. ANDREWS 29                     |DEM   |               771|        1864|  41.3626609|
|ST. ANDREWS 29                     |REP   |               919|        1864|  49.3025751|
|ST. ANDREWS 3                      |DEM   |               743|         932|  79.7210300|
|ST. ANDREWS 3                      |REP   |               145|         932|  15.5579399|
|ST. ANDREWS 30                     |DEM   |               474|        1042|  45.4894434|
|ST. ANDREWS 30                     |REP   |               452|        1042|  43.3781190|
|ST. ANDREWS 31                     |DEM   |               316|         746|  42.3592493|
|ST. ANDREWS 31                     |REP   |               366|         746|  49.0616622|
|ST. ANDREWS 32                     |DEM   |               272|         803|  33.8729763|
|ST. ANDREWS 32                     |REP   |               473|         803|  58.9041096|
|ST. ANDREWS 33                     |DEM   |               152|         428|  35.5140187|
|ST. ANDREWS 33                     |REP   |               254|         428|  59.3457944|
|ST. ANDREWS 34                     |DEM   |               400|        1232|  32.4675325|
|ST. ANDREWS 34                     |REP   |               733|        1232|  59.4967532|
|ST. ANDREWS 35                     |DEM   |               353|        1060|  33.3018868|
|ST. ANDREWS 35                     |REP   |               628|        1060|  59.2452830|
|ST. ANDREWS 36                     |DEM   |               379|        1176|  32.2278912|
|ST. ANDREWS 36                     |REP   |               700|        1176|  59.5238095|
|ST. ANDREWS 37                     |DEM   |               833|        2137|  38.9798783|
|ST. ANDREWS 37                     |REP   |              1129|        2137|  52.8310716|
|ST. ANDREWS 4                      |DEM   |               329|         832|  39.5432692|
|ST. ANDREWS 4                      |REP   |               428|         832|  51.4423077|
|ST. ANDREWS 5                      |DEM   |               360|         710|  50.7042254|
|ST. ANDREWS 5                      |REP   |               293|         710|  41.2676056|
|ST. ANDREWS 6                      |DEM   |               267|         863|  30.9385863|
|ST. ANDREWS 6                      |REP   |               523|         863|  60.6025492|
|ST. ANDREWS 7                      |DEM   |               416|        1082|  38.4473198|
|ST. ANDREWS 7                      |REP   |               563|        1082|  52.0332717|
|ST. ANDREWS 8                      |DEM   |               412|         510|  80.7843137|
|ST. ANDREWS 8                      |REP   |                62|         510|  12.1568627|
|ST. ANDREWS 9                      |DEM   |               696|         777|  89.5752896|
|ST. ANDREWS 9                      |REP   |                52|         777|   6.6924067|
|ST. CHARLES                        |DEM   |               540|         722|  74.7922438|
|ST. CHARLES                        |REP   |               168|         722|  23.2686981|
|St. George No. 1                   |DEM   |               395|         795|  49.6855346|
|St. George No. 1                   |REP   |               370|         795|  46.5408805|
|St. George No. 2                   |DEM   |               227|         546|  41.5750916|
|St. George No. 2                   |REP   |               301|         546|  55.1282051|
|St. James                          |DEM   |               477|        1220|  39.0983607|
|St. James                          |REP   |               666|        1220|  54.5901639|
|St. John's Lutheran                |DEM   |               275|         882|  31.1791383|
|St. John's Lutheran                |REP   |               552|         882|  62.5850340|
|ST. MATTHEWS                       |DEM   |               580|        1273|  45.5616654|
|ST. MATTHEWS                       |REP   |               664|        1273|  52.1602514|
|St. Michael                        |DEM   |               347|        1680|  20.6547619|
|St. Michael                        |REP   |              1233|        1680|  73.3928571|
|ST. PAUL                           |DEM   |               677|        1141|  59.3339176|
|ST. PAUL                           |REP   |               410|        1141|  35.9333918|
|ST. PAULS 1                        |DEM   |               712|         916|  77.7292576|
|ST. PAULS 1                        |REP   |               184|         916|  20.0873362|
|ST. PAULS 2A                       |DEM   |               468|         741|  63.1578947|
|ST. PAULS 2A                       |REP   |               252|         741|  34.0080972|
|ST. PAULS 2B                       |DEM   |               663|        1056|  62.7840909|
|ST. PAULS 2B                       |REP   |               362|        1056|  34.2803030|
|ST. PAULS 3                        |DEM   |               408|        1367|  29.8463789|
|ST. PAULS 3                        |REP   |               905|        1367|  66.2033650|
|ST. PAULS 4                        |DEM   |               971|        1275|  76.1568627|
|ST. PAULS 4                        |REP   |               266|        1275|  20.8627451|
|ST. PAULS 5                        |DEM   |               388|         751|  51.6644474|
|ST. PAULS 5                        |REP   |               340|         751|  45.2729694|
|ST. PAULS 6                        |DEM   |               423|        1164|  36.3402062|
|ST. PAULS 6                        |REP   |               693|        1164|  59.5360825|
|St. Stephen 1                      |DEM   |               993|        1177|  84.3670348|
|St. Stephen 1                      |REP   |               160|        1177|  13.5938828|
|St. Stephen 2                      |DEM   |               568|        1106|  51.3562387|
|St. Stephen 2                      |REP   |               505|        1106|  45.6600362|
|ST.JOHN                            |DEM   |               737|        1181|  62.4047417|
|ST.JOHN                            |REP   |               421|        1181|  35.6477561|
|Stallsville                        |DEM   |               206|         799|  25.7822278|
|Stallsville                        |REP   |               553|         799|  69.2115144|
|Stamp Creek                        |DEM   |               315|        1427|  22.0742817|
|Stamp Creek                        |REP   |              1060|        1427|  74.2817099|
|STANDING SPRINGS                   |DEM   |               559|        1624|  34.4211823|
|STANDING SPRINGS                   |REP   |               954|        1624|  58.7438424|
|Starr                              |DEM   |               100|         741|  13.4952767|
|Starr                              |REP   |               618|         741|  83.4008097|
|Startex Fire Station               |DEM   |               373|         773|  48.2535576|
|Startex Fire Station               |REP   |               367|         773|  47.4773609|
|Stateline                          |DEM   |               450|        1188|  37.8787879|
|Stateline                          |REP   |               656|        1188|  55.2188552|
|Steele Creek                       |DEM   |               708|        2018|  35.0842418|
|Steele Creek                       |REP   |              1193|        2018|  59.1179386|
|STOKES                             |DEM   |               115|         546|  21.0622711|
|STOKES                             |REP   |               413|         546|  75.6410256|
|Stone Church                       |DEM   |               461|         966|  47.7225673|
|Stone Church                       |REP   |               411|         966|  42.5465839|
|STONE HILL                         |DEM   |               590|         597|  98.8274707|
|STONE HILL                         |REP   |                 6|         597|   1.0050251|
|Stone Lake                         |DEM   |               311|        1144|  27.1853147|
|Stone Lake                         |REP   |               780|        1144|  68.1818182|
|STONE VALLEY                       |DEM   |               658|        1991|  33.0487192|
|STONE VALLEY                       |REP   |              1188|        1991|  59.6685083|
|STONEHAVEN                         |DEM   |               447|        1554|  28.7644788|
|STONEHAVEN                         |REP   |              1015|        1554|  65.3153153|
|Stonewood                          |DEM   |               249|        1231|  20.2274574|
|Stonewood                          |REP   |               937|        1231|  76.1169781|
|STONEY HILL                        |DEM   |                89|         616|  14.4480519|
|STONEY HILL                        |REP   |               501|         616|  81.3311688|
|Stratford 1                        |DEM   |               480|        1152|  41.6666667|
|Stratford 1                        |REP   |               599|        1152|  51.9965278|
|Stratford 2                        |DEM   |               341|        1391|  24.5147376|
|Stratford 2                        |REP   |               990|        1391|  71.1718188|
|Stratford 3                        |DEM   |               552|        1465|  37.6791809|
|Stratford 3                        |REP   |               823|        1465|  56.1774744|
|Stratford 4                        |DEM   |               472|        1330|  35.4887218|
|Stratford 4                        |REP   |               756|        1330|  56.8421053|
|Stratford 5                        |DEM   |               474|        1040|  45.5769231|
|Stratford 5                        |REP   |               481|        1040|  46.2500000|
|SUBER MILL                         |DEM   |               707|        2332|  30.3173242|
|SUBER MILL                         |REP   |              1457|        2332|  62.4785592|
|SUBURBAN 1                         |DEM   |               491|         511|  96.0861057|
|SUBURBAN 1                         |REP   |                10|         511|   1.9569472|
|SUBURBAN 2                         |DEM   |               489|         503|  97.2166998|
|SUBURBAN 2                         |REP   |                10|         503|   1.9880716|
|SUBURBAN 3                         |DEM   |               979|        1078|  90.8163265|
|SUBURBAN 3                         |REP   |                90|        1078|   8.3487941|
|SUBURBAN 4                         |DEM   |               289|         395|  73.1645570|
|SUBURBAN 4                         |REP   |               101|         395|  25.5696203|
|SUBURBAN 5                         |DEM   |               835|        1019|  81.9430815|
|SUBURBAN 5                         |REP   |               162|        1019|  15.8979392|
|SUBURBAN 6                         |DEM   |               456|         758|  60.1583113|
|SUBURBAN 6                         |REP   |               284|         758|  37.4670185|
|SUBURBAN 7                         |DEM   |               447|         968|  46.1776860|
|SUBURBAN 7                         |REP   |               494|         968|  51.0330579|
|SUBURBAN 8                         |DEM   |               362|         633|  57.1879937|
|SUBURBAN 8                         |REP   |               251|         633|  39.6524487|
|SUBURBAN 9                         |DEM   |               901|        1093|  82.4336688|
|SUBURBAN 9                         |REP   |               174|        1093|  15.9194876|
|SUGAR CREEK                        |DEM   |               481|        2096|  22.9484733|
|SUGAR CREEK                        |REP   |              1511|        2096|  72.0896947|
|SULLIVANS ISLAND                   |DEM   |               529|        1216|  43.5032895|
|SULLIVANS ISLAND                   |REP   |               594|        1216|  48.8486842|
|SULPHUR SPRINGS                    |DEM   |               473|        1828|  25.8752735|
|SULPHUR SPRINGS                    |REP   |              1264|        1828|  69.1466083|
|Summerton No. 1                    |DEM   |               439|        1167|  37.6178235|
|Summerton No. 1                    |REP   |               697|        1167|  59.7257926|
|Summerton No. 2                    |DEM   |               175|         236|  74.1525424|
|Summerton No. 2                    |REP   |                55|         236|  23.3050847|
|Summerton No. 3                    |DEM   |               585|         697|  83.9311334|
|Summerton No. 3                    |REP   |               105|         697|  15.0645624|
|Summit                             |DEM   |               227|        1093|  20.7685270|
|Summit                             |REP   |               824|        1093|  75.3888381|
|SUMTER HIGH 1                      |DEM   |               167|         463|  36.0691145|
|SUMTER HIGH 1                      |REP   |               273|         463|  58.9632829|
|SUMTER HIGH 2                      |DEM   |               375|         876|  42.8082192|
|SUMTER HIGH 2                      |REP   |               477|         876|  54.4520548|
|Sun City                           |DEM   |               535|        1721|  31.0865776|
|Sun City                           |REP   |              1152|        1721|  66.9378268|
|SUN CITY 1                         |DEM   |               275|        1006|  27.3359841|
|SUN CITY 1                         |REP   |               691|        1006|  68.6878728|
|SUN CITY 2                         |DEM   |               216|         673|  32.0950966|
|SUN CITY 2                         |REP   |               433|         673|  64.3387816|
|SUN CITY 3                         |DEM   |               332|        1031|  32.2017459|
|SUN CITY 3                         |REP   |               671|        1031|  65.0824442|
|SUN CITY 4                         |DEM   |               267|         814|  32.8009828|
|SUN CITY 4                         |REP   |               527|         814|  64.7420147|
|SUN CITY 5                         |DEM   |               234|         824|  28.3980583|
|SUN CITY 5                         |REP   |               573|         824|  69.5388350|
|SUN CITY 6                         |DEM   |               227|         783|  28.9910600|
|SUN CITY 6                         |REP   |               529|         783|  67.5606641|
|SUN CITY 7                         |DEM   |               232|         748|  31.0160428|
|SUN CITY 7                         |REP   |               488|         748|  65.2406417|
|SUN CITY 8                         |DEM   |               316|         966|  32.7122153|
|SUN CITY 8                         |REP   |               609|         966|  63.0434783|
|SUNSET                             |DEM   |               445|         969|  45.9236326|
|SUNSET                             |REP   |               485|         969|  50.0515996|
|SURFSIDE #1                        |DEM   |               504|        1910|  26.3874346|
|SURFSIDE #1                        |REP   |              1318|        1910|  69.0052356|
|SURFSIDE #2                        |DEM   |               222|         930|  23.8709677|
|SURFSIDE #2                        |REP   |               693|         930|  74.5161290|
|SURFSIDE #3                        |DEM   |               480|        2110|  22.7488152|
|SURFSIDE #3                        |REP   |              1553|        2110|  73.6018957|
|SURFSIDE #4                        |DEM   |               493|        2057|  23.9669421|
|SURFSIDE #4                        |REP   |              1477|        2057|  71.8035975|
|SUTTONS                            |DEM   |                89|         259|  34.3629344|
|SUTTONS                            |REP   |               167|         259|  64.4787645|
|SWAN LAKE                          |DEM   |               267|         714|  37.3949580|
|SWAN LAKE                          |REP   |               411|         714|  57.5630252|
|Swansea #1                         |DEM   |               517|        1109|  46.6185753|
|Swansea #1                         |REP   |               553|        1109|  49.8647430|
|Swansea #2                         |DEM   |               483|        1195|  40.4184100|
|Swansea #2                         |REP   |               669|        1195|  55.9832636|
|SWEET HOME                         |DEM   |               476|         966|  49.2753623|
|SWEET HOME                         |REP   |               452|         966|  46.7908903|
|SWIFT CREEK                        |DEM   |               273|         765|  35.6862745|
|SWIFT CREEK                        |REP   |               473|         765|  61.8300654|
|Swofford Career Center             |DEM   |               340|        2194|  15.4968095|
|Swofford Career Center             |REP   |              1766|        2194|  80.4922516|
|SYCAMORE                           |DEM   |               500|        2175|  22.9885057|
|SYCAMORE                           |REP   |              1570|        2175|  72.1839080|
|Tabernacle                         |DEM   |               281|         599|  46.9115192|
|Tabernacle                         |REP   |               289|         599|  48.2470785|
|Talatha                            |DEM   |               496|        1323|  37.4905518|
|Talatha                            |REP   |               784|        1323|  59.2592593|
|Tamassee                           |DEM   |               171|        1130|  15.1327434|
|Tamassee                           |REP   |               919|        1130|  81.3274336|
|TANGLEWOOD                         |DEM   |              1003|        1927|  52.0498184|
|TANGLEWOOD                         |REP   |               851|        1927|  44.1619097|
|TANS BAY                           |DEM   |               440|        1092|  40.2930403|
|TANS BAY                           |REP   |               619|        1092|  56.6849817|
|TATUM                              |DEM   |               137|         280|  48.9285714|
|TATUM                              |REP   |               132|         280|  47.1428571|
|TAYLORS                            |DEM   |               831|        1952|  42.5717213|
|TAYLORS                            |REP   |               989|        1952|  50.6659836|
|TAYLORSVILLE                       |DEM   |                22|         297|   7.4074074|
|TAYLORSVILLE                       |REP   |               270|         297|  90.9090909|
|Tega Cay                           |DEM   |               366|        1151|  31.7984361|
|Tega Cay                           |REP   |               710|        1151|  61.6854909|
|TEMPERANCE                         |DEM   |               588|         863|  68.1344148|
|TEMPERANCE                         |REP   |               255|         863|  29.5480881|
|The Lodge                          |DEM   |               640|        2181|  29.3443375|
|The Lodge                          |REP   |              1468|        2181|  67.3085740|
|The Village                        |DEM   |               449|        1837|  24.4420250|
|The Village                        |REP   |              1278|        1837|  69.5699510|
|THOMAS SUMTER                      |DEM   |               524|         735|  71.2925170|
|THOMAS SUMTER                      |REP   |               196|         735|  26.6666667|
|THORNBLADE                         |DEM   |               762|        2448|  31.1274510|
|THORNBLADE                         |REP   |              1573|        2448|  64.2565359|
|Three and Twenty                   |DEM   |               275|        2117|  12.9900803|
|Three and Twenty                   |REP   |              1767|        2117|  83.4671705|
|TIGERVILLE                         |DEM   |               315|        2138|  14.7333957|
|TIGERVILLE                         |REP   |              1713|        2138|  80.1216090|
|Tillman                            |DEM   |               262|         457|  57.3304158|
|Tillman                            |REP   |               168|         457|  36.7614880|
|TILLY SWAMP                        |DEM   |               246|        1201|  20.4829309|
|TILLY SWAMP                        |REP   |               911|        1201|  75.8534555|
|Timber Ridge                       |DEM   |                91|         789|  11.5335868|
|Timber Ridge                       |REP   |               672|         789|  85.1711027|
|TIMBERLAKE                         |DEM   |               540|        1873|  28.8307528|
|TIMBERLAKE                         |REP   |              1166|        1873|  62.2530699|
|TIMMONSVILLE NO. 1                 |DEM   |              1032|        1263|  81.7102138|
|TIMMONSVILLE NO. 1                 |REP   |               198|        1263|  15.6769596|
|TIMMONSVILLE NO. 2                 |DEM   |               444|         897|  49.4983278|
|TIMMONSVILLE NO. 2                 |REP   |               432|         897|  48.1605351|
|Tirzah                             |DEM   |               294|        1514|  19.4187583|
|Tirzah                             |REP   |              1164|        1514|  76.8824306|
|TODDVILLE                          |DEM   |               327|        1168|  27.9965753|
|TODDVILLE                          |REP   |               787|        1168|  67.3801370|
|Tokeena-Providence                 |DEM   |               155|        1044|  14.8467433|
|Tokeena-Providence                 |REP   |               841|        1044|  80.5555556|
|Toney Creek                        |DEM   |                65|         465|  13.9784946|
|Toney Creek                        |REP   |               382|         465|  82.1505376|
|Tools Fork                         |DEM   |               390|        1187|  32.8559393|
|Tools Fork                         |REP   |               757|        1187|  63.7742207|
|Town Creek                         |DEM   |               206|        1050|  19.6190476|
|Town Creek                         |REP   |               799|        1050|  76.0952381|
|TOWN OF SEABROOK                   |DEM   |               607|        1617|  37.5386518|
|TOWN OF SEABROOK                   |REP   |               922|        1617|  57.0191713|
|Townville                          |DEM   |                97|         636|  15.2515723|
|Townville                          |REP   |               516|         636|  81.1320755|
|TRADE                              |DEM   |               739|        1795|  41.1699164|
|TRADE                              |REP   |               942|        1795|  52.4791086|
|Tramway                            |DEM   |               483|        1422|  33.9662447|
|Tramway                            |REP   |               848|        1422|  59.6343179|
|Tranquil                           |DEM   |               110|         434|  25.3456221|
|Tranquil                           |REP   |               301|         434|  69.3548387|
|Tranquil 2                         |DEM   |               423|         976|  43.3401639|
|Tranquil 2                         |REP   |               474|         976|  48.5655738|
|Tranquil 3                         |DEM   |               433|         920|  47.0652174|
|Tranquil 3                         |REP   |               413|         920|  44.8913043|
|TRAVELERS REST 1                   |DEM   |               581|        2051|  28.3276451|
|TRAVELERS REST 1                   |REP   |              1329|        2051|  64.7976597|
|TRAVELERS REST 2                   |DEM   |               316|        1419|  22.2692037|
|TRAVELERS REST 2                   |REP   |              1021|        1419|  71.9520789|
|Travelers Rest Baptist             |DEM   |               943|        2226|  42.3629829|
|Travelers Rest Baptist             |REP   |              1174|        2226|  52.7403414|
|Trenholm Road                      |DEM   |               282|         754|  37.4005305|
|Trenholm Road                      |REP   |               428|         754|  56.7639257|
|Trenton No.1                       |DEM   |               436|         905|  48.1767956|
|Trenton No.1                       |REP   |               442|         905|  48.8397790|
|Trenton No.2                       |DEM   |               819|        1372|  59.6938776|
|Trenton No.2                       |REP   |               512|        1372|  37.3177843|
|Tri County                         |DEM   |               110|         478|  23.0125523|
|Tri County                         |REP   |               343|         478|  71.7573222|
|Trinity                            |DEM   |               555|         859|  64.6100116|
|Trinity                            |REP   |               277|         859|  32.2467986|
|Trinity Methodist                  |DEM   |               402|        1112|  36.1510791|
|Trinity Methodist                  |REP   |               624|        1112|  56.1151079|
|TRINITY RIDGE                      |DEM   |               353|         997|  35.4062187|
|TRINITY RIDGE                      |REP   |               602|         997|  60.3811434|
|TRIO                               |DEM   |               655|         739|  88.6332882|
|TRIO                               |REP   |                73|         739|   9.8782138|
|Trolley                            |DEM   |               393|         840|  46.7857143|
|Trolley                            |REP   |               384|         840|  45.7142857|
|Troy                               |DEM   |                42|         131|  32.0610687|
|Troy                               |REP   |                86|         131|  65.6488550|
|TUBBS MOUNTAIN                     |DEM   |               310|        2037|  15.2184585|
|TUBBS MOUNTAIN                     |REP   |              1628|        2037|  79.9214531|
|Tupperway                          |DEM   |               173|         590|  29.3220339|
|Tupperway                          |REP   |               379|         590|  64.2372881|
|Tupperway 2                        |DEM   |               243|         613|  39.6411093|
|Tupperway 2                        |REP   |               332|         613|  54.1598695|
|Turbeville                         |DEM   |               260|         920|  28.2608696|
|Turbeville                         |REP   |               651|         920|  70.7608696|
|TURKEY CREEK                       |DEM   |               576|        1110|  51.8918919|
|TURKEY CREEK                       |REP   |               505|        1110|  45.4954955|
|TYGER RIVER                        |DEM   |               408|        1144|  35.6643357|
|TYGER RIVER                        |REP   |               675|        1144|  59.0034965|
|ULMER                              |DEM   |                79|         189|  41.7989418|
|ULMER                              |REP   |               105|         189|  55.5555556|
|UNION WARD 1 BOX 1                 |DEM   |               234|         467|  50.1070664|
|UNION WARD 1 BOX 1                 |REP   |               222|         467|  47.5374732|
|UNION WARD 1 BOX 2                 |DEM   |               562|         832|  67.5480769|
|UNION WARD 1 BOX 2                 |REP   |               237|         832|  28.4855769|
|UNION WARD 2                       |DEM   |               500|         687|  72.7802038|
|UNION WARD 2                       |REP   |               176|         687|  25.6186317|
|UNION WARD 3                       |DEM   |               368|         505|  72.8712871|
|UNION WARD 3                       |REP   |               113|         505|  22.3762376|
|UNION WARD 4 BOX 1                 |DEM   |               184|         490|  37.5510204|
|UNION WARD 4 BOX 1                 |REP   |               285|         490|  58.1632653|
|UNION WARD 4 BOX 2                 |DEM   |               186|         245|  75.9183673|
|UNION WARD 4 BOX 2                 |REP   |                51|         245|  20.8163265|
|Unity                              |DEM   |               228|         923|  24.7020585|
|Unity                              |REP   |               674|         923|  73.0227519|
|University                         |DEM   |               836|        2310|  36.1904762|
|University                         |REP   |              1281|        2310|  55.4545455|
|Utica                              |DEM   |               230|         539|  42.6716141|
|Utica                              |REP   |               274|         539|  50.8348794|
|Valhalla                           |DEM   |               809|        1581|  51.1701455|
|Valhalla                           |REP   |               678|        1581|  42.8842505|
|Valley State Park                  |DEM   |              1560|        1880|  82.9787234|
|Valley State Park                  |REP   |               248|        1880|  13.1914894|
|Van Wyck                           |DEM   |               245|         709|  34.5557123|
|Van Wyck                           |REP   |               443|         709|  62.4823695|
|VANCE                              |DEM   |               896|        1173|  76.3853367|
|VANCE                              |REP   |               258|        1173|  21.9948849|
|Varennes                           |DEM   |               373|         898|  41.5367483|
|Varennes                           |REP   |               485|         898|  54.0089087|
|Varnville                          |DEM   |               882|        1371|  64.3326039|
|Varnville                          |REP   |               458|        1371|  33.4062728|
|Vaucluse                           |DEM   |               405|        1227|  33.0073350|
|Vaucluse                           |REP   |               762|        1227|  62.1026895|
|Verdery                            |DEM   |               473|        1025|  46.1463415|
|Verdery                            |REP   |               506|        1025|  49.3658537|
|VERDMONT                           |DEM   |               642|        1908|  33.6477987|
|VERDMONT                           |REP   |              1190|        1908|  62.3689727|
|Victor Mill Methodist              |DEM   |               537|        1452|  36.9834711|
|Victor Mill Methodist              |REP   |               828|        1452|  57.0247934|
|Vinland                            |DEM   |               107|        1009|  10.6045590|
|Vinland                            |REP   |               878|        1009|  87.0168484|
|VOX                                |DEM   |               117|         579|  20.2072539|
|VOX                                |REP   |               437|         579|  75.4749568|
|W BENNETTSVILLE                    |DEM   |               492|         689|  71.4078374|
|W BENNETTSVILLE                    |REP   |               181|         689|  26.2699565|
|W Columbia No 1                    |DEM   |               256|         526|  48.6692015|
|W Columbia No 1                    |REP   |               227|         526|  43.1558935|
|W Columbia No 2                    |DEM   |               534|         645|  82.7906977|
|W Columbia No 2                    |REP   |                94|         645|  14.5736434|
|W Columbia No 3                    |DEM   |               153|         522|  29.3103448|
|W Columbia No 3                    |REP   |               328|         522|  62.8352490|
|W Columbia No 4                    |DEM   |               455|        1216|  37.4177632|
|W Columbia No 4                    |REP   |               679|        1216|  55.8388158|
|WADE HAMPTON                       |DEM   |               526|        1719|  30.5991856|
|WADE HAMPTON                       |REP   |              1068|        1719|  62.1291449|
|WADMALAW ISLAND 1                  |DEM   |               452|         843|  53.6180308|
|WADMALAW ISLAND 1                  |REP   |               351|         843|  41.6370107|
|WADMALAW ISLAND 2                  |DEM   |               615|         909|  67.6567657|
|WADMALAW ISLAND 2                  |REP   |               258|         909|  28.3828383|
|Wagener                            |DEM   |               758|        1663|  45.5802766|
|Wagener                            |REP   |               836|        1663|  50.2705953|
|Walden                             |DEM   |               624|         740|  84.3243243|
|Walden                             |REP   |                78|         740|  10.5405405|
|Walhalla 1                         |DEM   |               388|        2071|  18.7349107|
|Walhalla 1                         |REP   |              1562|        2071|  75.4225012|
|Walhalla 2                         |DEM   |               337|        1661|  20.2889825|
|Walhalla 2                         |REP   |              1242|        1661|  74.7742324|
|WALLACE                            |DEM   |               450|         964|  46.6804979|
|WALLACE                            |REP   |               479|         964|  49.6887967|
|WALNUT SPRINGS                     |DEM   |              1047|        3961|  26.4327190|
|WALNUT SPRINGS                     |REP   |              2686|        3961|  67.8111588|
|WALTERBORO NO. 1                   |DEM   |               289|         617|  46.8395462|
|WALTERBORO NO. 1                   |REP   |               304|         617|  49.2706645|
|WALTERBORO NO. 2                   |DEM   |               395|         641|  61.6224649|
|WALTERBORO NO. 2                   |REP   |               213|         641|  33.2293292|
|WALTERBORO NO. 3                   |DEM   |               699|         822|  85.0364964|
|WALTERBORO NO. 3                   |REP   |               103|         822|  12.5304136|
|WALTERBORO NO. 4                   |DEM   |               272|         737|  36.9063772|
|WALTERBORO NO. 4                   |REP   |               425|         737|  57.6662144|
|WALTERBORO NO. 5                   |DEM   |               184|         662|  27.7945619|
|WALTERBORO NO. 5                   |REP   |               450|         662|  67.9758308|
|WALTERBORO NO. 6                   |DEM   |               330|         650|  50.7692308|
|WALTERBORO NO. 6                   |REP   |               291|         650|  44.7692308|
|WAMPEE                             |DEM   |              1064|        1675|  63.5223881|
|WAMPEE                             |REP   |               557|        1675|  33.2537313|
|Ward                               |DEM   |               518|        1289|  40.1861908|
|Ward                               |REP   |               726|        1289|  56.3227308|
|WARD                               |DEM   |               220|         419|  52.5059666|
|WARD                               |REP   |               188|         419|  44.8687351|
|Ward 1                             |DEM   |               433|         729|  59.3964335|
|Ward 1                             |REP   |               235|         729|  32.2359396|
|Ward 10                            |DEM   |               544|         935|  58.1818182|
|Ward 10                            |REP   |               317|         935|  33.9037433|
|Ward 11                            |DEM   |               600|         902|  66.5188470|
|Ward 11                            |REP   |               221|         902|  24.5011086|
|Ward 12                            |DEM   |               572|         960|  59.5833333|
|Ward 12                            |REP   |               306|         960|  31.8750000|
|Ward 13                            |DEM   |               842|        1380|  61.0144928|
|Ward 13                            |REP   |               430|        1380|  31.1594203|
|Ward 14                            |DEM   |               618|        1081|  57.1692877|
|Ward 14                            |REP   |               375|        1081|  34.6901018|
|Ward 15                            |DEM   |               346|         732|  47.2677596|
|Ward 15                            |REP   |               319|         732|  43.5792350|
|Ward 16                            |DEM   |               340|         876|  38.8127854|
|Ward 16                            |REP   |               490|         876|  55.9360731|
|Ward 17                            |DEM   |               472|        1059|  44.5703494|
|Ward 17                            |REP   |               508|        1059|  47.9697828|
|Ward 18                            |DEM   |               868|        1008|  86.1111111|
|Ward 18                            |REP   |               105|        1008|  10.4166667|
|Ward 19                            |DEM   |              1014|        1042|  97.3128599|
|Ward 19                            |REP   |                12|        1042|   1.1516315|
|Ward 2                             |DEM   |               416|         514|  80.9338521|
|Ward 2                             |REP   |                84|         514|  16.3424125|
|Ward 20                            |DEM   |              1043|        1332|  78.3033033|
|Ward 20                            |REP   |               207|        1332|  15.5405405|
|Ward 21                            |DEM   |              1220|        1279|  95.3870211|
|Ward 21                            |REP   |                28|        1279|   2.1892103|
|Ward 22                            |DEM   |              1188|        1266|  93.8388626|
|Ward 22                            |REP   |                40|        1266|   3.1595577|
|Ward 23                            |DEM   |               435|         719|  60.5006954|
|Ward 23                            |REP   |               230|         719|  31.9888734|
|Ward 24                            |DEM   |               263|         714|  36.8347339|
|Ward 24                            |REP   |               391|         714|  54.7619048|
|Ward 25                            |DEM   |               341|        1158|  29.4473230|
|Ward 25                            |REP   |               734|        1158|  63.3851468|
|Ward 26                            |DEM   |               652|        1048|  62.2137405|
|Ward 26                            |REP   |               309|        1048|  29.4847328|
|Ward 29                            |DEM   |               956|        1041|  91.8347743|
|Ward 29                            |REP   |                47|        1041|   4.5148895|
|Ward 3                             |DEM   |               746|        1126|  66.2522202|
|Ward 3                             |REP   |               284|        1126|  25.2220249|
|Ward 30                            |DEM   |               385|         617|  62.3987034|
|Ward 30                            |REP   |               180|         617|  29.1734198|
|Ward 31                            |DEM   |               689|         724|  95.1657459|
|Ward 31                            |REP   |                17|         724|   2.3480663|
|Ward 32                            |DEM   |               703|         728|  96.5659341|
|Ward 32                            |REP   |                10|         728|   1.3736264|
|Ward 33                            |DEM   |               550|         726|  75.7575758|
|Ward 33                            |REP   |               121|         726|  16.6666667|
|Ward 34                            |DEM   |               436|         761|  57.2930355|
|Ward 34                            |REP   |               281|         761|  36.9250986|
|Ward 4                             |DEM   |               631|         973|  64.8509764|
|Ward 4                             |REP   |               244|         973|  25.0770812|
|Ward 5                             |DEM   |               368|         696|  52.8735632|
|Ward 5                             |REP   |               269|         696|  38.6494253|
|Ward 6                             |DEM   |               547|         979|  55.8733401|
|Ward 6                             |REP   |               355|         979|  36.2614913|
|Ward 7                             |DEM   |               838|         864|  96.9907407|
|Ward 7                             |REP   |                 8|         864|   0.9259259|
|Ward 8                             |DEM   |               728|         754|  96.5517241|
|Ward 8                             |REP   |                13|         754|   1.7241379|
|Ward 9                             |DEM   |               677|         717|  94.4211994|
|Ward 9                             |REP   |                20|         717|   2.7894003|
|WARE PLACE                         |DEM   |               390|        1892|  20.6131078|
|WARE PLACE                         |REP   |              1429|        1892|  75.5285412|
|Ware Shoals                        |DEM   |               221|         493|  44.8275862|
|Ware Shoals                        |REP   |               241|         493|  48.8843813|
|Warrenville                        |DEM   |               304|        1363|  22.3037417|
|Warrenville                        |REP   |              1011|        1363|  74.1746148|
|Wassamassaw 1                      |DEM   |               332|         620|  53.5483871|
|Wassamassaw 1                      |REP   |               267|         620|  43.0645161|
|Wassamassaw 2                      |DEM   |               645|        1982|  32.5428860|
|Wassamassaw 2                      |REP   |              1247|        1982|  62.9162462|
|WATERLOO                           |DEM   |               391|        1251|  31.2549960|
|WATERLOO                           |REP   |               818|        1251|  65.3876898|
|Waterstone                         |DEM   |               619|        1632|  37.9289216|
|Waterstone                         |REP   |               903|        1632|  55.3308824|
|WATTSVILLE                         |DEM   |               246|         944|  26.0593220|
|WATTSVILLE                         |REP   |               641|         944|  67.9025424|
|Weatherstone                       |DEM   |               486|        1218|  39.9014778|
|Weatherstone                       |REP   |               645|        1218|  52.9556650|
|Webber                             |DEM   |               601|         875|  68.6857143|
|Webber                             |REP   |               229|         875|  26.1714286|
|WELCOME                            |DEM   |               968|        1674|  57.8255675|
|WELCOME                            |REP   |               625|        1674|  37.3357228|
|Wellford Fire Station              |DEM   |               709|        1718|  41.2689173|
|Wellford Fire Station              |REP   |               930|        1718|  54.1327125|
|WELLINGTON                         |DEM   |               297|        1240|  23.9516129|
|WELLINGTON                         |REP   |               880|        1240|  70.9677419|
|West Central                       |DEM   |               257|         630|  40.7936508|
|West Central                       |REP   |               282|         630|  44.7619048|
|WEST CONWAY                        |DEM   |               235|         499|  47.0941884|
|WEST CONWAY                        |REP   |               248|         499|  49.6993988|
|WEST DENMARK                       |DEM   |              1035|        1176|  88.0102041|
|WEST DENMARK                       |REP   |               126|        1176|  10.7142857|
|WEST DILLON                        |DEM   |              1033|        1306|  79.0964778|
|WEST DILLON                        |REP   |               216|        1306|  16.5390505|
|WEST FLORENCE NO. 1                |DEM   |               651|        1928|  33.7655602|
|WEST FLORENCE NO. 1                |REP   |              1193|        1928|  61.8775934|
|WEST FLORENCE NO. 2                |DEM   |               318|         886|  35.8916479|
|WEST FLORENCE NO. 2                |REP   |               533|         886|  60.1580135|
|West Liberty                       |DEM   |               109|        1078|  10.1113173|
|West Liberty                       |REP   |               913|        1078|  84.6938776|
|WEST LORIS                         |DEM   |               579|         795|  72.8301887|
|WEST LORIS                         |REP   |               196|         795|  24.6540881|
|West Pelzer                        |DEM   |               210|        1475|  14.2372881|
|West Pelzer                        |REP   |              1221|        1475|  82.7796610|
|West Pickens                       |DEM   |               164|        1105|  14.8416290|
|West Pickens                       |REP   |               898|        1105|  81.2669683|
|West Savannah                      |DEM   |                85|         288|  29.5138889|
|West Savannah                      |REP   |               195|         288|  67.7083333|
|WEST SPRINGS                       |DEM   |                94|         277|  33.9350181|
|WEST SPRINGS                       |REP   |               174|         277|  62.8158845|
|West Union                         |DEM   |               229|        1285|  17.8210117|
|West Union                         |REP   |               996|        1285|  77.5097276|
|West View Elementary               |DEM   |               921|        2881|  31.9680666|
|West View Elementary               |REP   |              1809|        2881|  62.7906977|
|WESTCLIFFE                         |DEM   |               530|        1470|  36.0544218|
|WESTCLIFFE                         |REP   |               873|        1470|  59.3877551|
|Westminster                        |DEM   |               968|        1212|  79.8679868|
|Westminster                        |REP   |               179|        1212|  14.7689769|
|Westminster 1                      |DEM   |               311|        2079|  14.9591150|
|Westminster 1                      |REP   |              1683|        2079|  80.9523810|
|Westminster 2                      |DEM   |               176|        1214|  14.4975288|
|Westminster 2                      |REP   |               987|        1214|  81.3014827|
|Westover                           |DEM   |               320|        1189|  26.9133726|
|Westover                           |REP   |               786|        1189|  66.1059714|
|Westside                           |DEM   |                56|         718|   7.7994429|
|Westside                           |REP   |               645|         718|  89.8328691|
|WESTSIDE                           |DEM   |               701|        1774|  39.5152198|
|WESTSIDE                           |REP   |               999|        1774|  56.3134160|
|Westview 1                         |DEM   |               273|        1161|  23.5142119|
|Westview 1                         |REP   |               823|        1161|  70.8871662|
|Westview 2                         |DEM   |               459|        1506|  30.4780876|
|Westview 2                         |REP   |               955|        1506|  63.4130146|
|Westview 3                         |DEM   |               330|        1274|  25.9026688|
|Westview 3                         |REP   |               863|        1274|  67.7394035|
|Westview 4                         |DEM   |               356|        1219|  29.2042658|
|Westview 4                         |REP   |               785|        1219|  64.3970468|
|Westville                          |DEM   |               337|        1221|  27.6003276|
|Westville                          |REP   |               835|        1221|  68.3865684|
|WHEELAND                           |DEM   |                57|         384|  14.8437500|
|WHEELAND                           |REP   |               302|         384|  78.6458333|
|White Knoll                        |DEM   |               415|        1736|  23.9055300|
|White Knoll                        |REP   |              1206|        1736|  69.4700461|
|WHITE OAK                          |DEM   |               225|         842|  26.7220903|
|WHITE OAK                          |REP   |               582|         842|  69.1211401|
|White Plains                       |DEM   |               594|        3696|  16.0714286|
|White Plains                       |REP   |              2943|        3696|  79.6266234|
|White Pond                         |DEM   |               358|         754|  47.4801061|
|White Pond                         |REP   |               378|         754|  50.1326260|
|White Stone Methodist              |DEM   |               300|         758|  39.5778364|
|White Stone Methodist              |REP   |               434|         758|  57.2559367|
|Whitehall                          |DEM   |               669|        1649|  40.5700424|
|Whitehall                          |REP   |               868|        1649|  52.6379624|
|Whites Gardens                     |DEM   |               424|        1288|  32.9192547|
|Whites Gardens                     |REP   |               824|        1288|  63.9751553|
|Whitesville 1                      |DEM   |               717|        1803|  39.7670549|
|Whitesville 1                      |REP   |               984|        1803|  54.5757072|
|Whitesville 2                      |DEM   |               254|        1115|  22.7802691|
|Whitesville 2                      |REP   |               819|        1115|  73.4529148|
|Whitewell                          |DEM   |              1140|        1324|  86.1027190|
|Whitewell                          |REP   |               122|        1324|   9.2145015|
|Whitlock Jr. High                  |DEM   |               330|        1064|  31.0150376|
|Whitlock Jr. High                  |REP   |               682|        1064|  64.0977444|
|WHITMIRE CITY                      |DEM   |               202|         628|  32.1656051|
|WHITMIRE CITY                      |REP   |               403|         628|  64.1719745|
|WHITMIRE OUTSIDE                   |DEM   |               231|         664|  34.7891566|
|WHITMIRE OUTSIDE                   |REP   |               405|         664|  60.9939759|
|WHITTAKER                          |DEM   |               799|         886|  90.1805869|
|WHITTAKER                          |REP   |                78|         886|   8.8036117|
|WILD WING                          |DEM   |               629|        2340|  26.8803419|
|WILD WING                          |REP   |              1617|        2340|  69.1025641|
|WILDER                             |DEM   |               643|         703|  91.4651494|
|WILDER                             |REP   |                54|         703|   7.6813656|
|Wildewood                          |DEM   |               710|        1547|  45.8952812|
|Wildewood                          |REP   |               742|        1547|  47.9638009|
|Wilkinsville and Metcalf           |DEM   |                20|         477|   4.1928721|
|Wilkinsville and Metcalf           |REP   |               440|         477|  92.2431866|
|Wilksburg                          |DEM   |               217|         403|  53.8461538|
|Wilksburg                          |REP   |               180|         403|  44.6650124|
|WILLIAMS                           |DEM   |               127|         256|  49.6093750|
|WILLIAMS                           |REP   |               125|         256|  48.8281250|
|Williamston                        |DEM   |               380|        1782|  21.3243547|
|Williamston                        |REP   |              1314|        1782|  73.7373737|
|Williamston Mill                   |DEM   |               334|        2127|  15.7028679|
|Williamston Mill                   |REP   |              1717|        2127|  80.7240244|
|Willington                         |DEM   |                93|         159|  58.4905660|
|Willington                         |REP   |                65|         159|  40.8805031|
|WILLISTON 1                        |DEM   |               800|        1201|  66.6111574|
|WILLISTON 1                        |REP   |               379|        1201|  31.5570358|
|WILLISTON 2                        |DEM   |               168|         497|  33.8028169|
|WILLISTON 2                        |REP   |               316|         497|  63.5814889|
|WILLISTON 3                        |DEM   |               296|         758|  39.0501319|
|WILLISTON 3                        |REP   |               437|         758|  57.6517150|
|Willow Springs                     |DEM   |               214|        1049|  20.4003813|
|Willow Springs                     |REP   |               800|        1049|  76.2631077|
|Wilson Foreston                    |DEM   |               510|         835|  61.0778443|
|Wilson Foreston                    |REP   |               306|         835|  36.6467066|
|WILSON HALL                        |DEM   |               161|         994|  16.1971831|
|WILSON HALL                        |REP   |               792|         994|  79.6780684|
|Windjammer                         |DEM   |               529|        1644|  32.1776156|
|Windjammer                         |REP   |              1018|        1644|  61.9221411|
|Windsor                            |DEM   |               337|         754|  44.6949602|
|Windsor                            |REP   |               373|         754|  49.4694960|
|Windsor 2                          |DEM   |               372|         618|  60.1941748|
|Windsor 2                          |REP   |               209|         618|  33.8187702|
|Windsor No. 43                     |DEM   |               282|         859|  32.8288708|
|Windsor No. 43                     |REP   |               532|         859|  61.9324796|
|Windsor No. 82                     |DEM   |               320|         943|  33.9342524|
|Windsor No. 82                     |REP   |               563|         943|  59.7030753|
|WINDY HILL #1                      |DEM   |               300|        1107|  27.1002710|
|WINDY HILL #1                      |REP   |               770|        1107|  69.5573622|
|WINDY HILL #2                      |DEM   |               436|        2016|  21.6269841|
|WINDY HILL #2                      |REP   |              1547|        2016|  76.7361111|
|WINNSBORO MILLS                    |DEM   |               305|         527|  57.8747628|
|WINNSBORO MILLS                    |REP   |               191|         527|  36.2428843|
|WINNSBORO NO. 1                    |DEM   |               694|         917|  75.6815703|
|WINNSBORO NO. 1                    |REP   |               181|         917|  19.7382770|
|WINNSBORO NO. 2                    |DEM   |               447|         760|  58.8157895|
|WINNSBORO NO. 2                    |REP   |               283|         760|  37.2368421|
|WINYAH BAY                         |DEM   |               149|         582|  25.6013746|
|WINYAH BAY                         |REP   |               419|         582|  71.9931271|
|WOLF CREEK                         |DEM   |                38|         290|  13.1034483|
|WOLF CREEK                         |REP   |               246|         290|  84.8275862|
|WOODARD                            |DEM   |               106|         127|  83.4645669|
|WOODARD                            |REP   |                20|         127|  15.7480315|
|Woodfield                          |DEM   |              1287|        1783|  72.1817162|
|Woodfield                          |REP   |               421|        1783|  23.6118901|
|Woodland Heights Recreation Center |DEM   |               785|        1366|  57.4670571|
|Woodland Heights Recreation Center |REP   |               509|        1366|  37.2620791|
|Woodland Hills                     |DEM   |               704|        1176|  59.8639456|
|Woodland Hills                     |REP   |               387|        1176|  32.9081633|
|Woodlands                          |DEM   |               499|        1437|  34.7251218|
|Woodlands                          |REP   |               829|        1437|  57.6896312|
|WOODMONT                           |DEM   |              1036|        2093|  49.4983278|
|WOODMONT                           |REP   |               980|        2093|  46.8227425|
|WOODROW                            |DEM   |               127|         167|  76.0479042|
|WOODROW                            |REP   |                36|         167|  21.5568862|
|Woodruff Elementary                |DEM   |               613|        1743|  35.1692484|
|Woodruff Elementary                |REP   |              1054|        1743|  60.4704532|
|Woodruff Fire Station              |DEM   |               171|        1090|  15.6880734|
|Woodruff Fire Station              |REP   |               873|        1090|  80.0917431|
|WOODRUFF LAKES                     |DEM   |               605|        2270|  26.6519824|
|WOODRUFF LAKES                     |REP   |              1556|        2270|  68.5462555|
|Woodruff Leisure Center            |DEM   |               238|         909|  26.1826183|
|Woodruff Leisure Center            |REP   |               630|         909|  69.3069307|
|Woods                              |DEM   |               105|         858|  12.2377622|
|Woods                              |REP   |               724|         858|  84.3822844|
|WOODS                              |DEM   |               375|         559|  67.0840787|
|WOODS                              |REP   |               174|         559|  31.1270125|
|Woodside                           |DEM   |               352|        1175|  29.9574468|
|Woodside                           |REP   |               760|        1175|  64.6808511|
|Wright's School                    |DEM   |                81|         703|  11.5220484|
|Wright's School                    |REP   |               606|         703|  86.2019915|
|Wylie                              |DEM   |               240|         909|  26.4026403|
|Wylie                              |REP   |               621|         909|  68.3168317|
|Yellow House                       |DEM   |               559|        1304|  42.8680982|
|Yellow House                       |REP   |               678|        1304|  51.9938650|
|Yemassee                           |DEM   |               582|         907|  64.1675854|
|Yemassee                           |REP   |               292|         907|  32.1940463|
|York No. 1                         |DEM   |               678|        1193|  56.8315172|
|York No. 1                         |REP   |               472|        1193|  39.5641241|
|York No. 2                         |DEM   |               706|        1659|  42.5557565|
|York No. 2                         |REP   |               871|        1659|  52.5015069|
|YOUNGS                             |DEM   |               143|        1005|  14.2288557|
|YOUNGS                             |REP   |               814|        1005|  80.9950249|
|Zion                               |DEM   |               137|         891|  15.3759820|
|Zion                               |REP   |               716|         891|  80.3591470|
|ZION                               |DEM   |               325|         475|  68.4210526|
|ZION                               |REP   |               142|         475|  29.8947368|
 
So one picky issue is worth mentioning here. This dataset counts absentee ballots as its own precinct (or their own precincts). Part of the joys of blogging is sweeping issues like this under the rug, but this can be the source of interesting analyses in their own right.
 
The final bit of data wrangling I do here is to widen the dataset, so I can merge it easily later on with the shapefile.
 

{% highlight r %}
total_party_votes_wide <- total_party_votes %>% 
  select(-total_party_votes,-total_party_votes) %>% 
  group_by(precinct) %>% 
  spread(key=party,value=party_perc)
knitr::kable(total_party_votes_wide %>% slice(1:10))
{% endhighlight %}



|precinct                           | total_votes|       DEM|         REP|
|:----------------------------------|-----------:|---------:|-----------:|
|Abbeville No. 1                    |        1250| 30.800000|  65.4400000|
|Abbeville No. 2                    |        1054| 59.013283|  38.6148008|
|Abbeville No. 3                    |         744| 46.908602|  50.4032258|
|Abbeville No. 4                    |         611| 35.024550|  62.3567921|
|Abel                               |         731| 57.181942|  32.9685363|
|Abner Creek Baptist                |        1221| 15.888616|  80.2620803|
|Absentee                           |      521425| 50.410510|  47.0255550|
|Absentee 1                         |       56422| 50.271171|  47.2918365|
|ABSENTEE 1                         |       29495| 46.509578|  50.1847771|
|Absentee 2                         |      107903| 55.462777|  42.2045726|
|ABSENTEE 2                         |       16541| 40.299861|  56.6048002|
|Absentee 3                         |       26339| 50.206918|  47.1961730|
|Absentee 4                         |       10693| 44.019452|  53.0440475|
|ADAMSBURG                          |         498| 18.473896|  78.5140562|
|ADAMSVILLE                         |         273| 45.421245|  52.3809524|
|Adnah                              |         667| 27.736132|  67.1664168|
|ADRIAN                             |        1656| 21.557971|  74.3357488|
|AIKEN                              |         721| 57.420250|  37.7253814|
|Aiken No. 1                        |         832| 25.120192|  66.7067308|
|Aiken No. 2                        |         913| 77.546550|  18.9485214|
|Aiken No. 3                        |        1221| 83.210483|  13.2678133|
|Aiken No. 4                        |         525| 86.285714|  10.6666667|
|Aiken No. 47                       |         790| 34.810127|  58.7341772|
|Aiken No. 5                        |         789| 55.006337|  40.4309252|
|Aiken No. 6                        |         917| 27.917121|  65.8669575|
|Airport                            |        2672| 28.368264|  66.5793413|
|Albert R. Lewis                    |         991|  9.889001|  85.3683148|
|Alcolu                             |         606| 53.300330|  44.3894389|
|ALLENDALE #1                       |         543| 77.532228|  19.1528545|
|ALLENDALE #2                       |         549| 95.810565|   2.0036430|
|Allens                             |         859|  9.429569|  86.6123399|
|Allie's Crossing                   |         656| 29.115854|  67.2256098|
|Allison Creek                      |        2188| 23.628885|  71.0694698|
|ALLSBROOK                          |         620| 18.064516|  81.1290323|
|Alma Mill                          |        1201| 54.787677|  42.3813489|
|ALTAMONT FOREST                    |        1147| 21.011334|  73.1473409|
|Alvin                              |         939| 64.856230|  33.1203408|
|Amicks Ferry                       |        2412| 16.542289|  78.9800995|
|Anderson 1/1                       |        1030| 36.893204|  57.3786408|
|Anderson 1/2                       |         937| 24.866595|  71.0779082|
|Anderson 2/1                       |         933| 26.152197|  67.0953912|
|Anderson 2/2                       |        1689| 35.820012|  58.7329781|
|Anderson 3/1                       |         531| 60.828625|  33.1450094|
|Anderson 3/2                       |        1848| 72.186147|  25.3246753|
|Anderson 4/1                       |         524| 80.343512|  15.4580153|
|Anderson 4/2                       |         581| 90.017212|   7.7452668|
|Anderson 5/A                       |         539| 74.025974|  22.0779221|
|Anderson 5/B                       |         915| 82.732240|  15.0819672|
|Anderson 6/1                       |        1229| 33.685924|  58.9910496|
|Anderson 6/2                       |         316| 86.075949|  10.4430380|
|Anderson Mill Elementary           |        2737| 37.559372|  56.4486664|
|Anderson Pond No. 69               |        1160| 21.637931|  73.5344828|
|Anderson Road                      |        2386| 52.221291|  41.4082146|
|ANDREWS                            |        1270| 75.826772|  21.8110236|
|ANDREWS OUTSIDE                    |        1047| 56.542502|  41.6427889|
|ANGELUS-CARARRH                    |         565| 36.637168|  60.7079646|
|Antioch                            |        1375| 23.418182|  73.3090909|
|ANTIOCH                            |        1509| 45.725646|  51.6898608|
|Antioch and Kings Creek            |        1158| 10.621762|  84.4559585|
|Antreville                         |         904| 19.690265|  78.0973451|
|Appleton-Equinox                   |         566| 50.706714|  43.9929329|
|Arcadia                            |        1005| 54.228856|  38.3084577|
|Arcadia Elementary                 |         675| 50.074074|  43.4074074|
|Archdale                           |         940| 46.063830|  48.5106383|
|Archdale 2                         |        1075| 41.767442|  53.0232558|
|Ardincaple                         |         384| 95.572917|   2.8645833|
|Arial Mill                         |         843| 13.760380|  81.3760380|
|Ascauga Lake No. 63                |         849| 30.742050|  63.8398115|
|Ascauga Lake No. 84                |         925| 25.405405|  71.2432432|
|Ashborough East                    |         714| 44.537815|  48.7394958|
|Ashborough East 2                  |         703| 16.500711|  77.3826458|
|Ashborough West                    |         385| 26.753247|  63.1168831|
|Ashborough West 2                  |         934| 21.092077|  70.7708779|
|ASHETON LAKES                      |        2743| 22.019686|  73.0222384|
|ASHLAND/STOKES BRIDGE              |         459| 28.540305|  67.9738562|
|Ashley River                       |        1768| 42.138009|  51.8665158|
|ASHTON-LODGE                       |         393| 24.936387|  70.9923664|
|ASHWOOD                            |         532| 36.090226|  60.9022556|
|Ashworth                           |         956|  9.309623|  88.0753138|
|ATLANTIC BEACH                     |         136| 83.823529|  16.1764706|
|AUBURN                             |         673| 80.237741|  17.0876672|
|AVON                               |        1389| 27.645788|  66.5946724|
|AWENDAW                            |         990| 57.474747|  40.1010101|
|AYNOR                              |        1328| 16.415663|  81.0993976|
|BACK SWAMP                         |         389| 27.249357|  69.9228792|
|Bacons Bridge                      |        1339| 31.366692|  61.3144137|
|Bacons Bridge 2                    |         438| 31.050228|  63.4703196|
|BAILEY                             |         749| 35.380507|  59.5460614|
|BAKER CREEK                        |        1226| 23.001631|  73.1647635|
|Baldwin Mill                       |         670| 64.029851|  32.8358209|
|Ballentine 1                       |        1010| 31.584158|  60.0000000|
|Ballentine 2                       |        1193| 20.284996|  74.4341995|
|Barker's Creek-McAdams             |         340| 10.882353|  88.5294118|
|BARKSDALE-NARINE                   |         668| 32.185629|  64.3712575|
|BARNWELL 1                         |         487| 54.825462|  42.2997947|
|BARNWELL 2                         |        1097| 38.468551|  58.7055606|
|BARNWELL 3                         |        1218| 42.036125|  53.1198686|
|BARNWELL 4                         |        1011| 64.886251|  32.8387735|
|Barr Road #1                       |        1061| 22.714420|  72.6672950|
|Barr Road #2                       |        2013| 20.317933|  73.0750124|
|Barrineau                          |         480| 10.000000|  89.7916667|
|Barrows Mill                       |         162| 30.864197|  65.4320988|
|BATES                              |         558| 96.953405|   2.1505376|
|Batesburg                          |        1711| 58.912916|  38.2817066|
|Bath                               |         696| 46.408046|  50.1436782|
|Baton Rouge                        |         476| 20.798319|  75.6302521|
|Baxter                             |         971| 33.264676|  58.9083419|
|BAY SPRINGS                        |         314| 17.197452|  78.3439490|
|BAYBORO-GURLEY                     |        1229| 33.197722|  63.6289666|
|Beatty Road                        |         690| 88.260870|   8.4057971|
|BEAUFORT 1                         |         583| 61.578045|  31.9039451|
|BEAUFORT 2                         |         621| 41.867955|  50.5636071|
|BEAUFORT 3                         |         741| 32.388664|  59.3792173|
|Beaumont Methodist                 |         473| 45.665962|  50.3171247|
|Beckhamville                       |         878| 52.050114|  45.5580866|
|Beech Hill                         |         847| 22.904368|  72.6092090|
|Beech Hill 2                       |        1175| 23.148936|  68.7659574|
|Beech Island                       |        1508| 54.111406|  42.3076923|
|Beech Springs Intermediate         |        1633| 29.332517|  64.4825475|
|BELFAIR                            |        1600| 24.875000|  70.6875000|
|BELLE MEADE                        |        1576| 93.591371|   4.4416244|
|BELLS                              |         238| 41.176471|  56.7226891|
|BELLS CROSSING                     |        2584| 25.619195|  67.5309598|
|BELMONT                            |         837| 68.100358|  28.9127838|
|Belton                             |        1364| 25.073314|  71.0410557|
|Belton Annex                       |        1484| 24.865229|  70.6873315|
|Belvedere No. 44                   |        1239| 33.656174|  61.5819209|
|Belvedere No. 62                   |         991| 54.389505|  41.9778002|
|Belvedere No. 74                   |         552| 29.710145|  65.7608696|
|Belvedere No. 9                    |        1424| 46.278090|  48.1741573|
|Ben Avon Methodist                 |         962| 26.403326|  68.1912682|
|BEREA                              |        1277| 48.159749|  46.9068128|
|BEREA-SMOAKS                       |         858| 63.752914|  34.6153846|
|BERMUDA                            |         224| 44.196429|  54.0178571|
|BETH-EDEN                          |         405| 31.111111|  60.4938272|
|Bethany                            |        2054| 24.196689|  71.5189873|
|Bethany Baptist                    |        1024| 64.160156|  30.8593750|
|Bethany Wesleyan                   |        2215| 21.986456|  74.1309255|
|Bethel                             |        1232| 29.545455|  62.6623377|
|BETHEL                             |        2870| 36.341463|  61.0801394|
|Bethel School                      |        1777| 21.609454|  73.3258301|
|Bethera                            |         242|  8.264463|  88.0165289|
|Bethune                            |        1103| 40.072530|  55.6663645|
|Beulah Church                      |        1767| 12.846633|  82.9654782|
|Beverly Hills                      |        1086| 48.434623|  44.1068140|
|Biltmore Pines                     |         861| 30.778165|  64.1114983|
|BIRNIE                             |         758| 93.139842|   3.4300792|
|Bishop's Branch                    |        1677| 22.182469|  73.2259988|
|BISHOPVILLE 1                      |         505| 85.346535|  13.8613861|
|BISHOPVILLE 2                      |         614| 86.156352|  11.0749186|
|BISHOPVILLE 3                      |         597| 60.971524|  35.0083752|
|BISHOPVILLE 4                      |         829| 82.991556|  15.3196622|
|Black Creek                        |         185| 29.189189|  68.1081081|
|BLACK CREEK                        |         307| 38.762215|  58.6319218|
|BLACK CREEK-CLYDE                  |        1099| 25.750682|  71.9745223|
|Black Horse Run                    |        2115| 33.049645|  61.6548463|
|BLACK RIVER                        |        1344| 27.380952|  69.4940476|
|BLACK ROCK                         |         383| 62.402089|  35.2480418|
|Blacksburg Ward No. 1              |         773| 28.201811|  69.7283312|
|Blacksburg Ward No. 2              |        1117| 16.830797|  79.2300806|
|Blackstock                         |         474| 42.194093|  53.5864979|
|BLACKSTOCK                         |          66| 81.818182|  19.6969697|
|BLACKVILLE 1                       |         833| 73.109244|  24.8499400|
|BLACKVILLE 2                       |         532| 71.804511|  25.1879699|
|BLAIRS                             |         501| 88.822355|   9.9800399|
|BLENHEIM                           |         222| 42.342342|  52.7027027|
|BLOOMINGVALE                       |         895| 67.150838|  29.6089385|
|Bloomville                         |         357| 36.134454|  63.3053221|
|Bluff                              |        1542| 95.914397|   2.5940337|
|Bluffton 1A                        |        1040| 43.750000|  48.6538462|
|Bluffton 1B                        |         710| 32.535211|  61.6901408|
|Bluffton 1C                        |        1072| 28.078358|  66.0447761|
|Bluffton 1D                        |         954| 43.501048|  49.6855346|
|Bluffton 2A                        |         711| 38.115330|  56.9620253|
|Bluffton 2B                        |         782| 39.514066|  53.3248082|
|Bluffton 2C                        |        1671| 27.468582|  66.0083782|
|Bluffton 2D                        |        1770| 27.457627|  66.6666667|
|Bluffton 2E                        |         915| 51.693989|  42.2950820|
|Bluffton 3                         |         609| 22.331691|  72.9064039|
|Bluffton 4A                        |         572| 23.076923|  73.7762238|
|Bluffton 4B                        |         947| 27.349525|  68.8489968|
|Bluffton 4C                        |        1259| 37.807784|  56.0762510|
|Bluffton 4D                        |         928| 26.293103|  70.9051724|
|Bluffton 5A                        |         810| 26.419753|  70.9876543|
|Bluffton 5B                        |         712| 35.533708|  58.8483146|
|Blythewood 1                       |        1187| 27.632687|  66.6385847|
|Blythewood 2                       |        1670| 45.089820|  50.4191617|
|Blythewood 3                       |        1608| 49.067164|  46.0199005|
|Boiling Springs                    |        1550| 16.903226|  78.7096774|
|BOILING SPRINGS                    |        1870| 28.449198|  65.1336898|
|Boiling Springs 9th Grade          |        2586| 27.958237|  66.1252900|
|Boiling Springs Elementary         |        2287| 27.896808|  67.5557499|
|Boiling Springs High School        |         934| 23.126338|  72.0556745|
|Boiling Springs Intermediate       |        1963| 32.297504|  63.5761589|
|Boiling Springs South              |        1001| 14.985015|  81.1188811|
|BOLENTOWN                          |        1110| 47.837838|  50.2702703|
|Boling Springs Jr. High            |         754| 16.445623|  78.2493369|
|BONHAM                             |         652| 38.036810|  58.2822086|
|Bonneau                            |        1025| 36.878049|  60.6829268|
|Bonneau Beach                      |        1353| 20.103474|  77.2357724|
|Bonnett                            |         676| 30.473373|  65.3846154|
|Bookman                            |        1927| 57.239232|  36.3258952|
|BOTANY WOODS                       |        1440| 32.638889|  60.1388889|
|Bountyland                         |        1179| 20.780322|  74.3002545|
|Bowling Green                      |        1748| 16.075515|  79.1762014|
|BOWMAN 1                           |        1206| 73.466003|  24.8756219|
|BOWMAN 2                           |         782| 58.695652|  38.3631714|
|Bradley                            |         213| 33.802817|  61.0328638|
|BRANCHVILLE 1                      |         918| 44.771242|  52.3965142|
|BRANCHVILLE 2                      |         432| 36.111111|  60.8796296|
|Brandon 1                          |        1338| 72.272048|  22.7204783|
|Brandon 2                          |        1433| 77.041172|  15.4221912|
|Brandymill                         |         515| 27.184466|  63.4951456|
|Brandymill 2                       |        1015| 34.384237|  58.2266010|
|Breezy Hill                        |        1919| 33.715477|  61.9593538|
|BREWERTON                          |         431|  9.976798|  85.6148492|
|Briarwood                          |        2561| 61.694651|  32.9168294|
|Briarwood 2                        |         715| 34.545454|  60.1398601|
|Briarwood 3                        |         593| 25.295110|  67.1163575|
|Bridge Creek                       |        1403| 75.694939|  20.7412687|
|BRIDGE FORK                        |        1546| 25.485123|  71.0219922|
|BRIGHTSVILLE                       |         512| 51.757812|  45.5078125|
|BRITTON'S NECK                     |        1308| 70.795107|  27.5229358|
|Broadmouth                         |         435| 23.908046|  72.4137931|
|Broadview                          |         556| 66.366906|  31.4748201|
|Broadway                           |        1045| 35.311005|  60.4784689|
|BROCKS MILL                        |        1145| 63.318777|  34.9344978|
|BROOKDALE                          |         909| 96.259626|   2.6402640|
|BROOKGLENN                         |        1120| 32.857143|  60.4464286|
|BROOKGREEN                         |         558| 78.853047|  19.8924731|
|BROOKSVILLE #1                     |        2327| 28.233777|  68.1134508|
|BROOKSVILLE #2                     |         869| 34.982739|  61.4499425|
|BROWN'S FERRY                      |        1589| 82.945249|  15.4185022|
|BROWNSVILLE                        |         275| 30.545455|  68.0000000|
|BROWNWAY                           |        1380| 13.695652|  83.0434783|
|Brunson                            |         976| 55.430328|  41.0860656|
|Brushy Creek                       |        3445| 17.387518|  78.3164006|
|Buffalo                            |         844| 20.142180|  78.0805687|
|BUFFALO BOX 1                      |         638| 22.884013|  70.8463950|
|Bullocks Creek                     |         361| 18.282549|  78.3933518|
|BUNRS-DOWNS                        |         619| 36.025848|  60.7431341|
|BURGESS #1                         |        1823| 25.233132|  71.1464619|
|BURGESS #2                         |        2849| 24.780625|  72.3411723|
|BURGESS #3                         |        2695| 24.415584|  72.0964750|
|BURGESS #4                         |        1625| 24.123077|  72.5538462|
|BURNT BRANCH                       |         584| 32.534247|  64.3835616|
|BURTON 1A                          |        1093| 33.851784|  61.0247027|
|BURTON 1B                          |         749| 75.967957|  19.6261682|
|BURTON 1C                          |         943| 50.901379|  43.2661718|
|BURTON 1D                          |         457| 37.417943|  56.6739606|
|BURTON 2A                          |         980| 31.122449|  63.2653061|
|BURTON 2B                          |        1205| 39.917012|  53.6099585|
|BURTON 2C                          |        1232| 28.327922|  66.9642857|
|BURTON 3                           |         380| 55.789474|  35.7894737|
|Bush River                         |        1265| 42.371541|  50.4347826|
|BUSH RIVER                         |         239| 29.707113|  68.6192469|
|Butternut                          |        1256| 33.439490|  60.1114650|
|C.C. Woodson Recreation            |        1068| 95.692884|   3.0898876|
|CADES                              |         454| 62.114537|  37.2246696|
|Cainhoy                            |         976| 83.401639|  15.2663934|
|Calhoun                            |         737| 48.168250|  41.6553596|
|Calhoun Falls                      |        1538| 59.557867|  38.0364109|
|Callison                           |         787| 22.109276|  74.0787802|
|Calvary                            |         488| 81.557377|  16.5983607|
|Camden No. 1                       |         945| 56.507936|  39.3650794|
|Camden No. 2 & 3                   |         195| 40.512820|  53.3333333|
|Camden No. 5                       |         486| 30.452675|  64.6090535|
|Camden No. 5-A                     |         394| 69.543147|  29.1878173|
|Camden No. 6                       |         270| 37.407407|  56.6666667|
|CAMERON                            |         624| 54.006410|  41.1858974|
|Camp Creek                         |         657| 14.916286|  82.8006088|
|Canaan                             |         876| 31.278539|  64.0410959|
|CANADYS                            |         424| 42.216981|  52.3584906|
|Cane Bay                           |        2995| 29.081803|  64.9749583|
|CANEBRAKE                          |        2471| 27.883448|  66.9364630|
|Cannon Mill                        |         980| 28.469388|  65.1020408|
|Cannons Elementary                 |         799| 32.415519|  63.9549437|
|CARLISLE                           |         497| 90.945674|   7.2434608|
|Carlisle Fosters Grove             |        1513| 14.606742|  81.5598149|
|Carmel                             |         458| 45.851528|  53.2751092|
|Carnes Cross Road 1                |        2075| 12.048193|  83.0361446|
|Carnes Cross Road 2                |         903| 35.991141|  58.8039867|
|Carolina                           |        2220| 40.135135|  54.2342342|
|CAROLINA                           |        1400| 74.642857|  23.1428571|
|CAROLINA BAYS                      |        1545| 24.595469|  71.9741100|
|CAROLINA FOREST #1                 |        2406| 26.641729|  68.7863674|
|CAROLINA FOREST #2                 |        1574| 29.733164|  65.5019060|
|Carolina Heights                   |         982| 68.024440|  27.1894094|
|Carolina Springs                   |        1307| 28.615149|  64.5753634|
|CARTERSVILLE                       |         715| 43.636364|  54.1258741|
|CARVER'S BAY                       |         171| 22.222222|  73.0994152|
|CASH                               |         899| 58.398220|  40.1557286|
|Cassatt                            |        1171| 29.376601|  65.9265585|
|CASTLE ROCK                        |        2287| 16.571928|  79.1867075|
|Catawba                            |        1968| 24.034553|  72.9166667|
|Caughman Road                      |        1230| 72.520325|  24.2276423|
|CAUSEWAY BRANCH 1                  |         878| 33.371298|  60.4783599|
|CAUSEWAY BRANCH 2                  |         524| 36.450382|  59.1603053|
|Cavins Hobbysville                 |         828| 15.579710|  82.3671498|
|Cayce Ward 2-A                     |         995| 34.271357|  60.1005025|
|Cayce Ward No.1                    |         975| 49.435897|  40.9230769|
|Cayce Ward No.2                    |        1365| 59.926740|  34.3589744|
|Cayce Ward No.3                    |         563| 38.010657|  54.8845471|
|CEDAR CREEK                        |         801| 28.838951|  68.6641698|
|Cedar Creek No. 64                 |         967| 20.992761|  75.6980352|
|Cedar Grove                        |        1124| 18.416370|  78.8256228|
|CEDAR GROVE                        |         746| 12.868633|  84.9865952|
|Cedar Grove Baptist                |        1093| 84.080512|  13.5407136|
|Cedar Rock                         |        1124| 10.320285|  87.2775801|
|CEDAR SWAMP                        |         260| 48.846154|  48.4615385|
|Cedarcrest                         |        1299| 31.100847|  62.1247113|
|CENTENARY                          |        1138| 70.913884|  26.0105448|
|CENTENNIAL                         |         403| 24.317618|  70.9677419|
|CENTER GROVE-WINZO                 |         860| 57.906977|  40.8139535|
|CENTER HILL                        |         973| 55.395683|  41.1099692|
|Center Rock                        |        1881| 20.999468|  75.9170654|
|CENTERVILLE                        |         298| 31.208054|  67.4496644|
|Centerville Station A              |        2093| 23.936933|  72.4796942|
|Centerville Station B              |        2001| 28.385807|  66.8665667|
|Central                            |        2797| 35.001788|  58.3124777|
|CENTRAL                            |         806| 66.004963|  32.2580645|
|Central 2                          |        1008| 35.317460|  59.2261905|
|Chalk Hill                         |        2323| 77.227723|  19.8019802|
|Challedon                          |        1294| 53.554869|  38.6398764|
|Chapin                             |        2349| 24.904215|  70.3703704|
|Chapman Elementary                 |        1141| 35.232252|  58.8957055|
|Chapman High School                |        2002| 31.068931|  65.2847153|
|CHAPPELLS                          |         622| 31.511254|  64.4694534|
|CHARLESTON 1                       |         586| 31.911263|  61.4334471|
|CHARLESTON 10                      |         431| 72.389791|  16.7053364|
|CHARLESTON 11                      |         872| 60.550459|  27.9816514|
|CHARLESTON 12                      |         909| 75.907591|  17.1617162|
|CHARLESTON 13                      |         799| 80.725907|  11.5143930|
|CHARLESTON 14                      |         687| 73.508006|  17.9039301|
|CHARLESTON 15                      |         940| 90.851064|   3.8297872|
|CHARLESTON 16                      |         839| 82.121573|   9.6543504|
|CHARLESTON 17                      |         678| 76.401180|  14.6017699|
|CHARLESTON 18                      |        1034| 89.071567|   6.6731141|
|CHARLESTON 19                      |         658| 83.586626|  10.0303951|
|CHARLESTON 2                       |         631| 38.668780|  54.9920761|
|CHARLESTON 20                      |         920| 68.695652|  22.2826087|
|CHARLESTON 21                      |         550| 87.454545|   8.5454545|
|CHARLESTON 3                       |         676| 49.852071|  41.2721893|
|CHARLESTON 4                       |         634| 56.151420|  34.2271293|
|CHARLESTON 5                       |         582| 53.436426|  39.1752577|
|CHARLESTON 6                       |         716| 57.541899|  33.2402235|
|CHARLESTON 7                       |         842| 56.413302|  33.9667458|
|CHARLESTON 8                       |         788| 85.406091|   6.5989848|
|CHARLESTON 9                       |         597| 72.194305|  19.9329983|
|Charlotte Thompson                 |        1146| 45.113438|  51.5706806|
|CHECHESSEE 1                       |        1214| 29.159802|  66.3920923|
|CHECHESSEE 2                       |        1088| 27.849265|  67.5551471|
|CHERAW NO. 1                       |        1045| 41.244019|  54.8325359|
|CHERAW NO. 2                       |         764| 51.963351|  44.2408377|
|CHERAW NO. 3                       |        1378| 76.705370|  20.8998549|
|CHERAW NO. 4                       |        1019| 57.899902|  38.2728165|
|Cherokee Springs Fire Station      |        1159| 21.311475|  73.5116480|
|CHERRY GROVE #1                    |        1434| 23.291492|  73.8493724|
|CHERRY GROVE #2                    |        1741| 25.445146|  71.3957496|
|CHERRYVALE                         |         568| 62.852113|  34.3309859|
|Chesnee Elementary                 |        2200| 24.954545|  70.7272727|
|Chester Ward 1                     |         827| 70.495768|  25.9975816|
|Chester Ward 2                     |         539| 82.931354|  14.8423006|
|Chester Ward 3                     |         672| 55.803571|  40.1785714|
|Chester Ward 4                     |         633| 75.355450|  21.4849921|
|Chester Ward 5                     |         404| 43.564356|  53.4653465|
|Chesterfield Ave                   |         744| 80.107527|  15.8602151|
|CHESTNUT HILLS                     |        1391| 48.670022|  45.5787203|
|China Springs                      |        1168| 70.804794|  25.9417808|
|Chiquola Mill                      |         481| 43.451144|  52.3908524|
|CHOPPEE                            |         837| 76.105137|  22.4611708|
|CHRIST CHURCH                      |         704| 56.818182|  39.6306818|
|CIRCLE CREEK                       |        2373| 26.801517|  68.0994522|
|Civic Center                       |         869| 59.723821|  37.5143843|
|Clark's Hill                       |         519| 56.069364|  41.8111753|
|CLAUSSEN                           |        1296| 31.790123|  66.0493827|
|CLEAR CREEK                        |        1561| 15.374760|  78.0909673|
|Clearwater                         |         528| 46.590909|  51.5151515|
|Clemson                            |        2186| 32.891125|  60.3385178|
|Clemson 2                          |        1384| 27.384393|  66.3294798|
|Clemson 3                          |         983| 32.960326|  62.2583927|
|Cleveland Elementary               |         986| 86.004057|  11.1561866|
|Clifdale Elementary                |         620| 27.258064|  67.9032258|
|CLINTON 1                          |         985| 42.842640|  51.6751269|
|CLINTON 2                          |         881| 44.267877|  49.0351873|
|CLINTON 3                          |        1115| 26.188341|  70.2242152|
|CLINTON MILL                       |        1053| 64.102564|  30.3893637|
|CLIO                               |        1013| 70.779862|  26.8509378|
|Clover                             |        1089| 21.946740|  73.2782369|
|CLYDE                              |         221| 11.764706|  82.8054299|
|Coastal                            |         841| 51.605232|  39.1200951|
|Coastal 2                          |        1212| 36.138614|  57.7557756|
|Coastal 3                          |         516| 37.596899|  53.4883721|
|COASTAL CAROLINA                   |        1219| 39.704676|  53.4864643|
|COASTAL LANE #1                    |         893| 86.226204|  10.7502800|
|COASTAL LANE #2                    |         980| 70.408163|  25.2040816|
|Cokesbury                          |         877| 51.539339|  45.2679590|
|Cold Springs                       |         658| 20.820669|  76.5957447|
|Coldstream                         |        1481| 35.786631|  57.3261310|
|COLES CR ROADS                     |        1597| 38.447088|  56.4809017|
|College Acres                      |        1345| 27.211896|  66.2453532|
|College Place                      |        1207| 94.780447|   2.5683513|
|COLSTON                            |         167| 31.736527|  66.4670659|
|Concrete                           |        2493| 19.574810|  76.0930606|
|CONESTEE                           |        1960| 45.714286|  49.7448980|
|Congaree #1                        |        1386| 19.119769|  77.1284271|
|Congaree #2                        |         855| 28.304094|  68.5380117|
|CONSOLIDATED #5                    |         832| 30.288462|  65.5048077|
|Converse Fire Station              |         936| 30.128205|  67.4145299|
|COOKS                              |        1878| 29.073482|  65.6017039|
|COOL SPRINGS                       |         391| 22.250639|  75.9590793|
|Cooley Springs Baptist             |        1853| 22.018349|  73.5563950|
|Cooper                             |         757| 37.648613|  55.3500661|
|Coosaw                             |        1410| 37.375887|  55.5319149|
|Coosaw 2                           |        1531| 44.219464|  49.4448073|
|Coosaw 3                           |        1052| 34.600760|  59.8859316|
|Coosawhatchie                      |         346| 69.364162|  25.7225434|
|COPE                               |         638| 45.768025|  51.4106583|
|Cordesville                        |         946| 34.672304|  61.0993658|
|CORDOVA 1                          |        1248| 47.996795|  50.0801282|
|CORDOVA 2                          |        1268| 61.908517|  36.3564669|
|Cornerstone Baptist                |        1130| 63.008850|  32.3893805|
|Coronaca                           |        1117| 15.129812|  81.1996419|
|COTTAGEVILLE                       |        1073| 27.399814|  67.6607642|
|Cotton Belt                        |        1232| 17.288961|  78.4902597|
|Couchton                           |        1042| 35.604607|  59.4049904|
|COURTHOUSE                         |        1234| 35.332253|  62.2366288|
|COWARDS NO. 1                      |         675| 30.222222|  66.2222222|
|COWARDS NO. 2                      |         732| 24.590164|  73.2240437|
|Cowpens Depot Museum               |        1011| 34.718101|  62.6112760|
|Cowpens Fire Station               |        1427| 18.920813|  76.8745620|
|Cox's Creek                        |         633| 23.380727|  69.6682464|
|Craytonville                       |         914|  8.096280|  88.9496718|
|Crescent Hill                      |         940|  9.468085|  85.7446809|
|CRESENT                            |        1391| 24.083393|  70.5248023|
|CRESTON                            |         199| 42.713568|  55.2763819|
|Crestview                          |         987| 15.096251|  80.1418440|
|Crocket-Miley                      |         406| 42.857143|  52.9556650|
|Croft Baptist                      |         975| 54.564103|  42.2564103|
|Cromer                             |        1051| 27.402474|  66.7935300|
|Cross                              |         861| 45.063879|  52.2648084|
|Cross Anchor Fire Station          |         711| 21.800281|  75.5274262|
|CROSS HILL                         |        1368| 36.695906|  59.9415205|
|CROSS KEYS                         |         687| 35.953421|  61.5720524|
|Crossroads                         |        1113| 10.332435|  85.8939802|
|Crosswell                          |        1346| 15.453195|  80.7578009|
|CROSSWELL                          |        1005| 80.298507|  18.2089552|
|Cudd Memorial                      |         989| 50.353893|  44.5904954|
|Cummings                           |         662| 55.891239|  41.9939577|
|Cypress                            |        1688| 34.123223|  59.3009479|
|CYPRESS                            |         450| 69.111111|  28.6666667|
|Cypress 2                          |         539| 22.634508|  71.4285714|
|Dacusville                         |        1018| 12.966601|  84.3811395|
|DAISY                              |        1098| 21.038251|  76.0473588|
|DALE LOBECO                        |         856| 66.121495|  30.3738318|
|DALZELL 1                          |        1020| 41.666667|  53.0392157|
|DALZELL 2                          |         777| 46.203346|  48.9060489|
|Daniel Island 1                    |        1231| 23.883022|  72.0552396|
|Daniel Island 2                    |        1259| 37.648928|  55.4408261|
|Daniel Island 3                    |        1282| 35.647426|  58.2683307|
|Daniel Island 4                    |        1792| 31.752232|  61.3281250|
|Daniel Morgan Technology Center    |         854| 26.932084|  66.3934426|
|DARBY RIDGE                        |        2143| 15.538964|  78.8147457|
|DARLINGTON NO. 1                   |         233| 56.652361|  38.6266094|
|DARLINGTON NO. 2                   |        1111| 69.756976|  28.8928893|
|DARLINGTON NO. 3                   |        1648| 42.050971|  54.4296117|
|DARLINGTON NO. 4                   |         907| 70.562293|  27.1223815|
|DARLINGTON NO. 5                   |        1204| 92.940199|   4.7342193|
|DARLINGTON NO. 6                   |        1197| 50.125313|  47.1177945|
|DAUFUSKIE                          |         339| 31.268437|  65.1917404|
|Davis Station                      |        1155| 41.645022|  55.1515152|
|Dayton Fire Station                |         833| 48.979592|  46.0984394|
|DEER PARK 1A                       |         841| 59.690844|  31.3912010|
|DEER PARK 1B                       |        1553| 47.778493|  43.1423052|
|DEER PARK 2A                       |        1768| 49.264706|  45.9841629|
|DEER PARK 2B                       |        1161| 50.904393|  42.7217916|
|DEER PARK 2C                       |         693| 44.444444|  50.0721501|
|DEER PARK 3                        |        1293| 59.319412|  34.0293890|
|DEERFIELD                          |        2246| 24.220837|  71.9056100|
|DEL NORTE                          |        2000| 40.350000|  53.8000000|
|DELAINE                            |        1079| 80.444856|  16.0333642|
|Delemars                           |         640| 82.656250|  16.0937500|
|DELMAE NO. 1                       |        1448| 50.621547|  43.9917127|
|DELMAE NO. 2                       |        1234| 23.014587|  72.8525122|
|DELMAR                             |         354| 11.864407|  84.1807910|
|Delphia                            |        1398| 19.027182|  76.6094421|
|Dennyside                          |         917| 56.052345|  32.2791712|
|Dentsville                         |        1435| 91.986063|   6.4808362|
|Denver-Sandy Springs               |        1061| 20.546654|  74.7408106|
|DEVENGER                           |        1613| 22.318661|  69.9318041|
|Devon Forest 1                     |        1626| 35.977860|  56.6420664|
|Devon Forest 2                     |        1289| 33.436773|  60.2017067|
|Discovery                          |        1346| 41.753343|  51.1887073|
|DIXIE                              |        1483| 77.680378|  20.1618341|
|Doby's Mill                        |        1559| 31.237973|  64.2078255|
|Dobys Bridge                       |        1826| 25.903614|  67.3603505|
|DOGBLUFF                           |         865| 11.560694|  86.1271676|
|DOGWOOD                            |        1222| 40.916530|  54.9099836|
|Donalds                            |         438| 15.296804|  81.9634703|
|DONALDSON                          |         843| 73.072361|  23.9620403|
|Dorchester                         |         651| 32.565284|  58.3717358|
|Dorchester 2                       |         615| 24.065041|  66.8292683|
|Douglas                            |        1222| 45.008183|  51.3093290|
|DOVE TREE                          |        1554| 28.764479|  63.3848134|
|DOVESVILLE                         |        1381| 65.821868|  32.2230268|
|Draytonville                       |        1208| 23.509934|  72.8476821|
|Dreher Island                      |        1355| 11.439114|  85.2398524|
|DUDLEY-MANGUM                      |         768| 24.869792|  72.7864583|
|Due West                           |        1159| 33.563417|  62.0362381|
|Duncan United Methodist            |        1280| 43.437500|  52.3437500|
|DUNES #1                           |        2361| 22.744600|  75.0952986|
|DUNES #2                           |        1563| 23.672425|  73.4484965|
|DUNES #3                           |         896| 32.477679|  63.9508929|
|DUNKLIN                            |        2062| 13.142580|  83.1716780|
|Dutch Fork 1                       |         904| 23.783186|  68.6946903|
|Dutch Fork 2                       |         951| 39.432177|  52.7865405|
|Dutch Fork 3                       |        1538| 26.267880|  67.0351105|
|Dutch Fork 4                       |        1280| 32.890625|  60.8593750|
|Dutchman Shores                    |        1605| 13.769470|  80.6853583|
|DUTCHMANS CREEK                    |        1043| 24.640460|  71.4285714|
|Dwight                             |        1345| 15.390335|  80.3717472|
|E BENNETTSVILLE                    |         776| 68.298969|  29.6391753|
|E. Camden-Hermitage                |         373| 33.512064|  59.2493298|
|E.P. Todd Elementary               |        1581| 47.881088|  48.8931056|
|Eadytown                           |         625| 72.960000|  25.7600000|
|EARLES                             |         563| 24.511545|  73.3570160|
|Earles Grove                       |         736| 13.586956|  83.8315217|
|Early Branch                       |         286| 54.895105|  43.7062937|
|Easley                             |         957| 21.734587|  73.4587252|
|EAST BUFFALO                       |         269| 74.721190|  21.9330855|
|EAST CONWAY                        |         852| 29.342723|  65.0234742|
|EAST DENMARK                       |        1508| 84.350133|  14.0583554|
|EAST DILLON                        |        1257| 20.604614|  76.5314240|
|East Forest Acres                  |         761| 30.749015|  60.8409987|
|East Liberty                       |         973| 15.005139|  80.5755396|
|EAST LORIS                         |        2235| 35.123042|  61.4317673|
|EAST MCCOLL                        |         528| 23.674242|  74.2424242|
|East Pickens                       |         974|  8.521561|  87.0636550|
|Eastover                           |        1080| 91.111111|   6.3888889|
|EASTSIDE                           |        1976| 28.238866|  66.2449393|
|Eastside Baptist                   |        1070| 37.757009|  58.8785047|
|Ebenezer                           |         911| 25.246981|  68.9352360|
|EBENEZER                           |        3787| 19.382097|  77.5283866|
|EBENEZER 1                         |         996| 53.714859|  41.7670683|
|EBENEZER 2                         |        1000| 49.800000|  46.1000000|
|Ebenezer Baptist                   |         677| 94.977843|   2.5110783|
|EBENEZER NO. 1                     |        2489| 26.556850|  68.6621133|
|EBENEZER NO. 2                     |        1623| 36.352434|  59.7042514|
|EBENEZER NO. 3                     |         850| 27.294118|  68.9411765|
|Ebinport                           |        1962| 37.971458|  55.6574924|
|Edenwood                           |        1714| 35.880980|  58.8098016|
|Edgefield No.1                     |         655| 39.389313|  56.7938931|
|Edgefield No.2                     |        1163| 53.654342|  43.1642304|
|Edgemoor                           |         926| 27.429806|  68.2505400|
|Edgewood                           |        3008| 90.093085|   7.0811170|
|Edgewood Station A                 |        1452| 36.088154|  58.6776860|
|Edgewood Station B                 |        1483| 22.319622|  73.0276467|
|EDISTO                             |        1541| 33.290071|  64.0493186|
|EDISTO BEACH                       |         880| 20.681818|  77.1590909|
|EDISTO ISLAND                      |        1203| 50.540316|  45.3865337|
|Edmund #1                          |         840| 28.095238|  65.4761905|
|Edmund #2                          |        1253| 13.487630|  80.7661612|
|EDWARDS FOREST                     |        1943| 25.887802|  67.5759135|
|EFFINGHAM                          |         547| 19.744059|  78.0621572|
|EHRHARDT                           |         670| 46.268657|  51.3432836|
|EKOM                               |         467| 13.490364|  81.5845824|
|Elgin                              |        1053| 35.897436|  60.1139601|
|Elgin No. 1                        |        1744| 25.917431|  68.2339450|
|Elgin No. 2                        |        1251| 32.214229|  62.8297362|
|Elgin No. 3                        |         988| 35.121457|  60.3238866|
|Elgin No. 4                        |        1532| 32.702350|  62.5326371|
|Elgin No. 5                        |        1137| 28.496042|  67.6341249|
|Elgin No. 6                        |         926| 42.656588|  51.4038877|
|ELIM-GLENWOOD                      |        1145| 25.327511|  72.7510917|
|ELKO                               |         537| 48.975791|  48.6033520|
|ELLIOTT                            |         530| 92.264151|   5.6603774|
|ELLOREE 1                          |         800| 49.750000|  47.2500000|
|ELLOREE 2                          |         672| 80.357143|  19.0476190|
|Emerald                            |         470| 78.936170|  16.8085106|
|EMERALD FOREST #1                  |        1773| 32.994924|  60.8573040|
|EMERALD FOREST #2                  |        2729| 30.194210|  64.3459143|
|EMERALD FOREST #3                  |        1992| 26.405622|  68.7248996|
|Emerald High                       |         384| 22.135417|  73.1770833|
|Emergency                          |        1076| 38.104089|  59.0148699|
|Emergency 1                        |         157| 52.229299|  46.4968153|
|Emergency 2                        |         338| 37.573965|  60.6508876|
|Emergency 3                        |           6| 83.333333|  33.3333333|
|Emergency 4                        |           2|        NA| 100.0000000|
|Emmanuel Church                    |        1698| 22.909305|  71.1425206|
|ENOREE                             |        2231| 31.196773|  63.6485881|
|Enoree First Baptist               |        1146| 20.244328|  75.6544503|
|ENTERPRISE                         |        2918| 26.525017|  69.4311172|
|Epworth                            |         560| 16.428571|  81.2500000|
|Erwin Farm                         |        1040| 51.442308|  43.7500000|
|Estates                            |        1525| 55.081967|  39.2786885|
|Estill                             |        1571| 79.121579|  17.5684278|
|Eureka                             |        1222| 23.567921|  71.9312602|
|Eureka Mill                        |         933| 63.772776|  32.4758842|
|EUTAWVILLE 1                       |        1286| 43.856921|  54.4323484|
|EUTAWVILLE 2                       |        1375| 78.836364|  19.2000000|
|EVERGREEN                          |         796| 27.763819|  69.0954774|
|EXCELSIOR                          |        1004| 46.613546|  51.3944223|
|Ezells and Butler                  |        1197| 15.789474|  80.7017544|
|Failsafe                           |        4293| 57.465642|  38.5744235|
|Failsafe / Provisional 1           |         250| 32.000000|  62.8000000|
|Failsafe 1                         |         803| 47.198008|  48.0697385|
|FAILSAFE 1                         |         428| 62.850467|  29.4392523|
|Failsafe 2                         |         788| 63.832487|  31.8527919|
|FAILSAFE 2                         |         194| 61.855670|  31.4432990|
|Failsafe 3                         |         279| 68.100358|  29.3906810|
|Failsafe 4                         |         153| 71.241830|  23.5294118|
|FAILSAFE PR                        |        1489| 39.489590|  54.8018805|
|Failsafe Prov 1                    |        1061| 43.449576|  50.8011310|
|Failsafe Provisional               |        2158| 47.544022|  47.4050046|
|Failsafe/Provisional               |         522| 50.000000|  42.7203065|
|Fair Play                          |         823| 11.907655|  86.0267315|
|FAIRFAX #1                         |         386| 63.471503|  31.6062176|
|FAIRFAX #2                         |         803| 87.048568|  10.7098381|
|Fairforest Elementary              |        1775| 23.211268|  73.3521127|
|Fairforest Middle School           |        1850| 36.648649|  58.3783784|
|Fairgrounds                        |        1222| 84.206219|  12.9296236|
|Fairlawn                           |        1849| 79.502434|  16.0086533|
|Fairview                           |        1183| 22.485207|  73.7954353|
|FAIRVIEW                           |        1191| 17.968094|  78.5894207|
|Fairwold                           |         649| 97.072419|   2.0030817|
|Faith Church                       |         996| 29.116466|  62.4497992|
|FALL BRANCH                        |         458| 45.633188|  52.1834061|
|FEASTER                            |         974| 39.117043|  54.7227926|
|FEASTERVILLE                       |         282| 73.404255|  25.8865248|
|Ferry Branch                       |         790| 20.886076|  73.1645570|
|Fewell Park                        |         785| 31.464968|  61.1464968|
|Filbert                            |        1250| 16.720000|  78.4000000|
|Five Forks                         |        1412| 24.008499|  72.8753541|
|Flat Rock                          |        2261| 16.983636|  78.5493145|
|FLORENCE NO. 1                     |         892| 96.412556|   2.1300448|
|FLORENCE NO. 10                    |         444| 94.594595|   3.1531532|
|FLORENCE NO. 11                    |         598| 42.140468|  52.8428094|
|FLORENCE NO. 12                    |        1286| 25.505443|  68.6625194|
|FLORENCE NO. 14                    |        1087| 32.382705|  63.2014719|
|FLORENCE NO. 15                    |         330| 80.606061|  17.5757576|
|FLORENCE NO. 2                     |         774| 94.702842|   3.4883721|
|FLORENCE NO. 3                     |         954| 97.064989|   0.7337526|
|FLORENCE NO. 4                     |         454| 48.458150|  44.2731278|
|FLORENCE NO. 5                     |         707| 68.033946|  27.2984441|
|FLORENCE NO. 6                     |         515| 32.233010|  64.4660194|
|FLORENCE NO. 7                     |        1137| 32.717678|  61.8293755|
|FLORENCE NO. 8                     |        1047| 21.585482|  73.2569245|
|FLORENCE NO. 9                     |        1095| 98.082192|   0.8219178|
|Flowertown                         |         949| 27.081138|  66.7017914|
|Flowertown 2                       |        1045| 39.617225|  53.3971292|
|Flowertown 3                       |         881| 33.257662|  58.9103292|
|FLOYDALE                           |         501| 25.748503|  71.4570858|
|FOLLY BEACH 1                      |         774| 40.697674|  50.6459948|
|FOLLY BEACH 2                      |         981| 40.978593|  51.2742100|
|FOLLY GROVE                        |         842| 27.197150|  71.0213777|
|FOLSOM PARK                        |        1034| 85.106383|  11.6054159|
|Forest Acres                       |         753| 24.302789|  71.0491368|
|FORESTBROOK                        |        2668| 28.448276|  67.0914543|
|FORK                               |         382| 29.581152|  69.1099476|
|Fork No.1                          |        1062| 20.903955|  76.6478343|
|Fork No.2                          |        1275| 15.921569|  79.6862745|
|FORK SHOALS                        |        1805| 15.124654|  80.8310249|
|Fort Lawn                          |        1269| 39.479905|  57.9984240|
|Fort Mill No. 1                    |        2291| 30.423396|  62.8546486|
|Fort Mill No. 2                    |        2400| 26.000000|  68.3333333|
|Fort Mill No. 3                    |        1628| 42.076167|  50.9213759|
|Fort Mill No. 4                    |        1277| 49.412686|  46.4369616|
|Fort Mill No. 5                    |        1671| 33.153800|  61.1609814|
|Fort Mill No. 6                    |        1412| 29.815864|  61.1189802|
|FORT MOTTE                         |         241| 58.091286|  39.8340249|
|Foster Creek 1                     |         303| 34.983498|  58.0858086|
|Foster Creek 2                     |        1701| 33.803645|  59.2592593|
|Foster Creek 3                     |        1251| 37.969624|  54.9960032|
|FOUNTAIN INN 1                     |        2808| 44.836182|  50.4273504|
|FOUNTAIN INN 2                     |        1227| 28.850856|  66.1776691|
|Four Hole                          |         944| 46.504237|  50.3177966|
|FOUR HOLES                         |         547| 33.820841|  64.8994516|
|FOUR MILE                          |        1579| 26.599113|  69.7910070|
|Fox Bank                           |        1499| 34.422949|  58.4389593|
|FOX CHASE                          |        1770| 16.610170|  78.3615819|
|Fox Creek No. 58                   |        1231| 22.014622|  73.9236393|
|Fox Creek No. 73                   |        1242| 17.552335|  78.0193237|
|Friarsgate 1                       |        1280| 52.812500|  40.2343750|
|Friarsgate 2                       |        1076| 46.375465|  46.8401487|
|FRIENDFIELD                        |         438| 15.296804|  82.6484018|
|Friendship                         |        3295| 20.971168|  73.5660091|
|FRIENDSHIP                         |         888| 32.094595|  65.9909910|
|Friendship Baptist                 |        3094| 18.648998|  77.2786037|
|FROHAWK                            |        1482| 18.353576|  76.7881242|
|FRUIT HILL                         |         677| 69.423929|  28.0649926|
|Fruit Mountain                     |         826| 16.222760|  79.1767554|
|Furman                             |         370| 71.891892|  26.7567568|
|FURMAN                             |        3344| 26.794258|  68.3612440|
|Gable Middle School                |        2171| 23.583602|  72.5011515|
|GADDY'S MILL                       |         192| 38.541667|  60.4166667|
|Gadsden                            |        1077| 93.314763|   5.1996286|
|Gaffney Ward No. 1                 |         570| 73.157895|  24.2105263|
|Gaffney Ward No. 2                 |         909| 79.647965|  17.7117712|
|Gaffney Ward No. 3                 |         725| 84.413793|  13.1034483|
|Gaffney Ward No. 4                 |        1014| 54.930966|  41.9132150|
|Gaffney Ward No. 5                 |         760| 38.157895|  57.7631579|
|Gaffney Ward No. 6                 |         849| 27.561837|  69.7290931|
|GALLIVANTS FERRY                   |         178| 17.977528|  80.8988764|
|GARDEN CITY #1                     |        1863| 21.953838|  75.7380569|
|GARDEN CITY #2                     |        1233| 16.301703|  81.5896188|
|GARDEN CITY #3                     |        1545| 32.556634|  63.9482201|
|GARDEN CITY #4                     |        1101| 28.701181|  67.7565849|
|Gardendale                         |        1236| 53.398058|  41.6666667|
|Garners                            |         682| 62.903226|  33.2844575|
|Garnett                            |         167| 89.820359|  10.7784431|
|Gaston #1                          |        1044| 17.145594|  77.9693487|
|Gaston #2                          |        1330| 29.097744|  65.3383459|
|Gates Ford                         |         270| 12.222222|  85.1851852|
|Gem Lakes No. 60                   |         948| 21.729958|  71.9409283|
|Gem Lakes No. 77                   |        1088| 20.404412|  72.1507353|
|Georges Creek                      |         976| 18.135246|  78.7909836|
|Georgetown                         |         681| 45.080764|  49.9265786|
|GEORGETOWN NO. 1                   |         507| 41.025641|  54.8323471|
|GEORGETOWN NO. 2-DREAM KEEPERS     |         798| 96.240601|   1.8796992|
|GEORGETOWN NO. 3                   |         874| 87.986270|   8.9244851|
|GEORGETOWN NO. 4                   |         321| 37.071651|  57.6323988|
|GEORGETOWN NO. 5                   |        1072| 39.365672|  56.9029851|
|Germantown                         |         895| 31.508380|  63.4636872|
|Gideon's Way                       |         582| 56.701031|  40.7216495|
|Gifford                            |         390| 92.051282|   7.6923077|
|Gilbert                            |        1494| 13.922356|  81.5930388|
|GILBERT                            |        1371| 85.849745|  11.6703136|
|Gillisonville                      |         450| 51.111111|  44.8888889|
|Givhans                            |         786| 35.241730|  61.5776081|
|Givhans 2                          |         784| 38.647959|  57.9081633|
|GLADDE3N GROVE                     |          63| 33.333333|  60.3174603|
|Glassy Mountain                    |         993|  8.660624|  87.1097684|
|Glendale                           |        1032| 19.476744|  75.6782946|
|Glendale Fire Station              |        1174| 14.565588|  81.7717206|
|GLENNS BAY                         |        1763| 25.014180|  69.7674419|
|Glenview                           |        1377| 32.026144|  62.6724764|
|Gloverville                        |         865| 20.000000|  75.0289017|
|Gluck Mill                         |         340| 46.764706|  49.1176471|
|Gold Hill                          |        2035| 31.695332|  62.7027027|
|Gooch's Cross Roads                |        1124| 55.249110|  41.5480427|
|Goucher and Thicketty              |         973| 12.846865|  84.1726619|
|GOVAN                              |         156| 68.589744|  30.1282051|
|GOWENSVILLE                        |        1791| 14.461195|  82.0212172|
|Grahamville 1                      |         758| 37.203166|  57.6517150|
|Grahamville 2                      |        1215| 64.526749|  31.5226337|
|Gramling Methodist                 |        1282| 10.296412|  86.4274571|
|GRANITE CREEK                      |        2310| 31.991342|  63.2467532|
|Graniteville                       |         930| 38.817204|  56.1290323|
|GRANTS MILL                        |         942| 35.774947|  60.1910828|
|Grassy Pond                        |        1655| 21.450151|  75.5287009|
|GRAY COURT                         |         992| 39.818548|  55.8467742|
|Grays                              |         574| 28.048780|  69.1637631|
|GRAZE BRANCH                       |        1415| 25.512367|  70.6007067|
|Great Falls                        |         897| 47.491639|  48.9409142|
|Greater St. James                  |        1665| 25.885886|  69.0090090|
|GREELEYVILLE                       |        1218| 80.213465|  18.0623974|
|GREEN POND                         |         762| 76.246719|  21.1286089|
|Green Pond Station A               |        1987| 20.533468|  75.7423251|
|GREEN SEA                          |         796| 32.286432|  65.7035176|
|GREEN SWAMP                        |        1176| 47.704082|  47.9591837|
|GREEN SWAMP 2                      |         539| 19.666048|  76.0667904|
|GREENBRIAR                         |        1586| 35.182850|  59.8991173|
|GREENBRIER                         |        1366| 71.595900|  24.8169839|
|Greenhurst                         |         779| 34.916560|  55.9691913|
|GREENPOND                          |        1389| 18.502520|  77.4658027|
|Greenview                          |        1328| 97.289157|   0.6024096|
|GREENVILLE 1                       |        1376| 32.485465|  57.9941860|
|GREENVILLE 10                      |        1742| 54.190585|  38.1745121|
|GREENVILLE 14                      |        1374| 92.358079|   5.0946143|
|GREENVILLE 16                      |        1529| 35.317201|  58.0117724|
|GREENVILLE 17                      |        1274| 33.437991|  60.2825746|
|GREENVILLE 18                      |        1219| 30.188679|  63.4946678|
|GREENVILLE 19                      |        1670| 81.796407|  13.5329341|
|GREENVILLE 20                      |        1021| 32.810970|  61.6062684|
|GREENVILLE 21                      |        1136| 38.028169|  50.8802817|
|GREENVILLE 22                      |        1966| 31.993896|  61.3936928|
|GREENVILLE 23                      |        1581| 23.466161|  71.9797596|
|GREENVILLE 24                      |        2522| 42.981761|  49.8413957|
|GREENVILLE 25                      |        1463| 44.429255|  47.0950103|
|GREENVILLE 26                      |        1428| 61.764706|  30.9523810|
|GREENVILLE 27                      |         933| 13.933548|  73.9549839|
|GREENVILLE 28                      |         815| 48.343558|  41.8404908|
|GREENVILLE 29                      |        1465| 75.085324|  19.1808874|
|GREENVILLE 3                       |        1952| 43.750000|  47.6434426|
|GREENVILLE 4                       |        1893| 65.398838|  27.3639725|
|GREENVILLE 5                       |        1964| 56.160896|  35.8961303|
|GREENVILLE 6                       |         404| 78.465346|  18.0693069|
|GREENVILLE 7                       |        1327| 83.798041|  11.9065561|
|GREENVILLE 8                       |        1824| 71.929825|  21.3815789|
|Greenwave                          |         747| 42.034806|  53.1459170|
|GREENWOOD                          |        1260| 45.714286|  50.4761905|
|Greenwood High                     |         654| 33.027523|  61.7737003|
|Greenwood Mill                     |         534| 26.779026|  66.4794007|
|Greenwood No. 1                    |         558| 82.974910|  12.5448029|
|Greenwood No. 2                    |         704| 94.460227|   4.2613636|
|Greenwood No. 3                    |         765| 41.045752|  52.5490196|
|Greenwood No. 4                    |         876| 50.456621|  45.3196347|
|Greenwood No. 5                    |         399| 76.691729|  20.3007519|
|Greenwood No. 6                    |         656| 63.262195|  33.5365854|
|Greenwood No. 7                    |         728| 61.950550|  32.0054945|
|Greenwood No. 8                    |         697| 38.737446|  56.0975610|
|Gregg Park                         |        1284| 58.878505|  36.1370717|
|Grenadier                          |        1447| 58.604008|  35.1762267|
|GRIER'S                            |         557| 83.842011|  15.6193896|
|Griffin                            |        1288|  9.394410|  86.2577640|
|GROVE                              |        1335| 60.973783|  35.2808989|
|Grove School                       |         483| 12.215321|  86.3354037|
|Grover                             |         726| 48.760331|  48.3471074|
|Hall                               |        1080| 24.074074|  72.6851852|
|Hall's Store                       |         588| 37.414966|  61.0544218|
|Halsellville                       |         217| 58.986175|  40.0921659|
|HAMER                              |         606| 46.039604|  50.6600660|
|Hammond Annex                      |        1165| 23.433476|  71.5021459|
|Hammond No. 48                     |         863| 31.517961|  65.2375435|
|Hammond No. 81                     |         871| 35.017222|  61.6532721|
|Hammond School                     |        1652| 22.639225|  71.6707022|
|Hampton                            |        1199| 61.551293|  29.0241868|
|Hampton Courthouse No.1            |         707| 49.646393|  46.3932107|
|Hampton Courthouse No.2            |         923| 49.837486|  47.6706392|
|Hampton Mill                       |         994| 23.541248|  71.6297787|
|HAMPTON PARK                       |         471| 38.004246|  54.7770701|
|Hanahan 1                          |        1822| 21.130626|  72.7771679|
|Hanahan 2                          |        1008| 37.996032|  54.9603175|
|Hanahan 3                          |        1027| 26.387536|  65.9201558|
|Hanahan 4                          |        1101| 42.960945|  48.7738420|
|Hanahan 5                          |        1031| 19.495635|  75.2667313|
|HANNAH                             |         586| 11.262799|  86.3481229|
|Harbison 1                         |        1532| 64.751958|  28.0026110|
|Harbison 2                         |         969| 60.061920|  33.5397317|
|Harbour Lake                       |        1377| 63.979666|  30.2832244|
|Hardeeville 1                      |        1009| 48.463826|  45.8870168|
|Hardeeville 2                      |         689| 70.246734|  28.4470247|
|Harleyville                        |         624| 41.025641|  54.8076923|
|Harmony                            |        1176| 39.030612|  58.6734694|
|HARMONY                            |         331| 29.607251|  69.4864048|
|Harris                             |         504| 40.079365|  54.3650794|
|Harrisburg                         |        2520| 34.246032|  60.5158730|
|HARTFORD                           |         803| 46.575342|  48.8169365|
|HARTSVILLE NO. 1                   |         909| 24.092409|  68.2068207|
|HARTSVILLE NO. 4                   |         798| 74.060150|  22.5563910|
|HARTSVILLE NO. 5                   |        1626| 40.836408|  53.8745387|
|HARTSVILLE NO. 6                   |        1271| 98.190401|   1.2588513|
|HARTSVILLE NO. 7                   |         861| 48.315912|  47.9674797|
|HARTSVILLE NO. 8                   |        2112| 21.070076|  74.7632576|
|HARTSVILLE NO. 9                   |        1440| 41.666667|  54.5138889|
|Harvest                            |         920| 31.847826|  61.8478261|
|Hayne Baptist                      |        1008| 55.853175|  38.4920635|
|Hazelwood                          |         561| 27.450980|  68.2709447|
|HEALING SPRINGS                    |         794| 80.982368|  17.2544081|
|Heath Springs                      |         943| 35.630965|  60.3393425|
|HEBRON                             |         498| 14.257028|  83.5341365|
|HELENA                             |         735| 85.986395|  12.1088435|
|HEMINGWAY                          |        1343| 65.897245|  32.7624721|
|HENDERSONVILLE                     |         829| 65.018094|  31.6043426|
|Hendrix Elementary                 |        2520| 42.103175|  51.3492063|
|HENRY-POPLAR HILL                  |         549| 50.273224|  47.7231330|
|Hickory Grove                      |         889| 22.947132|  73.0033746|
|HICKORY GROVE                      |        1347| 16.184113|  79.4357832|
|HICKORY HILL                       |         493| 43.407708|  54.3610548|
|HICKORY RIDGE                      |         737| 71.506106|  26.0515604|
|HICKORY TAVERN                     |        1812| 14.955850|  79.4150110|
|Hicks                              |         539| 17.068646|  81.6326531|
|HIGGINS-ZOAR                       |         516| 55.813953|  42.0542636|
|HIGH HILL                          |        2429| 46.603541|  50.3087690|
|High Point                         |         518| 12.934363|  84.3629344|
|Highland Park                      |         932| 56.545064|  38.5193133|
|HIGHTOWERS MILL                    |          92| 65.217391|  33.6956522|
|HILDA                              |         760| 11.973684|  86.0526316|
|HILLCREST                          |        2945| 35.823430|  58.9473684|
|Hilton Cross Rd                    |        1256| 53.423567|  43.1528662|
|HILTON HEAD 10                     |        1317| 42.065300|  53.8344723|
|HILTON HEAD 11                     |         873| 32.416953|  63.9175258|
|HILTON HEAD 12                     |         676| 37.130178|  60.2071006|
|HILTON HEAD 13                     |         916| 35.152838|  57.5327511|
|HILTON HEAD 14                     |         780| 28.589744|  67.8205128|
|HILTON HEAD 15A                    |         478| 32.845188|  64.4351464|
|HILTON HEAD 15B                    |         758| 27.308707|  70.1846966|
|HILTON HEAD 1A                     |         961| 45.057232|  48.5952133|
|HILTON HEAD 1B                     |         848| 48.702830|  48.1132075|
|HILTON HEAD 2A                     |        1133| 43.248014|  53.0450132|
|HILTON HEAD 2B                     |         999| 58.858859|  33.2332332|
|HILTON HEAD 2C                     |        1311| 25.553013|  72.5400458|
|HILTON HEAD 3                      |         713| 26.507714|  68.8639551|
|HILTON HEAD 4A                     |         606| 28.217822|  66.9966997|
|HILTON HEAD 4B                     |        1055| 30.616114|  65.4976303|
|HILTON HEAD 4C                     |         856| 37.032710|  58.6448598|
|HILTON HEAD 4D                     |         929| 32.723358|  63.0785791|
|HILTON HEAD 5A                     |         926| 32.829374|  64.0388769|
|HILTON HEAD 5B                     |         830| 30.240964|  65.6626506|
|HILTON HEAD 5C                     |         801| 30.711610|  64.6691635|
|HILTON HEAD 6                      |        1115| 29.058296|  65.2914798|
|HILTON HEAD 7A                     |         924| 32.251082|  63.8528139|
|HILTON HEAD 7B                     |         982| 32.382892|  64.0529532|
|HILTON HEAD 8                      |         683| 33.821376|  60.0292826|
|HILTON HEAD 9A                     |        1233| 34.144363|  59.1240876|
|HILTON HEAD 9B                     |        1084| 17.250923|  79.7970480|
|Hitchcock No. 66                   |         809| 27.688504|  68.8504326|
|Hobkirk's Hill                     |         971| 40.061792|  53.5530381|
|Hodges                             |        1074| 23.184358|  73.8361266|
|Hollis Lakes                       |        1421| 43.490500|  50.3870514|
|Hollow Creek                       |        2713| 19.093255|  76.2992997|
|HOLLY                              |         843| 10.794780|  85.8837485|
|Holly Grove-Buffalo                |        1038| 10.308285|  85.3564547|
|HOLLY HILL 1                       |        1530| 56.797386|  40.9150327|
|HOLLY HILL 2                       |        1575| 85.079365|  13.8412698|
|Holly Springs                      |        1522| 13.469120|  82.1287779|
|Holly Springs Baptist              |        2381| 11.255775|  84.0823184|
|HOLLY TREE                         |        1198| 25.626043|  69.6160267|
|HOLLYWOOD                          |        1001| 12.687313|  83.4165834|
|HOLSTONS                           |         856| 41.004673|  55.7242991|
|Holy Communion                     |        1362| 64.537445|  30.6167401|
|Home Branch                        |         304| 17.434210|  81.9078947|
|Homeland Park                      |        1806| 44.462901|  50.9966777|
|HOMEWOOD                           |        1231| 31.519090|  65.2315191|
|Honea Path                         |        1212| 19.389439|  77.3927393|
|Hook'S Store                       |        1513| 40.647720|  54.0647720|
|Hopewell                           |        2117| 23.193198|  71.7524799|
|Hopkins 1                          |         928| 88.146552|   9.9137931|
|Hopkins 2                          |         955| 85.130890|  12.0418848|
|HORATIO                            |         423| 85.342790|  13.4751773|
|HOREB-GLENN                        |         317| 83.280757|  13.5646688|
|Horrell Hill                       |        1572| 54.071247|  41.6030534|
|HORRY                              |         987| 11.043566|  85.5116515|
|Horse Gall                         |          74|  5.405405|  91.8918919|
|HORSE PEN                          |         522| 28.352490|  67.2413793|
|Howe Hall 1                        |        1580| 53.101266|  40.5063291|
|Howe Hall 2                        |         894| 43.176734|  46.8680089|
|HUDSON MILL                        |         424| 29.245283|  66.9811321|
|Huger                              |        1080| 66.111111|  30.8333333|
|Hunt Meadows                       |        3471| 15.499856|  80.3514837|
|HUNTER'S CHAPEL                    |         228| 50.000000|  49.1228070|
|Hunting Creek                      |         344| 43.023256|  54.3604651|
|Hyde Park                          |        1041| 34.678194|  61.1911623|
|Independence                       |         736| 20.244565|  75.8152174|
|India Hook                         |        1257| 33.174224|  60.3818616|
|INDIAN BRANCH                      |         540| 31.296296|  64.4444444|
|Indian Field                       |         466| 67.811159|  29.3991416|
|Indian Field 2                     |         708| 54.096045|  43.2203390|
|INDIANTOWN                         |        1266| 84.992101|  13.9810427|
|INLAND                             |         392| 43.367347|  55.1020408|
|IONIA                              |         524| 42.557252|  56.2977099|
|Irmo                               |        1513| 45.274290|  47.2571051|
|Irongate                           |         563| 16.518650|  76.0213144|
|Irongate 2                         |         331| 39.274924|  52.2658610|
|Irongate 3                         |         474| 24.894515|  65.8227848|
|ISLE OF PALMS 1A                   |         790| 30.886076|  60.8860759|
|ISLE OF PALMS 1B                   |        1053| 29.914530|  62.8679962|
|ISLE OF PALMS 1C                   |         988| 28.340081|  66.0931174|
|Issaqueena                         |         613| 45.187602|  45.6769984|
|Iva                                |        1262| 19.096672|  76.5451664|
|Jackson                            |        1314| 19.558600|  77.6255708|
|JACKSON BLUFF                      |         473| 23.678647|  68.7103594|
|Jackson Mill                       |         615| 13.008130|  81.4634146|
|JACKSONBORO                        |         378| 80.952381|  17.4603175|
|Jacksonham                         |        1088| 34.099265|  62.9595588|
|JAMES ISLAND 10                    |        1051| 43.672693|  46.6222645|
|JAMES ISLAND 11                    |        1122| 38.324421|  52.6737968|
|JAMES ISLAND 12                    |         789| 33.079848|  57.2877060|
|JAMES ISLAND 13                    |         869| 42.002302|  50.4027618|
|JAMES ISLAND 14                    |         706| 35.977337|  56.3739377|
|JAMES ISLAND 15                    |        1172| 43.856655|  47.0136519|
|JAMES ISLAND 17                    |        1141| 50.306748|  38.8255916|
|JAMES ISLAND 19                    |        1058| 47.542533|  42.4385633|
|JAMES ISLAND 1A                    |        1347| 48.032665|  43.1328879|
|JAMES ISLAND 1B                    |         550| 81.818182|  14.5454545|
|JAMES ISLAND 20                    |        1032| 49.127907|  41.8604651|
|JAMES ISLAND 22                    |         992| 46.774194|  42.4395161|
|JAMES ISLAND 3                     |         627| 85.007975|  11.4832536|
|JAMES ISLAND 5A                    |         865| 34.913295|  55.3757225|
|JAMES ISLAND 5B                    |         475| 29.263158|  64.4210526|
|JAMES ISLAND 6                     |        1070| 49.813084|  44.3925234|
|JAMES ISLAND 7                     |        1191| 44.584383|  47.6070529|
|JAMES ISLAND 8A                    |         772| 57.642487|  35.8808290|
|JAMES ISLAND 8B                    |        1282| 46.879875|  44.1497660|
|JAMES ISLAND 9                     |        1078| 44.341373|  46.8460111|
|Jamestown                          |         534| 58.988764|  37.4531835|
|JAMESTOWN                          |        2332| 39.451115|  56.6895369|
|JAMISON                            |        1331| 72.727273|  24.9436514|
|JEFFERSON                          |        1490| 43.624161|  53.4899329|
|JENKINSVILLE                       |         612| 85.620915|  12.5816993|
|JENNINGS MILL                      |        1454| 18.088033|  76.4099037|
|JERIGANS CROSSROADS                |         660| 16.363636|  80.6060606|
|Jesse Bobo Elementary              |        1342| 75.111773|  20.5663189|
|Jesse Boyd Elementary              |         998| 53.707415|  40.4809619|
|JET PORT #1                        |        1326| 32.202112|  64.5550528|
|JET PORT #2                        |        3162| 31.182796|  65.1486401|
|JOANNA                             |        1416| 23.163842|  72.5282486|
|JOHNS ISLAND 1A                    |        1100| 33.818182|  62.0000000|
|JOHNS ISLAND 1B                    |        1078| 58.627087|  35.7142857|
|JOHNS ISLAND 2                     |        2484| 40.499195|  51.4895330|
|JOHNS ISLAND 3A                    |        1815| 37.796143|  54.1597796|
|JOHNS ISLAND 3B                    |        1202| 52.079867|  43.9267887|
|JOHNS ISLAND 4                     |         761| 55.321945|  38.8961892|
|JOHNSONVILLE                       |        1794| 31.884058|  65.6633222|
|Johnston No.1                      |        1188| 68.265993|  29.2087542|
|Johnston No.2                      |        1053| 58.784425|  38.5565052|
|JOHNSTONE                          |         399| 37.092732|  59.1478697|
|JONES                              |        1256| 32.802548|  63.2165605|
|JONESVILLE BOX 1                   |         852| 26.995305|  69.7183099|
|JONESVILLE BOX 2                   |         933| 39.549839|  57.0203644|
|Jordan                             |        1157| 25.669836|  71.1322385|
|JORDANVILLE                        |         538|  4.646840|  92.9368030|
|JOYNER SWAMP                       |         387| 16.537468|  81.9121447|
|JUNIPER BAY                        |        1516| 17.744063|  78.1662269|
|Kanawha                            |        1249| 31.385108|  63.0104083|
|KEARSE                             |         113|  5.309735|  94.6902655|
|Keels 1                            |        1094| 85.374771|  10.9689214|
|Keels 2                            |         911| 87.705818|   8.7815587|
|Keenan                             |        1169| 68.776732|  25.6629598|
|KELLEYTOWN                         |        1463| 16.746412|  79.6308954|
|Kelly Mill                         |        1373| 53.459578|  42.0975965|
|KELTON                             |         803| 38.231631|  57.1606476|
|KEMPER                             |         375| 58.666667|  39.2000000|
|KENSINGTON                         |         721| 20.527046|  76.2829404|
|Keowee                             |        2158| 17.099166|  78.9620019|
|Kershaw North                      |        1207| 41.010770|  55.4266777|
|Kershaw South                      |        1117| 19.964190|  76.5443151|
|KIAWAH ISLAND                      |        1188| 28.787879|  65.4040404|
|KILGORE FARMS                      |        2071| 32.641236|  61.9990343|
|Killian                            |        1427| 63.209530|  31.3945340|
|KINARDS JALAPA                     |         397| 31.738035|  65.4911839|
|King's Grant                       |        1345| 36.728625|  58.1412639|
|King's Grant 2                     |        1287| 38.073038|  57.7311577|
|KINGSBURG-STONE                    |         955| 58.638743|  39.6858639|
|KINGSTREE NO.1                     |        2112| 50.426136|  47.3011364|
|KINGSTREE NO.2                     |         611| 94.108020|   2.9459902|
|KINGSTREE NO.3                     |        1453| 91.878871|   5.9876118|
|KINGSTREE NO.4                     |         899| 78.865406|  18.4649611|
|Kingswood                          |        2118| 86.307838|  10.7176582|
|Kitti Wake                         |        1492| 31.635389|  62.1313673|
|KLINE                              |         493| 42.190669|  54.9695740|
|Knightsville                       |         898| 29.398664|  65.8129176|
|La France                          |         753| 26.958831|  68.3930943|
|Laco                               |        1098| 32.604736|  63.0236794|
|LADSON                             |        1827| 56.978654|  36.6721401|
|Ladys Island 1A                    |        1043| 34.611697|  57.8139981|
|Ladys Island 1B                    |        1036| 40.637066|  55.6949807|
|Ladys Island 2A                    |        1134| 22.398589|  71.8694885|
|Ladys Island 2B                    |         842| 28.978622|  65.6769596|
|Ladys Island 2C                    |         705| 31.063830|  61.2765957|
|Ladys Island 3A                    |         645| 29.302326|  66.5116279|
|Ladys Island 3B                    |         762| 25.853018|  69.1601050|
|Ladys Island 3C                    |         670| 27.313433|  66.4179104|
|Lake Bowen Baptist                 |        2910| 13.161512|  83.1958763|
|Lake Carolina                      |        1951| 49.000513|  45.7201435|
|LAKE CITY NO. 1                    |        1135| 77.533040|  20.0000000|
|LAKE CITY NO. 2                    |         963| 38.006231|  58.2554517|
|LAKE CITY NO. 3                    |        1230| 62.764228|  34.1463415|
|LAKE CITY NO. 4                    |        1532| 96.279373|   2.4151436|
|Lake House                         |        1574| 34.371029|  61.7534943|
|Lake Murray #1                     |        1600| 15.125000|  78.6875000|
|Lake Murray #2                     |        2204| 20.961887|  73.0943739|
|LAKE PARK                          |        3697| 29.943197|  65.4855288|
|LAKE SWAMP                         |        1235| 43.562753|  52.6315789|
|LAKE VIEW                          |        1035| 47.053140|  50.4347826|
|Lakeshore                          |        1755| 31.396011|  63.3048433|
|Lakeside                           |        1817| 41.496973|  54.9807375|
|LAKEVIEW                           |        1970| 43.096447|  50.1015228|
|Lakewood                           |        1180| 24.915254|  69.8305085|
|LAMAR NO. 1                        |         791| 64.981037|  33.7547408|
|LAMAR NO. 2                        |        1429| 40.797761|  56.6829951|
|Lancaster East                     |         939| 67.305644|  29.6059638|
|Lancaster West                     |         562| 56.939502|  36.8327402|
|Lando/Lansford                     |         818| 28.850856|  67.9706601|
|Landrum High School                |        1909| 16.396019|  80.1990571|
|Landrum United Methodist           |        2272| 21.346831|  75.5721831|
|LANE                               |         872| 91.972477|   7.4541284|
|Langley                            |         974| 23.305955|  70.7392197|
|Larne                              |         953| 29.695698|  64.5330535|
|LATTA                              |        1834| 56.652127|  40.5125409|
|Laurel Creek                       |        1046| 23.996176|  72.5621415|
|LAUREL RIDGE                       |        2007| 27.154958|  67.7130045|
|LAURENS 1                          |         479| 67.849687|  28.6012526|
|LAURENS 2                          |         386| 85.233161|  11.3989637|
|LAURENS 3                          |         593| 53.625632|  43.0016863|
|LAURENS 4                          |         580| 80.862069|  14.8275862|
|LAURENS 5                          |         922| 35.357918|  61.2798265|
|LAURENS 6                          |         704| 28.409091|  68.1818182|
|Lawrence Chapel                    |        1041| 22.382325|  70.6051873|
|Leaphart Road                      |         768| 39.973958|  52.4739583|
|LEAWOOD                            |        1803| 38.657793|  55.1858014|
|Lebanon                            |        1320| 22.575758|  73.7121212|
|LEBANON                            |         518| 55.598456|  41.6988417|
|Leesville                          |        1842| 42.779587|  53.8002172|
|LEMIRA                             |         976| 83.811475|  13.0122951|
|Lenhart                            |         931| 21.160043|  75.1879699|
|LEO                                |         293| 39.590444|  58.3617747|
|LEON                               |        1418| 52.609309|  44.0056417|
|Lesslie                            |        1127| 15.794144|  79.7692990|
|Levels No. 52                      |        1007| 40.714995|  53.0287984|
|Levels No. 72                      |         752| 38.031915|  52.9255319|
|Levels No. 83                      |         451| 42.350333|  49.0022173|
|Levy                               |        1362| 61.233480|  35.0954479|
|Lexington #3                       |        1617| 22.696351|  69.6351268|
|Lexington #4                       |        2137| 28.731867|  64.4361254|
|Lexington No. 1                    |        1829| 26.025150|  66.5390924|
|Lexington No. 2                    |        1204| 33.803987|  59.5514950|
|Liberty                            |         640| 54.218750|  42.6562500|
|Liberty Hall                       |        1812| 44.646799|  46.6887417|
|Liberty Hill                       |         424| 25.235849|  71.9339623|
|LIMESTONE 1                        |        1685| 74.124629|  24.2136499|
|LIMESTONE 2                        |         805| 63.602485|  34.1614907|
|Limestone Mill                     |         573| 50.261780|  46.4223386|
|Lincoln                            |        1137| 66.402814|  28.8478452|
|Lincolnshire                       |        1719| 96.160558|   1.7452007|
|LINCOLNVILLE                       |        1226| 52.283850|  41.6802610|
|Lincreek                           |        1534| 34.941330|  59.8435463|
|LITTLE MOUNTAIN                    |         842| 30.285036|  67.8147268|
|LITTLE RIVER #1                    |        1416| 22.175141|  73.7994350|
|LITTLE RIVER #2                    |        2330| 26.008584|  70.0858369|
|LITTLE RIVER #3                    |        1865| 24.235925|  72.8686327|
|LITTLE ROCK                        |         615| 68.455285|  29.5934959|
|LITTLE SWAMP                       |         120| 10.833333|  90.0000000|
|Littlejohn's and Sarratt's         |         325|  8.307692|  90.4615385|
|LIVE OAK                           |         659| 34.749621|  61.7602428|
|LOCKHART                           |         549| 21.675774|  72.3132969|
|LOCUST HILL                        |        1450| 14.758621|  81.3103448|
|LONE STAR                          |         845| 46.863905|  51.4792899|
|LONG BRANCH                        |         959| 18.873827|  76.5380605|
|Long Creek                         |         349| 24.068768|  68.7679083|
|LONG CREEK                         |        1285| 26.614786|  67.8599222|
|Longcreek                          |        2719| 40.161824|  54.1375506|
|Longleaf                           |        1275| 85.803922|  11.4509804|
|LORING                             |         642| 85.202492|  12.6168224|
|Lower Lake                         |         896| 14.062500|  83.0357143|
|Lowndesville                       |         863| 15.874855|  81.8076477|
|Lowrys                             |         739| 25.033829|  70.6359946|
|Lugoff No. 1                       |         831| 33.814681|  61.3718412|
|Lugoff No. 2                       |        1279| 24.784988|  70.3674746|
|Lugoff No. 3                       |        1172| 22.696246|  70.8191126|
|Lugoff No. 4                       |        1020| 19.215686|  76.2745098|
|LYDIA                              |         717| 71.548117|  26.4993026|
|LYDIA MILL                         |         831| 60.529483|  34.1756919|
|Lykesland                          |        1270| 67.480315|  28.7401575|
|Lyman Town Hall                    |        2836| 23.201693|  73.3074753|
|LYNCHBURG                          |         774| 88.888889|   9.9483204|
|Lynwood                            |         757| 24.570674|  70.8058124|
|Lynwood Drive                      |        1501| 37.908061|  58.1612258|
|Macedonia                          |        2742| 11.670314|  84.9744712|
|Mack-Edisto                        |         667| 19.490255|  75.8620690|
|MADDENS                            |         896| 26.785714|  69.0848214|
|Madison                            |         549|  8.561020|  87.7959927|
|MAGNOLIA-HARMONY                   |         463| 86.393089|  12.5269978|
|Mallet Hill                        |        1664| 68.209135|  27.6442308|
|Malvern Hill                       |        1064| 46.522556|  48.7781955|
|Manchester                         |         956| 43.410042|  50.4184100|
|MANCHESTER FOREST                  |        1135| 48.634361|  48.7224670|
|MANNING                            |         243| 44.032922|  53.0864198|
|Manning No. 1                      |         398| 63.065327|  34.6733668|
|Manning No. 2                      |         536| 57.462687|  39.9253731|
|Manning No. 3                      |         720| 32.222222|  63.8888889|
|Manning No. 4                      |         575| 85.043478|  13.9130435|
|Manning No. 5                      |         619| 52.988691|  44.2649435|
|MANVILLE                           |         585| 76.410256|  21.1965812|
|MAPLE                              |        1243| 26.790024|  70.8769107|
|MAPLE CANE                         |         701| 16.405136|  78.1740371|
|MAPLE CREEK                        |        1718| 30.325960|  64.9592549|
|MARIDELL                           |        1760| 20.056818|  75.4545455|
|MARION NO. 1                       |         909| 71.837184|  24.3124312|
|MARION NO. 2                       |         952| 47.584034|  48.5294118|
|MARION NORTH                       |        1139| 54.784899|  41.5276558|
|MARION SOUTH                       |        2098| 80.028599|  18.2554814|
|MARION WEST                        |         943| 44.008484|  53.8706257|
|MARLOWE #1                         |        2200| 24.954545|  71.4545455|
|MARLOWE #2                         |        2612| 27.220521|  70.0612557|
|MARLOWE #3                         |        1397| 28.060129|  68.2176092|
|MARS BLUFF NO. 1                   |        1522| 46.846255|  49.7371879|
|MARS BLUFF NO. 2                   |        1062| 33.050848|  63.4651601|
|Marshall Oaks                      |         412| 76.699029|  19.1747573|
|MARTIN                             |         289| 78.892734|  18.6851211|
|MARTINS-POPLAR SPRINGS             |         603| 12.271973|  84.0796020|
|MASHAWVILLE                        |         561| 58.110517|  39.3939394|
|MAULDIN 1                          |        1732| 40.935335|  52.5981524|
|MAULDIN 2                          |        2963| 34.660817|  58.7917651|
|MAULDIN 3                          |        2224| 54.001799|  40.8723022|
|MAULDIN 4                          |        2535| 38.145957|  56.5680473|
|MAULDIN 5                          |        2237| 40.143049|  53.0174341|
|MAULDIN 6                          |        1980| 40.050505|  55.5050505|
|MAULDIN 7                          |        1660| 32.289157|  59.9397590|
|Maxwellton Pike                    |         596| 13.758389|  82.2147651|
|MAYBINTON                          |          79| 79.746835|  21.5189873|
|MAYESVILLE                         |         590| 84.745763|  14.2372881|
|MAYEWOOD                           |        1051| 42.816365|  54.4243578|
|Mayo Elementary                    |        1330| 11.954887|  84.7368421|
|MAYSON                             |         378| 27.777778|  69.0476190|
|McAllister                         |         825| 22.181818|  73.4545455|
|MCALLISTER MILL                    |         623| 34.189406|  63.8844302|
|MCBEE                              |        1447| 39.599171|  56.7380788|
|McBeth                             |         804| 34.328358|  62.5621891|
|MCCLELLANVILLE                     |        1375| 70.618182|  25.8181818|
|MCCOLL                             |         703| 46.372689|  49.5021337|
|McConnells                         |        1225| 27.591837|  68.5714286|
|McCormick No. 1                    |         743| 63.257066|  32.8398385|
|McCormick No. 2                    |         582| 71.134021|  26.8041237|
|MCCRAYS MILL 1                     |        1000| 38.900000|  58.8000000|
|MCCRAYS MILL 2                     |        1107| 35.049684|  61.8789521|
|McEntire                           |         580| 57.241379|  38.7931034|
|McKissick                          |        1013| 25.765054|  70.2862784|
|Meadowfield                        |        1126| 43.161634|  50.9769094|
|Meadowlake                         |        1473| 95.926680|   1.9008826|
|MECHANICSVILLE                     |        1266| 55.924171|  41.9431280|
|Medway                             |        2643| 46.765040|  45.3651154|
|Melton                             |         599| 25.041736|  69.4490818|
|Merriweather No.1                  |        2029| 17.644160|  78.4622967|
|Merriweather No.2                  |        2389| 18.082880|  77.5638342|
|METHODIST-MILL SWAMP               |         745|  3.758389|  93.9597315|
|MIDDENDORF                         |         607| 13.179572|  83.6902801|
|Midland Valley No. 51              |        1583| 28.932407|  66.7719520|
|Midland Valley No. 71              |        1537| 26.545218|  70.1366298|
|Midway                             |        3274| 51.099572|  43.8301772|
|MIDWAY                             |         552| 20.471014|  77.1739130|
|Miles/Jamison                      |        1402| 32.881598|  60.2710414|
|MILL BRANCH                        |         616| 69.155844|  27.9220779|
|Mill Creek                         |        1811| 48.536720|  47.1010491|
|Millbrook                          |        1273| 28.436764|  65.5145326|
|MILLWOOD                           |         487| 45.790554|  45.9958932|
|Mimosa Crest                       |         525| 33.523809|  61.7142857|
|Mims                               |        1088| 20.955882|  75.2757353|
|MINTURN                            |         174| 66.091954|  31.6091954|
|MISSION                            |        1997| 27.491237|  67.2008012|
|Misty Lakes                        |        1421| 35.327234|  60.3096411|
|MITFORD                            |         704| 54.687500|  43.4659091|
|Modoc                              |         248|  7.661290|  90.7258065|
|MONARCH BOX 1                      |         840| 24.047619|  68.6904762|
|MONARCH BOX 2                      |         252| 36.111111|  61.9047619|
|MONAVIEW                           |        1402| 46.005706|  46.7189729|
|Moncks Corner 1                    |        1193| 38.893546|  57.4182733|
|Moncks Corner 2                    |        1165| 45.751073|  49.6995708|
|Moncks Corner 3                    |        1478| 48.849797|  46.3464141|
|Moncks Corner 4                    |        1527| 22.658808|  73.0844794|
|Monetta                            |        1074| 50.744879|  46.6480447|
|Monticello                         |        1631| 55.180871|  42.1827100|
|MONTICELLO                         |         513| 77.192982|  18.9083821|
|Montmorenci No. 22                 |        1326| 32.277526|  62.8959276|
|Montmorenci No. 78                 |         768| 35.416667|  59.3750000|
|MOORE CREEK                        |        2699| 41.200445|  53.7236013|
|Morgan                             |        1063| 11.288805|  86.4534337|
|Morningside Baptist                |        1301| 31.591084|  64.6425826|
|MORRIS COLLEGE                     |         723| 92.807745|   5.3941909|
|Morrison                           |         878| 41.002278|  47.4943052|
|MORRISVILLE                        |         261| 95.785441|   3.8314176|
|MOSS CREEK                         |        1430| 32.377622|  63.0769231|
|Mossy Oaks 1A                      |         717| 31.241283|  64.0167364|
|Mossy Oaks 1B                      |         828| 27.053140|  66.7874396|
|Mossy Oaks 2                       |         792| 36.742424|  56.0606061|
|Motlow Creek Baptist               |         950| 12.631579|  83.7894737|
|Moultrie                           |        1142| 80.035026|  17.5131349|
|Mount Horeb                        |        1469| 17.767189|  75.7658271|
|MOUNT OLIVE                        |         884| 11.651584|  85.9728507|
|Mount Tabor                        |        1922| 25.650364|  71.0718002|
|MOUNT VERNON                       |         392| 62.500000|  33.9285714|
|Mountain Creek                     |         946| 25.687104|  70.8245243|
|MOUNTAIN CREEK                     |        1948| 16.273101|  77.9774127|
|Mountain Laurel                    |         672| 52.678571|  41.3690476|
|Mountain Rest                      |         776| 18.943299|  77.1907216|
|Mountain View                      |        1059| 15.108593|  81.2086874|
|MOUNTAIN VIEW                      |        2060| 11.601942|  85.0970874|
|Mountain View Baptist              |         930| 13.225806|  82.0430108|
|MOUNTVILLE                         |         553| 36.528029|  59.8553345|
|Mt Hebron                          |        1049| 32.697807|  61.7731173|
|Mt. Airy                           |        2115| 14.893617|  81.7494090|
|MT. BETHERL GARMANY                |         834| 59.112710|  38.6091127|
|MT. CALVARY                        |        1564| 69.948849|  26.6624041|
|Mt. Calvary Presbyterian           |        2175|  9.931035|  86.0689655|
|Mt. Carmel                         |         239| 86.610879|  12.5523013|
|MT. CLIO                           |         240| 86.666667|  11.6666667|
|Mt. Gallant                        |        1275| 24.862745|  70.8235294|
|MT. GROGHAN                        |         293| 28.327645|  68.9419795|
|Mt. Holly                          |        2061| 45.705968|  49.9757399|
|Mt. Moriah Baptist                 |         923| 84.832069|  11.7009751|
|MT. OLIVE                          |         822| 27.615572|  69.7080292|
|MT. PLEASANT                       |        1348| 79.599407|  16.6913947|
|MT. PLEASANT 1                     |         976| 43.237705|  50.2049180|
|MT. PLEASANT 10                    |         604| 28.807947|  63.2450331|
|MT. PLEASANT 11                    |         713| 37.587658|  54.1374474|
|MT. PLEASANT 12                    |        1284| 37.694704|  54.7507788|
|MT. PLEASANT 13                    |         742| 37.870620|  52.5606469|
|MT. PLEASANT 14                    |         944| 40.889831|  50.1059322|
|MT. PLEASANT 15                    |        1390| 42.805755|  50.7913669|
|MT. PLEASANT 16                    |         444| 29.729730|  61.9369369|
|MT. PLEASANT 17                    |        1538| 31.209363|  60.7932380|
|MT. PLEASANT 18                    |         814| 28.746929|  62.4078624|
|MT. PLEASANT 19                    |        1176| 40.476191|  50.4251701|
|MT. PLEASANT 2                     |         601| 37.936772|  50.5823627|
|MT. PLEASANT 20                    |         990| 45.050505|  48.0808081|
|MT. PLEASANT 21                    |         794| 36.775819|  55.0377834|
|MT. PLEASANT 22                    |         738| 44.850949|  48.3739837|
|MT. PLEASANT 23                    |        1114| 48.384201|  42.6391382|
|MT. PLEASANT 24                    |         483| 36.645963|  54.2443064|
|MT. PLEASANT 25                    |         497| 28.973843|  63.9839034|
|MT. PLEASANT 26                    |         401| 95.261845|   3.2418953|
|MT. PLEASANT 27                    |        1637| 32.437385|  59.5601710|
|MT. PLEASANT 28                    |         795| 30.314465|  58.9937107|
|MT. PLEASANT 29                    |         194| 35.567010|  59.2783505|
|MT. PLEASANT 3                     |         975| 43.384615|  48.1025641|
|MT. PLEASANT 30                    |        1597| 33.437696|  59.9248591|
|MT. PLEASANT 31                    |         804| 40.298507|  55.3482587|
|MT. PLEASANT 32                    |        1588| 29.534005|  64.6095718|
|MT. PLEASANT 33                    |        2335| 26.381156|  67.3661670|
|MT. PLEASANT 34                    |         895| 34.189944|  59.7765363|
|MT. PLEASANT 35                    |        2678| 30.731890|  61.9865571|
|MT. PLEASANT 36                    |        1213| 40.148392|  50.7007420|
|MT. PLEASANT 37                    |        2206| 48.640073|  45.3762466|
|MT. PLEASANT 38                    |         907| 25.689085|  67.1444322|
|MT. PLEASANT 39                    |        1539| 29.889539|  65.0422352|
|MT. PLEASANT 4                     |        1006| 39.463221|  52.6838966|
|MT. PLEASANT 5                     |         845| 33.846154|  58.3431953|
|MT. PLEASANT 6                     |        1269| 36.170213|  55.0039401|
|MT. PLEASANT 7                     |         580| 38.793103|  53.4482759|
|MT. PLEASANT 8                     |         551| 40.290381|  53.1760436|
|MT. PLEASANT 9                     |         647| 31.530139|  60.7418856|
|MT. VERNON                         |         581| 12.564544|  85.0258176|
|MT. WILLING                        |         202| 24.257426|  74.2574257|
|Mt. Zion Gospel Baptist            |         594| 58.417508|  38.7205387|
|MUDDY CREEK                        |         778| 33.033419|  63.7532134|
|MULBERRY                           |         668| 72.155689|  25.0000000|
|MURPH MILL                         |         359| 55.153203|  43.1754875|
|Murraywood                         |        1490| 34.161074|  59.9328859|
|MURRELL'S INLET NO. 1              |        2616| 24.197248|  72.5535168|
|MURRELL'S INLET NO. 2              |        1620| 27.469136|  69.4444444|
|MURRELL'S INLET NO. 3              |         641| 26.833073|  71.1388456|
|MURRELL'S INLET NO. 4              |        1220| 15.819672|  80.7377049|
|Musgrove Mill                      |         993| 28.398792|  68.7814703|
|MYERSVILLE                         |         508| 91.535433|   7.4803150|
|MYRTLE TRACE                       |        1209| 27.212572|  67.5765095|
|MYRTLEWOOD #1                      |        1029| 33.819242|  60.9329446|
|MYRTLEWOOD #2                      |        1461| 29.774127|  67.5564682|
|MYRTLEWOOD #3                      |        1542| 25.162127|  71.0116732|
|N BENNETTSVILLE                    |        1037| 52.748312|  44.6480231|
|N EAST MULLINS                     |        1408| 67.400568|  29.4744318|
|N WEST MULLINS                     |        1262| 76.941363|  21.0776545|
|N. Augusta No. 25                  |        1075| 38.790698|  55.5348837|
|N. Augusta No. 26                  |         888| 44.031531|  51.3513514|
|N. Augusta No. 27                  |        1325| 13.962264|  81.4339623|
|N. Augusta No. 28                  |         999| 19.819820|  75.2752753|
|N. Augusta No. 29                  |         986| 28.194726|  65.6186613|
|N. Augusta No. 54                  |         986| 54.259635|  41.0750507|
|N. Augusta No. 55                  |         888| 22.409910|  70.6081081|
|N. Augusta No. 67                  |        1033| 19.167473|  74.8305905|
|N. Augusta No. 68                  |        1759| 19.840819|  74.9857874|
|N. Augusta No. 80                  |         680| 22.352941|  72.2058824|
|Nation Ford                        |        1995| 34.586466|  59.7994987|
|Neal's Creek                       |        1442| 34.604716|  61.3730929|
|NEELY FARMS                        |        3152| 30.488579|  64.2449239|
|Neelys Creek                       |         783| 25.542784|  69.7318008|
|NEESES-LIVINGSTON                  |         871| 40.068886|  57.6349024|
|NESMITH                            |         586| 86.518771|  10.0682594|
|New Castle                         |         709| 21.438646|  73.9069111|
|New Ellenton                       |        1447| 48.168625|  48.4450587|
|New Holland                        |         668| 20.359281|  74.8502994|
|NEW HOLLY                          |         314| 40.127389|  58.5987261|
|New Home                           |        1732| 26.039261|  69.4572748|
|New Hope                           |        1431| 14.884696|  80.4332635|
|NEW HOPE                           |          57| 38.596491|  59.6491228|
|New Market                         |         742| 42.048518|  54.9865229|
|NEW MARKET                         |         905| 12.375691|  84.1988950|
|New Zion                           |         425| 38.352941|  60.0000000|
|NEWBERRY WD 1                      |         282| 60.992908|  36.1702128|
|NEWBERRY WD 2                      |         621| 33.977456|  58.2930757|
|NEWBERRY WD 3                      |         599| 58.096828|  37.3956594|
|NEWBERRY WD 4                      |         402| 88.059702|  10.6965174|
|NEWBERRY WD 5                      |         547| 87.934186|   7.8610603|
|NEWBERRY WD 6                      |         685| 53.576642|  42.0437956|
|Newington                          |         877| 25.769669|  67.6168757|
|Newington 2                        |         509| 20.235756|  73.0844794|
|Newport                            |        1314| 29.908676|  64.0791476|
|Newry-Corinth                      |         221| 27.601810|  68.7782805|
|NICHOLS                            |         602| 43.355482|  52.1594684|
|Nine Forks                         |        1158|  9.067357|  87.7374784|
|Ninety Nine and Cherokee Falls     |         721|  9.015257|  88.2108183|
|Ninety Six                         |         651| 42.703533|  52.9953917|
|Ninety Six Mill                    |         593| 13.322091|  82.1247892|
|NIX                                |        1089| 97.887971|   0.8264463|
|NIXONS XROADS #1                   |        1484| 26.549865|  70.4851752|
|NIXONS XROADS #2                   |        2296| 38.588850|  58.1881533|
|NIXONS XROADS #3                   |        1467| 30.947512|  65.9168371|
|Norris                             |        1047| 14.422159|  82.9990449|
|NORTH 1                            |        1059| 58.356941|  40.0377715|
|NORTH 2                            |        1090| 48.715596|  49.1743119|
|NORTH BAMBERG                      |        1337| 50.635752|  46.5220643|
|North Central                      |         912| 24.232456|  69.0789474|
|NORTH CHARLESTON 1                 |         645| 93.953488|   3.1007752|
|NORTH CHARLESTON 10                |         982| 78.513238|  16.1914460|
|NORTH CHARLESTON 11                |         627| 42.105263|  47.8468900|
|NORTH CHARLESTON 12                |         549| 47.723133|  38.2513661|
|NORTH CHARLESTON 13                |         704| 88.352273|   8.5227273|
|NORTH CHARLESTON 14                |         443| 64.785553|  26.8623025|
|NORTH CHARLESTON 15                |         829| 82.147165|  12.5452352|
|NORTH CHARLESTON 16                |         616| 80.681818|  15.9090909|
|NORTH CHARLESTON 17                |         500| 89.000000|   7.6000000|
|NORTH CHARLESTON 18                |        1102| 78.765880|  16.5154265|
|NORTH CHARLESTON 19                |         667| 82.008995|  14.5427286|
|NORTH CHARLESTON 2                 |         288| 93.402778|   4.5138889|
|NORTH CHARLESTON 20                |         471| 49.893843|  45.6475584|
|NORTH CHARLESTON 21                |         805| 69.192547|  25.3416149|
|NORTH CHARLESTON 22                |         963| 72.481828|  23.1568017|
|NORTH CHARLESTON 23                |        1145| 58.253275|  36.4192140|
|NORTH CHARLESTON 24                |        1500| 70.133333|  24.4000000|
|NORTH CHARLESTON 25                |         503| 84.890656|  10.5367793|
|NORTH CHARLESTON 26                |         382| 86.649215|  11.5183246|
|NORTH CHARLESTON 27                |         705| 73.617021|  22.2695035|
|NORTH CHARLESTON 28                |         458| 79.694323|  15.2838428|
|NORTH CHARLESTON 29                |         565| 67.079646|  28.6725664|
|NORTH CHARLESTON 3                 |         859| 38.300349|  55.5296857|
|NORTH CHARLESTON 30                |        1320| 72.045455|  22.7272727|
|NORTH CHARLESTON 4                 |         751| 86.418109|  10.7856192|
|NORTH CHARLESTON 5                 |        1224| 92.565359|   4.4934641|
|NORTH CHARLESTON 6                 |         981| 92.558614|   3.4658512|
|NORTH CHARLESTON 7                 |        1011| 91.295747|   6.2314540|
|NORTH CHARLESTON 8                 |         520| 52.500000|  38.0769231|
|NORTH CHARLESTON 9                 |         975| 60.512820|  31.0769231|
|NORTH CONWAY #1                    |        1136| 45.246479|  50.3521127|
|NORTH CONWAY #2                    |         919| 28.944505|  66.3764962|
|North Forest Acres                 |         921| 51.791531|  40.8251900|
|North Liberty                      |         925| 16.216216|  78.8108108|
|North Pickens                      |        1010|  8.118812|  87.3267327|
|North Pointe                       |        1205| 20.000000|  75.1867220|
|North Side                         |         401| 58.603491|  39.6508728|
|North Springs 1                    |         816| 59.068627|  36.0294118|
|North Springs 2                    |        1693| 56.999409|  36.6213822|
|North Springs 3                    |        1495| 77.324415|  18.1270903|
|North Summerville                  |         292| 36.986301|  58.5616438|
|North Summerville 2                |         830| 72.168675|  23.1325301|
|Northside                          |         913| 51.369113|  38.7732749|
|Northwestern                       |        1522| 24.901446|  69.5795007|
|NORTHWOOD                          |        1720| 26.220930|  66.2209302|
|NORWAY                             |        1203| 66.749792|  30.8395677|
|O'NEAL                             |        1054| 18.406072|  77.6091082|
|Oak Grove                          |         873| 20.389462|  74.7995418|
|OAK GROVE                          |         690| 33.333333|  63.6231884|
|OAK GROVE-SARDIS                   |         883| 18.006795|  79.2751982|
|Oak Pointe 1                       |        1006| 42.246521|  51.2922465|
|Oak Pointe 2                       |         588| 37.414966|  55.7823129|
|Oak Pointe 3                       |         831| 49.458484|  42.2382671|
|Oakatie                            |         913| 45.016429|  48.5213582|
|Oakbrook                           |        1776| 42.173423|  50.3941441|
|Oakbrook 2                         |         995| 37.587940|  55.5778894|
|Oakdale                            |         286| 56.643357|  41.6083916|
|OAKLAND                            |        1297| 71.703932|  24.5952197|
|Oakland Elementary                 |        1539| 15.659519|  79.0123457|
|OAKLAND PLANTATION 1               |         835| 42.754491|  52.9341317|
|OAKLAND PLANTATION 2               |         691| 38.494935|  57.5976845|
|Oakridge                           |        1895| 27.387863|  69.2875989|
|OAKVIEW                            |        2488| 24.919614|  69.3327974|
|Oakway                             |        1105| 14.298642|  81.5384615|
|Oakwood                            |        3859| 31.899456|  61.3371340|
|OATES                              |         936| 38.888889|  58.5470085|
|OCEAN DRIVE #1                     |        1732| 23.787529|  72.4018476|
|OCEAN DRIVE #2                     |        2628| 19.596651|  78.4246575|
|OCEAN FOREST #1                    |        1279| 26.348710|  69.8983581|
|OCEAN FOREST #2                    |        1374| 28.602620|  67.1033479|
|OCEAN FOREST #3                    |         893| 41.769317|  51.8477044|
|Ogden                              |        1708| 47.482436|  48.4777518|
|OLANTA                             |        1231| 46.953696|  50.1218522|
|OLAR                               |         339| 46.312684|  52.2123894|
|Old 52                             |         587| 36.967632|  57.7512777|
|Old Barnwell Rd                    |        1171| 34.756618|  58.5824082|
|Old Friarsgate                     |         986| 52.535497|  42.0892495|
|Old Lexington                      |        2280| 17.192982|  76.0526316|
|Old Pointe                         |        1228| 42.508143|  50.8143322|
|Olympia                            |        1352| 65.606509|  26.2573964|
|ONEAL                              |        2498| 14.891913|  81.1048839|
|ORA-LANFORD                        |         753| 33.598938|  62.0185923|
|ORANGEBURG WD 1                    |         541| 60.813309|  36.5988909|
|ORANGEBURG WD 10                   |         546| 61.721612|  35.7142857|
|ORANGEBURG WD 2                    |         439| 94.305239|   5.2391800|
|ORANGEBURG WD 3                    |         794| 95.843829|   3.4005038|
|ORANGEBURG WD 4                    |        1206| 96.600332|   1.0779436|
|ORANGEBURG WD 5                    |         386| 91.968912|   6.7357513|
|ORANGEBURG WD 6                    |         559| 79.069767|  18.4257603|
|ORANGEBURG WD 8                    |         445| 54.382022|  43.3707865|
|ORANGEBURG WD 9                    |         432| 74.305556|  22.9166667|
|Orchard Park                       |        1565| 31.309904|  60.8306709|
|ORNAGEBURG WD 7                    |         517| 57.833656|  40.2321083|
|Osceola                            |        2189| 33.394244|  61.9460941|
|OSWEGO                             |         843| 38.315540|  59.0747331|
|OUSLEYDALE                         |         618| 13.430421|  81.8770227|
|OWINGS                             |         691| 30.680174|  64.8335745|
|Pacolet Elementary                 |        1863| 28.609769|  68.5990338|
|PAGELAND NO. 1                     |        1461| 48.528405|  49.2128679|
|PAGELAND NO. 2                     |        1353| 43.976349|  52.5498891|
|Palmetto                           |        1881| 34.343434|  58.7985114|
|PALMETTO                           |        3072| 42.285156|  52.1158854|
|PALMETTO BAYS                      |        2700| 24.925926|  71.2222222|
|PALMETTO PARK                      |         727| 52.407153|  43.1911967|
|PAMPLICO NO. 1                     |         910| 29.890110|  67.6923077|
|PAMPLICO NO. 2                     |         632| 74.841772|  22.3101266|
|Panola                             |         216| 76.388889|  22.2222222|
|PARIS MOUNTAIN                     |        1191| 23.845508|  69.3534845|
|Park Hills Elementary              |        1308| 83.333333|  13.6085627|
|Park Road #1                       |        1290| 25.503876|  66.7441860|
|Park Road #2                       |         718| 25.069638|  69.0807799|
|Parkridge 1                        |         610| 51.639344|  41.1475410|
|Parkridge 2                        |         658| 59.878419|  33.7386018|
|Parksville                         |         163| 12.269939|  84.0490798|
|Parkway 1                          |        1689| 78.685613|  16.7554766|
|Parkway 2                          |        1515| 69.966997|  24.6864686|
|Parkway 3                          |        1252| 86.741214|   9.9840256|
|Parson's Mill                      |         582| 34.879725|  58.5910653|
|PATRICK                            |         558| 39.247312|  55.1971326|
|Patriot                            |        1103| 70.716228|  24.3880326|
|Pauline Glenn Springs Elementary   |         919| 14.254625|  83.2426551|
|PAWLEY'S ISLAND NO. 1              |        1959| 26.186830|  69.8315467|
|PAWLEY'S ISLAND NO. 2              |        2040| 40.539216|  55.0980392|
|PAWLEY'S ISLAND NO. 3              |        1559| 25.144323|  70.8787684|
|PAWLEY'S ISLAND NO. 4              |        1494| 20.348059|  74.0294511|
|PAWLEY'S ISLAND NO. 5              |        1720| 23.546512|  72.5000000|
|PAWLEYS SWAMP                      |         551| 13.430127|  81.8511797|
|Paxville                           |         756| 58.201058|  36.2433862|
|PEAK                               |         108| 25.000000|  72.2222222|
|PEBBLE CREEK                       |        1916| 23.538622|  71.1899791|
|PEE DEE                            |         242| 19.421488|  79.7520661|
|PEEPLES                            |         763| 40.891219|  55.5701180|
|PELHAM FALLS                       |        1030| 26.213592|  67.6699029|
|Pelham Fire Station                |        1575| 28.317460|  65.2063492|
|Pelion #1                          |        1078| 12.430427|  82.9313544|
|Pelion #2                          |        1176| 19.132653|  75.7653061|
|Pelzer                             |         671| 11.326379|  83.4575261|
|Pendleton                          |        3066| 36.138291|  57.6320939|
|PENIEL                             |         561| 43.493761|  50.6238859|
|Pennington 1                       |         799| 20.775970|  73.9674593|
|Pennington 2                       |         939| 42.492013|  49.0947817|
|PENNY ROYAL                        |         358| 34.078212|  65.0837989|
|PERGAMOS                           |         218| 44.954128|  54.1284404|
|Perry                              |         769| 33.289987|  61.6384915|
|PETITS                             |         182| 33.516483|  59.3406593|
|Pickensville                       |         899| 19.354839|  75.6395996|
|Piedmont                           |         734| 20.708447|  74.7956403|
|PIEDMONT                           |        2181| 31.636864|  63.0444750|
|Piercetown                         |        1710| 15.146199|  80.2923977|
|Pike                               |         800| 35.500000|  56.7500000|
|Pilgrim Church                     |        1941| 21.638331|  70.7367336|
|Pimlico                            |        2403| 27.340824|  66.2505202|
|Pine Forest                        |        1493| 18.486269|  77.0931011|
|Pine Grove                         |        1241| 87.671233|   9.5890411|
|PINE HILL                          |         955| 61.256544|  36.5445026|
|Pine Lakes 1                       |         748| 87.834225|   7.3529412|
|Pine Lakes 2                       |         938| 88.166311|   8.4221748|
|Pinecrest                          |         669| 35.575486|  59.1928251|
|Pineland                           |         494| 84.412955|   9.5141700|
|Pineridge #1                       |         961| 26.222685|  66.4932362|
|Pineridge #2                       |        1599| 35.209506|  61.1632270|
|Pineview                           |        1320| 25.303030|  69.0151515|
|PINEVIEW                           |        1056| 15.814394|  80.3030303|
|Pinewood                           |        1193| 81.810562|  13.6630344|
|PINEWOOD                           |        1415| 51.802120|  45.8657244|
|PINEY FOREST                       |         403|  3.225807|  95.0372208|
|Pinopolis                          |        1370| 16.861314|  80.5109489|
|PLANTERSVILLE                      |         695| 80.863309|  18.4172662|
|Platt Springs 1                    |        1088| 20.128677|  74.7242647|
|Platt Springs 2                    |        1921| 40.239459|  54.1384695|
|PLEASANT CROSS                     |         212| 54.716981|  45.7547170|
|Pleasant Grove                     |         754| 50.928382|  47.3474801|
|PLEASANT GROVE                     |         586| 13.481229|  84.1296928|
|Pleasant Hill                      |         938| 35.181237|  60.8742004|
|PLEASANT HILL                      |         945| 36.613757|  59.4708995|
|Pleasant Meadows                   |         566| 72.084806|  25.6183746|
|Pleasant Road                      |        1496| 30.414438|  65.7085561|
|Pleasant Valley                    |        2408| 36.544851|  57.3089701|
|PLEASANT VIEW                      |         232| 19.396552|  79.7413793|
|Plum Branch                        |         632| 55.063291|  42.0886076|
|POCOTALIGO 1                       |        1201| 38.467943|  58.3680266|
|POCOTALIGO 2                       |         925| 53.621622|  43.5675676|
|POINSETT                           |        2006| 29.661017|  64.1076770|
|Pole Branch                        |        1340| 26.343284|  67.9104478|
|Polo Road                          |        1540| 70.519481|  25.0000000|
|PONARIA                            |         530| 27.735849|  67.9245283|
|Pond Branch                        |        1532| 15.665796|  78.7859008|
|Pontiac 1                          |        1537| 54.326610|  42.1600520|
|Pontiac 2                          |         919| 42.219804|  51.1425462|
|Pope Field                         |         733| 24.283765|  70.9413370|
|POPLAR HILL                        |         746|  9.517426|  88.2037534|
|Poplar Springs Fire Station        |        1850| 24.108108|  72.1621622|
|PORT HARRELSON                     |         850| 92.000000|   6.2352941|
|PORT ROYAL 1                       |         764| 42.146597|  52.2251309|
|PORT ROYAL 2                       |         762| 47.900262|  45.8005249|
|Possum Hollow                      |        1970| 32.131980|  63.1979695|
|POTATO BED FERRY                   |         678| 42.920354|  54.5722714|
|Powdersville                       |        2498| 20.936749|  75.2201761|
|Powell Saxon Una                   |        1185| 71.729958|  24.1350211|
|Praters Creek                      |         754|  6.100796|  90.1856764|
|PRINCETON                          |         239| 12.133891|  82.8451883|
|PRIVATEER                          |        1202| 25.623960|  69.8003328|
|PROSPECT                           |         337|  5.934718|  90.8011869|
|PROSPERITY                         |        1324| 45.996979|  50.7552870|
|PROVIDENCE                         |        1084| 74.169742|  24.8154982|
|Providence Church                  |        1795| 15.821727|  79.0529248|
|Provisional                        |        2449| 45.692119|  49.8979175|
|Provisional 1                      |         161| 32.298137|  65.2173913|
|PROVISIONAL 1                      |         199| 35.678392|  56.7839196|
|Provisional 2                      |         309| 52.427185|  43.3656958|
|PROVISIONAL 2                      |         123| 33.333333|  62.6016260|
|Provisional 3                      |         117| 41.880342|  55.5555556|
|Provisional 4                      |          46| 17.391304|  76.0869565|
|Pumpkintown                        |        1305| 16.321839|  79.7701149|
|PUTMAN                             |         547| 17.001828|  79.7074954|
|Quail Hollow                       |        1307| 34.276970|  58.6074981|
|Quail Valley                       |        1579| 41.228626|  53.1982267|
|QUICKS X ROADS                     |         590| 56.779661|  39.3220339|
|QUINBY                             |         682| 73.167155|  23.7536657|
|R.D. Anderson Vocational           |        1392| 13.649425|  82.5431034|
|Rabon's X Roads                    |        1417| 19.548342|  77.0642202|
|RACEPATH #1                        |         938| 52.985075|  43.1769723|
|RACEPATH #2                        |        1173| 92.412617|   5.4560955|
|RAINS                              |         698| 73.638969|  23.2091691|
|RAINTREE                           |        2531| 34.650336|  59.5416831|
|RANCH CREEK                        |        2398| 52.752294|  41.9933278|
|RATTLESNAKE SPRINGS                |         348| 53.735632|  44.2528736|
|Ravenel                            |        1805| 32.576177|  62.7146814|
|Rebirth Missionary Baptist         |        2615| 22.523901|  71.7399618|
|Red Bank                           |        2308| 24.046794|  70.5372617|
|Red Bank South #1                  |        1622| 19.728730|  75.1541307|
|RED BLUFF                          |         917| 45.147219|  51.3631407|
|RED HILL                           |         640| 47.500000|  50.7812500|
|RED HILL #1                        |         941| 24.548353|  69.2879915|
|RED HILL #2                        |        1972| 31.440162|  64.4016227|
|Redbank South #2                   |        1283| 26.890101|  66.9524552|
|Redds Branch                       |         918| 31.263617|  63.0718954|
|REEDY FORK                         |        1730| 45.491329|  50.6936416|
|Reevesville                        |         879| 51.877133|  45.2787258|
|Reidville Elementary               |        2506| 20.510774|  75.4588986|
|Reidville Fire Station             |        2457| 25.641026|  69.8005698|
|REMBERT                            |        1511| 85.771013|  12.8391794|
|Return                             |         639| 12.050078|  85.1330203|
|Rice Creek 1                       |        1199| 81.234362|  15.0959133|
|Rice Creek 2                       |        1679| 74.687314|  20.8457415|
|RICE PATCH                         |         485| 38.350516|  57.1134021|
|Rices Creek                        |        1052| 11.121673|  85.4562738|
|Rich Hill                          |         861| 14.750290|  81.5331010|
|Richburg                           |        1103| 36.718042|  59.2021759|
|Richland                           |         871| 16.303100|  78.8748565|
|RICHLAND                           |         542| 21.955720|  75.4612546|
|Ridge Road                         |        1618| 12.360939|  83.3745365|
|RIDGE SPRING - MONETTA             |         772| 59.585492|  37.5647668|
|Ridge View 1                       |        1412| 71.317280|  24.3626062|
|Ridge View 2                       |        1764| 71.882086|  22.7891156|
|Ridgeland 1                        |         633| 30.489731|  65.0868878|
|Ridgeland 2                        |         660| 48.333333|  46.6666667|
|Ridgeland 3                        |         486| 34.362140|  60.9053498|
|Ridgeville                         |         699| 46.351931|  50.2145923|
|Ridgeville 2                       |         610| 53.770492|  43.4426230|
|RIDGEWAY                           |        1607| 68.388301|  28.8736777|
|Ridgewood                          |         587| 94.889268|   2.3850085|
|Riley                              |         186| 39.784946|  59.1397849|
|RITTER                             |         582| 71.821306|  26.4604811|
|River's Edge                       |        1454| 22.696011|  71.2517194|
|River Bluff                        |        1794| 24.024526|  67.7257525|
|River Hills                        |        1773| 27.072758|  69.4867456|
|RIVER OAKS                         |        1730| 23.410405|  72.8323699|
|River Ridge Elementary             |        1673| 31.320980|  63.8374178|
|River Road                         |        1533| 28.701892|  68.0365297|
|Riverdale                          |         660| 85.454545|  12.2727273|
|Rivers Mill                        |          65| 61.538461|  32.3076923|
|Riverside                          |        1697| 60.813200|  33.6476134|
|RIVERSIDE                          |        2016| 35.367064|  58.2341270|
|Riversprings 1                     |         809| 25.463535|  66.6254635|
|Riversprings 2                     |        1112| 48.830935|  46.3129496|
|Riversprings 3                     |         966| 39.544514|  55.5900621|
|Riverview                          |        1107| 31.707317|  61.4272809|
|Riverwalk                          |        1906| 60.230850|  34.3651626|
|RIVERWALK                          |        2347| 24.073285|  70.7285897|
|Rock Creek                         |        1205| 21.576763|  74.1908714|
|ROCK HILL                          |        1982| 37.941473|  55.0454087|
|Rock Hill No. 2                    |         982| 95.519348|   2.2403259|
|Rock Hill No. 3                    |        1566| 90.166028|   7.0881226|
|Rock Hill No. 4                    |        1284| 55.607477|  38.3177570|
|Rock Hill No. 5                    |        1045| 48.421053|  43.5406699|
|Rock Hill No. 6                    |        1012| 78.656126|  17.5889328|
|Rock Hill No. 7                    |        1656| 52.053140|  41.6062802|
|Rock Hill No. 8                    |         763| 88.204456|   8.3879423|
|Rock Mill                          |         934| 17.558886|  80.0856531|
|Rock Spring                        |         668| 25.449102|  71.2574850|
|Rock Springs                       |        1023| 19.061584|  76.7350929|
|ROCKY CREEK                        |        1647| 38.858531|  55.3126897|
|Rodman                             |         812| 31.650246|  64.6551724|
|Roebuck Bethlehem                  |         987| 45.592705|  50.9625127|
|Roebuck Elementary                 |        1911| 48.613292|  47.7760335|
|ROLLING GREEN                      |        1492| 25.000000|  71.2466488|
|Roosevelt                          |        1127| 41.526176|  54.2147294|
|ROSE HILL                          |        1504| 23.204787|  72.3404255|
|Rosewood                           |        2346| 49.360614|  43.8192668|
|Rosinville                         |        1178| 49.066214|  48.5568761|
|Rosses                             |         876| 41.552511|  55.5936073|
|Rossville                          |         356| 33.707865|  64.8876404|
|Round Hill                         |        2599| 22.393228|  71.5275106|
|ROUND O                            |         675| 34.222222|  61.3333333|
|Round Top                          |         601| 67.554076|  29.1181364|
|ROWESVILLE                         |         578| 61.937716|  37.0242215|
|ROYAL OAKS                         |        1291| 87.529047|   9.4500387|
|Royle                              |        1060| 34.245283|  60.0000000|
|RUBY                               |         781| 42.509603|  54.5454545|
|RUFFIN                             |         211| 46.919431|  51.6587678|
|Russellville                       |         990| 82.626263|  14.6464646|
|Rutherford Shoals                  |         643| 35.769829|  61.5863142|
|S BENNETTSVILLE                    |         552| 88.586956|   7.4275362|
|S EAST MULLINS                     |         932| 33.798283|  61.9098712|
|S WEST MULLINS                     |        1133| 67.343336|  30.3618711|
|Saint Helena 1A                    |         880| 80.340909|  17.1590909|
|Saint Helena 1B                    |        1011| 77.645895|  20.0791296|
|Saint Helena 1C                    |        1112| 28.237410|  67.3561151|
|Saint Helena 2A                    |         918| 58.496732|  38.6710240|
|Saint Helena 2B                    |         970| 73.711340|  22.9896907|
|Saint Helena 2C                    |         889| 27.446569|  69.5163105|
|Salem                              |        1515| 12.607261|  83.8283828|
|SALEM                              |        2595| 27.283237|  67.7071291|
|Salley                             |         667| 58.620690|  38.6806597|
|Salt Pond                          |        1157| 24.373379|  70.8729473|
|SALTERS                            |         981| 85.626911|  12.4362895|
|SALTERSTOWN                        |         656| 43.445122|  52.4390244|
|Saluda                             |        1067| 20.243674|  75.9137769|
|SALUDA                             |        1364| 33.724340|  61.7302053|
|SALUDA NO. 1                       |        1072| 73.600746|  23.8805970|
|SALUDA NO. 2                       |         868| 45.622120|  50.3456221|
|Saluda River                       |        1274| 45.918367|  45.7613815|
|SAMPIT                             |         919| 82.154516|  16.2132753|
|Sandhill                           |        1255| 30.916335|  64.2231076|
|Sandlapper                         |        1839| 77.379010|  18.5426862|
|Sandridge                          |         589| 15.280136|  82.1731749|
|Sandstone No. 70                   |        1033| 30.590513|  62.1490803|
|Sandstone No. 79                   |         527| 34.155598|  60.5313093|
|SANDY BAY                          |         326| 26.380368|  72.6993865|
|SANDY FLAT                         |        2994| 14.228457|  80.8951236|
|Sandy Run                          |         777| 31.917632|  64.0926641|
|SANDY RUN                          |        1471| 24.881033|  72.1278042|
|Sangaree 1                         |         846| 33.215130|  59.2198582|
|Sangaree 2                         |        1199| 34.945788|  60.2168474|
|Sangaree 3                         |        1083| 33.795014|  59.9261311|
|SANTEE                             |         978| 83.742331|  14.6216769|
|SANTEE 1                           |        1145| 38.340611|  59.4759825|
|SANTEE 2                           |        1161| 95.348837|   3.2730405|
|SANTUCK                            |         728| 65.659341|  30.4945055|
|Sardina-Gable                      |         374| 71.390374|  28.3422460|
|SARDIS                             |         445|  8.539326|  87.1910112|
|Satchelford                        |         985| 34.923858|  58.8832487|
|Saul Dam                           |         324| 23.765432|  69.1358025|
|SAVAGE-GLOVER                      |         454| 96.916300|   0.8810573|
|Savannah                           |         844| 17.417062|  80.0947867|
|SAVANNAH GROVE                     |        2298| 51.044386|  46.0400348|
|Sawmill Branch                     |        1027| 26.971762|  64.5569620|
|SCHROCKS MILL/LUCKNOW              |         427| 48.009368|  50.5854801|
|Scotia                             |         351| 89.458690|   7.4074074|
|SCRANTON                           |         772| 45.077720|  53.8860104|
|SEA OATS #1                        |        1230| 36.341463|  58.9430894|
|SEA OATS #2                        |        1332| 52.177177|  43.6186186|
|SEA WINDS                          |        2824| 28.824363|  67.5991501|
|SEABROOK 1                         |         760| 44.342105|  51.0526316|
|SEABROOK 2                         |         680| 71.029412|  25.7352941|
|SEABROOK 3                         |        1071| 55.182073|  40.2427638|
|SECOND MILL                        |        1004| 17.828685|  76.4940239|
|Sedgefield 1                       |        1198| 42.821369|  51.9198664|
|Sedgefield 2                       |         754| 39.920424|  52.2546419|
|SELLERS                            |         224| 77.678571|  21.4285714|
|Seneca 1                           |        1898| 43.730242|  50.7376185|
|Seneca 2                           |        1384| 31.502890|  62.2832370|
|Seneca 3                           |         945| 25.714286|  69.4179894|
|Seneca 4                           |        1845| 44.390244|  50.2439024|
|Seven Oaks                         |        1231| 47.928513|  44.1917141|
|Seventy Eight                      |        1044| 39.080460|  52.5862069|
|SEVIER                             |        2243| 23.272403|  70.0847080|
|Sharon                             |        1132| 29.770318|  65.1943463|
|Sharpe'S Hill                      |        1497| 26.987308|  68.1362725|
|SHAW                               |         179| 30.167598|  60.8938547|
|Shaws Fork                         |         579| 21.934370|  72.5388601|
|Shaylor's Hill                     |         605| 38.512397|  57.8512397|
|Sheffield                          |        1105| 21.176471|  75.7466063|
|SHELDON 1                          |         876| 56.278539|  41.0958904|
|SHELDON 2                          |         632| 88.449367|   9.0189873|
|SHELL                              |        1052| 11.977186|  83.3650190|
|Shelley Mullis                     |        1595| 34.169279|  58.8087774|
|Shiloh                             |        2376| 28.998317|  66.8350168|
|SHILOH                             |         500| 35.000000|  61.8000000|
|Shirley's Store                    |         717| 19.665272|  77.8242678|
|Shoals Junction                    |         281| 23.487544|  71.5302491|
|Shoreline                          |        1792| 33.816964|  60.7142857|
|Shulerville                        |         389| 46.272494|  50.6426735|
|SIDNEYS                            |         443| 21.896162|  75.3950339|
|Silver Bluff                       |        1457| 56.142759|  40.8373370|
|SILVERLEAF                         |        1803| 23.904603|  69.2734332|
|SILVERSTREET                       |         561| 37.433155|  58.2887701|
|Simpson                            |         855| 51.812866|  43.1578947|
|SIMPSON                            |         770| 58.701299|  37.4025974|
|Simpsonville                       |        2204| 16.152450|  79.4010889|
|SIMPSONVILLE 1                     |        2069| 32.914451|  61.4306428|
|SIMPSONVILLE 2                     |        1439| 35.858235|  57.1924948|
|SIMPSONVILLE 3                     |        2037| 25.233186|  70.0540010|
|SIMPSONVILLE 4                     |        1670| 37.844311|  56.1676647|
|SIMPSONVILLE 5                     |        1701| 45.561434|  48.2069371|
|SIMPSONVILLE 6                     |        2326| 34.737747|  59.9312124|
|SINGLETARY                         |         250| 82.400000|  15.6000000|
|Sitton                             |        1239| 20.742534|  75.4640839|
|Six Mile                           |        2216| 13.312274|  82.1750903|
|Six Mile Mountain                  |        1219| 13.371616|  81.2141099|
|Six Points No. 35                  |         968| 37.293388|  57.3347107|
|Six Points No. 46                  |         964| 90.041494|   7.2614108|
|Skelton                            |         957|  9.299895|  86.8338558|
|Skyland                            |         792| 67.045455|  24.3686869|
|SKYLAND                            |        2266|  8.164166|  87.9523389|
|SLATER MARIETTA                    |        2555| 13.189824|  81.4090020|
|Sleepy Hollow No. 65               |        1527| 19.187950|  75.9659463|
|Smith Grove                        |         826| 17.191283|  76.9975787|
|Smyrna                             |         580| 10.862069|  84.6551724|
|SNELLING                           |        1031| 48.690592|  49.7575170|
|SNIDERS                            |         459| 27.886710|  69.4989107|
|SNOW HILL-VAUGHN                   |         382| 21.989529|  72.2513089|
|SOCASTEE #1                        |        2202| 26.748410|  68.2107175|
|SOCASTEE #2                        |        1411| 18.639263|  77.6045358|
|SOCASTEE #3                        |        3001| 23.858714|  71.3762079|
|SOCASTEE #4                        |        2976| 29.267473|  66.5322581|
|SOCIETY HILL                       |         827| 70.979444|  27.0858525|
|South Aiken No. 75                 |        1327| 29.088169|  65.7874906|
|South Aiken No. 76                 |        1525| 23.213115|  69.3114754|
|SOUTH BAMBERG                      |        1650| 76.909091|  20.3636364|
|South Beltline                     |         910| 69.230769|  25.1648352|
|South Central                      |         893| 40.649496|  51.0638298|
|SOUTH DILLON                       |        1112| 81.834532|  15.2877698|
|SOUTH FLORENCE NO. 1               |        1218| 44.581281|  50.1642036|
|SOUTH FLORENCE NO. 2               |        1230| 79.268293|  17.1544715|
|South Forest Acres                 |         997| 41.725175|  52.7582748|
|SOUTH LIBERTY                      |         338| 79.881657|  17.4556213|
|SOUTH LYNCHBURG                    |         384| 78.906250|  19.5312500|
|South Pickens                      |         867| 24.567474|  70.5882353|
|SOUTH RED BAY                      |         737| 93.351425|   5.0203528|
|South Union                        |        1246| 15.890851|  78.8121990|
|SOUTH WINNSBORO                    |         550| 83.818182|  13.6363636|
|SOUTHSIDE                          |        1632| 50.735294|  45.4044118|
|Southside Baptist                  |         772| 80.569948|  14.5077720|
|Spann                              |         937| 23.906083|  68.4098186|
|Sparrows Grace                     |        1030| 13.009709|  84.0776699|
|SPARROWS POINT                     |        1999| 30.465233|  63.3316658|
|Spartanburg High School            |        1518| 41.831357|  52.2397892|
|SPAULDING                          |         855| 93.918129|   4.4444444|
|SPECTRUM                           |         675| 69.629630|  28.0000000|
|SPRING BRANCH                      |         346| 16.473988|  80.0578035|
|SPRING FOREST                      |        1574| 40.343075|  52.4777637|
|SPRING GULLY                       |        1221| 52.579853|  44.6355446|
|Spring Hill                        |        2420| 16.528926|  79.5454545|
|SPRING HILL                        |         628| 73.566879|  24.0445860|
|Spring Valley                      |        1615| 54.427245|  39.8761610|
|Spring Valley West                 |        1824| 75.328947|  19.0789474|
|Springdale                         |        3544| 37.584650|  56.3487585|
|Springdale South                   |         560| 29.821429|  63.3928571|
|Springfield                        |        1741| 24.755887|  70.3618610|
|SPRINGFIELD                        |        1048| 55.152672|  42.7480916|
|Springville 1                      |        1344| 19.791667|  74.0327381|
|Springville 2                      |        1161| 15.934539|  75.7967270|
|St Davids                          |        2033| 24.249877|  68.8145598|
|ST PHILLIPS JOLLY ST.              |         817| 37.209302|  59.1187271|
|St. Andrews                        |         934| 74.304068|  21.4132762|
|ST. ANDREWS 1                      |         379| 59.894459|  32.1899736|
|ST. ANDREWS 10                     |         739| 55.345061|  36.8064953|
|ST. ANDREWS 11                     |         577| 36.395147|  54.7660312|
|ST. ANDREWS 12                     |         623| 40.128411|  47.8330658|
|ST. ANDREWS 13                     |         700| 44.714286|  46.5714286|
|ST. ANDREWS 14                     |         970| 47.010309|  43.4020619|
|ST. ANDREWS 15                     |         671| 75.111773|  17.7347243|
|ST. ANDREWS 16                     |         645| 35.348837|  53.3333333|
|ST. ANDREWS 17                     |        1066| 37.335835|  53.9399625|
|ST. ANDREWS 18                     |        1143| 67.366579|  26.0717410|
|ST. ANDREWS 19                     |         194| 85.567010|   9.7938144|
|ST. ANDREWS 2                      |         713| 60.448808|  29.3127630|
|ST. ANDREWS 20                     |        1461| 57.905544|  33.2648871|
|ST. ANDREWS 21                     |         512| 48.632812|  41.9921875|
|ST. ANDREWS 22                     |         603| 40.796020|  51.5754561|
|ST. ANDREWS 23                     |         620| 50.000000|  40.0000000|
|ST. ANDREWS 24                     |         693| 64.069264|  28.5714286|
|ST. ANDREWS 25                     |         703| 57.752489|  32.1479374|
|ST. ANDREWS 26                     |         794| 50.881612|  40.6801008|
|ST. ANDREWS 27                     |        2188| 47.714808|  44.0585009|
|ST. ANDREWS 28                     |        1490| 46.979866|  45.7718121|
|ST. ANDREWS 29                     |        1864| 41.362661|  49.3025751|
|ST. ANDREWS 3                      |         932| 79.721030|  15.5579399|
|ST. ANDREWS 30                     |        1042| 45.489443|  43.3781190|
|ST. ANDREWS 31                     |         746| 42.359249|  49.0616622|
|ST. ANDREWS 32                     |         803| 33.872976|  58.9041096|
|ST. ANDREWS 33                     |         428| 35.514019|  59.3457944|
|ST. ANDREWS 34                     |        1232| 32.467532|  59.4967532|
|ST. ANDREWS 35                     |        1060| 33.301887|  59.2452830|
|ST. ANDREWS 36                     |        1176| 32.227891|  59.5238095|
|ST. ANDREWS 37                     |        2137| 38.979878|  52.8310716|
|ST. ANDREWS 4                      |         832| 39.543269|  51.4423077|
|ST. ANDREWS 5                      |         710| 50.704225|  41.2676056|
|ST. ANDREWS 6                      |         863| 30.938586|  60.6025492|
|ST. ANDREWS 7                      |        1082| 38.447320|  52.0332717|
|ST. ANDREWS 8                      |         510| 80.784314|  12.1568627|
|ST. ANDREWS 9                      |         777| 89.575290|   6.6924067|
|ST. CHARLES                        |         722| 74.792244|  23.2686981|
|St. George No. 1                   |         795| 49.685535|  46.5408805|
|St. George No. 2                   |         546| 41.575092|  55.1282051|
|St. James                          |        1220| 39.098361|  54.5901639|
|St. John's Lutheran                |         882| 31.179138|  62.5850340|
|ST. MATTHEWS                       |        1273| 45.561665|  52.1602514|
|St. Michael                        |        1680| 20.654762|  73.3928571|
|ST. PAUL                           |        1141| 59.333918|  35.9333918|
|ST. PAULS 1                        |         916| 77.729258|  20.0873362|
|ST. PAULS 2A                       |         741| 63.157895|  34.0080972|
|ST. PAULS 2B                       |        1056| 62.784091|  34.2803030|
|ST. PAULS 3                        |        1367| 29.846379|  66.2033650|
|ST. PAULS 4                        |        1275| 76.156863|  20.8627451|
|ST. PAULS 5                        |         751| 51.664447|  45.2729694|
|ST. PAULS 6                        |        1164| 36.340206|  59.5360825|
|St. Stephen 1                      |        1177| 84.367035|  13.5938828|
|St. Stephen 2                      |        1106| 51.356239|  45.6600362|
|ST.JOHN                            |        1181| 62.404742|  35.6477561|
|Stallsville                        |         799| 25.782228|  69.2115144|
|Stamp Creek                        |        1427| 22.074282|  74.2817099|
|STANDING SPRINGS                   |        1624| 34.421182|  58.7438424|
|Starr                              |         741| 13.495277|  83.4008097|
|Startex Fire Station               |         773| 48.253558|  47.4773609|
|Stateline                          |        1188| 37.878788|  55.2188552|
|Steele Creek                       |        2018| 35.084242|  59.1179386|
|STOKES                             |         546| 21.062271|  75.6410256|
|Stone Church                       |         966| 47.722567|  42.5465839|
|STONE HILL                         |         597| 98.827471|   1.0050251|
|Stone Lake                         |        1144| 27.185315|  68.1818182|
|STONE VALLEY                       |        1991| 33.048719|  59.6685083|
|STONEHAVEN                         |        1554| 28.764479|  65.3153153|
|Stonewood                          |        1231| 20.227457|  76.1169781|
|STONEY HILL                        |         616| 14.448052|  81.3311688|
|Stratford 1                        |        1152| 41.666667|  51.9965278|
|Stratford 2                        |        1391| 24.514738|  71.1718188|
|Stratford 3                        |        1465| 37.679181|  56.1774744|
|Stratford 4                        |        1330| 35.488722|  56.8421053|
|Stratford 5                        |        1040| 45.576923|  46.2500000|
|SUBER MILL                         |        2332| 30.317324|  62.4785592|
|SUBURBAN 1                         |         511| 96.086106|   1.9569472|
|SUBURBAN 2                         |         503| 97.216700|   1.9880716|
|SUBURBAN 3                         |        1078| 90.816327|   8.3487941|
|SUBURBAN 4                         |         395| 73.164557|  25.5696203|
|SUBURBAN 5                         |        1019| 81.943082|  15.8979392|
|SUBURBAN 6                         |         758| 60.158311|  37.4670185|
|SUBURBAN 7                         |         968| 46.177686|  51.0330579|
|SUBURBAN 8                         |         633| 57.187994|  39.6524487|
|SUBURBAN 9                         |        1093| 82.433669|  15.9194876|
|SUGAR CREEK                        |        2096| 22.948473|  72.0896947|
|SULLIVANS ISLAND                   |        1216| 43.503290|  48.8486842|
|SULPHUR SPRINGS                    |        1828| 25.875273|  69.1466083|
|Summerton No. 1                    |        1167| 37.617824|  59.7257926|
|Summerton No. 2                    |         236| 74.152542|  23.3050847|
|Summerton No. 3                    |         697| 83.931133|  15.0645624|
|Summit                             |        1093| 20.768527|  75.3888381|
|SUMTER HIGH 1                      |         463| 36.069114|  58.9632829|
|SUMTER HIGH 2                      |         876| 42.808219|  54.4520548|
|Sun City                           |        1721| 31.086578|  66.9378268|
|SUN CITY 1                         |        1006| 27.335984|  68.6878728|
|SUN CITY 2                         |         673| 32.095097|  64.3387816|
|SUN CITY 3                         |        1031| 32.201746|  65.0824442|
|SUN CITY 4                         |         814| 32.800983|  64.7420147|
|SUN CITY 5                         |         824| 28.398058|  69.5388350|
|SUN CITY 6                         |         783| 28.991060|  67.5606641|
|SUN CITY 7                         |         748| 31.016043|  65.2406417|
|SUN CITY 8                         |         966| 32.712215|  63.0434783|
|SUNSET                             |         969| 45.923633|  50.0515996|
|SURFSIDE #1                        |        1910| 26.387435|  69.0052356|
|SURFSIDE #2                        |         930| 23.870968|  74.5161290|
|SURFSIDE #3                        |        2110| 22.748815|  73.6018957|
|SURFSIDE #4                        |        2057| 23.966942|  71.8035975|
|SUTTONS                            |         259| 34.362934|  64.4787645|
|SWAN LAKE                          |         714| 37.394958|  57.5630252|
|Swansea #1                         |        1109| 46.618575|  49.8647430|
|Swansea #2                         |        1195| 40.418410|  55.9832636|
|SWEET HOME                         |         966| 49.275362|  46.7908903|
|SWIFT CREEK                        |         765| 35.686275|  61.8300654|
|Swofford Career Center             |        2194| 15.496809|  80.4922516|
|SYCAMORE                           |        2175| 22.988506|  72.1839080|
|Tabernacle                         |         599| 46.911519|  48.2470785|
|Talatha                            |        1323| 37.490552|  59.2592593|
|Tamassee                           |        1130| 15.132743|  81.3274336|
|TANGLEWOOD                         |        1927| 52.049818|  44.1619097|
|TANS BAY                           |        1092| 40.293040|  56.6849817|
|TATUM                              |         280| 48.928571|  47.1428571|
|TAYLORS                            |        1952| 42.571721|  50.6659836|
|TAYLORSVILLE                       |         297|  7.407407|  90.9090909|
|Tega Cay                           |        1151| 31.798436|  61.6854909|
|TEMPERANCE                         |         863| 68.134415|  29.5480881|
|The Lodge                          |        2181| 29.344338|  67.3085740|
|The Village                        |        1837| 24.442025|  69.5699510|
|THOMAS SUMTER                      |         735| 71.292517|  26.6666667|
|THORNBLADE                         |        2448| 31.127451|  64.2565359|
|Three and Twenty                   |        2117| 12.990080|  83.4671705|
|TIGERVILLE                         |        2138| 14.733396|  80.1216090|
|Tillman                            |         457| 57.330416|  36.7614880|
|TILLY SWAMP                        |        1201| 20.482931|  75.8534555|
|Timber Ridge                       |         789| 11.533587|  85.1711027|
|TIMBERLAKE                         |        1873| 28.830753|  62.2530699|
|TIMMONSVILLE NO. 1                 |        1263| 81.710214|  15.6769596|
|TIMMONSVILLE NO. 2                 |         897| 49.498328|  48.1605351|
|Tirzah                             |        1514| 19.418758|  76.8824306|
|TODDVILLE                          |        1168| 27.996575|  67.3801370|
|Tokeena-Providence                 |        1044| 14.846743|  80.5555556|
|Toney Creek                        |         465| 13.978495|  82.1505376|
|Tools Fork                         |        1187| 32.855939|  63.7742207|
|Town Creek                         |        1050| 19.619048|  76.0952381|
|TOWN OF SEABROOK                   |        1617| 37.538652|  57.0191713|
|Townville                          |         636| 15.251572|  81.1320755|
|TRADE                              |        1795| 41.169916|  52.4791086|
|Tramway                            |        1422| 33.966245|  59.6343179|
|Tranquil                           |         434| 25.345622|  69.3548387|
|Tranquil 2                         |         976| 43.340164|  48.5655738|
|Tranquil 3                         |         920| 47.065217|  44.8913043|
|TRAVELERS REST 1                   |        2051| 28.327645|  64.7976597|
|TRAVELERS REST 2                   |        1419| 22.269204|  71.9520789|
|Travelers Rest Baptist             |        2226| 42.362983|  52.7403414|
|Trenholm Road                      |         754| 37.400531|  56.7639257|
|Trenton No.1                       |         905| 48.176796|  48.8397790|
|Trenton No.2                       |        1372| 59.693878|  37.3177843|
|Tri County                         |         478| 23.012552|  71.7573222|
|Trinity                            |         859| 64.610012|  32.2467986|
|Trinity Methodist                  |        1112| 36.151079|  56.1151079|
|TRINITY RIDGE                      |         997| 35.406219|  60.3811434|
|TRIO                               |         739| 88.633288|   9.8782138|
|Trolley                            |         840| 46.785714|  45.7142857|
|Troy                               |         131| 32.061069|  65.6488550|
|TUBBS MOUNTAIN                     |        2037| 15.218459|  79.9214531|
|Tupperway                          |         590| 29.322034|  64.2372881|
|Tupperway 2                        |         613| 39.641109|  54.1598695|
|Turbeville                         |         920| 28.260870|  70.7608696|
|TURKEY CREEK                       |        1110| 51.891892|  45.4954955|
|TYGER RIVER                        |        1144| 35.664336|  59.0034965|
|ULMER                              |         189| 41.798942|  55.5555556|
|UNION WARD 1 BOX 1                 |         467| 50.107066|  47.5374732|
|UNION WARD 1 BOX 2                 |         832| 67.548077|  28.4855769|
|UNION WARD 2                       |         687| 72.780204|  25.6186317|
|UNION WARD 3                       |         505| 72.871287|  22.3762376|
|UNION WARD 4 BOX 1                 |         490| 37.551020|  58.1632653|
|UNION WARD 4 BOX 2                 |         245| 75.918367|  20.8163265|
|Unity                              |         923| 24.702058|  73.0227519|
|University                         |        2310| 36.190476|  55.4545455|
|Utica                              |         539| 42.671614|  50.8348794|
|Valhalla                           |        1581| 51.170145|  42.8842505|
|Valley State Park                  |        1880| 82.978723|  13.1914894|
|Van Wyck                           |         709| 34.555712|  62.4823695|
|VANCE                              |        1173| 76.385337|  21.9948849|
|Varennes                           |         898| 41.536748|  54.0089087|
|Varnville                          |        1371| 64.332604|  33.4062728|
|Vaucluse                           |        1227| 33.007335|  62.1026895|
|Verdery                            |        1025| 46.146341|  49.3658537|
|VERDMONT                           |        1908| 33.647799|  62.3689727|
|Victor Mill Methodist              |        1452| 36.983471|  57.0247934|
|Vinland                            |        1009| 10.604559|  87.0168484|
|VOX                                |         579| 20.207254|  75.4749568|
|W BENNETTSVILLE                    |         689| 71.407837|  26.2699565|
|W Columbia No 1                    |         526| 48.669201|  43.1558935|
|W Columbia No 2                    |         645| 82.790698|  14.5736434|
|W Columbia No 3                    |         522| 29.310345|  62.8352490|
|W Columbia No 4                    |        1216| 37.417763|  55.8388158|
|WADE HAMPTON                       |        1719| 30.599186|  62.1291449|
|WADMALAW ISLAND 1                  |         843| 53.618031|  41.6370107|
|WADMALAW ISLAND 2                  |         909| 67.656766|  28.3828383|
|Wagener                            |        1663| 45.580277|  50.2705953|
|Walden                             |         740| 84.324324|  10.5405405|
|Walhalla 1                         |        2071| 18.734911|  75.4225012|
|Walhalla 2                         |        1661| 20.288982|  74.7742324|
|WALLACE                            |         964| 46.680498|  49.6887967|
|WALNUT SPRINGS                     |        3961| 26.432719|  67.8111588|
|WALTERBORO NO. 1                   |         617| 46.839546|  49.2706645|
|WALTERBORO NO. 2                   |         641| 61.622465|  33.2293292|
|WALTERBORO NO. 3                   |         822| 85.036496|  12.5304136|
|WALTERBORO NO. 4                   |         737| 36.906377|  57.6662144|
|WALTERBORO NO. 5                   |         662| 27.794562|  67.9758308|
|WALTERBORO NO. 6                   |         650| 50.769231|  44.7692308|
|WAMPEE                             |        1675| 63.522388|  33.2537313|
|Ward                               |        1289| 40.186191|  56.3227308|
|WARD                               |         419| 52.505967|  44.8687351|
|Ward 1                             |         729| 59.396434|  32.2359396|
|Ward 10                            |         935| 58.181818|  33.9037433|
|Ward 11                            |         902| 66.518847|  24.5011086|
|Ward 12                            |         960| 59.583333|  31.8750000|
|Ward 13                            |        1380| 61.014493|  31.1594203|
|Ward 14                            |        1081| 57.169288|  34.6901018|
|Ward 15                            |         732| 47.267760|  43.5792350|
|Ward 16                            |         876| 38.812785|  55.9360731|
|Ward 17                            |        1059| 44.570349|  47.9697828|
|Ward 18                            |        1008| 86.111111|  10.4166667|
|Ward 19                            |        1042| 97.312860|   1.1516315|
|Ward 2                             |         514| 80.933852|  16.3424125|
|Ward 20                            |        1332| 78.303303|  15.5405405|
|Ward 21                            |        1279| 95.387021|   2.1892103|
|Ward 22                            |        1266| 93.838863|   3.1595577|
|Ward 23                            |         719| 60.500695|  31.9888734|
|Ward 24                            |         714| 36.834734|  54.7619048|
|Ward 25                            |        1158| 29.447323|  63.3851468|
|Ward 26                            |        1048| 62.213741|  29.4847328|
|Ward 29                            |        1041| 91.834774|   4.5148895|
|Ward 3                             |        1126| 66.252220|  25.2220249|
|Ward 30                            |         617| 62.398703|  29.1734198|
|Ward 31                            |         724| 95.165746|   2.3480663|
|Ward 32                            |         728| 96.565934|   1.3736264|
|Ward 33                            |         726| 75.757576|  16.6666667|
|Ward 34                            |         761| 57.293036|  36.9250986|
|Ward 4                             |         973| 64.850976|  25.0770812|
|Ward 5                             |         696| 52.873563|  38.6494253|
|Ward 6                             |         979| 55.873340|  36.2614913|
|Ward 7                             |         864| 96.990741|   0.9259259|
|Ward 8                             |         754| 96.551724|   1.7241379|
|Ward 9                             |         717| 94.421199|   2.7894003|
|WARE PLACE                         |        1892| 20.613108|  75.5285412|
|Ware Shoals                        |         493| 44.827586|  48.8843813|
|Warrenville                        |        1363| 22.303742|  74.1746148|
|Wassamassaw 1                      |         620| 53.548387|  43.0645161|
|Wassamassaw 2                      |        1982| 32.542886|  62.9162462|
|WATERLOO                           |        1251| 31.254996|  65.3876898|
|Waterstone                         |        1632| 37.928922|  55.3308824|
|WATTSVILLE                         |         944| 26.059322|  67.9025424|
|Weatherstone                       |        1218| 39.901478|  52.9556650|
|Webber                             |         875| 68.685714|  26.1714286|
|WELCOME                            |        1674| 57.825567|  37.3357228|
|Wellford Fire Station              |        1718| 41.268917|  54.1327125|
|WELLINGTON                         |        1240| 23.951613|  70.9677419|
|West Central                       |         630| 40.793651|  44.7619048|
|WEST CONWAY                        |         499| 47.094188|  49.6993988|
|WEST DENMARK                       |        1176| 88.010204|  10.7142857|
|WEST DILLON                        |        1306| 79.096478|  16.5390505|
|WEST FLORENCE NO. 1                |        1928| 33.765560|  61.8775934|
|WEST FLORENCE NO. 2                |         886| 35.891648|  60.1580135|
|West Liberty                       |        1078| 10.111317|  84.6938776|
|WEST LORIS                         |         795| 72.830189|  24.6540881|
|West Pelzer                        |        1475| 14.237288|  82.7796610|
|West Pickens                       |        1105| 14.841629|  81.2669683|
|West Savannah                      |         288| 29.513889|  67.7083333|
|WEST SPRINGS                       |         277| 33.935018|  62.8158845|
|West Union                         |        1285| 17.821012|  77.5097276|
|West View Elementary               |        2881| 31.968067|  62.7906977|
|WESTCLIFFE                         |        1470| 36.054422|  59.3877551|
|Westminster                        |        1212| 79.867987|  14.7689769|
|Westminster 1                      |        2079| 14.959115|  80.9523810|
|Westminster 2                      |        1214| 14.497529|  81.3014827|
|Westover                           |        1189| 26.913373|  66.1059714|
|Westside                           |         718|  7.799443|  89.8328691|
|WESTSIDE                           |        1774| 39.515220|  56.3134160|
|Westview 1                         |        1161| 23.514212|  70.8871662|
|Westview 2                         |        1506| 30.478088|  63.4130146|
|Westview 3                         |        1274| 25.902669|  67.7394035|
|Westview 4                         |        1219| 29.204266|  64.3970468|
|Westville                          |        1221| 27.600328|  68.3865684|
|WHEELAND                           |         384| 14.843750|  78.6458333|
|White Knoll                        |        1736| 23.905530|  69.4700461|
|WHITE OAK                          |         842| 26.722090|  69.1211401|
|White Plains                       |        3696| 16.071429|  79.6266234|
|White Pond                         |         754| 47.480106|  50.1326260|
|White Stone Methodist              |         758| 39.577836|  57.2559367|
|Whitehall                          |        1649| 40.570042|  52.6379624|
|Whites Gardens                     |        1288| 32.919255|  63.9751553|
|Whitesville 1                      |        1803| 39.767055|  54.5757072|
|Whitesville 2                      |        1115| 22.780269|  73.4529148|
|Whitewell                          |        1324| 86.102719|   9.2145015|
|Whitlock Jr. High                  |        1064| 31.015038|  64.0977444|
|WHITMIRE CITY                      |         628| 32.165605|  64.1719745|
|WHITMIRE OUTSIDE                   |         664| 34.789157|  60.9939759|
|WHITTAKER                          |         886| 90.180587|   8.8036117|
|WILD WING                          |        2340| 26.880342|  69.1025641|
|WILDER                             |         703| 91.465149|   7.6813656|
|Wildewood                          |        1547| 45.895281|  47.9638009|
|Wilkinsville and Metcalf           |         477|  4.192872|  92.2431866|
|Wilksburg                          |         403| 53.846154|  44.6650124|
|WILLIAMS                           |         256| 49.609375|  48.8281250|
|Williamston                        |        1782| 21.324355|  73.7373737|
|Williamston Mill                   |        2127| 15.702868|  80.7240244|
|Willington                         |         159| 58.490566|  40.8805031|
|WILLISTON 1                        |        1201| 66.611157|  31.5570358|
|WILLISTON 2                        |         497| 33.802817|  63.5814889|
|WILLISTON 3                        |         758| 39.050132|  57.6517150|
|Willow Springs                     |        1049| 20.400381|  76.2631077|
|Wilson Foreston                    |         835| 61.077844|  36.6467066|
|WILSON HALL                        |         994| 16.197183|  79.6780684|
|Windjammer                         |        1644| 32.177616|  61.9221411|
|Windsor                            |         754| 44.694960|  49.4694960|
|Windsor 2                          |         618| 60.194175|  33.8187702|
|Windsor No. 43                     |         859| 32.828871|  61.9324796|
|Windsor No. 82                     |         943| 33.934252|  59.7030753|
|WINDY HILL #1                      |        1107| 27.100271|  69.5573622|
|WINDY HILL #2                      |        2016| 21.626984|  76.7361111|
|WINNSBORO MILLS                    |         527| 57.874763|  36.2428843|
|WINNSBORO NO. 1                    |         917| 75.681570|  19.7382770|
|WINNSBORO NO. 2                    |         760| 58.815790|  37.2368421|
|WINYAH BAY                         |         582| 25.601375|  71.9931271|
|WOLF CREEK                         |         290| 13.103448|  84.8275862|
|WOODARD                            |         127| 83.464567|  15.7480315|
|Woodfield                          |        1783| 72.181716|  23.6118901|
|Woodland Heights Recreation Center |        1366| 57.467057|  37.2620791|
|Woodland Hills                     |        1176| 59.863946|  32.9081633|
|Woodlands                          |        1437| 34.725122|  57.6896312|
|WOODMONT                           |        2093| 49.498328|  46.8227425|
|WOODROW                            |         167| 76.047904|  21.5568862|
|Woodruff Elementary                |        1743| 35.169248|  60.4704532|
|Woodruff Fire Station              |        1090| 15.688073|  80.0917431|
|WOODRUFF LAKES                     |        2270| 26.651982|  68.5462555|
|Woodruff Leisure Center            |         909| 26.182618|  69.3069307|
|Woods                              |         858| 12.237762|  84.3822844|
|WOODS                              |         559| 67.084079|  31.1270125|
|Woodside                           |        1175| 29.957447|  64.6808511|
|Wright's School                    |         703| 11.522048|  86.2019915|
|Wylie                              |         909| 26.402640|  68.3168317|
|Yellow House                       |        1304| 42.868098|  51.9938650|
|Yemassee                           |         907| 64.167585|  32.1940463|
|York No. 1                         |        1193| 56.831517|  39.5641241|
|York No. 2                         |        1659| 42.555757|  52.5015069|
|YOUNGS                             |        1005| 14.228856|  80.9950249|
|Zion                               |         891| 15.375982|  80.3591470|
|ZION                               |         475| 68.421053|  29.8947368|
 
There were some casualties in this operation, namely the total party votes and total votes, but I don't really need them for the simple thing I'm doing here.
 
The `spread` function I used above comes from the `tidyr` package, loaded by `tidyverse`. It, along with `gather`, enable navigating between "long" and "wide" datasets. You have to be careful using these functions, though, or you may get something strange. For instance, when I left in the party votes using `spread` above (in a previous iteration of this post), I ended up with an ugly wide and long dataset, but with `NA` every other row on each of the percent columns.
 
# Merging data
 
In the last blog post, we were simply able to plot two maps on top of each other using the `leaflet` package. We are faced with a slightly different issue here. One data set is a geographic dataset, but the elections data only lists a precinct name. So it is up to us to do the merge.
 

{% highlight r %}
precinct_elect <- merge(precinct_shapes,total_party_votes_wide,by.x="PNAME",by.y="precinct")
{% endhighlight %}
 
Honestly, I thought the above step would be the hardest part of the post. But like `plot`, the `merge` function in R understands what it's operating on (i.e. uses a method that's specific to spatial objects). Someone else did the hard work, and I just use the magic.
 

{% highlight r %}
library(leaflet)
pal <- colorNumeric(palette = "viridis", 
                    domain = c(0,100))
 
precinct_elect %>% 
  leaflet(width="100%") %>% 
  addPolygons(popup = ~PNAME,
              stroke = FALSE,
                smoothFactor = 0,
                fillOpacity = 0.5,
                color = ~ pal(DEM)) %>% 
  addLegend("bottomright", 
              pal = pal, 
              values = ~ DEM,
              title = "Dem P/VP Vote %",
              labFormat = labelFormat(suffix = "%"),
              opacity = 1)
{% endhighlight %}



{% highlight text %}
## PhantomJS not found. You can install it with webshot::install_phantomjs(). If it is installed, please make sure the phantomjs executable can be found via the PATH variable.
{% endhighlight %}



{% highlight text %}
## Warning in normalizePath(path.expand(path), winslash, mustWork): path[1]=".
## \webshot49f45792409b.png": The system cannot find the file specified
{% endhighlight %}



{% highlight text %}
## Warning in file(con, "rb"): cannot open file 'C:\Users\johnd\AppData\Local
## \Temp\RtmpCuimA7\file49f454305815\webshot49f45792409b.png': No such file or
## directory
{% endhighlight %}



{% highlight text %}
## Error in file(con, "rb"): cannot open the connection
{% endhighlight %}
 
Now there are a few things to note:
* In this blog post, the map is static. If you actually run this code in RStudio, it will be an interactive map that lets you zoom and pan, and where clicking areas will give you the precinct name.
* I basically copied and pasted the `leaflet` code from the previous blog post, and changed variable names.
* It looks like the dataset has a few holes. This may be where sweeping the absentee ballot under the rug leaves out a lot.
 
# Discussion
 
I used the `data.world` package and website to download and use Greenville election data. I then merged it with precinct shapefiles found from a different source (Github). The actual merge process wasn't hard, and in fact the most difficult part of this process was deciding how I wanted to present the data. This election data is rather rich, but has a few necessary quirks in its structure.
 
Once you have characteristic data in the right format and shape files, it's magically easy to merge them.
 
I copied and pasted most of the `leaflet` code from my last post to present the data, with tweaks for variable names.
