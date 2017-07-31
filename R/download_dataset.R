#' Download LINCS dataset packages, given dataset id's, from Lincs Data Portal.
#'
#' @param lds_id Vector of dataset ids (LDS-xxxx)
#' @param path Path to local folder where the dataset package will be downloaded, default = current directory
#' @return NULL
#' @export
#' @examples
#' \dontrun{
#' download_dataset("LDS-1266")
#' download_dataset("LDS-1173", path = "/datasets")
#' }
#'

download_dataset<- function(lds_id, path = "./")
{

  for (i in 1:length(lds_id))
  {
    url <- httr::modify_url("http://lincsportal.ccs.miami.edu", path = paste("/dcic/api/fetchdata?searchTerm=datasetid:",lds_id[i],"&fields=path",sep = ""))
    resp <- httr::GET(url)
    if(httr::status_code(resp)>400 & httr::status_code(resp)<500) {
      stop("API returned an error", call. = FALSE)
    }
    parsed <- strsplit(jsonlite::fromJSON(httr::content(resp, "text"))$results$documents$path,split = "bd2klincs/")[[1]][2]

    filepath = paste("/dcic/api/download?path=",parsed,"&file=",lds_id[i],".tar.gz",sep = "")
    url <- httr::modify_url("http://lincsportal.ccs.miami.edu", path = filepath)

    utils::download.file(url,paste(path,lds_id[i],".tar.gz",sep = ""),mode = "wb")
  }

}
