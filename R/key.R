#' @importFrom keyring key_set
key_add <- function(){
  keyring::key_set(service = "rtmolitr")
}

#' @importFrom keyring key_get
key_get <- function(){
  keyring::key_get(service = "rtmolitr")
}

key_check <- function(){
  key <- try(key_get(), silent = T)

}
