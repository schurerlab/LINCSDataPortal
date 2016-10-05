# LINCSdataportal
R package to query LINCS Data Portal

LINCS Data Portal (www.lincsdataportal.ccs.miami.edu) is the primer repository for all LINCS project data (www.lincsroject.org).

LINCSdataportal R package provides easy access to all LINCS data and metadata. 

LINCS data can be retrieved using a variety of search terms for entities of interest (e.g. small molecule, protein, gene, cell line) and downloaded in any of the available data level.
Moreover, all metadata associated with any entity used in LINCS experiments can be retrieved.

To install the package from R simply:

###   install package devtools
install.packages("devtools")

###   load devtools package
library(devtools)

###   install LINCSdataportal package from Github
install_github("mforlin/LINCSdataportal")
