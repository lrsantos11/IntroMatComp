### A Pluto.jl notebook ###
# v0.20.24

using Markdown
using InteractiveUtils

# ╔═╡ 20000000-0000-0000-0000-000000000001
begin
    using Plots
    using StatsPlots
    using CSV, DataFrames
    using PlutoUI
    using Statistics
end

# ╔═╡ 20000000-0000-0000-0000-000000000002
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Semana 07 - Aula 02
"""

# ╔═╡ 20000000-0000-0000-0000-000000000003
md"""
### Viz de Dados: DataFrames e Estatística
Nesta aula vamos explorar como carregar dados estruturados (planilhas CSV) e visualizar usando os recursos avançados do `DataFrames.jl` e do pacote `StatsPlots.jl`.
"""

# ╔═╡ 20000000-0000-0000-0000-000000000004
md"""
### Carregando e Inspecionando Dados (CSV)
Após carregar o arquivo CSV, podemos visualizar a estrutura da tabela, por exemplo, imprimindo as 5 primeiras linhas com a função `first`.
"""

# ╔═╡ 20000000-0000-0000-0000-000000000005
df_metrosp = CSV.read("../assets/metro_sp.csv", DataFrame)

# ╔═╡ 20000000-0000-0000-0000-000000000010
first(df_metrosp, 5)

# ╔═╡ 20000000-0000-0000-0000-000000000006
md"""
### O poder da macro `@df`
O pacote `StatsPlots.jl` traz a macro `@df`, que nos permite passar o DataFrame como argumento principal e, em seguida, chamar as colunas diretamente pelos seus símbolos (como `:lon`, `:lat`), delegando a extração dos dados automaticamente!
"""

# ╔═╡ 20000000-0000-0000-0000-000000000007
begin
    # Gráfico direto das colunas do DataFrame, colorido pela categoria `:linha`
    @df df_metrosp scatter(
        :lon, :lat, 
        group = :linha, 
        title = "Estações de metrô de São Paulo por Linha", 
        aspect_ratio = :equal, 
        leg = :outertopright,
        markersize = 6
    )
end

# ╔═╡ 20000000-0000-0000-0000-000000000008
md"""
### Manipulação e Agrupamento
Com o pacote `DataFrames.jl`, podemos usar a dupla `groupby` (para agrupar por uma categoria) e `combine` (para calcular sumarizações). 

Por exemplo, podemos contar o número de itens usando uma função especial de contagem (`nrow => :nome_da_coluna`):
"""

# ╔═╡ 20000000-0000-0000-0000-000000000009
begin
    # Conta quantas estações existem em cada linha
    df_resumo = combine(groupby(df_metrosp, :linha), nrow => :total_estacoes)
    
    # Plota os resultados em um gráfico de barras
    @df df_resumo bar(
        :linha, :total_estacoes, 
        legend = false, 
        title = "Número de Estações por Linha", 
        rotation = 45,
        color = :teal
    )
end

# ╔═╡ 20000000-0000-0000-0000-000000000011
md"""
Além da contagem, podemos aplicar qualquer **função matemática ou estatística** em uma coluna específica usando a sintaxe `coluna => funcao => nova_coluna`. Veja o exemplo abaixo, onde usamos a função `minimum` para achar a menor latitude (o ponto mais ao Sul) de cada linha:
"""

# ╔═╡ 20000000-0000-0000-0000-000000000012
combine(groupby(df_metrosp, :linha), :lat => minimum => :lat_mais_ao_sul)

# ╔═╡ 30000000-0000-0000-0000-000000000000
md"""
## Exercício da Aula 02 — Explorando Dados (Metrô de SP)

> A partir do dataset `metro_sp.csv` (carregado via `DataFrames.jl`), descubra a Latitude e Longitude *médias* das estações de cada linha.
> - Use as funções `groupby` e `combine` (dica: agregue usando a função `mean` do pacote `Statistics`).
> - Em seguida, utilize o `StatsPlots.jl` (macro `@df`) para fazer um gráfico de espalhamento (`scatter`) da coordenada média de cada linha.
> - Faça com que a cor de cada ponto seja agrupada pela linha correspondente.

**Observações:** 
- Suba um Notebook Pluto com o nome _Tarefa_Semana07_Meu_Nome.pluto.jl_ na atividade específica no Moodle agregando as resoluções da Aula 01 e desta Aula 02.
- Não esqueça de incluir as referências consultadas.
"""

# ╔═╡ Cell order:
# ╠═20000000-0000-0000-0000-000000000001
# ╟─20000000-0000-0000-0000-000000000002
# ╟─20000000-0000-0000-0000-000000000003
# ╟─20000000-0000-0000-0000-000000000004
# ╠═20000000-0000-0000-0000-000000000005
# ╠═20000000-0000-0000-0000-000000000010
# ╟─20000000-0000-0000-0000-000000000006
# ╠═20000000-0000-0000-0000-000000000007
# ╟─20000000-0000-0000-0000-000000000008
# ╠═20000000-0000-0000-0000-000000000009
# ╟─20000000-0000-0000-0000-000000000011
# ╠═20000000-0000-0000-0000-000000000012
# ╟─30000000-0000-0000-0000-000000000000
