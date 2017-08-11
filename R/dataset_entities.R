#' Retrieve entities (gene, protein, small molecule, etc.) associated with a specific LINCS dataset
#'
#' @param lds_id String representing the dataset id (LDS-xxxx)
#' @return list of vectors with entities, measured or used to perturb the experiment associated to a given dataset. One vector per entity type.
#' @export
#' @examples
#' dataset_entities("LDS-1266")
#' dataset_entities("LDS-1173")
#'

dataset_entities <- function(lds_id)
{
  url <- httr::modify_url("http://lincsportal.ccs.miami.edu", path = paste("/dcic/api/fetchdata?searchTerm=datasetid:",lds_id,sep = ""))
  resp <- httr::GET(url)
  if(httr::status_code(resp)>400 & httr::status_code(resp)<500) {
    stop("API returned an error", call. = FALSE)
  }

  parsed <-  jsonlite::fromJSON(httr::content(resp, "text"))

  if (httr::http_error(resp)) {
    stop(
      sprintf(
        "LDP API request failed [%s]\n%s\n<%s>",
        httr::status_code(resp),
        parsed$message,
        parsed$documentation_url
      ),
      call. = FALSE
    )
  }
  if(parsed$results$totalDocuments==0)
  {
    stop(paste("No entities found for dataset with '",lds_id, "' LINCS ID",sep=""), call. = FALSE)
  } else {

  whichEntities=matrix(unlist(strsplit(parsed$results$documents$counts[[1]],split = ":")),ncol = 2,byrow = TRUE)[,1]
  L=vector("list", length(whichEntities))
  for (i in 1:length(whichEntities))
  {  names(L)[i]=whichEntities[i]
  L[i]=parsed$results$documents[,names(parsed$results$documents)==whichEntities[i]]
  }
  }
  return(L)
}
