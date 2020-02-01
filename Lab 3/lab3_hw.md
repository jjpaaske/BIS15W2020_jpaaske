---
title: "Lab 3 Homework"
author: "Joshua Paaske"
date: "Winter 2020"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
---


```r
knitr::opts_chunk$set(echo = TRUE)
```

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run.  

## Load the tidyverse

```r
library(tidyverse)
```

```
## ── Attaching packages ──────────────────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.2.1     ✓ purrr   0.3.3
## ✓ tibble  2.1.3     ✓ dplyr   0.8.3
## ✓ tidyr   1.0.0     ✓ stringr 1.4.0
## ✓ readr   1.3.1     ✓ forcats 0.4.0
```

```
## ── Conflicts ─────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

## Data
For the homework, we will use data about vertebrate home range sizes. The data are in the class folder, but the reference is below.  

**Database of vertebrate home range sizes.**  
Reference: Tamburello N, Cote IM, Dulvy NK (2015) Energy and the scaling of animal space use. The American Naturalist 186(2):196-211. http://dx.doi.org/10.1086/682070.  
Data: http://datadryad.org/resource/doi:10.5061/dryad.q5j65/1  

1. Load the data into a new object called `homerange`.  

```r
homerange <- readr::read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")
```

```
## Parsed with column specification:
## cols(
##   .default = col_character(),
##   mean.mass.g = col_double(),
##   log10.mass = col_double(),
##   mean.hra.m2 = col_double(),
##   log10.hra = col_double(),
##   preymass = col_double(),
##   log10.preymass = col_double(),
##   PPMR = col_double()
## )
```

```
## See spec(...) for full column specifications.
```

2. Use `spec()` to see the full details of the columns.  

```r
spec(homerange)
```

```
## cols(
##   taxon = col_character(),
##   common.name = col_character(),
##   class = col_character(),
##   order = col_character(),
##   family = col_character(),
##   genus = col_character(),
##   species = col_character(),
##   primarymethod = col_character(),
##   N = col_character(),
##   mean.mass.g = col_double(),
##   log10.mass = col_double(),
##   alternative.mass.reference = col_character(),
##   mean.hra.m2 = col_double(),
##   log10.hra = col_double(),
##   hra.reference = col_character(),
##   realm = col_character(),
##   thermoregulation = col_character(),
##   locomotion = col_character(),
##   trophic.guild = col_character(),
##   dimension = col_character(),
##   preymass = col_double(),
##   log10.preymass = col_double(),
##   PPMR = col_double(),
##   prey.size.reference = col_character()
## )
```

3. Explore the data. Show the dimensions, column names, classes for each variable, and a statistical summary. Keep these as separate code chunks.  

### Dimensions

```r
dim(homerange)
```

```
## [1] 569  24
```

### Column Names

```r
names(homerange)
```

```
##  [1] "taxon"                      "common.name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "N"                          "mean.mass.g"               
## [11] "log10.mass"                 "alternative.mass.reference"
## [13] "mean.hra.m2"                "log10.hra"                 
## [15] "hra.reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic.guild"              "dimension"                 
## [21] "preymass"                   "log10.preymass"            
## [23] "PPMR"                       "prey.size.reference"
```

### Classes of each variable (in second column)

```r
glimpse(homerange)
```

```
## Observations: 569
## Variables: 24
## $ taxon                      <chr> "lake fishes", "river fishes", "river fish…
## $ common.name                <chr> "american eel", "blacktail redhorse", "cen…
## $ class                      <chr> "actinopterygii", "actinopterygii", "actin…
## $ order                      <chr> "anguilliformes", "cypriniformes", "cyprin…
## $ family                     <chr> "anguillidae", "catostomidae", "cyprinidae…
## $ genus                      <chr> "anguilla", "moxostoma", "campostoma", "cl…
## $ species                    <chr> "rostrata", "poecilura", "anomalum", "fund…
## $ primarymethod              <chr> "telemetry", "mark-recapture", "mark-recap…
## $ N                          <chr> "16", NA, "20", "26", "17", "5", "2", "2",…
## $ mean.mass.g                <dbl> 887.00, 562.00, 34.00, 4.00, 4.00, 3525.00…
## $ log10.mass                 <dbl> 2.9479236, 2.7497363, 1.5314789, 0.6020600…
## $ alternative.mass.reference <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA…
## $ mean.hra.m2                <dbl> 282750.00, 282.10, 116.11, 125.50, 87.10, …
## $ log10.hra                  <dbl> 5.4514026, 2.4504031, 2.0648696, 2.0986437…
## $ hra.reference              <chr> "Minns, C. K. 1995. Allometry of home rang…
## $ realm                      <chr> "aquatic", "aquatic", "aquatic", "aquatic"…
## $ thermoregulation           <chr> "ectotherm", "ectotherm", "ectotherm", "ec…
## $ locomotion                 <chr> "swimming", "swimming", "swimming", "swimm…
## $ trophic.guild              <chr> "carnivore", "carnivore", "carnivore", "ca…
## $ dimension                  <chr> "3D", "2D", "2D", "2D", "2D", "2D", "2D", …
## $ preymass                   <dbl> NA, NA, NA, NA, NA, NA, 1.39, NA, NA, NA, …
## $ log10.preymass             <dbl> NA, NA, NA, NA, NA, NA, 0.1430148, NA, NA,…
## $ PPMR                       <dbl> NA, NA, NA, NA, NA, NA, 530, NA, NA, NA, N…
## $ prey.size.reference        <chr> NA, NA, NA, NA, NA, NA, "Brose U, et al. 2…
```

### Statistical Summary

```r
summary(homerange)
```

```
##     taxon           common.name           class              order          
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##     family             genus             species          primarymethod     
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##       N              mean.mass.g        log10.mass     
##  Length:569         Min.   :      0   Min.   :-0.6576  
##  Class :character   1st Qu.:     50   1st Qu.: 1.6990  
##  Mode  :character   Median :    330   Median : 2.5185  
##                     Mean   :  34602   Mean   : 2.5947  
##                     3rd Qu.:   2150   3rd Qu.: 3.3324  
##                     Max.   :4000000   Max.   : 6.6021  
##                                                        
##  alternative.mass.reference  mean.hra.m2          log10.hra     
##  Length:569                 Min.   :0.000e+00   Min.   :-1.523  
##  Class :character           1st Qu.:4.500e+03   1st Qu.: 3.653  
##  Mode  :character           Median :3.934e+04   Median : 4.595  
##                             Mean   :2.146e+07   Mean   : 4.709  
##                             3rd Qu.:1.038e+06   3rd Qu.: 6.016  
##                             Max.   :3.551e+09   Max.   : 9.550  
##                                                                 
##  hra.reference         realm           thermoregulation    locomotion       
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##  trophic.guild       dimension            preymass         log10.preymass   
##  Length:569         Length:569         Min.   :     0.67   Min.   :-0.1739  
##  Class :character   Class :character   1st Qu.:    20.02   1st Qu.: 1.3014  
##  Mode  :character   Mode  :character   Median :    53.75   Median : 1.7304  
##                                        Mean   :  3989.88   Mean   : 2.0188  
##                                        3rd Qu.:   363.35   3rd Qu.: 2.5603  
##                                        Max.   :130233.20   Max.   : 5.1147  
##                                        NA's   :502         NA's   :502      
##       PPMR         prey.size.reference
##  Min.   :  0.380   Length:569         
##  1st Qu.:  3.315   Class :character   
##  Median :  7.190   Mode  :character   
##  Mean   : 31.752                      
##  3rd Qu.: 15.966                      
##  Max.   :530.000                      
##  NA's   :502
```

4. Are there NA's in your data? Show the code that you would use to verify this, please.  


```r
anyNA(homerange)
```

```
## [1] TRUE
```
### Yes there are NA's in my data. 

5. Change the class of the variables `taxon` and `order` to factors and display their levels.


```r
homerange$taxon <- as.factor(homerange$taxon)
```


```r
levels(homerange$taxon)
```

```
## [1] "birds"         "lake fishes"   "lizards"       "mammals"      
## [5] "marine fishes" "river fishes"  "snakes"        "tortoises"    
## [9] "turtles"
```


```r
homerange$order <- as.factor(homerange$order)
```


```r
levels(homerange$order)
```

```
##  [1] "accipitriformes"    "afrosoricida"       "anguilliformes"    
##  [4] "anseriformes"       "apterygiformes"     "artiodactyla"      
##  [7] "caprimulgiformes"   "carnivora"          "charadriiformes"   
## [10] "columbidormes"      "columbiformes"      "coraciiformes"     
## [13] "cuculiformes"       "cypriniformes"      "dasyuromorpha"     
## [16] "dasyuromorpia"      "didelphimorphia"    "diprodontia"       
## [19] "diprotodontia"      "erinaceomorpha"     "esociformes"       
## [22] "falconiformes"      "gadiformes"         "galliformes"       
## [25] "gruiformes"         "lagomorpha"         "macroscelidea"     
## [28] "monotrematae"       "passeriformes"      "pelecaniformes"    
## [31] "peramelemorphia"    "perciformes"        "perissodactyla"    
## [34] "piciformes"         "pilosa"             "proboscidea"       
## [37] "psittaciformes"     "rheiformes"         "roden"             
## [40] "rodentia"           "salmoniformes"      "scorpaeniformes"   
## [43] "siluriformes"       "soricomorpha"       "squamata"          
## [46] "strigiformes"       "struthioniformes"   "syngnathiformes"   
## [49] "testudines"         "tetraodontiformes\xa0" "tinamiformes"
```

6. Make a new dataframe `deer` that is limited to the mean mass, log10 mass, family, genus, and species of deer in the database. The family for deer is cervidae. Arrange the data in descending order by log10 mass. Which is the largest deer?  


```r
deer <- homerange %>% 
  select(mean.mass.g, log10.mass, family, genus, species) %>% 
  filter(family == "cervidae") %>% 
  arrange(desc(log10.mass))

deer
```

```
## # A tibble: 12 x 5
##    mean.mass.g log10.mass family   genus      species    
##          <dbl>      <dbl> <chr>    <chr>      <chr>      
##  1     307227.       5.49 cervidae alces      alces      
##  2     234758.       5.37 cervidae cervus     elaphus    
##  3     102059.       5.01 cervidae rangifer   tarandus   
##  4      87884.       4.94 cervidae odocoileus virginianus
##  5      71450.       4.85 cervidae dama       dama       
##  6      62823.       4.80 cervidae axis       axis       
##  7      53864.       4.73 cervidae odocoileus hemionus   
##  8      35000.       4.54 cervidae ozotoceros bezoarticus
##  9      29450.       4.47 cervidae cervus     nippon     
## 10      24050.       4.38 cervidae capreolus  capreolus  
## 11      13500.       4.13 cervidae muntiacus  reevesi    
## 12       7500.       3.88 cervidae pudu       puda
```
### The largest deer is the alces alces.  

7. As measured by the data, which snake species has the smallest homerange? Show all of your work, please. Look this species up online and tell me about it!  


```r
snake <- homerange %>% 
  select(taxon, family, genus, species, mean.hra.m2, log10.hra) %>% 
  filter(taxon == "snakes") %>% 
  arrange(log10.hra)

snake
```

```
## # A tibble: 41 x 6
##    taxon  family     genus       species      mean.hra.m2 log10.hra
##    <fct>  <chr>      <chr>       <chr>              <dbl>     <dbl>
##  1 snakes viperidae  bitis       schneideri          200       2.30
##  2 snakes colubridae carphopis   viridis             253       2.40
##  3 snakes colubridae thamnophis  butleri             600       2.78
##  4 snakes colubridae carphopis   vermis              700       2.85
##  5 snakes viperidae  vipera      latastei           2400       3.38
##  6 snakes viperidae  gloydius    shedaoensis        2614.      3.42
##  7 snakes colubridae diadophis   punctatus          6476       3.81
##  8 snakes viperidae  agkistrodon piscivorous       10655       4.03
##  9 snakes colubridae oocatochus  rufodorsatus      15400       4.19
## 10 snakes colubridae pituophis   catenifer         17400       4.24
## # … with 31 more rows
```

### The snake with the smallest homerange is the bitis schneideri, otherwise known as the namaqua dwarf adder. It's the smallest adder in the world, only being about 20 cm long on average. They seem to experience a higher mortality rate than average due to their small size, and can cause serious pain and swelling with their bite. 

8. You suspect that homerange and mass are correlated in birds. We need a ratio that facilitates exploration of this prediction. First, build a new dataframe called `hra_ratio` that is limited to genus, species, mean.mass.g, log10.mass, log10.hra. Arrange it in ascending order by mean mass in grams. 


```r
hra_ratio <- homerange %>% 
  filter(taxon == "birds") %>% 
  select(genus, species, mean.mass.g, log10.mass, log10.hra) %>% 
  arrange(mean.mass.g)

hra_ratio
```

```
## # A tibble: 140 x 5
##    genus        species      mean.mass.g log10.mass log10.hra
##    <chr>        <chr>              <dbl>      <dbl>     <dbl>
##  1 regulus      regulus             5.15      0.712      4.30
##  2 regulus      ignicapillus        5.3       0.724      4.22
##  3 phylloscopus bonelli             7.5       0.875      4.54
##  4 aegithalos   caudatus            8         0.903      4.62
##  5 vireo        atricapillus        8.5       0.929      4.18
##  6 setophaga    magnolia            8.6       0.934      3.86
##  7 certhia      familiaris          8.77      0.943      4.67
##  8 sylvia       undata              8.8       0.944      3.45
##  9 setophaga    ruticilla           9         0.954      3.29
## 10 setophaga    virens              9         0.954      3.81
## # … with 130 more rows
```


9. Replace the existing `hra_ratio` dataframe with a new dataframe that adds a column calculating the ratio of log 10 hra to log 10 mass. Call it `hra.mass.ratio`. Arrange it in descending order by mean mass in grams.  

```r
hra.mass.ratio <- hra_ratio %>% 
  mutate(ratio = log10.hra/log10.mass) %>% 
  arrange(desc(mean.mass.g))

hra.mass.ratio
```

```
## # A tibble: 140 x 6
##    genus      species      mean.mass.g log10.mass log10.hra ratio
##    <chr>      <chr>              <dbl>      <dbl>     <dbl> <dbl>
##  1 struthio   camelus            88250       4.95      7.93  1.60
##  2 rhea       americana          25000       4.40      6.39  1.45
##  3 rhea       pennata            15000       4.18      7.38  1.77
##  4 aquila     chrysaetos          3000       3.48      7.44  2.14
##  5 tetrao     urogallus           2936       3.47      6.74  1.94
##  6 apteryx    australis           2320       3.37      5.67  1.68
##  7 neophron   percnopterus        2203       3.34      7.80  2.33
##  8 bubo       bubo                2191       3.34      7.20  2.16
##  9 hieraaetus fasciatus           2049       3.31      7.29  2.20
## 10 strigops   habroptilus         1941       3.29      5.29  1.61
## # … with 130 more rows
```

10. What is the lowest mass for birds with a `hra.mass.ratio` greater than or equal to 4.0?

```r
hra.mass.ratio %>% 
  filter(ratio >= 4)
```

```
## # A tibble: 17 x 6
##    genus        species      mean.mass.g log10.mass log10.hra ratio
##    <chr>        <chr>              <dbl>      <dbl>     <dbl> <dbl>
##  1 motacilla    alba               21.2       1.33       5.89  4.44
##  2 contopus     virens             13.8       1.14       4.64  4.07
##  3 spizella     passerina          12.2       1.09       4.49  4.13
##  4 hippolais    polyglotta         11         1.04       4.48  4.30
##  5 parus        palustris          11         1.04       4.36  4.18
##  6 parus        carolinensis       10.1       1.00       4.18  4.16
##  7 vireo        belli              10         1          4.07  4.07
##  8 cisticola    juncidis            9.8       0.991      4.16  4.20
##  9 troglodytes  troglodytes         9.5       0.978      4.01  4.10
## 10 wilsonia     canadensis          9.3       0.968      4.01  4.14
## 11 certhia      familiaris          8.77      0.943      4.67  4.95
## 12 setophaga    magnolia            8.6       0.934      3.86  4.13
## 13 vireo        atricapillus        8.5       0.929      4.18  4.49
## 14 aegithalos   caudatus            8         0.903      4.62  5.12
## 15 phylloscopus bonelli             7.5       0.875      4.54  5.19
## 16 regulus      ignicapillus        5.3       0.724      4.22  5.82
## 17 regulus      regulus             5.15      0.712      4.30  6.04
```
### The lowest mass for a bird with a mass ratio greater than or equal to 4.0 is the regulus regulus, that only weighs 5.15 g on average. 

11. Do a search online; what is the common name of the bird from #8 above? Place a link in your markdown file that takes us to a webpage with information on its biology.  

### The common name of regulus regulus is the [Goldcrest](https://www.iucnredlist.org/species/22734997/132183740)

12. What is the `hra.mass.ratio` for an ostrich? Show your work, please.  

```r
homerange %>% 
  filter(common.name == "ostrich") %>% 
  select(genus, species)
```

```
## # A tibble: 1 x 2
##   genus    species
##   <chr>    <chr>  
## 1 struthio camelus
```
### The ostrich genus and species is struthio camelus


```r
hra.mass.ratio %>% 
  filter(species == "camelus")
```

```
## # A tibble: 1 x 6
##   genus    species mean.mass.g log10.mass log10.hra ratio
##   <chr>    <chr>         <dbl>      <dbl>     <dbl> <dbl>
## 1 struthio camelus       88250       4.95      7.93  1.60
```
### The hra.mass.ratio for an ostrich is 1.602565 m^2/g. 


## Push your final code to GitHub!
Please be sure that you have check the `keep md` file in the knit preferences.  
