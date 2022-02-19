test_that("Funcao resultado_loteria esta funcionando corretamente", {
  ndezenas_modalidades <- list(megasena = 6, lotofacil = 15, timemania = 7,
                               quina = 5, lotomania = 20, duplasena = 12,
                               diadesorte = 7, supersete = 7)

  purrr::walk(names(ndezenas_modalidades), function(modalidade) {
    # Executar a funcao uma vez
    da_sorteio <- resultado_loteria(1, modalidade)

    # Testar a classe
    expect_s3_class(da_sorteio, "tbl_df")

    # Testar numero de colunas
    cols_restantes <- ifelse(modalidade %in% c('timemania', 'diadesorte'), 3, 2)
    expect_equal(ncol(da_sorteio), ndezenas_modalidades[[modalidade]] + cols_restantes)

    # Testar valores faltantes (NA)
    expect_false(any(is.na(da_sorteio)))

    # Testar numero de linhas
    expect_equal(nrow(da_sorteio), 1)

    # Testar classe das variáveis
    expect_s3_class(da_sorteio$data, "Date")
    expect_type(da_sorteio$concurso, "integer")
    for(n_col in 1:ndezenas_modalidades[[modalidade]]) {
      expect_type(da_sorteio[[paste0('dezena_', n_col)]], "integer")
    }
  })

})
