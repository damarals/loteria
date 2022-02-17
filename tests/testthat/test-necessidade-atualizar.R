test_that("Funcao necessario_atualizar esta funcionando corretamente", {
  modalidades <- c("megasena", "lotofacil", "quina",  "lotomania",
                   "duplasena", "diadesorte", "supersete")

  purrr::walk(modalidades, function(modalidade) {
    # Executar a funcao uma vez
    atualizar <- necessario_atualizar(modalidade)

    # Testar a classe
    expect_type(atualizar, "logical")

    # Testar o tamanho
    expect_equal(length(atualizar), 1)
  })

})
