### A Pluto.jl notebook ###
# v0.20.27

using Markdown
using InteractiveUtils

# ╔═╡ fa000001-0000-4000-8000-000000000001
begin
    using PlutoUI
    using LinearAlgebra
    using DataFrames
end

# ╔═╡ fa000002-0000-4000-8000-000000000002
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos  |  Semana 05 — Aula 01
"""

# ╔═╡ fa000003-0000-4000-8000-000000000003

md"""
# Erros em Algoritmos Numéricos
## Erros absolutos e relativos

Ao implementar algoritmos numéricos encontramos inevitavelmente erros, pois buscamos uma *aproximação $v$* de alguma *solução exata $u$*.

Há dois tipos principais:

- **Erro absoluto:**
```math
E_A = \lvert u - v \rvert
```
- **Erro relativo:**
```math
E_R = \frac{\lvert u - v \rvert}{\lvert u \rvert}, \quad u \neq 0
```

> O erro relativo é mais informativo: é adimensional e independe da escala do problema.
"""

# ╔═╡ fa000019-0000-4000-8000-000000000019

md"""
## 1. Funções de Erro

Usamos `norm` do `LinearAlgebra` para calcular normas (generaliza o valor absoluto para vetores).
"""

# ╔═╡ fa000020-0000-4000-8000-000000000020

Eₐ(u, v) = norm(u - v)              # erro absoluto

# ╔═╡ fa000021-0000-4000-8000-000000000021

Eᵣ(u, v) = norm(u - v) / norm(u)   # erro relativo

# ╔═╡ fa000022-0000-4000-8000-000000000022

md"""
### Exemplo: pares exato/aproximado
"""

# ╔═╡ fa000023-0000-4000-8000-000000000023

u = [1.0, 1.0, -1.5, 100.0, 100.0]

# ╔═╡ fa000024-0000-4000-8000-000000000024

v = [0.99, 1.01, -1.2, 99.99, 99.0]

# ╔═╡ a2a1fabe-c8ec-483c-a02a-397d2c853433

Eₐ(u, v)

# ╔═╡ 936e38fb-7a69-4cad-a5a0-be95e6b0fd06

Eᵣ(u, v)

# ╔═╡ 26947c99-a703-455b-99db-63ce480082cb

Eₐ.(u, v)

# ╔═╡ f8ac4cbe-7ec7-478c-9fe0-954fbe72db91

Eᵣ.(u, v)

# ╔═╡ fa000025-0000-4000-8000-000000000025

md"""
`Eₐ.(u, v)` usa o operador ponto (`.`) para **distribuir** a função sobre os vetores elemento a elemento (*broadcasting*).
"""

# ╔═╡ fa000026-0000-4000-8000-000000000026

df_erros = DataFrame(
    :ValorExato => u,
    :Aproximação => v,
    :ErroAbsoluto => Eₐ.(u, v),
    :ErroRelativo => Eᵣ.(u, v),
)

# ╔═╡ fa000032-0000-4000-8000-000000000032

md"""
## 2. Exemplo: Aproximação de Stirling para $n!$

A fórmula de Stirling:
```math
S_n = \sqrt{2\pi n}\left(\frac{n}{e}\right)^n \approx n!
```
é assintoticamente exata: $S_n / n! \to 1$ quando $n \to \infty$.
"""

# ╔═╡ fa000033-0000-4000-8000-000000000033

Sₙ(n) = sqrt(2π * n) * (n / ℯ)^n   #  e = \euler, π = \pi

# ╔═╡ fa000034-0000-4000-8000-000000000034

@bind n_max Slider(1:20, show_value=true, default=10)

# ╔═╡ fa000035-0000-4000-8000-000000000035

let
    ns = (collect(1:n_max))
    fat = factorial.(ns)
    stir = Sₙ.(ns)
    DataFrame(
        :n => ns,
        :n! => fat,
        :Sₙ => stir,
        :ErroAbsoluto => Eₐ.(fat, stir),
        :ErroRelativo => Eᵣ.(fat, stir),
    )
end

# ╔═╡ fa000036-0000-4000-8000-000000000036

md"""
!!! nota
	O erro *absoluto* cresce com $n$, mas o erro *relativo* decresce — Stirling fica **proporcionalmente** mais preciso para $n$ grande.
"""

# ╔═╡ c3a16d30-bcaa-4db2-b392-abd88d31d60b

md"""
## 3. Propagação de Erro e Instabilidade Numérica

Para ilustrar o impacto letal do erro de arredondamento em sequências numéricas, considere avaliar as integrais:

$$y_n = \int_{0}^{1} \frac{x^n}{x + 10} dx, \quad n = 1, \dots, 30.$$

Resolvendo a integral analiticamente para estabelecer uma relação, deduzimos a **recorrência progressiva**:

$$y_n = \frac{1}{n} - 10y_{n-1}$$

Onde o valor inicial é $y_0 = \ln(11) - \ln(10)$.
"""

# ╔═╡ 3407ef43-bb62-4c61-be42-42355a114560

function seq_progressiva(n_max)
    y = zeros(n_max)
    yzero = log(11) - log(10)
    #  n = 1
    y[1] = 1 - 10 * yzero
    for n = 2:n_max
        y[n] = 1 / n - 10 * y[n-1]
    end
    return y
end

# ╔═╡ aea0972c-e6a8-4dbc-a14c-03444360134e

seq_progressiva(30)

# ╔═╡ 34ceb838-b3fa-4139-9a8e-3f9e1f2fa3b4

DataFrame(:n => 1:30, :y_n => seq_progressiva(30))

# ╔═╡ 4ae08607-3893-4aff-95bd-310acabf11b2

md"""
!!! warning "Explosão do Erro"
    Note na tabela acima como, a partir de $n=18$, os valores começam a oscilar descontroladamente e assumir números gigantescos (e negativos!). Sabemos da integral original que $0 < y_n < 1$. O que aconteceu?
	
    A cada passo, o erro de arredondamento da iteração anterior é **multiplicado por -10**. Deixamos a derivação da solução estável (a recorrência regressiva) como exercício prático!
"""

# ╔═╡ Cell order:
# ╠═fa000001-0000-4000-8000-000000000001
# ╟─fa000002-0000-4000-8000-000000000002
# ╟─fa000003-0000-4000-8000-000000000003
# ╟─fa000019-0000-4000-8000-000000000019
# ╠═fa000020-0000-4000-8000-000000000020
# ╠═fa000021-0000-4000-8000-000000000021
# ╟─fa000022-0000-4000-8000-000000000022
# ╠═fa000023-0000-4000-8000-000000000023
# ╠═fa000024-0000-4000-8000-000000000024
# ╠═a2a1fabe-c8ec-483c-a02a-397d2c853433
# ╠═936e38fb-7a69-4cad-a5a0-be95e6b0fd06
# ╠═26947c99-a703-455b-99db-63ce480082cb
# ╠═f8ac4cbe-7ec7-478c-9fe0-954fbe72db91
# ╟─fa000025-0000-4000-8000-000000000025
# ╠═fa000026-0000-4000-8000-000000000026
# ╟─fa000032-0000-4000-8000-000000000032
# ╠═fa000033-0000-4000-8000-000000000033
# ╠═fa000034-0000-4000-8000-000000000034
# ╠═fa000035-0000-4000-8000-000000000035
# ╟─fa000036-0000-4000-8000-000000000036
# ╟─c3a16d30-bcaa-4db2-b392-abd88d31d60b
# ╠═3407ef43-bb62-4c61-be42-42355a114560
# ╠═aea0972c-e6a8-4dbc-a14c-03444360134e
# ╠═34ceb838-b3fa-4139-9a8e-3f9e1f2fa3b4
# ╟─4ae08607-3893-4aff-95bd-310acabf11b2
