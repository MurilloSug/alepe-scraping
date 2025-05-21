library(RSelenium)
library(rvest)
library(tidyverse) 
library(wdman) #caminhos de arquivos
library(netstat) #porta livre (precia de um SO em ingles)
source("htm2txt.R")

# Testes para achar arquivos no pc ----------------------------------------

selenium()

selenium_object <- selenium(retcommand = T, check = F)


chromeCommand <- chrome(retcommand = T, verbose = F, check = F)

binman::list_versions("chromedriver")

# Inicializar servidor ----------------------------------------------------


rs_driver_object <- rsDriver(browser = "chrome",
                             chromever = "136.0.7103.94",
                             verbose = F,
                             port = 4445L)


# Criando Client ----------------------------------------------------------

remDr <- rs_driver_object$client


# Abrir navegador ---------------------------------------------------------

remDr$open()

remDr$maxWindowSize()

# Acessar site ------------------------------------------------------------

remDr$navigate("https://legis.alepe.pe.gov.br/lista.aspx?tiponorma=1")

# Botao com icone de arquivo (texto original) -----------------------------

botao <- remDr$findElement(using = 'xpath', '//div[@class="sprite txt-original"]')

botao$clickElement()

remDr$goBack() # volta uma pagina


# Texto em html -----------------------------------------------------------

texto <- remDr$findElement(using = 'class', 'col-sm-12')

texto$getElementAttribute("type")

texto_html <- texto$getPageSource()

page <- read_html(texto_html %>% unlist())

# testes (html para texto) ------------------------------------------------

html_text(page)

html_text2(page)

htm2txt(page)

# Seletor de ano ----------------------------------------------------------

ano <- remDr$findElement(using = 'id', 'ddlAno')
ano$clickElement()

# Encerrando o servidor ---------------------------------------------------

system("taskkill /im java.exe /f")



