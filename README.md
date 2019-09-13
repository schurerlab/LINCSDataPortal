# LINCSDataPortal

Please cite the LINCS Data Portal as follows:
Koleti, Amar, et al. "Data Portal for the Library of Integrated Network-based Cellular Signatures (LINCS) program: integrated access to diverse large-scale cellular perturbation response data." Nucleic acids research 46.D1 (2017): D558-D566.
https://academic.oup.com/nar/article/46/D1/D558/4621325

R package to query LINCS Data Portal

LINCS Data Portal (http://lincsportal.ccs.miami.edu) is the prime repository for all LINCS project data (www.lincsproject.org).

LINCSdataportal R package provides easy access to all LINCS data and metadata. 

LINCS data can be retrieved using a variety of search terms for entities of interest (e.g. small molecule, protein, gene, cell line) and downloaded in any of the available data level.
Moreover, all metadata associated with any entity used in LINCS experiments can be retrieved.

To install the package from R simply use the install_github function from package devtools:

install_github("schurerlab/LINCSDataPortal")
