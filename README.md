
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Pacote Loteria

<!-- badges: start -->

[![R-CMD-check](https://github.com/damarals/loteria/workflows/R-CMD-check/badge.svg)](https://github.com/damarals/loteria/actions)
[![update-data](https://github.com/damarals/loteria/actions/workflows/update-data.yaml/badge.svg)](https://github.com/damarals/loteria/actions/workflows/update-data.yaml)
[![Codecov test
coverage](https://codecov.io/gh/damarals/loteria/branch/master/graph/badge.svg)](https://app.codecov.io/gh/damarals/loteria?branch=master)
<!-- badges: end -->

O objetivo deste pacote é disponibilizar os sorteios atualizados das
principais modalidades das loterias CAIXA: Mega Sena, Dupla Sena,
Lotomania, Quina, etc. O pacote é atualizado diariamente através de um
workflow com [GitHub
Actions](https://github.com/damarals/loteria/actions).

Os dados foram obtidos do [Portal Mega
Loterias](https://www.megaloterias.com.br).

**Caso você não utilize R**, é possível **fazer download das bases de
dados** através dos seguintes links:

  - *Mega Sena* [Arquivo
    `.csv`](https://github.com/damarals/loteria/raw/master/inst/extdata/megasena.csv)
  - *Dupla Sena* [Arquivo
    `.csv`](https://github.com/damarals/loteria/raw/master/inst/extdata/duplasena.csv)
  - *Lotofacil* [Arquivo
    `.csv`](https://github.com/damarals/loteria/raw/master/inst/extdata/lotofacil.csv)
  - *Lotomania* [Arquivo
    `.csv`](https://github.com/damarals/loteria/raw/master/inst/extdata/lotomania.csv)
  - *Timemania* [Arquivo
    `.csv`](https://github.com/damarals/loteria/raw/master/inst/extdata/timemania.csv)
  - *Quina* [Arquivo
    `.csv`](https://github.com/damarals/loteria/raw/master/inst/extdata/quina.csv)
  - *Super Sete* [Arquivo
    `.csv`](https://github.com/damarals/loteria/raw/master/inst/extdata/supersete.csv)
  - *Dia de Sorte* [Arquivo
    `.csv`](https://github.com/damarals/loteria/raw/master/inst/extdata/diadesorte.csv)

Os arquivos foram salvos com encoding UTF-8 e separados por vírgula.

## Instalação

Este pacote pode ser instalado através do [GitHub](https://github.com/)
utilizando o seguinte código em `R`:

``` r
# install.packages("devtools")
devtools::install_github("damarals/loteria")
library(loteria)
```

## Como usar?

Caso você tenha conexão à internet, é possível buscar a base atualizada
usando a função `dados_sorteios()`:

``` r
dados_megasena <- loteria::dados_sorteios(modalidade = 'megasena') 
```

Caso você não tenha conexão à internet, você pode utilizar a base
disponível no pacote. Porém as mesmas estarão atualizadas até a data em
que você instalou (ou atualizou) o pacote.

Abaixo segue um exemplo da base disponível:

``` r
dplyr::glimpse(loteria::megasena)
#> Rows: 2,465
#> Columns: 8
#> $ data     <date> 1996-03-11, 1996-03-18, 1996-03-25, 1996-04-01, 1996-04-08, …
#> $ concurso <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18…
#> $ dezena_1 <int> 4, 9, 10, 1, 1, 7, 3, 4, 8, 4, 15, 4, 18, 2, 12, 20, 6, 23, 5…
#> $ dezena_2 <int> 5, 37, 11, 5, 2, 13, 5, 17, 43, 18, 25, 16, 32, 16, 33, 32, 1…
#> $ dezena_3 <int> 30, 39, 29, 6, 6, 19, 20, 37, 54, 21, 37, 19, 47, 23, 35, 34,…
#> $ dezena_4 <int> 33, 41, 30, 27, 16, 22, 21, 38, 55, 25, 38, 20, 50, 27, 51, 4…
#> $ dezena_5 <int> 41, 43, 36, 42, 19, 40, 38, 47, 56, 38, 58, 27, 54, 47, 52, 5…
#> $ dezena_6 <int> 52, 49, 47, 59, 46, 47, 56, 53, 60, 57, 59, 43, 56, 53, 60, 6…
```

### Exemplo de tabela

Cinco últimos sorteios da **Megasena**:

``` r
library(magrittr)
dados_megasena %>% 
  tail(5) %>%
  knitr::kable() 
```

| data       | concurso | dezena\_1 | dezena\_2 | dezena\_3 | dezena\_4 | dezena\_5 | dezena\_6 |
| :--------- | -------: | --------: | --------: | --------: | --------: | --------: | --------: |
| 2022-03-09 |     2461 |         8 |        11 |        16 |        21 |        32 |        37 |
| 2022-03-12 |     2462 |         3 |        16 |        23 |        41 |        45 |        57 |
| 2022-03-16 |     2463 |        11 |        16 |        31 |        37 |        42 |        51 |
| 2022-03-19 |     2464 |         2 |         7 |        24 |        43 |        52 |        56 |
| 2022-03-23 |     2465 |         3 |         8 |        23 |        29 |        53 |        54 |
