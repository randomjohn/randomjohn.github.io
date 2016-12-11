---
title: "Plotting GeoJSON data on a map with R"
date: "December 11, 2016"
output: html_document
status: publish
published: true
---
 
 

 
GeoJSON is a standard text-based data format for encoding geographical information, which relies on the JSON (Javascript object notation) standard. There are a number of public datasets for Greenville, SC that use this format, and, fortunately, the [R](http://www.r-project.org) programming language makes working with these data through the [rgeojson](https://ropensci.org/tutorials/geojsonio_tutorial.html) library. Note that this is part of the [ROpenSci](https://ropensci.org) family of packages, which are useful for working with different kinds of public data.
 
In this post we plot some public data in GeoJSON format on top of a retrieved Google Map. To set up we do the following:
 

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
 
I wrapped `geojsonio` in a require because it may not be installed on your system. Geojsonio takes most of the work out of dealing with GeoJSON data, thus allowing you to concentrate on your analysis rather than data manipulation to a great extent. There is still some data manipulation to be done, as seen below, but as these things go, it's fairly lightweight.
 
## Getting the data
 
The data we are going to analyze consists of the convenient parking locations for access to the Swamp Rabbit Trail running between Greenville, SC and Traveler's Rest, SC. Though this data is located in an ArcGIS system, there is a GeoJSON version at [OpenUpstate](http://data.openupstate.org).
 

{% highlight text %}
Error in download.file(data_url, data_file): cannot open destfile 'data/srt_parking.geojson', reason 'No such file or directory'
{% endhighlight %}



{% highlight text %}
Error: File does not exist. Create it, or fix the path.
{% endhighlight %}
 
Theoretically, you can use `geojson_read` to get the data from the URL directly; however this seemed to fail for me. I'm not sure why doing the two-step process with `download.file` and then `geojson_read` works, but it may be good in some workflows to download your data first anyway. Then, the `what="sp"` option in `geojson_read` is used to return the read data in a spatial object. Now that the data is in a spatial object, we can analyze however we wish, and forget about the original data format.
 
## Analyzing the data
 
The first thing you can do is plot the data, and the `plot` command makes that easy. If you don't know what is going on behind the scenes, the `plot` command detects that it is dealing with a spatial object and calls the plot method from the `sp` package. But we just issue a simple command:
 

{% highlight text %}
Error in plot(data_json): object 'data_json' not found
{% endhighlight %}
 
Unfortunately, this plot is not very helpful, because it simply plots the points without any context. So we use the `ggmap` and `ggplot2` package to give us some context. First, we download from Google the right map.
 

 
I got the latitude and longitude by looking up on Google, and then hand-tuned the scale and zoom.
 
A note of warning: if you do this with a recent version of `ggmap` and `ggplot2`, you may need to download the GitHub versions. See this [Stackoverflow thread](http://stackoverflow.com/questions/40642850/ggmap-error-geomrasterann-was-built-with-an-incompatible-version-of-ggproto/40644348) for details.
 
Now, we prepare our spatial object for plotting:
 

{% highlight text %}
Error in as.data.frame(data_json): object 'data_json' not found
{% endhighlight %}



{% highlight text %}
Error in names(data_df)[4:5] <- c("lon", "lat"): object 'data_df' not found
{% endhighlight %}
 
There's really no output from this. I suppose the renaming step isn't necessary, either, but I believe in descriptive labels.
 
Now we can make the plot:
 

{% highlight text %}
Error in fortify(data): object 'data_df' not found
{% endhighlight %}
 
It may be helpful to add labels based on the name of the location, given in the 'title' field:
 

{% highlight text %}
Error in fortify(data): object 'data_df' not found
{% endhighlight %}
 
Here, I use `geom_text` to make the labels, and tweaked the options by hand using the help page.
 
## Conclusions
 
GeoJSON data is becoming more popular, especially in public data. The `geojsonio` package makes working with such data trivial. Once the data is in a spatial data format, R's wide variety of spatial data tools are available.
 
