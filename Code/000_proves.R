library(httr)
library(rvest)
library(openxlsx)

#  user = "gramire4",
#  password = "qSc2uIZGKRYBHCYJN76LzIyvz4XX3"


# mmonto13
# Montoro47277157j

    
library(httr)
library(rvest)

# Configura la URL
url <- "https://aplicacions.ensenyament.gencat.cat/e13_bor/editLoginGeco.do"
data_url <- "https://aplicacions.ensenyament.gencat.cat/e13_bor/desaEscollirSTNivell.do"

# Inicia una sessió
sess <- session(url)

# Omple el formulari amb les teves credencials
filled_form <- sess %>%
  html_form() %>%
  .[[1]] %>%
  html_form_set(
    usuariXTEC = "mmonto13",
    contrasenyaXTEC = "Montoro47277157j"
  )

# Envia el formulari
logged_in_session <- submit_form(sess, filled_form)

# Omple el formulari amb les seleccions desitjades
selection_form <- logged_in_session %>%
  html_form() %>%
  .[[1]] %>%
  html_form_set(
    serveiTerritorial = "0117", # Alt Pirineu i Aran
    nivell = "P"                # Primària
  )

# Envia el formulari amb les seleccions
final_session <- submit_form(logged_in_session, selection_form)

# Navega a la pàgina amb les taules
final_session <- session_jump_to(final_session, data_url)

# Obtén el contingut de la pàgina
page_content <- read_html(data_url)

# Captura les taules de la pàgina
tables <- page_content %>%
  html_table()




# Obtén el títol de la pàgina
page_title <- page_content %>% html_node('title') %>% html_text()

# Imprimeix el títol de la pàgina
print(page_title)




# Obtén la taula específica que desitges (en aquest cas, estic obtenint la primera taula; ajusta l'índex segons sigui necessari)


# Crea un nou llibre de treball
wb <- createWorkbook()

# Afegeix cada taula com una nova pestanya en el llibre de treball
for(i in seq_along(tables)) {
  addWorksheet(wb, paste("Taula", i))
  writeData(wb, sheet = paste("Taula", i), x = tables[[i]])
}

# Guarda el llibre de treball com un arxiu .xlsx
saveWorkbook(wb, "../Out/meves_taules.xlsx", overwrite = TRUE)




lapply(tables, function(x) print(x))


for(i in seq_along(tables)) {
  print(paste("Taula", i, ":"))
  print(tables[[i]])
}







