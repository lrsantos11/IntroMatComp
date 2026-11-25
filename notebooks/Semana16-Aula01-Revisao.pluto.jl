### A Pluto.jl notebook ###
# v0.20.23

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ f1600000-0000-0000-0000-000000000001
md"""
## UFSC/Blumenau
### MAT4642 — Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Semana 16 — Aula 01: Revisão Integrada (EDA, Aleatórios, Álgebra Linear e Ajuste de Curvas)
"""

# ╔═╡ f1600000-0000-0000-0000-000000000002
TableOfContents(title="Índice da Revisão")

# ╔═╡ f1600000-0000-0000-0000-000000000003
begin
	using DataFrames
	using RDatasets
	using Statistics
	using StatsBase
	using Plots
	using StatsPlots
	using Random
	using LinearAlgebra
	using PlutoUI
end

# ╔═╡ f1600000-0000-0000-0000-000000000004
md"""
# Visão Geral da Aula de Revisão (100 minutos)

Nesta aula vamos integrar os principais tópicos trabalhados ao longo da disciplina em um único fluxo prático de Ciência de Dados e Cálculo Numérico:

1. **Parte 1 — Dataset e Limpeza:** carregamento de dados reais (`airquality`), inspeção inicial e tratamento de `missing` com laços `for`.
2. **Parte 2 — Laços, Estatística Descritiva e Visualização (EDA):** implementação manual de média e desvio-padrão, validação com `Statistics`, agrupamento com `DataFrames.jl` e gráficos com `Plots.jl` e `StatsPlots.jl`.
3. **Parte 3 — Números Aleatórios e Divisão Treino/Teste:** reprodutibilidade com `Random.seed!`, transformações de `rand`/`randn` e amostragem com `randperm`.
4. **Parte 4 — Álgebra Linear e Quadrados Mínimos:** matriz de Vandermonde respeitando *column-major order*, Equações Normais vs. Fatoração QR (`\`), condicionamento ``\kappa_2(V)`` e escolha do grau polinomial.
5. **Parte 5 — Interpolação Polinomial vs. Quadrados Mínimos:** sistema quadrado via Fatoração LU (`lu`), singularidade por abscissas repetidas, Fenômeno de Runge e sensibilidade ao ruído.

> **Como usar este caderno:** as células de infraestrutura e os **Laboratórios Interativos** já estão prontos para execução. Nas células marcadas com `# PRÁTICA`, siga as dicas nos comentários e descomente ou complete o código ao vivo durante a aula.
"""

# ╔═╡ f1600000-0000-0000-0000-000000000005
md"""
---
# Parte 1: Dataset `airquality` (Nova York, 1973) e Tratamento de Dados

Vamos trabalhar com um conjunto de dados clássico disponível no pacote `RDatasets.jl`: as medições diárias da **qualidade do ar em Nova York** entre maio e setembro de 1973 (153 observações e 6 colunas):

- `Ozone`: concentração média de ozônio (ppb) à tarde na Ilha Roosevelt;
- Radiação solar matinal no Central Park (o nome da coluna pode aparecer como `Solar_R` ou `SolarR` conforme o parser);
- `Wind`: velocidade média do vento (mph) no aeroporto LaGuardia;
- `Temp`: temperatura máxima diária (°F) no aeroporto LaGuardia;
- `Month` (`5` a `9`) e `Day` (`1` a `31`).

> **Nota prática:** para evitar dependência da grafia da segunda coluna, vamos inspecionar todos os nomes dinamicamente com `names(df_bruto)` e manipular explicitamente `:Ozone`, `:Wind`, `:Temp`, `:Month` e `:Day`.
"""

# ╔═╡ f1600000-0000-0000-0000-000000000006
df_bruto = dataset("datasets", "airquality")

# ╔═╡ f1600000-0000-0000-0000-000000000007
let
	# Dicas de inspeção inicial da tabela (descomente uma linha por vez para testar):
	# first(df_bruto, 5)
	# last(df_bruto, 5)
	# describe(df_bruto)
	(dimensoes = size(df_bruto), colunas = names(df_bruto))
end

# ╔═╡ f1600000-0000-0000-0000-000000000008
let
	# PRÁTICA 1: Contando valores faltantes (`missing`) por coluna com laço `for`
	# Dica 1: Percorra `for col in names(df_bruto)`
	# Dica 2: Verifique valores ausentes com `ismissing` sobre `df_bruto[!, col]`
	# Dica 3: Conte quantos `true` existem com `count(ismissing, ...)` ou `sum(ismissing.(...))`
	#
	# Exemplo de estrutura (descomente e remova o `nothing` ao completar):
	# faltantes = Dict{String, Int}()
	# for col in names(df_bruto)
	#     faltantes[col] = count(ismissing, df_bruto[!, col])
	# end
	# faltantes
	nothing
end

# ╔═╡ f1600000-0000-0000-0000-000000000009
begin
	# Remove linhas que contêm `missing` em qualquer coluna
	df_ar = dropmissing(df_bruto)

	# Conversão de unidades usando broadcasting: °F -> °C e mph -> km/h
	df_ar.TempC = round.((df_ar.Temp .- 32.0) .* (5.0 / 9.0), digits=1)
	df_ar.WindKmh = round.(df_ar.Wind .* 1.60934, digits=1)

	# Rótulo categórico ordenado para facilitar agrupamentos e gráficos por mês
	mapa_meses = Dict(5 => "5-Mai", 6 => "6-Jun", 7 => "7-Jul", 8 => "8-Ago", 9 => "9-Set")
	df_ar.Mes = [mapa_meses[m] for m in df_ar.Month]

	first(df_ar, 6)
end

# ╔═╡ f1600000-0000-0000-0000-000000000010
md"""
---
# Parte 2: Laços `for`, Funções, Estatísticas Descritivas e EDA

Antes de usar bibliotecas prontas, vamos relembrar como escrever funções limpas com `@assert` e laços `for` calculando a **média amostral** e o **desvio-padrão amostral** (com correção de Bessel ``n - 1``):

```math
\bar{x} = \frac{1}{n}\sum_{i=1}^n x_i, \qquad s = \sqrt{\frac{1}{n - 1}\sum_{i=1}^n (x_i - \bar{x})^2}.
```

Em seguida, compararemos nossos resultados com `mean` e `std` usando igualdade aproximada ``\approx`` (`\approx` + `<Tab>`), e exploraremos o dataset com `summarystats`, `cor`, `filter`, `groupby` e `combine`.
"""

# ╔═╡ f1600000-0000-0000-0000-000000000011
begin
	# PRÁTICA 2: Implemente média e desvio-padrão amostral usando laço `for`
	function minha_media(v)
		@assert !isempty(v) "O vetor não pode estar vazio"
		# Dica 1: Inicialize `soma = 0.0`
		# Dica 2: Acumule `soma += x` dentro de `for x in v`
		# Dica 3: Retorne `soma / length(v)`
		return nothing
	end

	function meu_desvio_padrao(v)
		@assert length(v) > 1 "São necessários pelo menos 2 elementos"
		# Dica 1: Reutilize `μ = minha_media(v)`
		# Dica 2: Acumule `(x - μ)^2` dentro de `for x in v`
		# Dica 3: Retorne `sqrt(soma_quad / (length(v) - 1))`
		return nothing
	end
end

# ╔═╡ f1600000-0000-0000-0000-000000000012
let
	# Após implementar `minha_media` e `meu_desvio_padrao` acima, descomente para validar:
	# @assert minha_media(df_ar.Ozone) ≈ mean(df_ar.Ozone)
	# @assert meu_desvio_padrao(df_ar.Ozone) ≈ std(df_ar.Ozone)

	resumo_ozonio = summarystats(df_ar.Ozone)
	cor_temp_ozonio = cor(df_ar.TempC, df_ar.Ozone)
	cor_vento_ozonio = cor(df_ar.WindKmh, df_ar.Ozone)

	(
		resumo_ozone = resumo_ozonio,
		correlacao_TempC_Ozone = round(cor_temp_ozonio, digits=4),
		correlacao_WindKmh_Ozone = round(cor_vento_ozonio, digits=4)
	)
end

# ╔═╡ f1600000-0000-0000-0000-000000000013
let
	# PRÁTICA 3: Filtragem e sumarização por mês (`filter`, `groupby`, `combine`)
	# Dica 1: Filtre dias críticos com `df_criticos = filter(row -> row.Ozone > 100, df_ar)`
	# Dica 2: Agrupe por mês com `gdf = groupby(df_ar, :Mes)`
	# Dica 3: Calcule estatísticas por mês com `combine`:
	# df_mensal = combine(
	#     gdf,
	#     nrow => :Dias,
	#     :TempC => mean => :TempMediaC,
	#     :Ozone => mean => :OzonioMedio,
	#     :Ozone => maximum => :OzonioMax
	# )
	# sort!(df_mensal, :Mes)
	# (dias_criticos = nrow(df_criticos), resumo_mensal = df_mensal)
	nothing
end

# ╔═╡ f1600000-0000-0000-0000-000000000014
md"""
### Visualização Exploratória (`Plots.jl` e `StatsPlots.jl`)

Relembrando os padrões da disciplina:
- `histogram(vetor, bins=...)`: inspeciona a distribuição de uma variável contínua;
- `@df tabela boxplot(:Grupo, :Variavel)`: compara distribuições entre categorias;
- `@df tabela scatter(:X, :Y, group=:Grupo)`: visualiza relações bivariadas coloridas por grupo;
- `plot(p1, p2, p3, p4, layout=(2, 2))`: organiza múltiplos gráficos em uma grade.
"""

# ╔═╡ f1600000-0000-0000-0000-000000000015
let
	# PRÁTICA 4: Monte o painel exploratório 2×2 (substitua o retorno `p4` pelo `plot(...)` completo)
	# Dica 1: Histograma da concentração de ozônio:
	# p1 = histogram(df_ar.Ozone, bins=15, color=:teal, leg=false,
	#                title="Distribuição do Ozônio", xlabel="Ozônio (ppb)", ylabel="Frequência")
	#
	# Dica 2: Histograma da temperatura em °C:
	# p2 = histogram(df_ar.TempC, bins=12, color=:darkorange, leg=false,
	#                title="Distribuição da Temperatura", xlabel="Temperatura (°C)", ylabel="Frequência")
	#
	# Dica 3: Boxplot mensal usando a macro `@df`:
	# p3 = @df df_ar boxplot(:Mes, :Ozone, leg=false, fillalpha=0.6,
	#                        title="Ozônio por Mês", xlabel="Mês", ylabel="Ozônio (ppb)")
	#
	# Pré-visualização ativa (dispersão TempC vs Ozone por mês):
	p4 = @df df_ar scatter(:TempC, :Ozone, group=:Mes, markersize=5, alpha=0.85,
	                       title="Ozônio vs Temperatura (°C)",
	                       xlabel="Temperatura (°C)", ylabel="Ozônio (ppb)",
	                       legend=:topleft)

	# Dica 4: Combine os quatro gráficos com `plot(p1, p2, p3, p4, layout=(2, 2), size=(900, 620))`
	p4
end

# ╔═╡ f1600000-0000-0000-0000-000000000016
md"""
---
# Parte 3: Números Aleatórios e Validação Treino/Teste

Recordando a Semana 09 e a Semana 11:
- `Random.seed!(semente)` fixa o estado do gerador pseudoaleatório para garantir **reprodutibilidade**.
- `rand(n)` gera amostras uniformes em ``[0, 1)``. Para mapear para ``[a, b]``, aplicamos a transformação afim ``y = a + (b - a)x``.
- `randn(n)` gera amostras da Normal padrão ``\mathcal{N}(0, 1)``. Para obter ``\mathcal{N}(\mu, \sigma^2)``, calculamos ``X = \mu + \sigma Z``.
- `randperm(n)` gera uma permutação aleatória dos índices ``1, \dots, n`` (amostragem **sem reposição**), ideal para separar o dataset em **Treino (80%)** e **Teste (20%)** sem viés temporal.
"""

# ╔═╡ f1600000-0000-0000-0000-000000000017
let
	# PRÁTICA 5: Revisão de geradores pseudoaleatórios e histogramas de densidade
	# Dica 1: Fixe a semente com `Random.seed!(2026)`
	# Dica 2: Gere 10_000 valores uniformes em [15, 35]:
	# u_amostra = 15.0 .+ (35.0 - 15.0) .* rand(10_000)
	# Dica 3: Gere 10_000 valores normais com média μ = 25.0 e desvio padrão σ = 4.0:
	# z_amostra = 25.0 .+ 4.0 .* randn(10_000)
	# Dica 4: Compare em um painel 1×2 usando `normalize=:pdf`:
	# p_u = histogram(u_amostra, bins=25, normalize=:pdf, color=:steelblue, leg=false,
	#                 title="Uniforme [15, 35]", xlabel="x", ylabel="Densidade")
	# p_z = histogram(z_amostra, bins=30, normalize=:pdf, color=:firebrick, leg=false,
	#                 title="Normal(25, 4²)", xlabel="x", ylabel="Densidade")
	# plot(p_u, p_z, layout=(1, 2), size=(820, 320))
	nothing
end

# ╔═╡ f1600000-0000-0000-0000-000000000018
begin
	# Variáveis de modelagem: Temperatura (°C) -> Ozônio (ppb)
	x_all = Float64.(df_ar.TempC)
	y_all = Float64.(df_ar.Ozone)
	n_total = length(x_all)

	# Partição aleatória reprodutível (80% treino / 20% teste)
	Random.seed!(42)
	ordem_aleatoria = randperm(n_total)
	n_treino = round(Int, 0.8 * n_total)

	idx_treino = ordem_aleatoria[1:n_treino]
	idx_teste  = ordem_aleatoria[(n_treino + 1):end]

	x_treino, y_treino = x_all[idx_treino], y_all[idx_treino]
	x_teste,  y_teste  = x_all[idx_teste],  y_all[idx_teste]

	p_split = scatter(x_treino, y_treino, label="Treino (n = $n_treino)",
	                  color=:steelblue, markersize=5, alpha=0.85,
	                  xlabel="Temperatura (°C)", ylabel="Ozônio (ppb)",
	                  title="Divisão Aleatória: Treino (80%) vs Teste (20%)",
	                  legend=:topleft)
	scatter!(p_split, x_teste, y_teste, label="Teste (n = $(n_total - n_treino))",
	         color=:darkorange, marker=:diamond, markersize=6, alpha=0.9)
	p_split
end

# ╔═╡ f1600000-0000-0000-0000-000000000019
md"""
---
# Parte 4: Álgebra Linear e Ajuste por Quadrados Mínimos

Queremos ajustar um polinômio de grau ``d`` aos ``m`` pares de treino ``(x_i, y_i)``:

```math
p(x) = c_0 + c_1 x + c_2 x^2 + \cdots + c_d x^d.
```

Como temos muito mais observações do que parâmetros (``m > d + 1``), obtemos o sistema linear **sobredeterminado** ``V c \approx y``, em que ``V \in \mathbb{R}^{m \times (d+1)}`` é a **Matriz de Vandermonde** (``V_{i, j+1} = x_i^j`` para ``j = 0, \dots, d``).

### Pontos-chave de Álgebra Linear Numérica
1. **Ordem na memória (*column-major order*):** em Julia, matrizes são armazenadas coluna após coluna na RAM. Ao construir ``V`` com laços `for`, percorrer primeiro as colunas (`for j in 0:grau`) e depois as linhas (`for i in 1:m`) melhora a localidade de cache.
2. **Equações Normais vs. Fatoração QR:** resolver ``(V^T V) c = V^T y`` eleva o número de condição ao quadrado, ``\kappa_2(V^T V) = (\kappa_2(V))^2``, podendo destruir dígitos significativos. Já o operador nativo `V \ y` usa **Fatoração QR**, preservando ``\kappa_2(V)``.
3. **Métrica de erro (RMSE):**

```math
\text{RMSE} = \sqrt{\frac{1}{m}\sum_{i=1}^m (y_i - \hat{y}_i)^2}.
```
"""

# ╔═╡ f1600000-0000-0000-0000-000000000020
begin
	# PRÁTICA 6: Matriz de Vandermonde via laços `for` respeitando column-major order
	function vandermonde_for(x, grau)
		m = length(x)
		V = zeros(Float64, m, grau + 1)
		# Dica 1: Faça o laço externo nas colunas (`for j in 0:grau`)
		# Dica 2: Faça o laço interno nas linhas (`for i in 1:m`)
		# Dica 3: Preencha `V[i, j + 1] = x[i]^j`
		# Dica 4: Retorne `V` e compare com `vandermonde_vec(x_treino, 3)` usando `≈`
		return nothing
	end

	# Versão vetorizada pronta para os experimentos abaixo:
	vandermonde_vec(x, grau) = Float64.(x) .^ (0:grau)'

	# Avaliação numericamente estável via Método de Horner (suporta escalar e vetor):
	function avalia_polinomio(c, x::Number)
		s = 0.0
		for k in length(c):-1:1
			s = s * x + c[k]
		end
		return s
	end
	avalia_polinomio(c, x::AbstractVector) = [avalia_polinomio(c, xi) for xi in x]

	calcula_rmse(y_real, y_prev) = sqrt(mean((y_real .- y_prev) .^ 2))
end

# ╔═╡ f1600000-0000-0000-0000-000000000021
let
	# PRÁTICA 7: Ajuste linear (d = 1) comparando Fatoração QR (`\`) vs Equações Normais
	# Dica 1: Monte a matriz de Vandermonde de grau 1:
	# V1 = vandermonde_vec(x_treino, 1)
	#
	# Dica 2: Calcule os coeficientes pelos dois métodos:
	# c_qr = V1 \ y_treino
	# c_norm = (V1' * V1) \ (V1' * y_treino)
	#
	# Dica 3: Verifique a proximidade entre soluções, o RMSE no teste e o número de condição:
	# rmse_teste = calcula_rmse(y_teste, avalia_polinomio(c_qr, x_teste))
	# (
	#     c_qr = c_qr,
	#     c_norm = c_norm,
	#     diff_coefs = norm(c_qr - c_norm),
	#     rmse_teste = rmse_teste,
	#     cond_V = cond(V1),
	#     cond_VtV = cond(V1' * V1)
	# )
	nothing
end

# ╔═╡ f1600000-0000-0000-0000-000000000022
md"""
### Laboratório Interativo 1 — Quadrados Mínimos Polinomial e Condicionamento

Deslize o grau ``d`` de ``1`` até ``6`` e observe:
1. Em ``d = 1`` há **subajuste** (*underfitting*), ignorando o crescimento acelerado em dias quentes;
2. Em ``d = 2`` ou ``d = 3`` a curva acompanha a tendência física mantendo erro de teste equilibrado;
3. Para graus mais altos, ``\kappa_2(V)`` cresce exponencialmente e as bordas tornam-se mais sensíveis ao ruído.
"""

# ╔═╡ f1600000-0000-0000-0000-000000000023
@bind grau_qm Slider(1:6, default=2, show_value=true)

# ╔═╡ f1600000-0000-0000-0000-000000000024
let
	V_tr = vandermonde_vec(x_treino, grau_qm)
	c_qm = V_tr \ y_treino

	y_prev_tr = avalia_polinomio(c_qm, x_treino)
	y_prev_te = avalia_polinomio(c_qm, x_teste)

	rmse_tr = calcula_rmse(y_treino, y_prev_tr)
	rmse_te = calcula_rmse(y_teste, y_prev_te)
	cond_v  = cond(V_tr)

	x_grade = collect(range(minimum(x_all) - 0.5, maximum(x_all) + 0.5, length=250))
	y_grade = avalia_polinomio(c_qm, x_grade)

	p_qm = scatter(x_treino, y_treino, label="Treino", color=:steelblue, markersize=4.5, alpha=0.8)
	scatter!(p_qm, x_teste, y_teste, label="Teste", color=:darkorange, marker=:diamond, markersize=5.5, alpha=0.9)
	plot!(p_qm, x_grade, y_grade, label="QM Grau $grau_qm", color=:crimson, lw=2.5)
	ylims!(p_qm, -15, 185)
	xlabel!(p_qm, "Temperatura (°C)")
	ylabel!(p_qm, "Ozônio (ppb)")
	title!(p_qm, "Grau $grau_qm | RMSE Treino: $(round(rmse_tr, digits=2)) | Teste: $(round(rmse_te, digits=2)) | cond(V): $(round(cond_v, sigdigits=3))")
	p_qm
end

# ╔═╡ f1600000-0000-0000-0000-000000000025
let
	# PRÁTICA 8: Curva diagnóstica de RMSE (treino vs teste) e cond(V) para graus 1..6
	# Dica 1: Inicialize os vetores de resultados:
	# graus = 1:6
	# erros_treino = Float64[]
	# erros_teste  = Float64[]
	# conds        = Float64[]
	#
	# Dica 2: No laço `for d in graus`, ajuste `c_d = vandermonde_vec(x_treino, d) \ y_treino`
	#         e registre os valores com `push!`
	#
	# Dica 3: Monte o painel lado a lado (`layout=(1, 2)`) com `yscale=:log10` no condicionamento:
	# p_err = plot(graus, erros_treino, marker=:circle, lw=2, label="Treino",
	#              xlabel="Grau d", ylabel="RMSE (ppb)", title="Erro de Ajuste")
	# plot!(p_err, graus, erros_teste, marker=:diamond, lw=2, label="Teste")
	# p_cnd = plot(graus, conds, marker=:square, lw=2, yscale=:log10, leg=false,
	#              xlabel="Grau d", ylabel="cond(V) (log)", title="Condicionamento")
	# plot(p_err, p_cnd, layout=(1, 2), size=(880, 340))
	nothing
end

# ╔═╡ f1600000-0000-0000-0000-000000000026
md"""
---
# Parte 5: Interpolação Polinomial vs. Quadrados Mínimos

Na **Interpolação Polinomial**, exigimos que o polinômio passe **exatamente** por ``k`` nós dados ``(x_1, y_1), \dots, (x_k, y_k)``, ajustando um polinômio de grau ``d = k - 1``. Isso gera um **sistema linear quadrado** ``k \times k``:

```math
V c = y,
```

que podemos resolver com a **Fatoração LU** (`F = lu(V); c = F \ y`).

### Por que precisamos agrupar o dataset por temperatura antes de interpolar?
Se dois dias distintos tiverem exatamente a **mesma temperatura** (``x_i = x_j`` com ``i \neq j``), a matriz ``V`` terá duas linhas idênticas e será **singular** (``\det(V) = 0``), além de ser impossível uma função assumir dois valores diferentes de ozônio na mesma abscissa. Por isso, agregamos primeiro os dados calculando o ozônio médio para cada temperatura única em `df_por_temp`.
"""

# ╔═╡ f1600000-0000-0000-0000-000000000027
begin
	df_por_temp = sort(
		combine(groupby(df_ar, :TempC), :Ozone => mean => :OzoneMedio, nrow => :QtdDias),
		:TempC
	)
	first(df_por_temp, 6)
end

# ╔═╡ f1600000-0000-0000-0000-000000000028
let
	# PRÁTICA 9: Interpolação polinomial via Fatoração LU para k = 5 nós
	# Dica 1: Escolha 5 índices igualmente espaçados em `df_por_temp`:
	# idx = round.(Int, range(1, nrow(df_por_temp), length=5))
	# xn = Float64.(df_por_temp.TempC[idx])
	# yn = Float64.(df_por_temp.OzoneMedio[idx])
	#
	# Dica 2: Monte a Vandermonde quadrada (5×5, grau = 4) e resolva via LU:
	# V_sq = vandermonde_vec(xn, length(xn) - 1)
	# F = lu(V_sq)
	# c_interp = F \ yn
	#
	# Dica 3: Confira o resíduo exato nos nós (ordem de 1e-13 ou menor):
	# erro_nos = norm(V_sq * c_interp - yn, Inf)
	#
	# Dica 4: Plote `df_por_temp`, os 5 nós escolhidos e o polinômio interpolador
	nothing
end

# ╔═╡ f1600000-0000-0000-0000-000000000029
md"""
### Laboratório Interativo 2 — Fenômeno de Runge, Condicionamento e Ruído Aleatório

Use os controles abaixo para experimentar dois efeitos clássicos ao interpolar nós igualmente espaçados:
1. Aumente `n_nos` de ``3`` até ``8`` (com ruído ``0``) para observar o **Fenômeno de Runge** (oscilações acentuadas nos extremos) e a explosão de ``\kappa_2(V_{\text{bruta}})`` na matriz de Vandermonde sem escala.
2. Adicione perturbações normais ``\varepsilon \sim \mathcal{N}(0, \sigma_{\text{ruído}}^2)`` nos nós para comparar a **fragilidade da interpolação** com a **robustez dos Quadrados Mínimos (grau 2)**.

> **Truque numérico adotado no laboratório:** exibimos o condicionamento real `cond(V_bruta)` na escala original em °C, mas resolvemos o sistema `lu(V_norm)` na variável padronizada ``u = (x - \mu_x)/\sigma_x`` para evitar perda de precisão em `Float64` e visualizar fielmente o polinômio interpolador exato.
"""

# ╔═╡ f1600000-0000-0000-0000-000000000030
@bind n_nos Slider(3:8, default=5, show_value=true)

# ╔═╡ f1600000-0000-0000-0000-000000000031
@bind ruido_nos Slider(0.0:1.0:8.0, default=0.0, show_value=true)

# ╔═╡ f1600000-0000-0000-0000-000000000032
let
	# Seleciona `n_nos` nós distintos igualmente espaçados por índice
	idx = round.(Int, range(1, nrow(df_por_temp), length=n_nos))
	xn = Float64.(df_por_temp.TempC[idx])

	Random.seed!(2026)
	yn = Float64.(df_por_temp.OzoneMedio[idx]) .+ ruido_nos .* randn(n_nos)

	# Condicionamento na variável original x (sem padronização)
	V_bruta = vandermonde_vec(xn, n_nos - 1)
	cond_bruta = cond(V_bruta)

	# Padronização u = (x - μx) / σx para resolver o sistema quadrado LU com alta estabilidade
	μx = mean(xn)
	σx = std(xn)
	un = (xn .- μx) ./ σx
	V_norm = vandermonde_vec(un, n_nos - 1)
	F_lu = lu(V_norm)
	c_u = F_lu \ yn
	cond_norm = cond(V_norm)

	# Modelo comparativo por Quadrados Mínimos (grau 2) sobre todos os dados de treino
	c_qm2 = vandermonde_vec(x_treino, 2) \ y_treino

	x_grade = collect(range(minimum(df_por_temp.TempC), maximum(df_por_temp.TempC), length=300))
	u_grade = (x_grade .- μx) ./ σx
	y_interp = avalia_polinomio(c_u, u_grade)
	y_qm2    = avalia_polinomio(c_qm2, x_grade)

	p_comp = scatter(df_por_temp.TempC, df_por_temp.OzoneMedio,
	                 label="Médias observadas (por °C)", color=:gray65, markersize=4, alpha=0.75)
	scatter!(p_comp, xn, yn, label="Nós de interpolação (k = $n_nos)",
	         color=:navy, marker=:circle, markersize=7)
	plot!(p_comp, x_grade, y_qm2, label="Quadrados Mínimos (grau 2)",
	      color=:forestgreen, ls=:dash, lw=2.5)
	plot!(p_comp, x_grade, y_interp, label="Interpolador (grau $(n_nos - 1))",
	      color=:crimson, lw=2.5)
	ylims!(p_comp, -30, 200)
	xlabel!(p_comp, "Temperatura (°C)")
	ylabel!(p_comp, "Ozônio (ppb)")
	title!(p_comp, "k=$n_nos (grau $(n_nos-1)), ruído=$ruido_nos | cond(V_bruta)=$(round(cond_bruta, sigdigits=2)), cond(V_norm)=$(round(cond_norm, sigdigits=2))")
	p_comp
end

# ╔═╡ f1600000-0000-0000-0000-000000000033
md"""
---
# Síntese Comparativa e Desafios Extras

| Critério | Interpolação Polinomial | Quadrados Mínimos (Regressão) |
| :--- | :--- | :--- |
| **Objetivo** | Passar exatamente por todos os ``k`` nós | Minimizar a soma dos resíduos quadráticos ``\|V c - y\|_2^2`` |
| **Sistema Linear** | Quadrado ``k \times k`` (grau ``d = k - 1``) | Sobredeterminado ``m \times (d + 1)`` (``m > d + 1``) |
| **Método no `LinearAlgebra`** | Fatoração LU (`lu(V)`) | Fatoração QR (`V \ y`) |
| **Sensibilidade a Ruído** | Alta (ajusta o ruído e sofre Fenômeno de Runge) | Baixa para graus moderados (filtra o ruído) |
| **Quando usar?** | Funções determinísticas e tabelas de alta precisão | Dados experimentais ruidosos e modelagem preditiva |

### Desafios Extras (Estudo Autônomo)
1. **Desafio Extra A (Célula abaixo):** Ajuste um modelo exponencial ``y(x) = C e^{k x}`` usando linearização logarítmica ``\ln(y) = \ln(C) + k x`` nos dados de treino (relembrando a Semana 13) e compare o RMSE no conjunto de teste com o polinômio de grau ``2``.
2. **Desafio Extra B:** Repita a análise exploratória e o ajuste por Quadrados Mínimos modelando `Ozone` em função da velocidade do vento `WindKmh`. O decaimento observado é melhor explicado por uma reta ou por uma parábola?
"""

# ╔═╡ f1600000-0000-0000-0000-000000000034
let
	# DESAFIO EXTRA A: Ajuste exponencial linearizável y(x) = C * exp(k * x)
	# Dica 1: Como todos os valores de ozônio após limpeza são positivos (Ozone >= 1), aplique:
	# z_tr = log.(y_treino)
	#
	# Dica 2: Monte a matriz linear e resolva via Fatoração QR:
	# A_exp = vandermonde_vec(x_treino, 1)
	# coefs = A_exp \ z_tr
	#
	# Dica 3: Recupere os parâmetros físicos originais:
	# C_est = exp(coefs[1])
	# k_est = coefs[2]
	#
	# Dica 4: Calcule `y_pred_te = C_est .* exp.(k_est .* x_teste)`, avalie `calcula_rmse(y_teste, y_pred_te)`
	#         e plote a curva exponencial comparando com o ajuste quadrático de Quadrados Mínimos
	nothing
end

# ╔═╡ Cell order:
# ╟─f1600000-0000-0000-0000-000000000001
# ╠═f1600000-0000-0000-0000-000000000002
# ╠═f1600000-0000-0000-0000-000000000003
# ╟─f1600000-0000-0000-0000-000000000004
# ╟─f1600000-0000-0000-0000-000000000005
# ╠═f1600000-0000-0000-0000-000000000006
# ╠═f1600000-0000-0000-0000-000000000007
# ╠═f1600000-0000-0000-0000-000000000008
# ╠═f1600000-0000-0000-0000-000000000009
# ╟─f1600000-0000-0000-0000-000000000010
# ╠═f1600000-0000-0000-0000-000000000011
# ╠═f1600000-0000-0000-0000-000000000012
# ╠═f1600000-0000-0000-0000-000000000013
# ╟─f1600000-0000-0000-0000-000000000014
# ╠═f1600000-0000-0000-0000-000000000015
# ╟─f1600000-0000-0000-0000-000000000016
# ╠═f1600000-0000-0000-0000-000000000017
# ╠═f1600000-0000-0000-0000-000000000018
# ╟─f1600000-0000-0000-0000-000000000019
# ╠═f1600000-0000-0000-0000-000000000020
# ╠═f1600000-0000-0000-0000-000000000021
# ╟─f1600000-0000-0000-0000-000000000022
# ╠═f1600000-0000-0000-0000-000000000023
# ╠═f1600000-0000-0000-0000-000000000024
# ╠═f1600000-0000-0000-0000-000000000025
# ╟─f1600000-0000-0000-0000-000000000026
# ╠═f1600000-0000-0000-0000-000000000027
# ╠═f1600000-0000-0000-0000-000000000028
# ╟─f1600000-0000-0000-0000-000000000029
# ╠═f1600000-0000-0000-0000-000000000030
# ╠═f1600000-0000-0000-0000-000000000031
# ╠═f1600000-0000-0000-0000-000000000032
# ╟─f1600000-0000-0000-0000-000000000033
# ╠═f1600000-0000-0000-0000-000000000034
