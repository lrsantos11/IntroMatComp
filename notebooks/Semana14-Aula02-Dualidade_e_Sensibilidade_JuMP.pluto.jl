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

# ╔═╡ f1000000-0000-0000-0000-000000000001
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Semana 14 - Aula 02: Dualidade, Preço Sombra e Análise de Sensibilidade
"""

# ╔═╡ f1000000-0000-0000-0000-000000000002
md"""
# 🍺 Da Produção à Gestão Estratégica: OtimizaBier
## Preços Sombra, Dualidade e Tomada de Decisão com JuMP
"""

# ╔═╡ f1000000-0000-0000-0000-000000000003
begin
	using JuMP
	using HiGHS
	using Plots
	using PlutoUI
	using Printf
end

# ╔═╡ f1000000-0000-0000-0000-000000000004
md"""
### Revisão da Aula Anterior: O Modelo Primal da OtimizaBier

Na aula passada, determinamos a alocação ótima de produção da fábrica:
- ``x_1``: volume de IPA a produzir (litros)
- ``x_2``: volume de Pilsen a produzir (litros)

```math
\begin{aligned}
\text{Maximizar } \quad & Z = 5x_1 + 3x_2 \\
\text{sujeito a:} \quad & \\
& 2x_1 + 1x_2 \le 75 \quad \text{(c\_malte: 75 kg)} \\
& 4x_1 + 1x_2 \le 100 \quad \text{(c\_lupulo: 100 g)} \\
& 1x_1 + 1x_2 \le 70 \quad \text{(c\_agua: 70 L)} \\
& x_1 \ge 0, \quad x_2 \ge 0
\end{aligned}
```

O solver encontrou a solução ótima ``x_1^* = 5{,}0\text{ L}`` e ``x_2^* = 65{,}0\text{ L}``, gerando um **Lucro Máximo de R\$ 220,00**.

#### A Pergunta Gerencial de Hoje
Se você pudesse comprar uma unidade adicional de matéria-prima, quanto ela agregaria ao seu lucro?
- Vale a pena pagar R\$ 1,50 para ter mais 1 kg de Malte?
- Vale a pena pagar R\$ 0,50 para ter mais 1 L de Água?
- Vale a pena pagar R\$ 0,10 para ter mais 1 g de Lúpulo?

Essa resposta é fornecida rigorosamente pelos **Preços Sombra (*Shadow Prices*)** do problema dual.
"""

# ╔═╡ f1000000-0000-0000-0000-000000000005
begin
	# 1. Resolver o modelo primal nomeando as restrições:
	primal = Model(HiGHS.Optimizer)
	set_silent(primal)

	@variable(primal, ipa ≥ 0)
	@variable(primal, pilsen ≥ 0)

	@objective(primal, Max, 5 * ipa + 3 * pilsen)

	@constraint(primal, c_malte, 2 * ipa + 1 * pilsen ≤ 75)
	@constraint(primal, c_lupulo, 4 * ipa + 1 * pilsen ≤ 100)
	@constraint(primal, c_agua, 1 * ipa + 1 * pilsen ≤ 70)

	optimize!(primal)

	# 2. Complete a recuperação dos Preços Sombra:
	# Dica: use a função shadow_price(restricao)
	# y_malte = shadow_price(c_malte)
	# y_lupulo = ...
	# y_agua = ...

	return nothing
end

# ╔═╡ f1000000-0000-0000-0000-000000000006
md"""
### 1. O Ponto de Vista do "Tio João" (A Formulação Dual) 💰

Imagine que o **Tio João**, proprietário de uma cervejaria vizinha, visita a fábrica e faz a seguinte proposta ao Pedro:
> *"Pedro, não ligue as caldeiras nesta semana. Eu compro todo o seu estoque de matérias-primas hoje mesmo em dinheiro vivo. Diga o preço unitário de cada insumo ($y_1$ para o malte, $y_2$ para o lúpulo, $y_3$ para a água)."*

Para o Pedro aceitar a proposta, a venda dos insumos necessários para fazer cada cerveja deve render **no mínimo** o mesmo lucro que ele obteria vendendo a cerveja pronta:
- Para a IPA: ``2 y_1 + 4 y_2 + 1 y_3 \ge 5`` (R\$ 5,00 de lucro);
- Para a Pilsen: ``1 y_1 + 1 y_2 + 1 y_3 \ge 3`` (R\$ 3,00 de lucro).

Ao mesmo tempo, o Tio João deseja **minimizar o desembolso total** na compra dos estoques:

```math
\begin{aligned}
\text{Minimizar } \quad & W = 75 y_1 + 100 y_2 + 70 y_3 \\
\text{sujeito a:} \quad & \\
& 2 y_1 + 4 y_2 + 1 y_3 \ge 5 \quad \text{(Garantia de lucro da IPA)} \\
& 1 y_1 + 1 y_2 + 1 y_3 \ge 3 \quad \text{(Garantia de lucro da Pilsen)} \\
& y_1 \ge 0, \quad y_2 \ge 0, \quad y_3 \ge 0
\end{aligned}
```

#### O Teorema Forte da Dualidade
Se o problema primal possui solução ótima finita, o dual também possui solução ótima finita e **os valores das funções objetivo coincidem**:
$$Z^* = W^* = \text{R\$ } 220{,}00.$$

Além disso, pelo **Teorema da Folga Complementar**:
- Se sobrou lúpulo no primal (folga de 15 g), seu valor marginal é nulo: ``y_2^* = 0``;
- Se o malte e a água esgotaram (gargalos ativos), seus preços sombra são estritamente positivos: ``y_1^* = 2{,}00`` e ``y_3^* = 1{,}00``.
"""

# ╔═╡ f1000000-0000-0000-0000-000000000007
let
	# Complete a resolução direta do modelo dual com JuMP:
	# dual = Model(HiGHS.Optimizer)
	# set_silent(dual)
	# @variable(dual, y1 >= 0)
	# ...
	return nothing
end

# ╔═╡ f1000000-0000-0000-0000-000000000008
md"""
### 2. Análise de Sensibilidade: Lançamento de um Novo Produto (Cerveja Bock)

O mestre cervejeiro da fábrica propôs introduzir um terceiro rótulo para o inverno: a **Cerveja Bock** (variável ``x_3``), com lucro unitário previsto de **R$ 4,50 por litro**.

A receita da Bock consome por litro:
- 3 kg de Malte;
- 1 g de Lúpulo;
- 1 L de Água.

#### Pergunta de Inteligência de Negócio:
**Vale a pena colocar a cerveja Bock em produção, ou ela canibalizará insumos nobres da IPA e da Pilsen?**

Em vez de refazer a matriz e reotimizar tudo do zero, podemos usar a teoria de **Custos Reduzidos (*Pricing Out*)**:
Calculamos o **Custo de Oportunidade** dos insumos consumidos pela Bock a partir dos preços sombra do mercado dual:
$$\text{Custo de Oportunidade} = 3 y_1^* + 1 y_2^* + 1 y_3^* = 3(2{,}00) + 1(0{,}00) + 1(1{,}00) = \text{R\$ } 7{,}00 / \text{L}.$$

Como produzir 1 litro de Bock consome R\$ 7,00 em matérias-primas valoradas no ótimo e só entrega R\$ 4,50 de lucro, **NÃO vale a pena produzir Bock**!
O custo reduzido é:
$$c_3 - \sum_{i=1}^m a_{i3} y_i^* = 4{,}50 - 7{,}00 = -2{,}50 < 0.$$
"""

# ╔═╡ f1000000-0000-0000-0000-000000000009
let
	# Complete a simulação do modelo com os 3 produtos (IPA, Pilsen e Bock):
	# expandido = Model(HiGHS.Optimizer)
	# set_silent(expandido)
	# ...
	return nothing
end

# ╔═╡ f1000000-0000-0000-0000-000000000010
md"""
---
### 3. Exercício Prático: O Ponto de Virada da Bock

Qual deve ser o preço de venda mínimo da cerveja Bock para que passe a ser economicamente vantajoso produzi-la?
Suponha que a diretoria autorizou um reposicionamento *premium* da Bock para **R$ 8,00 por litro**.

**Sua tarefa:**
1. Verifique analiticamente se o novo lucro (R\$ 8,00) supera o custo de oportunidade (R\$ 7,00);
2. Resolva o novo modelo com JuMP e determine a nova alocação ótima da fábrica;
3. Responda: qual cerveja teve sua produção reduzida para abrir espaço à Bock?
"""

# ╔═╡ f1000000-0000-0000-0000-000000000011
let
	# Complete a resolução com a Bock a R$ 8.00:
	# modelo_premium = Model(HiGHS.Optimizer)
	# ...
	return nothing
end

# ╔═╡ Cell order:
# ╟─f1000000-0000-0000-0000-000000000001
# ╟─f1000000-0000-0000-0000-000000000002
# ╠═f1000000-0000-0000-0000-000000000003
# ╟─f1000000-0000-0000-0000-000000000004
# ╠═f1000000-0000-0000-0000-000000000005
# ╟─f1000000-0000-0000-0000-000000000006
# ╠═f1000000-0000-0000-0000-000000000007
# ╟─f1000000-0000-0000-0000-000000000008
# ╠═f1000000-0000-0000-0000-000000000009
# ╟─f1000000-0000-0000-0000-000000000010
# ╠═f1000000-0000-0000-0000-000000000011
