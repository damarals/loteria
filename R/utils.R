#' Obtem o JSON de um sorteio especifico de uma
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
#' @importFrom httr2 request req_headers req_perform resp_body_string
#' @importFrom jsonlite read_json
#'
#' @examples
#' obter_json_sorteio(id_concurso = 1, modalidade = 'megasena')
obter_json_sorteio <- function(id_concurso, modalidade) {
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
  u <- glue('https://loterias.caixa.gov.br/wps/portal/loterias/landing/{modalidade}/!ut/p/a1/{codigos_modalidade[[modalidade]]}/res/id=buscaResultado/c=cacheLevelPage{param_final}')
  request(u) %>%
    req_headers("Host" = "loterias.caixa.gov.br",
                "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:97.0) Gecko/20100101 Firefox/97.0",
                "Request-Id" = "|jiqfG.muZiF",
                "Connection" = "keep-alive",
                "Referer" = "http://loterias.caixa.gov.br/wps/portal/loterias/landing/megasena",
                "Cookie" = "_pk_id.4.968f=1118fd41ebca69b5.1644245163.12.1644767132.1644766902.; _pk_ref.4.968f=%5B%22%22%2C%22%22%2C1644766902%2C%22https%3A%2F%2Fwww.google.com%2F%22%5D; _fbp=fb.2.1644245163455.210300274; _ga=GA1.4.1759838994.1644245164; _ga=GA1.3.1427735449.1644245187; __uzma=6486b949-b31d-4ee6-9665-aa83f791363b; __uzmb=1644464092; __uzmc=3785040615473; __uzmd=1644767131; ai_user=AZdYh|2022-02-10T03:34:52.254Z; _gid=GA1.4.967139367.1644722587; _gid=GA1.3.1634177439.1644724183; security=true; JSESSIONID=0000Qw3gP1_k89HC9-Uar76RO_B:19790cild; ai_session=daOkw|1644766901943|1644767131869; _pk_ses.4.968f=*; _gat_UA-85357028-1=1") %>%
    req_perform() %>% resp_body_string() %>% read_json(simplifyVector = TRUE)
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
#' @importFrom tibble tibble
#' @importFrom lubridate dmy
#' @importFrom tidyr separate
#'
#' @examples
#' resultado_loteria(id_concurso = 1, modalidade = 'megasena')
resultado_loteria <- function(id_concurso, modalidade) {
  json <- obter_json_sorteio(id_concurso, modalidade)
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
#' @importFrom magrittr extract2
#' @importFrom purrr set_names map_dfr discard
#'
#' @examples
#' resultado_loteria_todos(modalidade = 'megasena', min_concurso = 2452)
resultado_loteria_todos <- function(modalidade, min_concurso = 1) {
  max_concurso <- obter_json_sorteio(id_concurso = NULL, modalidade) %>%
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
#' @importFrom magrittr extract2
#' @importFrom rlang sym
#' @importFrom dplyr pull
#'
#' @examples
#' necessario_atualizar(modalidade = 'megasena')
necessario_atualizar <- function(modalidade) {
  max_concurso_online <- obter_json_sorteio(id_concurso = NULL, modalidade) %>%
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
