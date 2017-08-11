#' Retrieve metadata associated with a gene measured in LINCS experiments.
#'
#' @param ge String representing a gene symbol of interest
#' @return data frame with available gene metadata
#' @export
#' @examples
#' gene_metadata("BRCA1")
#' gene_metadata("CDK1")
#'

gene_metadata=function(ge)
{
  xnew <- toupper(ge)
  url <- httr::modify_url("http://lincsportal.ccs.miami.edu", path = paste("/dcic/api/fetchentities?searchTerm=entityName:",xnew,"&fields=lincsidentifier,entityName,category,GENE_Symbol,GENE_Synonyms,GENE_EntresID,GENE_Organism,GENE_Description",sep = ""))
  resp <- httr::GET(url)
  if(httr::status_code(resp)>400 & httr::status_code(resp)<500) {
    stop("API returned an error", call. = FALSE)
  }

  parsed =  jsonlite::fromJSON(httr::content(resp, "text"))
  result=NULL
  if(parsed$results$totalDocuments!=0)
  {
    result = parsed$results$documents[grep("Gene",parsed$results$documents$category),]
    if(dim(result)[1]==0)
    { result=NULL }
  }
  if(is.null(result))
  { stop(paste("No gene metadata found in LINCS with '",ge, "' symbol",sep=""), call. = FALSE)
  }

  return(result)
}
