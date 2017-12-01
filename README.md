
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis build status](https://travis-ci.org/USCCANA/socnet.svg?branch=master)](https://travis-ci.org/USCCANA/socnet) [![Coverage status](https://codecov.io/gh/USCCANA/socnet/branch/master/graph/badge.svg)](https://codecov.io/github/USCCANA/socnet?branch=master)

socnet
======

This R package is created to access the data available in the SOCNET website <https://lists.ufl.edu/cgi-bin/wa?A0=SOCNET>, which is hosted by The University of Florida in its Listserv website.

Installation
------------

This package is currently under develoment and is only available by downloading the bleeding edge version. You can use `devtools` to get it:

``` r
devtools::install_github("USCCANA/socnet")
```

Example
-------

Before starts, let's first load the package.

``` r
library(socnet)
```

Suppose that you want to look at the SOCNET archives, but you don't know from where to start. You can use the function `socnet_list_archives` to get a list of the archives that are available in the Listserv.

``` r
# Getting the URLs to the archives per month
archives <- socnet_list_archives(cached = TRUE)
#> Using cached version of SOCNET Listserv
#> The cached version of SOCNET_ARCHIVES_WWW (https://lists.ufl.edu/cgi-bin/wa?A0=SOCNET) was last updated on 2017-11-27 12:52:13.
head(archives)
#>                                                    url          date
#> 1 https://lists.ufl.edu/cgi-bin/wa?A1=ind1711&L=SOCNET  November '17
#> 2 https://lists.ufl.edu/cgi-bin/wa?A1=ind1710&L=SOCNET   October '17
#> 3 https://lists.ufl.edu/cgi-bin/wa?A1=ind1709&L=SOCNET September '17
#> 4 https://lists.ufl.edu/cgi-bin/wa?A1=ind1708&L=SOCNET    August '17
#> 5 https://lists.ufl.edu/cgi-bin/wa?A1=ind1707&L=SOCNET      July '17
#> 6 https://lists.ufl.edu/cgi-bin/wa?A1=ind1706&L=SOCNET      June '17
```

Now that we have the list of archives, we can access one of them and list what are the subjects (emails) that show under that archive with the `socnet_list_subjects` function.

``` r
# What was discussed during Oct 17?: Getting the subjects during that time
subjects <- socnet_list_subjects(archives$url[1], cached = TRUE)
#> Using cached version of SOCNET Listserv
#> The cached version of SOCNET_ARCHIVES_WWW (https://lists.ufl.edu/cgi-bin/wa?A0=SOCNET) was last updated on 2017-11-27 12:52:13.
```

Let's take a look at the output

``` r
str(subjects)
#> 'data.frame':    57 obs. of  5 variables:
#>  $ url    : chr  "https://lists.ufl.edu/cgi-bin/wa?A2=ind1711&L=SOCNET&T=0&F=&S=&P=57649" "https://lists.ufl.edu/cgi-bin/wa?A2=ind1711&L=SOCNET&T=0&F=&S=&P=51102" "https://lists.ufl.edu/cgi-bin/wa?A2=ind1711&L=SOCNET&T=0&F=&S=&P=47265" "https://lists.ufl.edu/cgi-bin/wa?A2=ind1711&L=SOCNET&T=0&F=&S=&P=30390" ...
#>  $ subject: chr  "'Frontiers for Network Analysis in Health Services Research and Implementation Science' Seminars: Amanda Beacom"| __truncated__ "2018 Sunbelt Session on Networked Innovation" "2018 Sunbelt Session on Urban Networks" "2nd CFP: Social Web for Disaster Management (SWDM'18)" ...
#>  $ from   : chr  "Reza Yousefi <[log in to unmask]>" "Brennecke, Julia <[log in to unmask]>" "Neal, Zachary <[log in to unmask]>" "yu-ru lin <[log in to unmask]>" ...
#>  $ date   : chr  "Mon, 27 Nov 2017 11:29:43 -0500" "Thu, 23 Nov 2017 07:17:01 +0000" "Mon, 20 Nov 2017 14:02:04 +0000" "Mon, 13 Nov 2017 19:57:46 -0500" ...
#>  $ size   : chr  "223 lines" "306 lines" "296 lines" "298 lines" ...
head(subjects[,-1])
#>                                                                                                                                 subject
#> 2       'Frontiers for Network Analysis in Health Services Research and Implementation Science' Seminars: Amanda Beacom (Dec 6, 4:00PM)
#> 3                                                                                          2018 Sunbelt Session on Networked Innovation
#> 4                                                                                                2018 Sunbelt Session on Urban Networks
#> 5                                                                                 2nd CFP: Social Web for Disaster Management (SWDM'18)
#> 6 A couple of articles of potential interest: Climate change communication in Canada; Networks, social capital, and ecotourism in Ghana
#> 7                                                               Call for Papers: Special Issue on “Network Analysis of Political Power”
#>                                        from
#> 2         Reza Yousefi <[log in to unmask]>
#> 3     Brennecke, Julia <[log in to unmask]>
#> 4        Neal, Zachary <[log in to unmask]>
#> 5            yu-ru lin <[log in to unmask]>
#> 6        David Tindall <[log in to unmask]>
#> 7 Alina V. Vladimirova <[log in to unmask]>
#>                              date      size
#> 2 Mon, 27 Nov 2017 11:29:43 -0500 223 lines
#> 3 Thu, 23 Nov 2017 07:17:01 +0000 306 lines
#> 4 Mon, 20 Nov 2017 14:02:04 +0000 296 lines
#> 5 Mon, 13 Nov 2017 19:57:46 -0500 298 lines
#> 6  Tue, 7 Nov 2017 08:02:25 -0800 212 lines
#> 7  Wed, 1 Nov 2017 18:32:03 +0300 219 lines
```

Now, we can use the function `socnet_parse_subject` to actually get the data of a particular subject. Let's try with the subject titled `'Frontiers for Network Analysis in Health Services Research and Implementation Science' Seminars: Amanda Beacom (Dec 6, 4:00PM)`

``` r
socnet_parse_subject(subjects$url[1])
#> $meta
#>                                                                                                                           Subject 
#> "'Frontiers for Network Analysis in Health Services Research and Implementation Science' Seminars: Amanda Beacom (Dec 6, 4:00PM)" 
#>                                                                                                                              From 
#>                                                                                               "Reza Yousefi <[log in to unmask]>" 
#>                                                                                                                          Reply-To 
#>                                                                                               "Reza Yousefi <[log in to unmask]>" 
#>                                                                                                                              Date 
#>                                                                                                 "Mon, 27 Nov 2017 11:29:43 -0500" 
#>                                                                                                                      Content-Type 
#>                                                                                                           "multipart/alternative" 
#>                                                                                                                 Parts/Attachments 
#>                                                                                                              "Parts/Attachments:" 
#> 
#> $contents
#>  [1] "Content-Type: text/html"                                                                                                                                                                                                                                                                                                    
#>  [2] ""                                                                                                                                                                                                                                                                                                                           
#>  [3] "*****  To join INSNA, visit http://www.insna.org  *****"                                                                                                                                                                                                                                                                    
#>  [4] ""                                                                                                                                                                                                                                                                                                                           
#>  [5] "The second seminar in the 'Frontiers for Network Analysis in Health"                                                                                                                                                                                                                                                        
#>  [6] "Services Research and Implementation Science' Series will be delivered by *Dr"                                                                                                                                                                                                                                              
#>  [7] "Amanda Beacom* on *December 6th at 4:00-5:30 *PM Eastern Time."                                                                                                                                                                                                                                                             
#>  [8] ""                                                                                                                                                                                                                                                                                                                           
#>  [9] "The talk is entitled"                                                                                                                                                                                                                                                                                                       
#> [10] ""                                                                                                                                                                                                                                                                                                                           
#> [11] "*\"Multilevel Perspectives on the Diffusion of Health Care Best"                                                                                                                                                                                                                                                            
#> [12] "Practices\".*Amanda"                                                                                                                                                                                                                                                                                                        
#> [13] "is a Visiting Scholar at the Carroll School of Management, Boston College."                                                                                                                                                                                                                                                 
#> [14] "Her research aims to increase our understanding of how knowledge is"                                                                                                                                                                                                                                                        
#> [15] "communicated in organizational networks, particularly in health contexts."                                                                                                                                                                                                                                                  
#> [16] "She holds a PhD in communication from the University of Southern California"                                                                                                                                                                                                                                                
#> [17] "and a master's degree in health policy from Johns Hopkins University. She"                                                                                                                                                                                                                                                  
#> [18] "recently completed a postdoctoral fellowship at the University of Alberta"                                                                                                                                                                                                                                                  
#> [19] "Faculty of Nursing."                                                                                                                                                                                                                                                                                                        
#> [20] ""                                                                                                                                                                                                                                                                                                                           
#> [21] "*Abstract:*"                                                                                                                                                                                                                                                                                                                
#> [22] "*While scholars have developed a rich understanding of diffusion in"                                                                                                                                                                                                                                                        
#> [23] "interpersonal knowledge networks--and, to a lesser extent, in"                                                                                                                                                                                                                                                              
#> [24] "inter-organizational networks--we know much less about how knowledge and"                                                                                                                                                                                                                                                   
#> [25] "best practices diffuse simultaneously across people, organizations, and"                                                                                                                                                                                                                                                    
#> [26] "other types of actors within a population, sector, or industry. For"                                                                                                                                                                                                                                                        
#> [27] "example, in planning a dissemination strategy, how might"                                                                                                                                                                                                                                                                   
#> [28] "inter-organizational network data enhance what we know about an"                                                                                                                                                                                                                                                            
#> [29] "interpersonal network? Do opinion leading individuals tend to work in"                                                                                                                                                                                                                                                      
#> [30] "opinion leading organizations? What new insights can we gain from"                                                                                                                                                                                                                                                          
#> [31] "considering information technologies, as well as the people, as another"                                                                                                                                                                                                                                                    
#> [32] "type, or level, of actor in diffusion networks? In this talk, I review some"                                                                                                                                                                                                                                                
#> [33] "obstacles to and advances in multilevel network analysis, and present two"                                                                                                                                                                                                                                                  
#> [34] "of my own research projects that examine the diffusion of health care best"                                                                                                                                                                                                                                                 
#> [35] "practices in multilevel networks.*"                                                                                                                                                                                                                                                                                         
#> [36] ""                                                                                                                                                                                                                                                                                                                           
#> [37] "You can find the details of the event, and instructions to in-person"                                                                                                                                                                                                                                                       
#> [38] "attendance online connection through Adobe Connect in this link:"                                                                                                                                                                                                                                                           
#> [39] "https://urldefense.proofpoint.com/v2/url?u=http-3A__ihpme.utoronto.ca_events_health-2Dservices-2D&d=DwIFaQ&c=pZJPUDQ3SB9JplYbifm4nt2lEVG5pWx2KikqINpWlZM&r=uXI5O6HThk1ULkPyaT6h2Ws3RKNKSY__GQ4DuS9UHhs&m=Unoq4LLj2ROYjrpMQjQb-IHLQZ_Xra1Pme03M2h2-Tk&s=MTpPoieQBinQgsJQNssjMuBCzTe2Hvljt2rRMvXZeD4&e= "                     
#> [40] "systems-policy-seminar-series-amanda-m-beacom/"                                                                                                                                                                                                                                                                             
#> [41] "<https://urldefense.proofpoint.com/v2/url?u=http-3A__ihpme.utoronto.ca_events_hssp-2Dseminar-2D11082017_&d=DwIFaQ&c=pZJPUDQ3SB9JplYbifm4nt2lEVG5pWx2KikqINpWlZM&r=uXI5O6HThk1ULkPyaT6h2Ws3RKNKSY__GQ4DuS9UHhs&m=Unoq4LLj2ROYjrpMQjQb-IHLQZ_Xra1Pme03M2h2-Tk&s=uwk1mZqpjaOtaDC5UXy7MDJ4RqTzz8LzIbAXgX2_VwU&e= >"             
#> [42] ""                                                                                                                                                                                                                                                                                                                           
#> [43] "In person or webinar presentations and Q/As will be broadcast online, and"                                                                                                                                                                                                                                                  
#> [44] "will be archived on the IHPME website. You can watch the recorded videos of"                                                                                                                                                                                                                                                
#> [45] "previous seminars at: https://urldefense.proofpoint.com/v2/url?u=http-3A__ihpme.utoronto.ca_hssp-2Dseminar-2Darchives_&d=DwIFaQ&c=pZJPUDQ3SB9JplYbifm4nt2lEVG5pWx2KikqINpWlZM&r=uXI5O6HThk1ULkPyaT6h2Ws3RKNKSY__GQ4DuS9UHhs&m=Unoq4LLj2ROYjrpMQjQb-IHLQZ_Xra1Pme03M2h2-Tk&s=eZE5ujKMAGBUUmy8rVbMZm9NEbEe9bJpZVragu7vJ4k&e= "
#> [46] ""                                                                                                                                                                                                                                                                                                                           
#> [47] "If you’d like to receive notifications about future talks in the series"                                                                                                                                                                                                                                                    
#> [48] "please send an email to <a href=\"/cgi-bin/wa?LOGON=A3%3Dind1711%26L%3DSOCNET%26E%3DQuoted-printable%26P%3D3475850%26B%3D--94eb2c0b90782cc6f1055ef96a93%26T%3Dtext%252Fplain%3B%2520charset%3DUTF-8\" >[log in to unmask]</a>"                                                                                              
#> [49] ""                                                                                                                                                                                                                                                                                                                           
#> [50] "Please consider forwarding this information to any colleagues who might be"                                                                                                                                                                                                                                                 
#> [51] "interested."                                                                                                                                                                                                                                                                                                                
#> [52] ""                                                                                                                                                                                                                                                                                                                           
#> [53] "With Regards"                                                                                                                                                                                                                                                                                                               
#> [54] ""                                                                                                                                                                                                                                                                                                                           
#> [55] "Reza Yousefi Nooraie, MD, PhD"                                                                                                                                                                                                                                                                                              
#> [56] ""                                                                                                                                                                                                                                                                                                                           
#> [57] ""                                                                                                                                                                                                                                                                                                                           
#> [58] "*Post-doctoral fellowInstitute of Health Policy, Management, and Evaluation"                                                                                                                                                                                                                                                
#> [59] "(IHPME)University of Toronto*"                                                                                                                                                                                                                                                                                              
#> [60] ""                                                                                                                                                                                                                                                                                                                           
#> [61] "_____________________________________________________________________"                                                                                                                                                                                                                                                      
#> [62] "SOCNET is a service of INSNA, the professional association for social"                                                                                                                                                                                                                                                      
#> [63] "network researchers (http://www.insna.org). To unsubscribe, send"                                                                                                                                                                                                                                                           
#> [64] "an email message to <a href=\"/cgi-bin/wa?LOGON=A3%3Dind1711%26L%3DSOCNET%26E%3DQuoted-printable%26P%3D3475850%26B%3D--94eb2c0b90782cc6f1055ef96a93%26T%3Dtext%252Fplain%3B%2520charset%3DUTF-8\" >[log in to unmask]</a> containing the line"                                                                              
#> [65] "UNSUBSCRIBE SOCNET in the body of the message."                                                                                                                                                                                                                                                                             
#> [66] ""
```

As you can see, the function returned a list with two elements, a vector of meta information, and the actual email.

Most active user (compose side)
===============================

``` r
rankfun <- function(x, colnames, maxn = 100) {
  x <- as.data.frame(table(x))
  x <- x[order(-x$Freq),]
  dimnames(x) <- list(1:nrow(x), colnames)
  knitr::kable(x[1:maxn,], row.names = TRUE)  
}

# Getting the from column and removing weird characters
data("subjects")
from <- subjects$from
from <- iconv(from, to="ASCII//TRANSLIT")

# Removing <[log in to unmask]> message
from <- tolower(gsub("[<].+", "", from))

# Fixing some names...
regexp <- "Th?om(as)?( W)?\\.? Valente"
from[grepl(regexp, from, ignore.case = TRUE)] <- "Thomas W. Valente"

regexp <- "Valdis( Krebs)?"
from[grepl(regexp, from, ignore.case = TRUE)] <- "Valdis Krebs"

regexp <- "Steve Borgatti|Borgatti, Steve"
from[grepl(regexp, from, ignore.case = TRUE)] <- "Steve Borgatti"

regexp <- "Snijders, T\\.A\\.B\\.|Tom A\\.B\\. Snijders|T\\.A\\.B\\.Snijders"
from[grepl(regexp, from, ignore.case = TRUE)] <- "Tom Snijders"

regexp <- "Kathleen( M\\.)? Carley"
from[grepl(regexp, from, ignore.case = TRUE)] <- "Kathleen M. Carley"

# Capitalizing the first letter
# I learned (copied) this from stackoverflow!
# https://stackoverflow.com/questions/6364783/capitalize-the-first-letter-of-both-words-in-a-two-word-string
# from <- gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", from, perl=TRUE)
from <- stringr::str_to_title(from)


# Creating the table
rankfun(from, colnames=c("User", "Count"))
```

|     | User                         |  Count|
|-----|:-----------------------------|------:|
| 1   | Barry Wellman                |   1100|
| 2   | Valdis Krebs                 |    573|
| 3   | Loet Leydesdorff             |    313|
| 4   | Moses Boudourides            |    204|
| 5   | David Lazer                  |    160|
| 6   | Steve Borgatti               |    152|
| 7   | Thomas W. Valente            |    149|
| 8   | Bill Richards                |    147|
| 9   | Vladimir Batagelj            |    126|
| 10  | Stanley Wasserman            |    121|
| 11  | Alvin Chin                   |    120|
| 12  | John T. Maloney (Jheuristic) |    107|
| 13  | John Mccreery                |    105|
| 14  | Ian Mcculloh                 |    104|
| 15  | Bruce Cronin                 |    101|
| 16  | Joshua O'madadhain           |     98|
| 17  | Jordi Comas                  |     97|
| 18  | Martina Morris               |     95|
| 19  | \[Log In To Unmask\]         |     94|
| 20  | Tansel Ozyer                 |     92|
| 21  | Brian Keegan                 |     82|
| 22  | Christoph Trattner           |     80|
| 23  | Don Steiny                   |     77|
| 24  | Rick Davies                  |     77|
| 25  | Kathleen M. Carley           |     74|
| 26  | Mckiernan, Gerard \[Lib\]    |     72|
| 27  | Sam Friedman                 |     72|
| 28  | Martin Everett               |     71|
| 29  | Mason Alexander Porter       |     71|
| 30  | Ilan Talmud                  |     69|
| 31  | Tom Snijders                 |     69|
| 32  | Denis Parra                  |     68|
| 33  | Elisa Bellotti               |     68|
| 34  | Katy Borner                  |     67|
| 35  | Bernie Hogan                 |     63|
| 36  | Carl Nordlund                |     60|
| 37  | Charles Kadushin             |     59|
| 38  | Garry Robins                 |     59|
| 39  | Ryan Lanham                  |     58|
| 40  | Steven Corman                |     58|
| 41  | Bill.richards                |     57|
| 42  | \[Log In To Unmask\]         |     56|
| 43  | Ulrik Brandes                |     56|
| 44  | H. Russell Bernard           |     55|
| 45  | Caroline Haythornthwaite     |     54|
| 46  | Hocine Cherifi               |     52|
| 47  | Johnson, Jeffrey C           |     52|
| 48  | David Carpe                  |     51|
| 49  | Juergen Pfeffer              |     49|
| 50  | David Tindall                |     48|
| 51  | Kamal Badar                  |     48|
| 52  | Tom Snijders                 |     48|
| 53  | Announce Announcements       |     46|
| 54  | Balazs Vedres                |     45|
| 55  | Jana Diesner                 |     45|
| 56  | John Maloney                 |     45|
| 57  | John T. Maloney              |     45|
| 58  | Sinan Aral                   |     45|
| 59  | Gerry Mckiernan              |     41|
| 60  | Guy Hagen                    |     40|
| 61  | Mark Newman                  |     40|
| 62  | Carter T. Butts              |     39|
| 63  | Richard Rothenberg           |     39|
| 64  | Robert Ackland               |     39|
| 65  | George Barnett               |     38|
| 66  | James Moody                  |     38|
| 67  | Jeffrey Broadbent            |     38|
| 68  | Christophe Prieur            |     37|
| 69  | Wolfe, Alvin                 |     37|
| 70  | Feng Xia                     |     36|
| 71  | Mark Tranmer                 |     36|
| 72  | Mrvar, Andrej                |     35|
| 73  | Paul B. Hartzog              |     35|
| 74  | Ronaldo Menezes              |     35|
| 75  |                              |     34|
| 76  | Nick Guenther                |     34|
| 77  | Semenov Alexander            |     34|
| 78  | Christian Steglich           |     33|
| 79  | Dc Christopoulos             |     33|
| 80  | Patrick Doreian              |     33|
| 81  | Ronald E. Rice               |     33|
| 82  | Simone Gabbriellini          |     33|
| 83  | Skvoretz, John               |     33|
| 84  | Anatoliy Gruzd               |     32|
| 85  | Edward Vielmetti             |     32|
| 86  | Elijah Wright                |     32|
| 87  | Grace Allas                  |     31|
| 88  | Ainhoa De Federico           |     30|
| 89  | Eelke Heemskerk              |     30|
| 90  | Cynthia Typaldos             |     29|
| 91  | Jose Luis Molina             |     29|
| 92  | Michal Bojanowski            |     29|
| 93  | Miranda Jessica Lubbers      |     29|
| 94  | Reifman, Alan                |     29|
| 95  | Bruno Goncalves              |     28|
| 96  | David Krackhardt             |     28|
| 97  | Dmitry Zinoviev              |     28|
| 98  | Andrew V. Shipilov           |     27|
| 99  | Doug Bryan                   |     27|
| 100 | Jackie Blanco                |     27|

Latest version of the cache data
================================

\[1\] "The cached version of SOCNET\_ARCHIVES\_WWW (<https://lists.ufl.edu/cgi-bin/wa?A0=SOCNET>) was last updated on 2017-12-01 14:54:37."
