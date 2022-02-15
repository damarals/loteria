#' Obtem o resultado de um sorteio especifico de uma
#' modalidade de loteria
#'
#' @param concurso numero do concurso do sorteio
#' @param modalidade modalidade do sorteio, disponiveis:
#'   * megasena
#'   * lotofacil
#'   * quina
#'   * lotomania
#'   * duplasena
#'   * diadesorte
#'   * supersete
#'
#' @return uma \code{tibble}
#' @export
#'
#' @examples
#' resultado_loteria(concurso = 1, modalidade = 'megasena')
resultado_loteria <- function(concurso = NULL, modalidade) {
  modalidades <- list(megasena = 'mega-sena', lotofacil = 'lotofacil', quina = 'quina',
                      lotomania = 'lotomania', duplasena = 'dupla-sena',
                      diadesorte = 'dia-de-sorte', supersete = 'super-sete')
  param_final <- ifelse(is.null(concurso), '', glue::glue('?drawNumber={concurso}'))
  u <- glue::glue('https://www.megaloterias.com.br/{modalidades[[modalidade]]}/resultados{param_final}')
  page_html <- u %>%
    rvest::read_html()
  data <- page_html %>%
    rvest::html_element(xpath = "//div[@class='result__draw-date']//strong") %>%
    rvest::html_text2()
  concurso <- page_html %>%
    rvest::html_element(xpath = "//div[@class='result__draw']//strong") %>%
    rvest::html_text2()
  dezenas <- page_html %>%
    rvest::html_element(xpath = ifelse(modalidade == "supersete",
                                       "//div[@class='result__supersete-grid']",
                                       "//div[@class='result__tens-grid']")) %>%
    rvest::html_text2()
  n_dezenas <- stringr::str_count(dezenas, "\n") + 1
  tibble::tibble(
    data = lubridate::dmy(data),
    concurso = as.integer(concurso),
    dezena = dezenas
  ) %>% tidyr::separate(dezena, sep = "\n", into = paste0('dezena_', 1:n_dezenas))
}

#' Obtem o resultado de todos os sorteios até a data atual
#' de uma modalidade de loteria, ou partindo de um concurso
#'
#' @param modalidade modalidade do sorteio, disponiveis:
#'   * megasena
#'   * lotofacil
#'   * quina
#'   * lotomania
#'   * duplasena
#'   * diadesorte
#'   * supersete
#' @param min_concurso numero do concurso de partida, padrao: 1
#'
#' @return uma \code{tibble}
#' @export
#'
#' @examples
#' resultado_loteria_todos(modalidade = 'megasena', min_concurso = 2452)
resultado_loteria_todos <- function(modalidade, min_concurso = 1) {
  max_concurso <- resultado_loteria(modalidade = modalidade) %>%
    magrittr::extract2('concurso')
  min_concurso:max_concurso %>%
    purrr::set_names() %>%
    purrr::map_dfr(function(x) {
      message(glue::glue('{modalidade} [{x}/{max_concurso}]'))
      resultado_loteria(concurso = x, modalidade = modalidade)
    }) %>%
    purrr::discard(~all(is.na(.x))) %>%
    dplyr::mutate_at(dplyr::vars(dplyr::contains('dezena')), as.integer)
}

#' Verifica se ha novos sorteios a serem coletados no dataset
#' historico da modalidade de loteria
#'
#' @param modalidade modalidade do sorteio, disponiveis:
#'   * megasena
#'   * lotofacil
#'   * quina
#'   * lotomania
#'   * duplasena
#'   * diadesorte
#'   * supersete
#'
#' @return um \code{logico}
#' @export
#'
#' @examples
#' necessario_atualizar(modalidade = 'megasena')
necessario_atualizar <- function(modalidade) {
  max_concurso_online <- resultado_loteria(modalidade = modalidade) %>%
    magrittr::extract2('concurso')
  max_concurso_offline <- dados_sorteios(modalidade) %>%
    dplyr::pull(concurso) %>% max
  max_concurso_online != max_concurso_offline
}

#' Le o conjunto de dados com todos os sorteios até a data atual
#' de uma modalidade de loteria
#'
#' @param modalidade modalidade do sorteio, disponiveis:
#'   * megasena
#'   * lotofacil
#'   * quina
#'   * lotomania
#'   * duplasena
#'   * diadesorte
#'   * supersete
#'
#' @return uma \code{tibble}
#' @export
#'
#' @examples
#' dados_sorteios(modalidade = 'megasena')
dados_sorteios <- function(modalidade) {
  readr::read_csv(
    glue::glue("https://github.com/damarals/loteria/raw/master/inst/extdata/{modalidade}.csv"),
    show_col_types = FALSE)
}
