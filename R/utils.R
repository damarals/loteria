#' Obtem o resultado de um sorteio especifico de uma
#' modalidade de loteria
#'
#' @param concurso numero do concurso do sorteio
#' @param modalidade modalidade do sorteio, disponiveis:
#'   * megasena
#'   * lotofacil
#'   * quina
#'   * lotomania
#'   * timemania
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
                      lotomania = 'lotomania', duplasena = 'dupla-sena', timemania = 'timemania',
                      diadesorte = 'dia-de-sorte', supersete = 'super-sete')
  param_final <- ifelse(is.null(concurso), '', glue::glue('?drawNumber={concurso}'))
  u <- glue::glue('https://www.megaloterias.com.br/{modalidades[[modalidade]]}/resultados{param_final}')
  page_html <- u %>%
    httr2::request() %>%
    httr2::req_retry(max_tries = 5) %>%
    httr2::req_perform() %>%
    httr2::resp_body_raw() %>%
    rvest::read_html() %>%
    rvest::html_element(xpath = "//section[contains(@class, 'lottery-totem')]")
  data <- page_html %>%
    rvest::html_element(xpath = ".//div[@class='result__draw-date']//strong") %>%
    rvest::html_text2()
  concurso <- page_html %>%
    rvest::html_element(xpath = ".//div[@class='result__draw']//strong") %>%
    rvest::html_text2()
  dezenas <- page_html %>%
    rvest::html_elements(xpath = ifelse(modalidade == "supersete",
                                        ".//div[@class='result__supersete-grid']//span",
                                        ".//div[@class='result__tens-grid']")) %>%
    rvest::html_text2() %>% paste0(collapse = '\n')
  n_dezenas <- stringr::str_count(dezenas, "\n") + 1
  dados <- tibble::tibble(
    data = lubridate::dmy(data),
    concurso = as.integer(concurso),
    dezena = dezenas) %>%
    tidyr::separate(dezena, sep = "\n", into = paste0('dezena_', 1:n_dezenas)) %>%
    dplyr::mutate_at(dplyr::vars(dplyr::contains('dezena')), as.integer)
  if(modalidade == 'diadesorte') {
    mes <- page_html %>%
      rvest::html_elements(xpath = ".//div[@class='text-center']//strong") %>%
      rvest::html_text2()
    dados <- dplyr::mutate(dados, mes = mes, .before = dezena_1)
  } else if (modalidade == 'timemania') {
    time <- page_html %>%
      rvest::html_elements(xpath = ".//div[@class='text-center']//strong") %>%
      rvest::html_text2()
    dados <- dplyr::mutate(dados, time = time, .before = dezena_1)
  }
  dados
}

#' Obtem o resultado de todos os sorteios até a data atual
#' de uma modalidade de loteria, ou partindo de um concurso
#'
#' @param modalidade modalidade do sorteio, disponiveis:
#'   * megasena
#'   * lotofacil
#'   * quina
#'   * lotomania
#'   * timemania
#'   * duplasena
#'   * diadesorte
#'   * supersete
#' @param min_concurso numero do concurso de partida, padrao: 1
#' @param max_concurso numero maximo do concurso, padrao: ultimo sorteio
#'
#' @return uma \code{tibble}
#' @export
#'
#' @examples
#' resultado_loteria_todos(modalidade = 'megasena', min_concurso = 2452)
resultado_loteria_todos <- function(modalidade, min_concurso = 1,
                                    max_concurso = NULL) {
  if(is.null(max_concurso)) {
    max_concurso <- resultado_loteria(modalidade = modalidade) %>%
      magrittr::extract2('concurso')
  }
  min_concurso:max_concurso %>%
    purrr::set_names() %>%
    purrr::map_dfr(function(x) resultado_loteria(x, modalidade)) %>%
    purrr::discard(~all(is.na(.x)))
}

#' Verifica se ha novos sorteios a serem coletados no dataset
#' historico da modalidade de loteria
#'
#' @param modalidade modalidade do sorteio, disponiveis:
#'   * megasena
#'   * lotofacil
#'   * quina
#'   * lotomania
#'   * timemania
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
#'   * timemania
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
  ct_modalidades <- list(megasena = paste0('Di', strrep('i', 6)),
                         lotofacil = paste0('Di', strrep('i', 15)),
                         quina = paste0('Di', strrep('i', 5)),
                         lotomania = paste0('Di', strrep('i', 20)),
                         timemania = paste0('Dic', strrep('i', 7)),
                         duplasena = paste0('Di', strrep('i', 12)),
                         diadesorte = paste0('Dic', strrep('i', 7)),
                         supersete = paste0('Di', strrep('i', 7)))
  readr::read_csv(
    glue::glue("https://github.com/damarals/loteria/raw/master/inst/extdata/{modalidade}.csv"),
    locale = readr::locale(encoding = "UTF-8"),
    col_types = ct_modalidades[[modalidade]])
}
