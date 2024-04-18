## Installation

You can install the development version of mediaBabies from `[GitHub]`
at <https://github.com/burgerhaley97/mediaBabies.git> with:

    # Install the package from GitHub
    devtools::install_github("burgerhaley97/mediaBabies")

## Introduction:

The mediaBabies package allows you to explore the correlation between
the year a media title was released and the number of babies that were
named the corresponding character’s name. This package uses media
information from the IMDB developer data base and social security data
for baby names counts from 1973 to 2023. You can use the custom
functions in this package to filter the media and babies names data,
create custom objects, and plot the objects to visualize any trends for
specific names.

-   `filter_char_by_baby_names()` Filters the movie character dataframe
    to only include movie characters that have a name listed in the baby
    names data frame.
-   `filter_baby_names_by_char()` Filters baby names data frame to only
    include names that have an associated character in the movie titles
    dataframe.
-   `create_poi_df()` Creates a dataframe consisting of three columns:
    name, year, and percent\_change for the baby names data.
-   `create_media_names_df()` Creates a dataframe with the name, title,
    release\_year, poi\_year, and percent\_change columns for future
    analysis.
-   `infuences()` Creates a custom influence object for plotting.
-   `baby_count()` Creates a custom baby count object for plotting.

## Example Workflow

    library("mediaBabies")

We’ll start by reading in and filtering the data included in our
package.

    # Load raw data media data
    data(characters, package = "mediaBabies")

    # Load female babies names data
    data(female_babies, package = "mediaBabies")

    # Filter the data frames so only matching names from each are kept.
    babies_df <- filter_baby_names_by_char(female_babies, characters)
    chars_df <- filter_char_by_baby_names(characters, female_babies)
    head(chars_df)
    #>    character            title year
    #> 1        Lee Enter the Dragon 1973
    #> 3      Tania Enter the Dragon 1973
    #> 4   Williams Enter the Dragon 1973
    #> 5      Chris     The Exorcist 1973
    #> 8     Merrin     The Exorcist 1973
    #> 11     Regan     The Exorcist 1973

Then we need to create our percent change data frame so we can identify
years that are considered a point of interest. We then create the data
frame representing names that are considered “media influenced.” Here we
choose to use the name Trinity.

    # percent change and point of interest functions
    babies_pc_df <- create_percent_change_df(babies_df)
    babies_poi <- create_poi_df(babies_pc_df)
    head(babies_poi)
    #>      name year percent_change
    #> 1  Tracey 2020      -188.8889
    #> 2   Jamie 1976       196.1729
    #> 3  Tricia 2021      -160.0000
    #> 4 Sabrina 1977       132.0216
    #> 5   Wanda 2010      -138.8889
    #> 6   Shawn 2021      -120.0000

    # create media influenced names table, use default max_range of 5  
    media_influenced_df <- create_media_names_df(babies_poi, chars_df)
    Trinity_influenced <- media_influenced_df[media_influenced_df$name == "Trinity", ]
    head(Trinity_influenced)
    #>          name      title release_year poi_year percent_change
    #> 23708 Trinity The Matrix         1999     1999       207.9002

Before plotting the results we need to convert the dataframes to custom
objects.

    # convert to custom influence object 
    media_influence_object <- influences(Trinity_influenced)

    # convert to custom baby_count object
    babies_Trinity <- babies_df[["Trinity"]]
    baby_count_obj <- baby_count("Trinity", as.numeric(1973), babies_Trinity)

Plot the custom objects from above to visualize the influence of media
events on the name Trinity.

    # plot and visualize the results 
    plot(media_influence_object, baby_count_obj, sex = "female")

![](C:/Users/A02425259/AppData/Local/Temp/Rtmp4iK8zn/preview-644849d93a9c.dir/mediaBabies_files/figure-markdown_strict/unnamed-chunk-6-1.png)
