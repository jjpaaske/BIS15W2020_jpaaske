---
title: "BIS 15L Practice Midterm"
author: "Joshua Paaske"
date: "1/31/20"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
---


```r
knitr::opts_chunk$set(echo = TRUE)
```

## `gapminder`
For this assignment, we are going to use the dataset [gapminder](https://cran.r-project.org/web/packages/gapminder/index.html). Gapminder includes information about economics, population, and life expectancy from countries all over the world. You will need to install it before use.

```r
#install.packages("gapminder")
```

## Load the libraries

```r
library(tidyverse)
```

```
## ── Attaching packages ──────────────────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.2.1     ✓ purrr   0.3.3
## ✓ tibble  2.1.3     ✓ dplyr   0.8.4
## ✓ tidyr   1.0.2     ✓ stringr 1.4.0
## ✓ readr   1.3.1     ✓ forcats 0.4.0
```

```
## ── Conflicts ─────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(gapminder)
options(scipen=999) #disables scientific notation when printing
```

## Data structure
**1. Use the function(s) of your choice to get an idea of the overall structure of the data frame, including its dimensions, column names, variable classes, etc.**

```r
dim(gapminder)
```

```
## [1] 1704    6
```

```r
names(gapminder)
```

```
## [1] "country"   "continent" "year"      "lifeExp"   "pop"       "gdpPercap"
```

```r
lapply(gapminder, class)
```

```
## $country
## [1] "factor"
## 
## $continent
## [1] "factor"
## 
## $year
## [1] "integer"
## 
## $lifeExp
## [1] "numeric"
## 
## $pop
## [1] "integer"
## 
## $gdpPercap
## [1] "numeric"
```

**2. Are there any NA's in the data?**

```r
anyNA(gapminder)
```

```
## [1] FALSE
```
No, there are no NA's. 

## Three versions of the `gampminder` data  
We will use three versions of the `gapminder` data to perform analyses and (eventually) make plots. For now, make the following long and wide versions of `gapminder`.

## `gapminder`
Notice that `gapminder` has one row for each country and year, and one column for each measurement (lifeExp, pop, gdpPercap).

```r
gapminder <- gapminder
gapminder
```

```
## # A tibble: 1,704 x 6
##    country     continent  year lifeExp      pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.
##  2 Afghanistan Asia       1957    30.3  9240934      821.
##  3 Afghanistan Asia       1962    32.0 10267083      853.
##  4 Afghanistan Asia       1967    34.0 11537966      836.
##  5 Afghanistan Asia       1972    36.1 13079460      740.
##  6 Afghanistan Asia       1977    38.4 14880372      786.
##  7 Afghanistan Asia       1982    39.9 12881816      978.
##  8 Afghanistan Asia       1987    40.8 13867957      852.
##  9 Afghanistan Asia       1992    41.7 16317921      649.
## 10 Afghanistan Asia       1997    41.8 22227415      635.
## # … with 1,694 more rows
```

## Long `gapminder`
**3. Make a new data frame `gapminder_long` that combines the three measured values (lifeExp, pop, gdpPercap) into a single column associated with a country and year.**

```r
gapminder_long <- gapminder %>% 
  pivot_longer(-c(country, year, continent),
               names_to = "measured_value", 
               values_to = "observation_value") %>% 
  unite("observation_year", measured_value, year, sep = "_") 
gapminder_long
```

```
## # A tibble: 5,112 x 4
##    country     continent observation_year observation_value
##    <fct>       <fct>     <chr>                        <dbl>
##  1 Afghanistan Asia      lifeExp_1952                  28.8
##  2 Afghanistan Asia      pop_1952                 8425333  
##  3 Afghanistan Asia      gdpPercap_1952               779. 
##  4 Afghanistan Asia      lifeExp_1957                  30.3
##  5 Afghanistan Asia      pop_1957                 9240934  
##  6 Afghanistan Asia      gdpPercap_1957               821. 
##  7 Afghanistan Asia      lifeExp_1962                  32.0
##  8 Afghanistan Asia      pop_1962                10267083  
##  9 Afghanistan Asia      gdpPercap_1962               853. 
## 10 Afghanistan Asia      lifeExp_1967                  34.0
## # … with 5,102 more rows
```

**4. For practice, use `pivot_wider()` to put the data back into the original `gapminder` format.**

```r
gapminder_long %>% 
  separate(observation_year, into=c("observation", "year"), sep = "_") %>% 
  pivot_wider(names_from = observation,
              values_from = observation_value) 
```

```
## # A tibble: 1,704 x 6
##    country     continent year  lifeExp      pop gdpPercap
##    <fct>       <fct>     <chr>   <dbl>    <dbl>     <dbl>
##  1 Afghanistan Asia      1952     28.8  8425333      779.
##  2 Afghanistan Asia      1957     30.3  9240934      821.
##  3 Afghanistan Asia      1962     32.0 10267083      853.
##  4 Afghanistan Asia      1967     34.0 11537966      836.
##  5 Afghanistan Asia      1972     36.1 13079460      740.
##  6 Afghanistan Asia      1977     38.4 14880372      786.
##  7 Afghanistan Asia      1982     39.9 12881816      978.
##  8 Afghanistan Asia      1987     40.8 13867957      852.
##  9 Afghanistan Asia      1992     41.7 16317921      649.
## 10 Afghanistan Asia      1997     41.8 22227415      635.
## # … with 1,694 more rows
```

## Wide `gapminder`
**5. Make a new data frame `gapminder_wide` that has all observations for each country in a single row. The column names should be named as "observation_year". Arrange them sequentially by year.**

```r
gapminder_wide <- gapminder_long %>% 
   pivot_wider(names_from = observation_year, values_from = observation_value)
gapminder_wide
```

```
## # A tibble: 142 x 38
##    country continent lifeExp_1952 pop_1952 gdpPercap_1952 lifeExp_1957 pop_1957
##    <fct>   <fct>            <dbl>    <dbl>          <dbl>        <dbl>    <dbl>
##  1 Afghan… Asia              28.8  8425333           779.         30.3  9240934
##  2 Albania Europe            55.2  1282697          1601.         59.3  1476505
##  3 Algeria Africa            43.1  9279525          2449.         45.7 10270856
##  4 Angola  Africa            30.0  4232095          3521.         32.0  4561361
##  5 Argent… Americas          62.5 17876956          5911.         64.4 19610538
##  6 Austra… Oceania           69.1  8691212         10040.         70.3  9712569
##  7 Austria Europe            66.8  6927772          6137.         67.5  6965860
##  8 Bahrain Asia              50.9   120447          9867.         53.8   138655
##  9 Bangla… Asia              37.5 46886859           684.         39.3 51365468
## 10 Belgium Europe            68    8730405          8343.         69.2  8989111
## # … with 132 more rows, and 31 more variables: gdpPercap_1957 <dbl>,
## #   lifeExp_1962 <dbl>, pop_1962 <dbl>, gdpPercap_1962 <dbl>,
## #   lifeExp_1967 <dbl>, pop_1967 <dbl>, gdpPercap_1967 <dbl>,
## #   lifeExp_1972 <dbl>, pop_1972 <dbl>, gdpPercap_1972 <dbl>,
## #   lifeExp_1977 <dbl>, pop_1977 <dbl>, gdpPercap_1977 <dbl>,
## #   lifeExp_1982 <dbl>, pop_1982 <dbl>, gdpPercap_1982 <dbl>,
## #   lifeExp_1987 <dbl>, pop_1987 <dbl>, gdpPercap_1987 <dbl>,
## #   lifeExp_1992 <dbl>, pop_1992 <dbl>, gdpPercap_1992 <dbl>,
## #   lifeExp_1997 <dbl>, pop_1997 <dbl>, gdpPercap_1997 <dbl>,
## #   lifeExp_2002 <dbl>, pop_2002 <dbl>, gdpPercap_2002 <dbl>,
## #   lifeExp_2007 <dbl>, pop_2007 <dbl>, gdpPercap_2007 <dbl>
```

**6. For practice, use `pivot_longer()` to put the data back into the original `gapminder` format. Hint: you can't do this in one step!**

```r
gapminder_wide %>% 
  pivot_longer(-c(country, continent),
               names_to = "observation_year",
               values_to = "observation_value") %>% 
  separate(observation_year, into=c("observation", "year"), sep = "_") %>% 
  pivot_wider(names_from = observation,
              values_from = observation_value)
```

```
## # A tibble: 1,704 x 6
##    country     continent year  lifeExp      pop gdpPercap
##    <fct>       <fct>     <chr>   <dbl>    <dbl>     <dbl>
##  1 Afghanistan Asia      1952     28.8  8425333      779.
##  2 Afghanistan Asia      1957     30.3  9240934      821.
##  3 Afghanistan Asia      1962     32.0 10267083      853.
##  4 Afghanistan Asia      1967     34.0 11537966      836.
##  5 Afghanistan Asia      1972     36.1 13079460      740.
##  6 Afghanistan Asia      1977     38.4 14880372      786.
##  7 Afghanistan Asia      1982     39.9 12881816      978.
##  8 Afghanistan Asia      1987     40.8 13867957      852.
##  9 Afghanistan Asia      1992     41.7 16317921      649.
## 10 Afghanistan Asia      1997     41.8 22227415      635.
## # … with 1,694 more rows
```

## Data summaries
**7. How many different continents and countries are represented in the data? Provide the total number and their names.**

```r
gapminder_wide %>% 
  summarize(count_country = n_distinct(country), count_continent = n_distinct(continent))
```

```
## # A tibble: 1 x 2
##   count_country count_continent
##           <int>           <int>
## 1           142               5
```
There are 142 countries and 5 continents. 

Names of countries:

```r
levels(gapminder_wide$country)
```

```
##   [1] "Afghanistan"              "Albania"                 
##   [3] "Algeria"                  "Angola"                  
##   [5] "Argentina"                "Australia"               
##   [7] "Austria"                  "Bahrain"                 
##   [9] "Bangladesh"               "Belgium"                 
##  [11] "Benin"                    "Bolivia"                 
##  [13] "Bosnia and Herzegovina"   "Botswana"                
##  [15] "Brazil"                   "Bulgaria"                
##  [17] "Burkina Faso"             "Burundi"                 
##  [19] "Cambodia"                 "Cameroon"                
##  [21] "Canada"                   "Central African Republic"
##  [23] "Chad"                     "Chile"                   
##  [25] "China"                    "Colombia"                
##  [27] "Comoros"                  "Congo, Dem. Rep."        
##  [29] "Congo, Rep."              "Costa Rica"              
##  [31] "Cote d'Ivoire"            "Croatia"                 
##  [33] "Cuba"                     "Czech Republic"          
##  [35] "Denmark"                  "Djibouti"                
##  [37] "Dominican Republic"       "Ecuador"                 
##  [39] "Egypt"                    "El Salvador"             
##  [41] "Equatorial Guinea"        "Eritrea"                 
##  [43] "Ethiopia"                 "Finland"                 
##  [45] "France"                   "Gabon"                   
##  [47] "Gambia"                   "Germany"                 
##  [49] "Ghana"                    "Greece"                  
##  [51] "Guatemala"                "Guinea"                  
##  [53] "Guinea-Bissau"            "Haiti"                   
##  [55] "Honduras"                 "Hong Kong, China"        
##  [57] "Hungary"                  "Iceland"                 
##  [59] "India"                    "Indonesia"               
##  [61] "Iran"                     "Iraq"                    
##  [63] "Ireland"                  "Israel"                  
##  [65] "Italy"                    "Jamaica"                 
##  [67] "Japan"                    "Jordan"                  
##  [69] "Kenya"                    "Korea, Dem. Rep."        
##  [71] "Korea, Rep."              "Kuwait"                  
##  [73] "Lebanon"                  "Lesotho"                 
##  [75] "Liberia"                  "Libya"                   
##  [77] "Madagascar"               "Malawi"                  
##  [79] "Malaysia"                 "Mali"                    
##  [81] "Mauritania"               "Mauritius"               
##  [83] "Mexico"                   "Mongolia"                
##  [85] "Montenegro"               "Morocco"                 
##  [87] "Mozambique"               "Myanmar"                 
##  [89] "Namibia"                  "Nepal"                   
##  [91] "Netherlands"              "New Zealand"             
##  [93] "Nicaragua"                "Niger"                   
##  [95] "Nigeria"                  "Norway"                  
##  [97] "Oman"                     "Pakistan"                
##  [99] "Panama"                   "Paraguay"                
## [101] "Peru"                     "Philippines"             
## [103] "Poland"                   "Portugal"                
## [105] "Puerto Rico"              "Reunion"                 
## [107] "Romania"                  "Rwanda"                  
## [109] "Sao Tome and Principe"    "Saudi Arabia"            
## [111] "Senegal"                  "Serbia"                  
## [113] "Sierra Leone"             "Singapore"               
## [115] "Slovak Republic"          "Slovenia"                
## [117] "Somalia"                  "South Africa"            
## [119] "Spain"                    "Sri Lanka"               
## [121] "Sudan"                    "Swaziland"               
## [123] "Sweden"                   "Switzerland"             
## [125] "Syria"                    "Taiwan"                  
## [127] "Tanzania"                 "Thailand"                
## [129] "Togo"                     "Trinidad and Tobago"     
## [131] "Tunisia"                  "Turkey"                  
## [133] "Uganda"                   "United Kingdom"          
## [135] "United States"            "Uruguay"                 
## [137] "Venezuela"                "Vietnam"                 
## [139] "West Bank and Gaza"       "Yemen, Rep."             
## [141] "Zambia"                   "Zimbabwe"
```

Names of continents:

```r
levels(gapminder_wide$continent)
```

```
## [1] "Africa"   "Americas" "Asia"     "Europe"   "Oceania"
```

**8. How many countries are represented on each continent?**

```r
gapminder_wide %>% 
  group_by(continent) %>% 
  summarize(number_of_countries = n_distinct(country))
```

```
## # A tibble: 5 x 2
##   continent number_of_countries
##   <fct>                   <int>
## 1 Africa                     52
## 2 Americas                   25
## 3 Asia                       33
## 4 Europe                     30
## 5 Oceania                     2
```

**9. For the years included in the data, what is the mean life expectancy by continent? Arrange the results in descending order.**

```r
gapminder %>% 
  select(continent, lifeExp) %>% 
  group_by(continent) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% 
  arrange(desc(mean_lifeExp))
```

```
## # A tibble: 5 x 2
##   continent mean_lifeExp
##   <fct>            <dbl>
## 1 Oceania           74.3
## 2 Europe            71.9
## 3 Americas          64.7
## 4 Asia              60.1
## 5 Africa            48.9
```

**10. For the years included in the data, how has life expectancy changed in each country between 1952-2007? How does this look in the USA only?**

```r
gapminder %>% 
  select(country, year, lifeExp)
```

```
## # A tibble: 1,704 x 3
##    country      year lifeExp
##    <fct>       <int>   <dbl>
##  1 Afghanistan  1952    28.8
##  2 Afghanistan  1957    30.3
##  3 Afghanistan  1962    32.0
##  4 Afghanistan  1967    34.0
##  5 Afghanistan  1972    36.1
##  6 Afghanistan  1977    38.4
##  7 Afghanistan  1982    39.9
##  8 Afghanistan  1987    40.8
##  9 Afghanistan  1992    41.7
## 10 Afghanistan  1997    41.8
## # … with 1,694 more rows
```
In general, life expectancy increases as time goes on. 


```r
gapminder %>% 
  select(country, year, lifeExp) %>% 
  filter(str_detect(country, "United States"))
```

```
## # A tibble: 12 x 3
##    country        year lifeExp
##    <fct>         <int>   <dbl>
##  1 United States  1952    68.4
##  2 United States  1957    69.5
##  3 United States  1962    70.2
##  4 United States  1967    70.8
##  5 United States  1972    71.3
##  6 United States  1977    73.4
##  7 United States  1982    74.6
##  8 United States  1987    75.0
##  9 United States  1992    76.1
## 10 United States  1997    76.8
## 11 United States  2002    77.3
## 12 United States  2007    78.2
```
Life expectancy in the United States still increases, but it starts much higher. 

**11. In the year 2007, which countries had a life expectancy between 70 and 75 years?**

```r
gapminder11 <- gapminder %>% 
  filter(year == 2007) %>% 
  filter(lifeExp >= 70 & lifeExp <= 75) %>% 
  droplevels

levels(gapminder11$country)
```

```
##  [1] "Algeria"                "Bosnia and Herzegovina" "Brazil"                
##  [4] "Bulgaria"               "China"                  "Colombia"              
##  [7] "Dominican Republic"     "Ecuador"                "Egypt"                 
## [10] "El Salvador"            "Guatemala"              "Honduras"              
## [13] "Hungary"                "Indonesia"              "Iran"                  
## [16] "Jamaica"                "Jordan"                 "Lebanon"               
## [19] "Libya"                  "Malaysia"               "Mauritius"             
## [22] "Montenegro"             "Morocco"                "Nicaragua"             
## [25] "Paraguay"               "Peru"                   "Philippines"           
## [28] "Romania"                "Saudi Arabia"           "Serbia"                
## [31] "Slovak Republic"        "Sri Lanka"              "Syria"                 
## [34] "Thailand"               "Tunisia"                "Turkey"                
## [37] "Venezuela"              "Vietnam"                "West Bank and Gaza"
```

**12. In 1997, what are the minimum, maximum, and mean life expectancies of the Americas and Europe?**

```r
gapminder %>% 
  filter(continent == "Europe" | continent == "Americas") %>% 
  filter(year == 1997) %>% 
  summarize(mean_lifeExp = mean(lifeExp), maximum_lifeExp = max(lifeExp), minimum_lifeExp = min(lifeExp))
```

```
## # A tibble: 1 x 3
##   mean_lifeExp maximum_lifeExp minimum_lifeExp
##          <dbl>           <dbl>           <dbl>
## 1         73.5            79.4            56.7
```
The mean life expectancy was 73.5 years, the maximum life expectancy was 79.39 years, and the minimum life expectancy was 56.7 years. 

**13. Which countries had the smallest populations in 1952? How about in 2007?**  

```r
gapminder %>% 
  select(country, year, pop) %>% 
  filter(year == 1952) %>% 
  arrange(pop)
```

```
## # A tibble: 142 x 3
##    country                year    pop
##    <fct>                 <int>  <int>
##  1 Sao Tome and Principe  1952  60011
##  2 Djibouti               1952  63149
##  3 Bahrain                1952 120447
##  4 Iceland                1952 147962
##  5 Comoros                1952 153936
##  6 Kuwait                 1952 160000
##  7 Equatorial Guinea      1952 216964
##  8 Reunion                1952 257700
##  9 Gambia                 1952 284320
## 10 Swaziland              1952 290243
## # … with 132 more rows
```
In 1952, Sao Tome and Principe, Dijbouti, and Bahrain had the smallest populations. 


```r
gapminder %>% 
  select(country, year, pop) %>% 
  filter(year == 2007) %>% 
  arrange(pop)
```

```
## # A tibble: 142 x 3
##    country                year     pop
##    <fct>                 <int>   <int>
##  1 Sao Tome and Principe  2007  199579
##  2 Iceland                2007  301931
##  3 Djibouti               2007  496374
##  4 Equatorial Guinea      2007  551201
##  5 Montenegro             2007  684736
##  6 Bahrain                2007  708573
##  7 Comoros                2007  710960
##  8 Reunion                2007  798094
##  9 Trinidad and Tobago    2007 1056608
## 10 Swaziland              2007 1133066
## # … with 132 more rows
```
In 1952, Sao Tome and Principe, Dijbouti, and Iceland had the smallest populations. 

**14. We are interested in the GDP for countries in the Middle East including all years in the data. First, separate all of the countries on the "Asia" continent. How many countries are listed and what are their names?**

```r
gapminder_wide %>% 
  filter(continent == "Asia") %>% 
  summarize(number_countries = n_distinct(country))
```

```
## # A tibble: 1 x 1
##   number_countries
##              <int>
## 1               33
```

```r
gapminder14 <- gapminder_wide %>% 
  filter(continent == "Asia") %>% 
  droplevels
levels(gapminder14$country)
```

```
##  [1] "Afghanistan"        "Bahrain"            "Bangladesh"        
##  [4] "Cambodia"           "China"              "Hong Kong, China"  
##  [7] "India"              "Indonesia"          "Iran"              
## [10] "Iraq"               "Israel"             "Japan"             
## [13] "Jordan"             "Korea, Dem. Rep."   "Korea, Rep."       
## [16] "Kuwait"             "Lebanon"            "Malaysia"          
## [19] "Mongolia"           "Myanmar"            "Nepal"             
## [22] "Oman"               "Pakistan"           "Philippines"       
## [25] "Saudi Arabia"       "Singapore"          "Sri Lanka"         
## [28] "Syria"              "Taiwan"             "Thailand"          
## [31] "Vietnam"            "West Bank and Gaza" "Yemen, Rep."
```

**15. Next, remove all of the countries from this list that are part of the Middle East and put them into a new object `gapminder_middleEast`. Add a new column to the data called "region" and make sure "Middle East" is specified for these countries.**

```r
gapminder_middleEast <- gapminder %>% 
  filter(country %in% c("Algeria", "Bahrain", "Egypt", "Iran", "Iraq", "Israel", "Jordan", "Kuwait", "Lebanon", "Libya", "Morocco", "Oman", "Qatar", "Saudi Arabia", "Syria", "Tunisia", "Turkey", "United Arab Emirates", "Yemen")) %>% 
  mutate(region = "Middle East")
gapminder_middleEast
```

```
## # A tibble: 192 x 7
##    country continent  year lifeExp      pop gdpPercap region     
##    <fct>   <fct>     <int>   <dbl>    <int>     <dbl> <chr>      
##  1 Algeria Africa     1952    43.1  9279525     2449. Middle East
##  2 Algeria Africa     1957    45.7 10270856     3014. Middle East
##  3 Algeria Africa     1962    48.3 11000948     2551. Middle East
##  4 Algeria Africa     1967    51.4 12760499     3247. Middle East
##  5 Algeria Africa     1972    54.5 14760787     4183. Middle East
##  6 Algeria Africa     1977    58.0 17152804     4910. Middle East
##  7 Algeria Africa     1982    61.4 20033753     5745. Middle East
##  8 Algeria Africa     1987    65.8 23254956     5681. Middle East
##  9 Algeria Africa     1992    67.7 26298373     5023. Middle East
## 10 Algeria Africa     1997    69.2 29072015     4797. Middle East
## # … with 182 more rows
```

**16. Now show the gdpPercap for each country with the years as column names; i.e. one row per country.**

```r
gapminder_middleEast %>% 
  select(country, continent, year, gdpPercap, region) %>% 
  mutate_at(vars(year), ~paste(.,"_gdpPercap")) %>% 
  pivot_wider(names_from = year,
              values_from = gdpPercap)
```

```
## # A tibble: 16 x 15
##    country continent region `1952 _gdpPerca… `1957 _gdpPerca… `1962 _gdpPerca…
##    <fct>   <fct>     <chr>             <dbl>            <dbl>            <dbl>
##  1 Algeria Africa    Middl…            2449.            3014.            2551.
##  2 Bahrain Asia      Middl…            9867.           11636.           12753.
##  3 Egypt   Africa    Middl…            1419.            1459.            1693.
##  4 Iran    Asia      Middl…            3035.            3290.            4187.
##  5 Iraq    Asia      Middl…            4130.            6229.            8342.
##  6 Israel  Asia      Middl…            4087.            5385.            7106.
##  7 Jordan  Asia      Middl…            1547.            1886.            2348.
##  8 Kuwait  Asia      Middl…          108382.          113523.           95458.
##  9 Lebanon Asia      Middl…            4835.            6090.            5715.
## 10 Libya   Africa    Middl…            2388.            3448.            6757.
## 11 Morocco Africa    Middl…            1688.            1642.            1566.
## 12 Oman    Asia      Middl…            1828.            2243.            2925.
## 13 Saudi … Asia      Middl…            6460.            8158.           11626.
## 14 Syria   Asia      Middl…            1643.            2117.            2193.
## 15 Tunisia Africa    Middl…            1468.            1395.            1660.
## 16 Turkey  Europe    Middl…            1969.            2219.            2323.
## # … with 9 more variables: `1967 _gdpPercap` <dbl>, `1972 _gdpPercap` <dbl>,
## #   `1977 _gdpPercap` <dbl>, `1982 _gdpPercap` <dbl>, `1987 _gdpPercap` <dbl>,
## #   `1992 _gdpPercap` <dbl>, `1997 _gdpPercap` <dbl>, `2002 _gdpPercap` <dbl>,
## #   `2007 _gdpPercap` <dbl>
```

