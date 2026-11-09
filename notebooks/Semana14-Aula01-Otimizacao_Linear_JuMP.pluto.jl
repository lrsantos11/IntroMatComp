### A Pluto.jl notebook ###
# v0.20.27

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

# ╔═╡ e1000000-0000-0000-0000-000000000001
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Semana 14 - Aula 01: Introdução à Programação Linear com JuMP
"""

# ╔═╡ e1000000-0000-0000-0000-000000000002
md"""
# 🍺 Otimização na Cervejaria _OtimizaBier_ de Blumenau/SC
## Modelagem Matemática, Solver HiGHS e Resolução Gráfica com JuMP
"""

# ╔═╡ e1000000-0000-0000-0000-000000000003
begin
	using JuMP
	using HiGHS
	using Plots
	using PlutoUI
end

# ╔═╡ e1000000-0000-0000-0000-000000000004
md"""
### O Cenário Prático

Você é o gerente de produção da **OtimizaBier**, uma microcervejaria artesanal localizada no bairro Garcia, próxima às nascentes da Nova Rússia em Blumenau/SC. A cervejaria produz dois rótulos consagrados:

1. **IPA (India Pale Ale):** cerveja com perfil aromático marcante, margem de lucro de **R$ 5,00 por litro**.
2. **Pilsen:** cerveja leve e de alta saída, margem de lucro de **R$ 3,00 por litro**.

Para a produção do lote semanal, a fábrica dispõe de estoques limitados de matérias-primas:
- **Malte Especial:** 75 kg disponíveis em estoque.
- **Lúpulo Aromático:** 100 g disponíveis em estoque.
- **Água Cristalina da Nova Rússia:** devido à capacidade do transporte em caminhão-pipa térmico, o limite semanal é de **70 Litros**.

#### Tabela de Receitas e Consumo por Litro

| Insumo | Consumo IPA (``x_1``) | Consumo Pilsen (``x_2``) | Estoque Total Disponível |
| :--- | :--- | :--- | :--- |
| **Malte** | 2 kg / L | 1 kg / L | **75 kg** |
| **Lúpulo** | 4 g / L | 1 g / L | **100 g** |
| **Água da Nova Rússia** | 1 L / L | 1 L / L | **70 L** |

**Objetivo:** Determinar a quantidade ideal de litros de IPA (``x_1``) e de Pilsen (``x_2``) a produzir, respeitando as limitações de capacidade, de modo a **maximizar o lucro semanal**.
"""

# ╔═╡ e1000000-0000-0000-0000-000000000005
md"""
### 1. Formulação Matemática: Problema de Programação Linear (PPL)

Denotando as variáveis de decisão por:
- ``x_1``: volume de cerveja IPA a ser produzido (em litros);
- ``x_2``: volume de cerveja Pilsen a ser produzido (em litros).

O modelo matemático na forma padrão de maximização é dado por:

```math
\begin{aligned}
\text{Maximizar } \quad & Z = 5x_1 + 3x_2 \\
\text{sujeito a:} \quad & \\
& 2x_1 + 1x_2 \le 75 \quad \text{(Restrição de Malte)} \\
& 4x_1 + 1x_2 \le 100 \quad \text{(Restrição de Lúpulo)} \\
& 1x_1 + 1x_2 \le 70 \quad \text{(Restrição de Água)} \\
& x_1 \ge 0, \quad x_2 \ge 0 \quad \text{(Não-negatividade)}
\end{aligned}
```
"""

# ╔═╡ e1000000-0000-0000-0000-000000000006
md"""
### 2. Implementação em Julia com `JuMP.jl` e Solver `HiGHS`

O `JuMP.jl` (*Julia Mathematical Programming*) é uma DSL (*Domain-Specific Language*) de altíssimo desempenho para otimização matemática. Em vez de acoplar seu código a uma sintaxe proprietária de solver, o JuMP serve como camada algébrica unificada: você modela em notação matemática natural e conecta solvers livres (`HiGHS` para Programação Linear/MIP, `Ipopt` para Não-Linear) de forma intercambiável.
"""

# ╔═╡ e1000000-0000-0000-0000-000000000007
begin
	# 1. Instanciar o modelo escolhendo o Solver (HiGHS):
	cervejaria = Model(HiGHS.Optimizer)
	set_silent(cervejaria) # Oculta os logs detalhados do solver no console

	# 2. Definir as Variáveis de Decisão com limites de não-negatividade (≥ 0):
	# Dica: use a macro @variable(cervejaria, ...)
	# @variable(cervejaria, ipa ≥ 0)
	# @variable(cervejaria, pilsen ≥ 0)

	# 3. Definir a Função Objetivo de Maximização:
	# Dica: use @objective(cervejaria, Max, ...)
	# @objective(cervejaria, Max, 5 * ipa + 3 * pilsen)

	# 4. Adicionar as Restrições Lineares nomeadas:
	# Dica: @constraint(cervejaria, nome_restricao, expressao)
	# @constraint(cervejaria, c_malte, 2 * ipa + 1 * pilsen ≤ 75)
	# @constraint(cervejaria, c_lupulo, 4 * ipa + 1 * pilsen ≤ 100)
	# @constraint(cervejaria, c_agua, 1 * ipa + 1 * pilsen ≤ 70)

	# 5. Resolver o problema:
	# optimize!(cervejaria)

	return nothing
end

# ╔═╡ e1000000-0000-0000-0000-000000000008
md"""
### 3. Inspeção da Solução Ótima e Consumo dos Estoques
"""

# ╔═╡ e1000000-0000-0000-0000-000000000009
let
	# Após otimizar o modelo acima, obtenha as respostas com:
	# litros_ipa = value(ipa)
	# litros_pilsen = value(pilsen)
	# lucro_otimo = objective_value(cervejaria)

	# Calcule o consumo real de cada recurso e determine se houve folga:
	# malte_usado = 2 * litros_ipa + litros_pilsen
	# lupulo_usado = 4 * litros_ipa + litros_pilsen
	# agua_usada = litros_ipa + litros_pilsen

	return nothing
end

# ╔═╡ e1000000-0000-0000-0000-000000000010
md"""
### 4. Interpretação Geométrica e Simplex Interativo

Em problemas bidimensionais (duas variáveis ``x_1, x_2``), a região viável é um poliedro convexo no primeiro quadrante.
Isolando ``x_2`` (eixo vertical) em cada fronteira:
- **Malte:** ``2x_1 + x_2 = 75 \implies x_2 = 75 - 2x_1``;
- **Lúpulo:** ``4x_1 + x_2 = 100 \implies x_2 = 100 - 4x_1``;
- **Água:** ``x_1 + x_2 = 70 \implies x_2 = 70 - x_1``;
- **Reta de Isolucro:** ``5x_1 + 3x_2 = Z \implies x_2 = \frac{Z - 5x_1}{3}``.

Use o slider interativo abaixo para variar o **lucro alvo ``Z``**. Veja a reta de nível atravessar a região viável até o último vértice de contato, exatamente no ponto ótimo ``(5.0, 65.0)`` com ``Z = 220.00``:
"""

# ╔═╡ e1000000-0000-0000-0000-000000000011
@bind lucro_alvo Slider(0.0:5.0:260.0, default=220.0, show_value=true)

# ╔═╡ e1000000-0000-0000-0000-000000000012
begin
	# 1. Equações das retas de restrição:
	r_malte(x)  = 75.0 - 2.0 * x
	r_lupulo(x) = 100.0 - 4.0 * x
	r_agua(x)   = 70.0 - x

	# Teto da Região Viável: menor valor das restrições e não-negativo
	teto_viavel(x) = max(0.0, min(r_malte(x), r_lupulo(x), r_agua(x)))

	# Reta de isolucro correspondente ao valor selecionado no slider:
	r_lucro(x) = (lucro_alvo - 5.0 * x) / 3.0

	x_vals = 0.0:0.2:30.0

	p = plot(title="Região Viável e Reta de Nível (Isolucro)",
	         xlabel="Litros de IPA (x₁)", ylabel="Litros de Pilsen (x₂)",
	         xlims=(0, 28), ylims=(0, 90), legend=:topright, size=(680, 440))

	# 1. Região viável sombreada:
	plot!(p, teto_viavel, 0.0, 25.0, fillrange=0.0, fillalpha=0.25,
	      color=:lightpink, label="Região Viável", lw=0)

	# 2. Retas de capacidade:
	plot!(p, x_vals, r_malte.(x_vals), label="Malte (2x₁ + x₂ ≤ 75)", color=:firebrick, ls=:dash, lw=1.8)
	plot!(p, x_vals, r_lupulo.(x_vals), label="Lúpulo (4x₁ + x₂ ≤ 100)", color=:forestgreen, ls=:dash, lw=1.8)
	plot!(p, x_vals, r_agua.(x_vals), label="Água (x₁ + x₂ ≤ 70)", color=:royalblue, ls=:dash, lw=1.8)

	# 3. Reta dinâmica de isolucro:
	plot!(p, x_vals, r_lucro.(x_vals), label="Isolucro: Z = R\$ $(lucro_alvo)", color=:darkorange, lw=2.5)

	# 4. Solução ótima teórica destacada:
	scatter!(p, [5.0], [65.0], label="Ótimo: (5.0 L, 65.0 L)",
	         color=:black, marker=:star5, markersize=9)

	p
end

# ╔═╡ e1000000-0000-0000-0000-000000000013
md"""
---
### 5. Exercício Prático: Simulação de Cenário e Escassez de Insumo

Suponha que, devido a uma quebra de safra no Vale do Itajaí, o fornecedor só conseguiu entregar **80 g de lúpulo** (em vez dos 100 g originais). Concomitantemente, o preço de venda da IPA subiu no mercado para **R$ 6,00 por litro** (o lucro da Pilsen permanece em R$ 3,00 por litro).

O novo problema de otimização passa a ser:

```math
\begin{aligned}
\text{Maximizar } \quad & Z = 6x_1 + 3x_2 \\
\text{sujeito a:} \quad & \\
& 2x_1 + 1x_2 \le 75 \quad \text{(Malte)} \\
& 4x_1 + 1x_2 \le 80 \quad \text{(Novo limite de Lúpulo)} \\
& 1x_1 + 1x_2 \le 70 \quad \text{(Água)} \\
& x_1 \ge 0, \quad x_2 \ge 0
\end{aligned}
```

**Sua tarefa:**
1. Crie o novo modelo `cenario_crise` no JuMP com o solver `HiGHS`;
2. Encontre a nova alocação ótima de produção e o novo lucro máximo;
3. Inspecione o consumo dos três insumos e responda: qual é o novo gargalo da fábrica e quanto restou de folga de malte e água?
"""

# ╔═╡ e1000000-0000-0000-0000-000000000014
let
	# Complete a resolução do cenário de crise:
	# cenario_crise = Model(HiGHS.Optimizer)
	# set_silent(cenario_crise)
	# @variable(cenario_crise, ipa ≥ 0)
	# @variable(cenario_crise, pilsen ≥ 0)
	# @objective(cenario_crise, Max, 6 * ipa + 3 * pilsen)
	# @constraint(...)
	# optimize!(cenario_crise)

	return nothing
end

# ╔═╡ Cell order:
# ╟─e1000000-0000-0000-0000-000000000001
# ╟─e1000000-0000-0000-0000-000000000002
# ╠═e1000000-0000-0000-0000-000000000003
# ╟─e1000000-0000-0000-0000-000000000004
# ╟─e1000000-0000-0000-0000-000000000005
# ╟─e1000000-0000-0000-0000-000000000006
# ╠═e1000000-0000-0000-0000-000000000007
# ╟─e1000000-0000-0000-0000-000000000008
# ╠═e1000000-0000-0000-0000-000000000009
# ╟─e1000000-0000-0000-0000-000000000010
# ╠═e1000000-0000-0000-0000-000000000011
# ╠═e1000000-0000-0000-0000-000000000012
# ╟─e1000000-0000-0000-0000-000000000013
# ╠═e1000000-0000-0000-0000-000000000014
