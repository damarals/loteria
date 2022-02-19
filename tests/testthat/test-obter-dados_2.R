test_that("Funcao resultado_loteria_todos esta funcionando corretamente", {
  ndezenas_modalidades <- list(megasena = 6, lotofacil = 15, timemania = 7,
                               quina = 5, lotomania = 20, duplasena = 12,
                               diadesorte = 7, supersete = 7)

  purrr::walk(names(ndezenas_modalidades), function(modalidade) {
    # Executar a funcao uma vez
    da_sorteios <- resultado_loteria_todos(modalidade, 1, 3)

    # Testar a classe
    expect_s3_class(da_sorteios, "tbl_df")

    # Testar numero de colunas
    cols_restantes <- ifelse(modalidade %in% c('timemania', 'diadesorte'), 3, 2)
    expect_equal(ncol(da_sorteios), ndezenas_modalidades[[modalidade]] + cols_restantes)

    # Testar valores faltantes (NA)
    expect_false(any(is.na(da_sorteios)))

    # Testar numero de linhas
    expect_equal(nrow(da_sorteios), 3)

    # Testar classe das variáveis
    expect_s3_class(da_sorteios$data, "Date")
    expect_type(da_sorteios$concurso, "integer")
    if(modalidade == 'diadesorte') {
      expect_type(da_sorteios$mes, "character")
    } else if (modalidade == 'timemania') {
      expect_type(da_sorteios$time, "character")
    }
    for(n_col in 1:ndezenas_modalidades[[modalidade]]) {
      expect_type(da_sorteios[[paste0('dezena_', n_col)]], "integer")
    }
  })

})
