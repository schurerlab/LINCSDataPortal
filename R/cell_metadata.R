#' Retrieve metadata associated with a cell (cl) used in LINCS experiments.
#'
#' @param cl String representng a cell of interest
#' @return data frame with available cell metadata
#' @export
#' @examples
#' cell_metadata("mcf7")
#'

cell_metadata=function(cl)
{ xnew=toupper(cl)
  url <- httr::modify_url("http://lincsportal.ccs.miami.edu", path = paste("/dcic/api/fetchentities?searchTerm=entityName:",xnew,"&fields=lincsidentifier,entityName,CL_LINCS_ID,CL_Alternative_Name,CL_Alternative_ID,CL_Organism,CL_Organ,CL_Disease,CL_Disease_Detail,IP_LINCS_ID,IP_Reprogramming_Method,IP_Passage_Last_Karyotyping,PC_LINCS_ID,PC_Donor_Age,PC_Provider_Name,DC_LINCS_ID",sep = ""))
  resp <- httr::GET(url)
   if(httr::status_code(resp)>400 & httr::status_code(resp)<500) {
     stop("API returned an error", call. = FALSE)
   }

  parsed =  jsonlite::fromJSON(httr::content(resp, "text"))


return(parsed$results$documents)
}
