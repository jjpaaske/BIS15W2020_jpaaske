---
title: "Lab 4 Homework"
author: "Joshua Paaske"
date: "2/7/20"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
---


```r
knitr::opts_chunk$set(echo = TRUE)
```

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove any `#` for included code chunks to run.  

## Load the tidyverse

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

For this assignment we are going to work with a large dataset from the [United Nations Food and Agriculture Organization](http://www.fao.org/about/en/) on world fisheries. First, load the data.  

1. Load the data `FAO_1950to2012_111914.csv` as a new object titled `fisheries`.


```r
fisheries <- readr::read_csv("data/FAO_1950to2012_111914.csv") %>% 
  mutate_all(~str_replace_all(., " F", "")) %>%
  mutate_all(str_trim) %>% 
  mutate_at(vars(starts_with("19",)), ~str_replace_all(., " ", "")) %>% 
  mutate_at(vars(starts_with("2")), ~str_replace_all(., " ", ""))
```

```
## Parsed with column specification:
## cols(
##   .default = col_character(),
##   `ISSCAAP group#` = col_double(),
##   `FAO major fishing area` = col_double()
## )
```

```
## See spec(...) for full column specifications.
```

2. What are the names of the columns? Do you see any potential problems with the column names?


```r
colnames(fisheries)
```

```
##  [1] "Country"                 "Common name"            
##  [3] "ISSCAAP group#"          "ISSCAAP taxonomic group"
##  [5] "ASFIS species#"          "ASFIS species name"     
##  [7] "FAO major fishing area"  "Measure"                
##  [9] "1950"                    "1951"                   
## [11] "1952"                    "1953"                   
## [13] "1954"                    "1955"                   
## [15] "1956"                    "1957"                   
## [17] "1958"                    "1959"                   
## [19] "1960"                    "1961"                   
## [21] "1962"                    "1963"                   
## [23] "1964"                    "1965"                   
## [25] "1966"                    "1967"                   
## [27] "1968"                    "1969"                   
## [29] "1970"                    "1971"                   
## [31] "1972"                    "1973"                   
## [33] "1974"                    "1975"                   
## [35] "1976"                    "1977"                   
## [37] "1978"                    "1979"                   
## [39] "1980"                    "1981"                   
## [41] "1982"                    "1983"                   
## [43] "1984"                    "1985"                   
## [45] "1986"                    "1987"                   
## [47] "1988"                    "1989"                   
## [49] "1990"                    "1991"                   
## [51] "1992"                    "1993"                   
## [53] "1994"                    "1995"                   
## [55] "1996"                    "1997"                   
## [57] "1998"                    "1999"                   
## [59] "2000"                    "2001"                   
## [61] "2002"                    "2003"                   
## [63] "2004"                    "2005"                   
## [65] "2006"                    "2007"                   
## [67] "2008"                    "2009"                   
## [69] "2010"                    "2011"                   
## [71] "2012"
```

Measure is slightly ambiguous, and the columns from 1950 to 2012 are variables. 

3. What is the structure of the data? Show the classes of each variable.

```r
sapply(fisheries, class)
```

```
##                 Country             Common name          ISSCAAP group# 
##             "character"             "character"             "character" 
## ISSCAAP taxonomic group          ASFIS species#      ASFIS species name 
##             "character"             "character"             "character" 
##  FAO major fishing area                 Measure                    1950 
##             "character"             "character"             "character" 
##                    1951                    1952                    1953 
##             "character"             "character"             "character" 
##                    1954                    1955                    1956 
##             "character"             "character"             "character" 
##                    1957                    1958                    1959 
##             "character"             "character"             "character" 
##                    1960                    1961                    1962 
##             "character"             "character"             "character" 
##                    1963                    1964                    1965 
##             "character"             "character"             "character" 
##                    1966                    1967                    1968 
##             "character"             "character"             "character" 
##                    1969                    1970                    1971 
##             "character"             "character"             "character" 
##                    1972                    1973                    1974 
##             "character"             "character"             "character" 
##                    1975                    1976                    1977 
##             "character"             "character"             "character" 
##                    1978                    1979                    1980 
##             "character"             "character"             "character" 
##                    1981                    1982                    1983 
##             "character"             "character"             "character" 
##                    1984                    1985                    1986 
##             "character"             "character"             "character" 
##                    1987                    1988                    1989 
##             "character"             "character"             "character" 
##                    1990                    1991                    1992 
##             "character"             "character"             "character" 
##                    1993                    1994                    1995 
##             "character"             "character"             "character" 
##                    1996                    1997                    1998 
##             "character"             "character"             "character" 
##                    1999                    2000                    2001 
##             "character"             "character"             "character" 
##                    2002                    2003                    2004 
##             "character"             "character"             "character" 
##                    2005                    2006                    2007 
##             "character"             "character"             "character" 
##                    2008                    2009                    2010 
##             "character"             "character"             "character" 
##                    2011                    2012 
##             "character"             "character"
```

4. Think about the classes. Will any present problems? Make any changes you think are necessary below.

The columns with years should not be characters, but numerics, and the rest should be a factors. 

```r
fisheries <- fisheries %>% 
  mutate_at(vars(starts_with("19")), as.numeric) %>% 
  mutate_at(vars(starts_with("2")), as.numeric) %>% 
  mutate_if(is.character, as.factor)
  

sapply(fisheries, class)
```

```
##                 Country             Common name          ISSCAAP group# 
##                "factor"                "factor"                "factor" 
## ISSCAAP taxonomic group          ASFIS species#      ASFIS species name 
##                "factor"                "factor"                "factor" 
##  FAO major fishing area                 Measure                    1950 
##                "factor"                "factor"               "numeric" 
##                    1951                    1952                    1953 
##               "numeric"               "numeric"               "numeric" 
##                    1954                    1955                    1956 
##               "numeric"               "numeric"               "numeric" 
##                    1957                    1958                    1959 
##               "numeric"               "numeric"               "numeric" 
##                    1960                    1961                    1962 
##               "numeric"               "numeric"               "numeric" 
##                    1963                    1964                    1965 
##               "numeric"               "numeric"               "numeric" 
##                    1966                    1967                    1968 
##               "numeric"               "numeric"               "numeric" 
##                    1969                    1970                    1971 
##               "numeric"               "numeric"               "numeric" 
##                    1972                    1973                    1974 
##               "numeric"               "numeric"               "numeric" 
##                    1975                    1976                    1977 
##               "numeric"               "numeric"               "numeric" 
##                    1978                    1979                    1980 
##               "numeric"               "numeric"               "numeric" 
##                    1981                    1982                    1983 
##               "numeric"               "numeric"               "numeric" 
##                    1984                    1985                    1986 
##               "numeric"               "numeric"               "numeric" 
##                    1987                    1988                    1989 
##               "numeric"               "numeric"               "numeric" 
##                    1990                    1991                    1992 
##               "numeric"               "numeric"               "numeric" 
##                    1993                    1994                    1995 
##               "numeric"               "numeric"               "numeric" 
##                    1996                    1997                    1998 
##               "numeric"               "numeric"               "numeric" 
##                    1999                    2000                    2001 
##               "numeric"               "numeric"               "numeric" 
##                    2002                    2003                    2004 
##               "numeric"               "numeric"               "numeric" 
##                    2005                    2006                    2007 
##               "numeric"               "numeric"               "numeric" 
##                    2008                    2009                    2010 
##               "numeric"               "numeric"               "numeric" 
##                    2011                    2012 
##               "numeric"               "numeric"
```

5. How many countries are represented in the data? Provide a count.

```r
nlevels(fisheries$Country)
```

```
## [1] 204
```

6. What are the names of the countries?

```r
levels(fisheries$Country)
```

```
##   [1] "Albania"                  "Algeria"                 
##   [3] "American Samoa"           "Angola"                  
##   [5] "Anguilla"                 "Antigua and Barbuda"     
##   [7] "Argentina"                "Aruba"                   
##   [9] "Australia"                "Bahamas"                 
##  [11] "Bahrain"                  "Bangladesh"              
##  [13] "Barbados"                 "Belgium"                 
##  [15] "Belize"                   "Benin"                   
##  [17] "Bermuda"                  "Bonaire/S.Eustatius/Saba"
##  [19] "Bosnia and Herzegovina"   "Brazil"                  
##  [21] "British Indian Ocean Ter" "British Virgin Islands"  
##  [23] "Brunei Darussalam"        "Bulgaria"                
##  [25] "Cabo Verde"               "Cambodia"                
##  [27] "Cameroon"                 "Canada"                  
##  [29] "Cayman Islands"           "Channel Islands"         
##  [31] "Chile"                    "China"                   
##  [33] "China, Hong Kong SAR"     "China, Macao SAR"        
##  [35] "Colombia"                 "Comoros"                 
##  [37] "Congo, Dem. Rep. of the"  "Congo, Republic of"      
##  [39] "Cook Islands"             "Costa Rica"              
##  [41] "Croatia"                  "Cuba"                    
##  [43] "Cura�ao"                  "Cyprus"                  
##  [45] "C�te d'Ivoire"            "Denmark"                 
##  [47] "Djibouti"                 "Dominica"                
##  [49] "Dominican Republic"       "Ecuador"                 
##  [51] "Egypt"                    "El Salvador"             
##  [53] "Equatorial Guinea"        "Eritrea"                 
##  [55] "Estonia"                  "Ethiopia"                
##  [57] "Falkland Is.(Malvinas)"   "Faroe Islands"           
##  [59] "Fiji, Republic of"        "Finland"                 
##  [61] "France"                   "French Guiana"           
##  [63] "French Polynesia"         "French Southern Terr"    
##  [65] "Gabon"                    "Gambia"                  
##  [67] "Georgia"                  "Germany"                 
##  [69] "Ghana"                    "Gibraltar"               
##  [71] "Greece"                   "Greenland"               
##  [73] "Grenada"                  "Guadeloupe"              
##  [75] "Guam"                     "Guatemala"               
##  [77] "Guinea"                   "GuineaBissau"            
##  [79] "Guyana"                   "Haiti"                   
##  [81] "Honduras"                 "Iceland"                 
##  [83] "India"                    "Indonesia"               
##  [85] "Iran (Islamic Rep. of)"   "Iraq"                    
##  [87] "Ireland"                  "Isle of Man"             
##  [89] "Israel"                   "Italy"                   
##  [91] "Jamaica"                  "Japan"                   
##  [93] "Jordan"                   "Kenya"                   
##  [95] "Kiribati"                 "Korea, Dem. People's Rep"
##  [97] "Korea, Republic of"       "Kuwait"                  
##  [99] "Latvia"                   "Lebanon"                 
## [101] "Liberia"                  "Libya"                   
## [103] "Lithuania"                "Madagascar"              
## [105] "Malaysia"                 "Maldives"                
## [107] "Malta"                    "Marshall Islands"        
## [109] "Martinique"               "Mauritania"              
## [111] "Mauritius"                "Mayotte"                 
## [113] "Mexico"                   "Micronesia,ed.States of" 
## [115] "Monaco"                   "Montenegro"              
## [117] "Montserrat"               "Morocco"                 
## [119] "Mozambique"               "Myanmar"                 
## [121] "Namibia"                  "Nauru"                   
## [123] "Netherlands"              "Netherlands Antilles"    
## [125] "New Caledonia"            "New Zealand"             
## [127] "Nicaragua"                "Nigeria"                 
## [129] "Niue"                     "Norfolk Island"          
## [131] "Northern Mariana Is."     "Norway"                  
## [133] "Oman"                     "Other nei"               
## [135] "Pakistan"                 "Palau"                   
## [137] "Palestine, Occupied Tr."  "Panama"                  
## [139] "Papua New Guinea"         "Peru"                    
## [141] "Philippines"              "Pitcairn Islands"        
## [143] "Poland"                   "Portugal"                
## [145] "Puerto Rico"              "Qatar"                   
## [147] "Romania"                  "Russianederation"        
## [149] "R�union"                  "Saint Barth�lemy"        
## [151] "Saint Helena"             "Saint Kitts and Nevis"   
## [153] "Saint Lucia"              "Saint Vincent/Grenadines"
## [155] "SaintMartin"              "Samoa"                   
## [157] "Sao Tome and Principe"    "Saudi Arabia"            
## [159] "Senegal"                  "Serbia and Montenegro"   
## [161] "Seychelles"               "Sierra Leone"            
## [163] "Singapore"                "Sint Maarten"            
## [165] "Slovenia"                 "Solomon Islands"         
## [167] "Somalia"                  "South Africa"            
## [169] "Spain"                    "Sri Lanka"               
## [171] "St. Pierre and Miquelon"  "Sudan"                   
## [173] "Sudan (former)"           "Suriname"                
## [175] "Svalbard and Jan Mayen"   "Sweden"                  
## [177] "Syrian Arab Republic"     "Taiwan Province of China"
## [179] "Tanzania, United Rep. of" "Thailand"                
## [181] "TimorLeste"               "Togo"                    
## [183] "Tokelau"                  "Tonga"                   
## [185] "Trinidad and Tobago"      "Tunisia"                 
## [187] "Turkey"                   "Turks and Caicos Is."    
## [189] "Tuvalu"                   "Ukraine"                 
## [191] "Un. Sov. Soc. Rep."       "United Arab Emirates"    
## [193] "United Kingdom"           "United States of America"
## [195] "Uruguay"                  "US Virgin Islands"       
## [197] "Vanuatu"                  "Venezuela, Boliv Rep of" 
## [199] "Viet Nam"                 "Wallis andutuna Is."     
## [201] "Western Sahara"           "Yemen"                   
## [203] "Yugoslavia SFR"           "Zanzibar"
```


7. Use `rename()` to rename the columns and make them easier to use. The new column names should be:  
+ country
+ commname
+ ASFIS_sciname
+ ASFIS_spcode
+ ISSCAAP_spgroup
+ ISSCAAP_spgroupname
+ FAO_area
+ unit

```r
fisheries <- fisheries %>% 
  rename(country = 'Country', commname = 'Common name', ASFIS_sciname = "ASFIS species name", ASFIS_spcode = 'ASFIS species#', ISSCAAP_spgroupname = 'ISSCAAP taxonomic group', ISSCAAP_spgroup = `ISSCAAP group#`, FAO_area = 'FAO major fishing area', unit = 'Measure')
```

8. Are these data tidy? Why or why not, and, how do you know? Use the appropriate pivot function to tidy the data. Remove the NA's. Put the tidy data frame into a new object `fisheries_tidy`. 

These data are not tidy, because the column names including years are data. 

```r
fisheries_tidy <- fisheries %>% 
  pivot_longer(-c(country, commname, ASFIS_spcode, ASFIS_sciname, ISSCAAP_spgroupname, ISSCAAP_spgroup, FAO_area, unit), 
               names_to = "year",
               values_to = "catch")
```

9. Refocus the data only to include country, ISSCAAP_spgroupname, ASFIS_spcode, ASFIS_sciname, year, and catch.

```r
fisheries_tidy2 <- fisheries_tidy %>% 
  select(country, ISSCAAP_spgroupname, ISSCAAP_spgroup, ASFIS_spcode, ASFIS_sciname, year, catch) %>% 
  mutate_at(vars(year), as.numeric)
```

10. Re-check the classes of `fisheries_tidy2`. Notice that "catch" is shown as a character! This is a problem because we will want to treat it as a numeric. How will you deal with this?

```r
lapply(fisheries_tidy2, class)
```

```
## $country
## [1] "factor"
## 
## $ISSCAAP_spgroupname
## [1] "factor"
## 
## $ISSCAAP_spgroup
## [1] "factor"
## 
## $ASFIS_spcode
## [1] "factor"
## 
## $ASFIS_sciname
## [1] "factor"
## 
## $year
## [1] "numeric"
## 
## $catch
## [1] "numeric"
```
I already changed the values of catch to numerics earlier on in the homework. 

11. Based on the ASFIS_spcode, how many distinct taxa were caught as part of these data?


```r
nlevels(fisheries_tidy2$ASFIS_spcode)
```

```
## [1] 1553
```
1553 distinct taxa were caught as part of this data.

12. Which country had the largest overall catch in the year 2000?

```r
fisheries_tidy2 %>% 
  filter(year == 2000) %>% 
  group_by(country) %>% 
  summarize(catch = sum(catch, na.rm = T)) %>% 
  arrange(desc(catch))
```

```
## # A tibble: 204 x 2
##    country                     catch
##    <fct>                       <dbl>
##  1 China                    12695472
##  2 Peru                     10625010
##  3 Japan                     4921013
##  4 United States of America  4692229
##  5 Chile                     4297928
##  6 Indonesia                 3761769
##  7 Russianederation          3678828
##  8 Thailand                  2795719
##  9 India                     2760632
## 10 Norway                    2698506
## # … with 194 more rows
```
China had the largest overal catch of 12695472 tonnes in the year 2000.

13. Which country caught the most sardines (_Sardina_) between the years 1990-2000?

```r
fisheries_tidy2 %>% 
  select(country, catch, year, ASFIS_sciname) %>%
  filter(str_detect(ASFIS_sciname, "Sardina")) %>% 
  filter(year <= 2000 & year >= 1990) %>% 
  group_by(country) %>% 
  summarize(catch = sum(catch, na.rm = T)) %>% 
  arrange(desc(catch, by.group = TRUE))
```

```
## # A tibble: 46 x 2
##    country            catch
##    <fct>              <dbl>
##  1 Morocco          4785190
##  2 Spain            2056817
##  3 Russianederation 1035139
##  4 Portugal          926318
##  5 Ukraine           784730
##  6 Algeria           631733
##  7 Italy             377907
##  8 Turkey            273565
##  9 France            263871
## 10 Denmark           242017
## # … with 36 more rows
```
Morocco had the largest catch of 4785190 tonnes. 

14. Which five countries caught the most cephalopods between 2008-2012?

```r
fisheries_tidy2 %>% 
  filter(str_detect(ISSCAAP_spgroupname, "Squids")) %>% 
  filter(year <= 2012 & year >= 2008) %>% 
  group_by(country) %>% 
  summarize(catch = sum(catch, na.rm = T)) %>% 
  arrange(desc(catch, by.group = TRUE))
```

```
## # A tibble: 139 x 2
##    country                    catch
##    <fct>                      <dbl>
##  1 China                    4785139
##  2 Peru                     2274232
##  3 Japan                    1644085
##  4 Korea, Republic of       1535454
##  5 Viet Nam                 1292000
##  6 Chile                     723186
##  7 Indonesia                 684567
##  8 United States of America  613400
##  9 Thailand                  603529
## 10 Taiwan Province of China  593638
## # … with 129 more rows
```
China caught the most cephalopods betwen 2008-2012. 

15. Given the top five countries from question 14 above, which species was the highest catch total? The lowest?

```r
fisheries_tidy2 %>% 
  filter(str_detect(ISSCAAP_spgroupname, "Squids")) %>% 
  filter(year <= 2012 & year >= 2008) %>% 
  group_by(ASFIS_sciname) %>% 
  summarize(catch_total=sum(catch, na.rm=T)) %>% 
  arrange(desc(catch_total))
```

```
## # A tibble: 35 x 2
##    ASFIS_sciname               catch_total
##    <fct>                             <dbl>
##  1 Dosidicus gigas                 4211138
##  2 Loliginidae, Ommastrephidae     2951507
##  3 Cephalopoda                     2040955
##  4 Todarodes pacificus             1936561
##  5 Illex argentinus                1834620
##  6 Octopodidae                     1497654
##  7 Sepiidae, Sepiolidae            1338968
##  8 Loligo spp                      1293727
##  9 Loligo opalescens                477536
## 10 Loligo gahi                      317535
## # … with 25 more rows
```
Dosidicus gigas had the highest catch total of 4211138 tons. 


```r
fisheries_tidy2 %>% 
  filter(str_detect(ISSCAAP_spgroupname, "Squids")) %>% 
  filter(year <= 2012 & year >= 2008) %>% 
  group_by(ASFIS_sciname) %>% 
  summarize(catch_total=sum(catch, na.rm=T)) %>% 
  arrange(catch_total)
```

```
## # A tibble: 35 x 2
##    ASFIS_sciname        catch_total
##    <fct>                      <dbl>
##  1 Eledone moschata               0
##  2 Gonatidae                      0
##  3 Moroteuthis robustus           0
##  4 Pareledone spp                 0
##  5 Todarodes filippovae           1
##  6 Martialia hyadesi              4
##  7 Moroteuthis ingens           194
##  8 Loligo vulgaris              398
##  9 Eledone cirrhosa             920
## 10 Loligo duvauceli            1843
## # … with 25 more rows
```
The species with the lowest catch total is Todarodes filippovae with 1 ton (excluding fish with 0 tonnes) 

16. In some cases, the taxonomy of the fish being caught is unclear. Make a new data frame called `coastal_fish` that shows the taxonomic composition of "Miscellaneous coastal fishes" within the ISSCAAP_spgroupname column.

```r
coastal_fish <- fisheries_tidy2 %>% 
  filter(ISSCAAP_spgroupname == 'Miscellaneous coastal fishes')
```

17. Use the data to do at least one exploratory analysis of your choice. What can you learn?

I am going to explore which country caught the most variety of coastal fish. 

```r
coastal_fish %>% 
  group_by(country) %>% 
  summarize(types_of_fish = n_distinct(ASFIS_sciname)) %>% 
  arrange(desc(types_of_fish))
```

```
## # A tibble: 150 x 2
##    country                  types_of_fish
##    <fct>                            <int>
##  1 United States of America            84
##  2 Saudi Arabia                        76
##  3 Spain                               66
##  4 Portugal                            63
##  5 Brazil                              42
##  6 France                              42
##  7 Senegal                             42
##  8 Un. Sov. Soc. Rep.                  41
##  9 Korea, Republic of                  40
## 10 Mexico                              39
## # … with 140 more rows
```
The United States of America caught the most variety of coastal fish with Saudi Arabia coming in second. 

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
