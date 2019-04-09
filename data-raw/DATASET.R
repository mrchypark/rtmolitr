## code to prepare `code` dataset goes here
#' data from https://www.code.go.kr/index.do

tar <- "https://www.code.go.kr/etc/codeFullDown.do?cPage=1&regionCd_pk=&chkWantCnt=0&reqSggCd=&reqUmdCd=&reqRiCd=&searchOk=&codeseId=%EB%B2%95%EC%A0%95%EB%8F%99%EC%BD%94%EB%93%9C&pageSize=10&regionCd=&locataddNm=&sidoCd=*&sggCd=*&umdCd=*&riCd=*&disuseAt=0&stdate=&enddate="

httr::POST(tar, httr::write_disk("code.zip", overwrite = TRUE))
unzip("code.zip",overwrite = T)
code <- readr::read_tsv("법정동코드 전체자료.txt",
                        locale = readr::locale(encoding = "CP949"),
                        col_type = list(`법정동코드` = readr::col_character()))

file.remove("code.zip")
file.remove("법정동코드 전체자료.txt")

code %>%
  dplyr::filter(폐지여부 == "존재") %>%
  dplyr::select(-폐지여부) %>%
  dplyr::mutate(법정동코드 = substr(법정동코드, 1,5)) %>%
  tidyr::separate(법정동명, into = c("시도", "시군구")) %>%
  dplyr::filter(!is.na(시군구)) %>%
  unique() ->
  code

names(code) <- iconv(names(code), "cp949", "utf8")
usethis::use_data(code, overwrite = T)
