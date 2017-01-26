#' Retrieve datasets from LINCS data portal associated with a term of interest (gene, protein, small molecule)
#'
#' @param searchterm String representing the search term
#' @return data.frame containing dataset id and description
#' @export
#' @examples
#' find_dataset("afatinib")
#' find_dataset("mcf7")
#'

find_dataset <- function(searchterm) {
  path = paste("/dcic/api/fetchdata?searchTerm=",searchterm,"&limit=1000&fields=datasetid,datasetname",sep = "")
  url <- httr::modify_url("http://lincsportal.ccs.miami.edu", path = path)

  resp <- httr::GET(url)

  if(httr::status_code(resp)>400 & httr::status_code(resp)<500) {
    stop("API returned an error", call. = FALSE)
  }
  parsed <- jsonlite::fromJSON(httr::content(resp, "text"))

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


  return(parsed$results$documents)
}
