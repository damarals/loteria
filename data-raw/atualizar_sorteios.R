library(magrittr, include.only = "%>%")

modalidades <- list(megasena = 'mega-sena', lotofacil = 'lotofacil', quina = 'quina',
                    lotomania = 'lotomania', duplasena = 'dupla-sena',
                    diadesorte = 'dia-de-sorte', supersete = 'super-sete')

purrr::walk(names(modalidades), function(modalidade) {
  if(loteria::necessario_atualizar(modalidade)) {
    max_concurso_offline <- loteria::dados_sorteios(modalidade) %>%
      dplyr::pull(concurso) %>% max
    modalidade_atualizada <- loteria::dados_sorteios(modalidade) %>%
      dplyr::bind_rows(
        loteria::resultado_loteria_todos(modalidade = modalidade,
                                         min_concurso = max_concurso_offline)
      ) %>% dplyr::distinct()
    assign(modalidade, modalidade_atualizada, envir = .GlobalEnv)
    readr::write_csv(modalidade_atualizada, glue::glue('inst/extdata/{modalidade}.csv'))
  }
})

try(usethis::use_data(megasena, overwrite = TRUE), silent = TRUE)
try(usethis::use_data(lotofacil, overwrite = TRUE), silent = TRUE)
try(usethis::use_data(quina, overwrite = TRUE), silent = TRUE)
try(usethis::use_data(lotomania, overwrite = TRUE), silent = TRUE)
try(usethis::use_data(duplasena, overwrite = TRUE), silent = TRUE)
try(usethis::use_data(diadesorte, overwrite = TRUE), silent = TRUE)
try(usethis::use_data(supersete, overwrite = TRUE), silent = TRUE)

rmarkdown::render("README.Rmd")
