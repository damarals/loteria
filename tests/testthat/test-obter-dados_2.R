test_that("Funcao resultado_loteria_todos esta funcionando corretamente", {
  ndezenas_modalidades <- list(megasena = 6, lotofacil = 15,
                               quina = 5, lotomania = 20, duplasena = 12,
                               diadesorte = 7, supersete = 7)

  purrr::walk(names(ndezenas_modalidades), function(modalidade) {
    # Executar a funcao uma vez
    da_sorteios <- resultado_loteria_todos(modalidade, 1, 3)

    # Testar a classe
    expect_s3_class(da_sorteios, "tbl_df")

    # Testar numero de colunas
    expect_equal(ncol(da_sorteios), ndezenas_modalidades[[modalidade]] + 2)

    # Testar valores faltantes (NA)
    expect_false(any(is.na(da_sorteios)))

    # Testar numero de linhas
    expect_equal(nrow(da_sorteios), 3)

    # Testar classe das variáveis
    expect_s3_class(da_sorteios$data, "Date")
    expect_type(da_sorteios$concurso, "integer")
    for(n_col in 1:ndezenas_modalidades[[modalidade]]) {
      expect_type(da_sorteios[[paste0('dezena_', n_col)]], "integer")
    }
  })

})
