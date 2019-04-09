#' add api key from data.go.kr
#'
#' @importFrom keyring key_set
#' @export
key_add <- function(){
  keyring::key_set(service = "rtmolitr")
}
#' use api key
#'
#' @importFrom keyring key_get
#' @export
key_get <- function(){
  keyring::key_get(service = "rtmolitr")
}

#' check api key registered
#'
#' @importFrom keyring key_get
#' @export
key_check <- function(){
  key <- try(keyring::key_get(service = "rtmolitr"), silent = T)
  ret <- class(key) != "try-error"
  if (!ret) {
    message("Need to set api key. Please use rtmolitr::key_add() function.")
  }
  return(ret)
}
