test_that("Funcao dados_sorteios esta funcionando corretamente", {
  ndezenas_modalidades <- list(megasena = 6, lotofacil = 15, timemania = 7,
                               quina = 5, lotomania = 20, duplasena = 6,
                               diadesorte = 7, supersete = 7)

  purrr::walk(names(ndezenas_modalidades), function(modalidade) {
    # Executar a funcao uma vez
    da_sorteio <- dados_sorteios(modalidade)

    # Testar a classe
    expect_s3_class(da_sorteio, "tbl_df")

    # Testar numero de colunas
    cols_restantes <- ifelse(modalidade %in% c('timemania', 'diadesorte', 'duplasena'), 3, 2)
    expect_equal(ncol(da_sorteio), ndezenas_modalidades[[modalidade]] + cols_restantes)

    # Testar valores faltantes (NA)
    expect_false(any(is.na(da_sorteio)))

    # Testar numero de linhas
    expect_gt(nrow(da_sorteio), 100)

    # Testar classe das variáveis
    expect_s3_class(da_sorteio$data, "Date")
    expect_type(da_sorteio$concurso, "integer")
    if (modalidade == 'diadesorte') {
      expect_type(da_sorteio$mes, "character")
    } else if (modalidade == 'timemania') {
      expect_type(da_sorteio$time, "character")
    } else if (modalidade == 'duplasena') {
      expect_type(da_sorteio$sorteio, "integer")
    }
    for(n_col in 1:ndezenas_modalidades[[modalidade]]) {
      expect_type(da_sorteio[[paste0('dezena_', n_col)]], "integer")
    }
  })

})
