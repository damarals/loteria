#' Obtem a URL do JSON de um sorteio especifico de uma
#' modalidade de loteria
#'
#' @param id_concurso numero do concurso do sorteio
#' @param modalidade modalidade do sorteio, disponiveis:
#'   * megasena
#'   * lotofacil
#'   * quina
#'   * lotomania
#'   * duplasena
#'   * diadesorte
#'   * supersete
#'
#' @return uma \code{string}
#' @export
#'
#' @importFrom glue glue
#'
#' @examples
#' obter_url_sorteio(id_concurso = 1, modalidade = 'megasena')
obter_url_sorteio <- function(id_concurso, modalidade) {
  codigos_modalidade <- list(
    megasena = '04_Sj9CPykssy0xPLMnMz0vMAfGjzOLNDH0MPAzcDbwMPI0sDBxNXAOMwrzCjA0sjIEKIoEKnN0dPUzMfQwMDEwsjAw8XZw8XMwtfQ0MPM2I02-AAzgaENIfrh-FqsQ9wNnUwNHfxcnSwBgIDUyhCvA5EawAjxsKckMjDDI9FQE-F4ca/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_HGK818G0KO6H80AU71KG7J0072',
    lotofacil = '04_Sj9CPykssy0xPLMnMz0vMAfGjzOLNDH0MPAzcDbz8vTxNDRy9_Y2NQ13CDA0sTIEKIoEKnN0dPUzMfQwMDEwsjAw8XZw8XMwtfQ0MPM2I02-AAzgaENIfrh-FqsQ9wBmoxN_FydLAGAgNTKEK8DkRrACPGwpyQyMMMj0VAcySpRM!/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_61L0H0G0J0VSC0AC4GLFAD2003',
    quina = 'jc69DoIwAATgZ_EJepS2wFgoaUswsojYxXQyTfgbjM9vNS4Oordd8l1yxJGBuNnfw9XfwjL78dmduIikhYFGA0tzSFZ3tG_6FCmP4BxBpaVhWQuA5RRWlUZlxR6w4r89vkTi1_5E3CfRXcUhD6osEAHA32Dr4gtsfFin44Bgdw9WWSwj/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_HGK818G0K8ULB0QT4MEM8L0086',
    lotomania = '04_Sj9CPykssy0xPLMnMz0vMAfGjzOLNDH0MPAzcDbz8vTxNDRy9_Y2NQ13CDA38jYEKIoEKnN0dPUzMfQwMDEwsjAw8XZw8XMwtfQ0MPM2I02-AAzgaENIfrh-FqsQ9wBmoxN_FydLAGAgNTKEK8DkRrACPGwpyQyMMMj0VAajYsZo!/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_61L0H0G0JGJVA0AKLR5T3K00V0',
    duplasena = '04_Sj9CPykssy0xPLMnMz0vMAfGjzOLNDH0MPAzcDbwMPI0sDBxNXAOMwrzCjA2cDIAKIoEKnN0dPUzMfQwMDEwsjAw8XZw8XMwtfQ0MPM2I02-AAzgaENIfrh-FqsQ9wNnUwNHfxcnSwBgIDUyhCvA5EawAjxsKckMjDDI9FQGgnyPS/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_HGK818G0KGSE30Q3I6OOK60006',
    diadesorte = 'jc5BDsIgFATQs3gCptICXdKSfpA2ujFWNoaVIdHqwnh-sXFr9c_qJ2-SYYGNLEzxmc7xkW5TvLz_IE6WvCoUwZPwArpTnZWD4SCewTGDlrQtZQ-gVGs401gj6wFw4r8-vpzGr_6BhZmIoocFYUO7toLemqYGz0H1AUsTZ7Cw4X7dj0hu9QIyUWUw/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_HGK818G0KO5GE0Q8PTB11800G3',
    supersete = 'jc5BDsIgEAXQs3gCPralsISSAFK1XaiVjWFlSLS6MJ5fbNxanVnN5P3kk0AGEsb4TOf4SLcxXt53YCdrPKfcwHOtGvTdfiMK31OgzOCYQWOkLesW-cOXcFpZXYs14Nh_eXwZiV_5AwkTYbSFhcHKdE0FudVKoMiL6gPmKk5gpsP9uhuQ3OIFKJSbBA!!/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_HGK818G0K85260Q5OIRSC420K6'
  )
  param_final <- ifelse(length(id_concurso) > 0, glue("//p=concurso={id_concurso}"), "")
  glue('https://loterias.caixa.gov.br/wps/portal/loterias/landing/{modalidade}/!ut/p/a1/{codigos_modalidade[[modalidade]]}/res/id=buscaResultado/c=cacheLevelPage{param_final}')
}

#' Obtem o resultado de um sorteio especifico de uma
#' modalidade de loteria
#'
#' @param id_concurso numero do concurso do sorteio
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
#' @importFrom glue glue
#' @importFrom jsonlite read_json
#' @importFrom tibble tibble
#' @importFrom lubridate dmy
#' @importFrom tidyr separate
#'
#' @examples
#' resultado_loteria(id_concurso = 1, modalidade = 'megasena')
resultado_loteria <- function(id_concurso, modalidade) {
  json <- obter_url_sorteio(id_concurso, modalidade) %>%
    read_json(simplifyVector = TRUE)
  tibble(
    date = dmy(json$dataApuracao),
    id_concurso = id_concurso,
    sort = paste0(as.numeric(json$dezenasSorteadasOrdemSorteio), collapse = ",")
  ) %>% separate(col = sort, sep = ",",
                 into = paste0('sort_', 1:length(json$dezenasSorteadasOrdemSorteio)))
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
#' @importFrom glue glue
#' @importFrom jsonlite read_json
#' @importFrom magrittr extract2
#' @importFrom purrr set_names map_dfr discard
#'
#' @examples
#' resultado_loteria_todos(modalidade = 'megasena', min_concurso = 2452)
resultado_loteria_todos <- function(modalidade, min_concurso = 1) {
  max_concurso <- obter_url_sorteio(id_concurso = NULL, modalidade) %>%
    read_json() %>%
    extract2('numero')
  min_concurso:max_concurso %>%
    set_names() %>%
    map_dfr(\(x) {
      message(glue('{modalidade} [{x}/{max_concurso}]'))
      resultado_loteria(x, modalidade)
    }) %>%
    discard(~all(is.na(.x)))
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
#' @importFrom glue glue
#' @importFrom jsonlite read_json
#' @importFrom magrittr extract2
#' @importFrom rlang sym
#' @importFrom dplyr pull
#'
#' @examples
#' necessario_atualizar(modalidade = 'megasena')
necessario_atualizar <- function(modalidade) {
  max_concurso_online <- obter_url_sorteio(id_concurso = NULL, modalidade) %>%
    read_json() %>%
    extract2('numero')
  max_concurso_offline <- glue('{modalidade}') %>%
    sym() %>% eval %>%
    pull(id_concurso) %>% max
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
#' @importFrom glue glue
#' @importFrom readr read_csv
#'
#' @examples
#' dados_sorteios(modalidade = 'megasena')
dados_sorteios <- function(modalidade) {
  readr::read_csv(
    glue("https://github.com/damarals/loteria/raw/master/inst/extdata/{modalidade}.csv"))
}
