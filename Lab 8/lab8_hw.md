---
title: "Lab 8 Homework"
author: "Joshua Paaske"
date: "2020-03-02"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run.  

## Libraries


```r
library(ape)
library(seqinr)
```

```
## 
## Attaching package: 'seqinr'
```

```
## The following objects are masked from 'package:ape':
## 
##     as.alignment, consensus
```

```r
library(rentrez)
```

**1. All the databases associated with NCBI are updating and sharing their data daily. With the new strain of the coronavirus, SARS-CoV-2 at the forefront of a lot of medical research, genomes have already been uploaded to GenBank. The accession number fora complete genome of an isolate from China is "MT093631.1". Pull this sequence from GenBank into R, then write it as a .fasta file and read the .fasta file into R using the code we learned in class.**


```r
coronaseq <- read.GenBank("MT093631.1", as.character = TRUE)
#coronaseq

write.fasta(names="SARS-CoV-2", sequences=coronaseq, file.out="data/corona1.fasta")

corona <- read.fasta(file = "data/corona1.fasta")

coronaseq  <- corona[[1]]
```

**2. Explore this sequence using functions we learned in class. What is the length of the genome? Create a table showing the nucleotide composition of the sequence, and calculate the GC content.**

```r
length(coronaseq)
```

```
## [1] 29911
```

```r
table(coronaseq)
```

```
## coronaseq
##    a    c    g    t 
## 8936 5500 5869 9606
```

```r
GC(coronaseq)
```

```
## [1] 0.3800943
```

**3.Several genomes for the new strain of coronavirus have already been uploaded to GenBank. Using search terms, look for uploaded genomes SARS-CoV-2. (Hint: You're looking for things listed as genomes, which you won't find looking for a [GENE] keyword 'entrez_db_searchable("nuccore")' will provide you with a list of search term options.) Limit your returned hits to 10. Download your ten genomes and write them out as a .fasta file.**


```r
corona_search <- entrez_search(db="nuccore", term= "SARS-CoV-2[GENOME]", retmax=10)
corona_search
```

```
## Entrez search result with 99 hits (object contains 10 IDs and no web_history object)
##  Search term (as translated):  "Severe acute respiratory syndrome coronavirus 2"[ ...
```

```r
corona_seqs <- entrez_fetch(db="nuccore", id=corona_search$ids, rettype="fasta")

write(corona_seqs, "data/corona_fasta.fasta", sep = "\n")
```

