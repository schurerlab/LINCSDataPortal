#' Retrieve metadata associated with a protein measured or used in LINCS experiments.
#'
#' @param pr String representing a protein of interest
#' @return data frame with available protein metadata
#' @export
#' @examples
#' protein_metadata("ACK")
#'

protein_metadata=function(pr)
{
  xnew <- toupper(pr)
  url <- httr::modify_url("http://lincsportal.ccs.miami.edu", path = paste("/dcic/api/fetchentities?searchTerm=entityName:",xnew,"&fields=lincsidentifier,entityName,category,PR_Gene_Symbol,PR_Protein_Species,PR_UniProt_ID",sep = ""))
  resp <- httr::GET(url)
  if(httr::status_code(resp)>400 & httr::status_code(resp)<500) {
    stop("API returned an error", call. = FALSE)
  }

  parsed =  jsonlite::fromJSON(httr::content(resp, "text"))

  return(parsed$results$documents[grep("Protein",parsed$results$documents$category),])
}
