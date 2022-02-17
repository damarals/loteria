test_that("Funcao resultado_loteria esta funcionando corretamente", {
  ndezenas_modalidades <- list(megasena = 6, lotofacil = 15,
                               quina = 5, lotomania = 20, duplasena = 6,
                               diadesorte = 7, supersete = 7)

  purrr::walk(length(ndezenas_modalidades), function(modalidade) {
    # Executar a funcao uma vez
    da_sorteio <- resultado_loteria(1, modalidade)

    # Testar a classe
    expect_s3_class(da_sorteio, "tbl_df")

    # Testar numero de colunas
    expect_equal(ncol(da_sorteio), ndezenas_modalidades[[modalidade]] + 2)

    # Testar valores faltantes (NA)
    expect_false(any(is.na(da_sorteio)))

    # Testar numero de linhas
    expect_gt(nrow(da_sorteio), 1)

    # Testar classe das variáveis
    expect_s3_class(da_sorteio$data, "Date")
    expect_type(da_sorteio$concurso, "integer")
    for(n_col in 1:ndezenas_modalidades[[modalidade]]) {
      expect_type(da_sorteio[[paste0('dezena_', n_col)]], "integer")
    }
  })

})
