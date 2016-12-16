---
layout: post
title: "Plotting GeoJSON polygons on a map with R"
author: "John Johnson"
date: "December 16, 2016"
status: publish
published: true
categories: Greenville
tags: ggplot geojson maps
---
 

 
In a [previous post](2016-12-11-r-geojson-srt.html) we plotted some points, retrieved from a public dataset in GeoJSON format, on top of a Google Map of the area surrounding Greenville, SC. In this post we plot some public data in GeoJSON format as well, but instead of particular points, we plot polygons. Polygons describe an area rather than a single point. As before, to set up we do the following:
 

{% highlight r %}
library(rgdal)
if (!require(geojsonio)) {
    install.packages("geojsonio")
    library(geojsonio)
}
library(sp)
library(maps)
library(ggmap)
library(maptools)
{% endhighlight %}
 
 
## Getting the data
 
The data we are going to analyze consists of the city parks in Greenville, SC. Though this data is located in an ArcGIS system, there is a [GeoJSON version](https://data.openupstate.org/maps/city-parks/parks.php) at [OpenUpstate](http://data.openupstate.org).
 

{% highlight r %}
data_url <- "https://data.openupstate.org/maps/city-parks/parks.php"
data_file <- "parks.geojson"
# for some reason, I can't read from the url directly, though the tutorial
# says I can
download.file(data_url, data_file)
data_park <- geojson_read(data_file, what = "sp")
{% endhighlight %}
 
 
## Analyzing the data
 
First, we plot the data as before:
 

{% highlight r %}
plot(data_park)
{% endhighlight %}

![plot of chunk unnamed-chunk-12](/figures/unnamed-chunk-12-1.png)
 
While this was easy to do, it doesn't give very much context. However, it does give the boundaries of the different parks. As before, we use the `ggmap` and `ggplot2` package to give us some context. First, we download from Google the right map.
 

{% highlight r %}
mapImage <- ggmap(get_googlemap(c(lon = -82.394012, lat = 34.852619), scale = 1, 
    zoom = 11), extent = "normal")
{% endhighlight %}
 
I got the latitude and longitude by looking up on Google, and then hand-tuned the scale and zoom.
 
A note of warning: if you do this with a recent version of `ggmap` and `ggplot2`, you may need to download the GitHub versions. See this [Stackoverflow thread](http://stackoverflow.com/questions/40642850/ggmap-error-geomrasterann-was-built-with-an-incompatible-version-of-ggproto/40644348) for details.
 
Now, we prepare our spatial object for plotting. This is a more difficult process than before, and requires the use of the `fortify` command from `ggplot2` package to make sure everything makes it to the right format:
 

{% highlight r %}
data_park_df <- fortify(data_park)
{% endhighlight %}
 
Now we can make the plot:
 

{% highlight r %}
print(mapImage + geom_polygon(aes(long, lat, group = group), data = data_park_df, 
    colour = "green"))
{% endhighlight %}

![plot of chunk unnamed-chunk-15](/figures/unnamed-chunk-15-1.png)
 
Note the use of the `group=` option in the `geom_polygon` function above. This tells `geom_polygon` that there are many polygons rather than just one. Without that option, you get a big mess:
 

{% highlight r %}
print(mapImage + geom_polygon(aes(long, lat), data = data_park_df, colour = "green"))
{% endhighlight %}

![plot of chunk unnamed-chunk-16](/figures/unnamed-chunk-16-1.png)
 
## Mashup of parking convenient to Swamp Rabbit Trail and city parks
 
Now, say you want to combine the city parks data with the parking places convenient to Swamp Rabbit Trail that was the subject of the last post. That is very easy using the `ggplot2` package. We get the data and manipulate it as last time:
 

 
Next, we use the layering feature of `ggplot2` to draw the map:
 

{% highlight text %}
Error in eval(expr, envir, enclos): object 'lon' not found
{% endhighlight %}

![plot of chunk unnamed-chunk-18](/figures/unnamed-chunk-18-1.png)
 
## Conclusions
 
We continue to explore public geographical data by examining data representing areas in addition to points. In addition, we layer data from two sources.
