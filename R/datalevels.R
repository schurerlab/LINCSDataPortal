#' Retrieve all available data level and associated dataset id for a given dataset id.
#'
#' @param lds_id String representng a dataset id (LDS-xxxx)
#' @return data frame with available data level and associated dataset id
#' @export
#' @examples
#' datalevels("LDS-1233")
#'

datalevels <- function(lds_id)
{
  url <- httr::modify_url("http://lincsportal.ccs.miami.edu", path = paste("/dcic/api/fetchdata?searchTerm=datasetlevels:",lds_id,"&fields=datasetlevels,datalevels",sep = ""))
  resp <- httr::GET(url)
  if(httr::status_code(resp)>400 & httr::status_code(resp)<500) {
    stop("API returned an error", call. = FALSE)
  }

  parsed =  jsonlite::fromJSON(httr::content(resp, "text"))$results$documents
  output = data.frame(cbind("level"=parsed$datalevels[[1]],"LDS"=parsed$datasetlevels[[1]]))
  return(output)

}
