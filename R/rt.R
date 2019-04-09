#' get rt data
#'
#' @param region_code code
#' @param dateym year month
#' @param service_key api key
#' @export
#' @return a [tibble][tibble::tibble-package]
#' @importFrom httr GET content
#' @importFrom purrr transpose map
#' @importFrom dplyr as_tibble
rt_get <- function(region_code, dateym, service_key = NULL) {

  if (is.null(service_key)) {
    service_key <- key_get()
  }

  tar <-
    paste0(
      "http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev?serviceKey=",
      service_key,
      "&pageNo=1&startPage=1&numOfRows=1000&pageSize=1000&LAWD_CD=",
      region_code,
      "&DEAL_YMD=",
      dateym
    )
  . <- NULL

  httr::GET(tar) %>%
    httr::content() %>%
    .$response -> res

  if (res$header$resultCode != "00") {
    stop(res$header$resultMsg)
  }

  if (res$body$totalCount == 0) {
    return(tibble())
  }

  res %>%
    .$body %>%
    .$items %>%
    .$item %>%
    purrr::transpose() %>%
    purrr::map( ~ as.character(.x)) %>%
    dplyr::as_tibble() %>%
    return()
}
