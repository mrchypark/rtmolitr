## https://www.code.go.kr/index.do

tar <- "https://www.code.go.kr/etc/codeFullDown.do?cPage=1&regionCd_pk=&chkWantCnt=0&reqSggCd=&reqUmdCd=&reqRiCd=&searchOk=&codeseId=%EB%B2%95%EC%A0%95%EB%8F%99%EC%BD%94%EB%93%9C&pageSize=10&regionCd=&locataddNm=&sidoCd=*&sggCd=*&umdCd=*&riCd=*&disuseAt=0&stdate=&enddate="

library(httr)
POST(tar,  write_disk("./data-raw/code.zip", overwrite = TRUE))
unzip("./data-raw/code.zip", exdir = "./data-raw",overwrite = T)
library(readr)
code <- read_tsv("data-raw/법정동코드 전체자료.txt",
                 locale = locale(encoding = "CP949"))
library(dplyr)
library(stringr)

