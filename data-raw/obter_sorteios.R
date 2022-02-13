# obter todos os sorteios de todas as modalidades
megasena <- resultado_loteria_todos(modalidade = 'megasena')
lotofacil <- resultado_loteria_todos(modalidade = 'lotofacil')
quina <- resultado_loteria_todos(modalidade = 'quina')
lotomania <- resultado_loteria_todos( modalidade = 'lotomania')
duplasena <- resultado_loteria_todos(modalidade = 'duplasena')
diadesorte <- resultado_loteria_todos(modalidade = 'diadesorte')
supersete <- resultado_loteria_todos(modalidade = 'supersete')

# salvar os datasets
usethis::use_data(megasena, overwrite = TRUE)
usethis::use_data(lotofacil, overwrite = TRUE)
usethis::use_data(quina, overwrite = TRUE)
usethis::use_data(lotomania, overwrite = TRUE)
usethis::use_data(duplasena, overwrite = TRUE)
usethis::use_data(diadesorte, overwrite = TRUE)
usethis::use_data(supersete, overwrite = TRUE)
