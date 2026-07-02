### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ 50a068b1-d15f-4b5f-a23b-0342afdb6e6c
# ╠═╡ pluto_cell_id = "50a068b1-d15f-4b5f-a23b-0342afdb6e6c"
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Tarefa 13 - Dualidade e Preços Sombra
"""

# ╔═╡ 2431bf70-4c12-4d67-94d0-d6cee8b5ebb6
# ╠═╡ pluto_cell_id = "2431bf70-4c12-4d67-94d0-d6cee8b5ebb6"
begin
    using JuMP
    using HiGHS
    using PlutoUI
end

# ╔═╡ 7b9b7ae0-0411-4d65-8464-48ed616cfc7a
# ╠═╡ pluto_cell_id = "7b9b7ae0-0411-4d65-8464-48ed616cfc7a"
TableOfContents(title="🧶 Malharia Itoupava")

# ╔═╡ 0d1d0870-ac78-4e4a-a5f5-a657ab470102
# ╠═╡ pluto_cell_id = "0d1d0870-ac78-4e4a-a5f5-a657ab470102"
md"""
# 🧶 Malharia Itoupava

A **Malharia Itoupava**, uma pequena confecção de malhas artesanais do bairro
Itoupava Central, em Blumenau, produz três peças de inverno: **Blusa de Lã**,
**Cachecol** e **Touca**. A produção semanal é limitada pelo estoque disponível de
quatro insumos: lã, horas de tear, aviamentos e linha de acabamento.

Complete as células abaixo para: (1) formular e resolver o problema de produção,
(2) calcular os preços sombra de cada insumo, (3) verificar a folga complementar,
e (4) decidir se vale a pena lançar uma quarta peça, o **Poncho**.

O enunciado completo, com as tarefas numeradas e os critérios de avaliação, está no
PDF anexo no Moodle.

**Entrega:** apenas este notebook (`.jl`), completo e executado, até **07/07**.
Não é necessário nenhum arquivo adicional — a formulação matemática e a resposta
dissertativa devem ficar em células markdown aqui dentro.
"""

# ╔═╡ 48a8fd02-67ce-4f7e-a22a-60fe8bc7e9c2
# ╠═╡ pluto_cell_id = "48a8fd02-67ce-4f7e-a22a-60fe8bc7e9c2"
md"""
## Dados do Problema

**Lucro por unidade:**

| Produto | Lucro (R\$/unidade) |
|:--------|:--------------------:|
| Blusa de Lã (\$x_1\$) | 276,00 |
| Cachecol (\$x_2\$)    | 85,00  |
| Touca (\$x_3\$)       | 78,00  |

**Consumo de insumos por unidade e estoque semanal:**

| Insumo | Blusa de Lã | Cachecol | Touca | Estoque semanal |
|:-------|:-----------:|:--------:|:-----:|:-----------------:|
| Lã (g)          | 400 | 120 | 80 | **52.000 g** |
| Tear (min)      | 70  | 25  | 35 | **12.000 min** |
| Aviamentos (un) | 4   | 1   | 2  | **600 un**   |
| Linha (m)       | 20  | 8   | 6  | **4.000 m**  |
"""

# ╔═╡ a14358a3-deaa-44c1-a4bf-b6154ddd8a43
# ╠═╡ pluto_cell_id = "a14358a3-deaa-44c1-a4bf-b6154ddd8a43"
md"""
## Proposta de um quarto produto: o Poncho

A proprietária está avaliando lançar o **Poncho**. Consumo por unidade e lucro
estimado:

| Insumo | Consumo por Poncho |
|:-------|:--------------------:|
| Lã         | 350 g |
| Tear       | 60 min |
| Aviamentos | 3 un |
| Linha      | 15 m |
| **Lucro estimado** | **R\$ 230,00/unidade** |
"""

# ╔═╡ f65cdcd1-9603-4f65-9ee7-daf2d4d20576
# ╠═╡ pluto_cell_id = "f65cdcd1-9603-4f65-9ee7-daf2d4d20576"
md"""
## Item 1 — Formulação Matemática

Escreva abaixo, na própria célula (edite o texto entre `\begin{aligned}` e
`\end{aligned}`), o modelo de Programação Linear completo — função objetivo e
restrições — para os três produtos atuais (**não inclua o Poncho aqui**). Use
\$x_1\$, \$x_2\$, \$x_3\$ como nas seções anteriores.
"""

# ╔═╡ 0a47b4a4-7211-45aa-b7ed-c8130fb8524c
# ╠═╡ pluto_cell_id = "0a47b4a4-7211-45aa-b7ed-c8130fb8524c"
md"""
```math
\begin{aligned}
\text{Maximizar } \quad & Z = \; ??? \\
\text{Sujeito a:} \quad & \\
& ??? \quad \text{(Lã)} \\
& ??? \quad \text{(Tear)} \\
& ??? \quad \text{(Aviamentos)} \\
& ??? \quad \text{(Linha)} \\
& x_1, x_2, x_3 \ge 0
\end{aligned}
```
"""

# ╔═╡ 28f5b124-c1a8-4b1a-8f3e-5cebe4a7f3aa
# ╠═╡ pluto_cell_id = "28f5b124-c1a8-4b1a-8f3e-5cebe4a7f3aa"
md"""
## Item 2 — Solução com JuMP

Complete a célula abaixo com a implementação do modelo (apenas os três produtos
atuais — **não inclua o Poncho aqui**).

**Use exatamente estes nomes**, para que as células seguintes funcionem sem
alterações:

- Variáveis: `x1` (Blusa de Lã), `x2` (Cachecol), `x3` (Touca)
- Restrições: `c_la`, `c_tear`, `c_aviamentos`, `c_linha`
"""

# ╔═╡ 28f5b124-90d8-4cac-9c39-6ebeb2037548
# ╠═╡ pluto_cell_id = "28f5b124-90d8-4cac-9c39-6ebeb2037548"
begin
    # 1. Modelo
    malharia = Model(HiGHS.Optimizer)

    # 2. Variáveis de decisão
    # @variable(malharia, x1 >= 0)   # Blusa de Lã
    # @variable(malharia, x2 >= 0)   # Cachecol
    # @variable(malharia, x3 >= 0)   # Touca

    # 3. Função objetivo (maximizar lucro)
    # @objective(malharia, Max, ???)

    # 4. Restrições de estoque
    # @constraint(malharia, c_la, ??? <= 52000)
    # @constraint(malharia, c_tear, ??? <= 12000)
    # @constraint(malharia, c_aviamentos, ??? <= 600)
    # @constraint(malharia, c_linha, ??? <= 4000)

    # 5. Otimizar
    optimize!(malharia)
end

# ╔═╡ aec0e01c-1c42-4a67-8c19-e086b8f4d980
# ╠═╡ pluto_cell_id = "aec0e01c-1c42-4a67-8c19-e086b8f4d980"
md"""
### 🏁 Plano de Produção Ótimo

* **Blusa de Lã:** $(value(x1)) un
* **Cachecol:** $(value(x2)) un
* **Touca:** $(value(x3)) un

**Lucro Máximo:** R\$ $(objective_value(malharia))
"""

# ╔═╡ 4594e081-add5-4d48-b2a3-6549ee206abd
# ╠═╡ pluto_cell_id = "4594e081-add5-4d48-b2a3-6549ee206abd"
md"""
## Item 3 — Preços Sombra

Complete a célula abaixo para obter o preço sombra de cada insumo.
"""

# ╔═╡ 9ff06927-c987-4308-aca6-e1d0ae4f746c
# ╠═╡ pluto_cell_id = "9ff06927-c987-4308-aca6-e1d0ae4f746c"
begin
    # y_la = shadow_price(c_la)
    # y_tear = shadow_price(c_tear)
    # y_aviamentos = shadow_price(c_aviamentos)
    # y_linha = shadow_price(c_linha)

    # Descomente e rode para ver os quatro valores, por exemplo:
    # (y_la, y_tear, y_aviamentos, y_linha)
end

# ╔═╡ 2cbdf554-dd07-4edb-990c-45f7348f720e
# ╠═╡ pluto_cell_id = "2cbdf554-dd07-4edb-990c-45f7348f720e"
md"""
## Item 4 — A Visita da Tia Marlene

Imagine que a **Tia Marlene**, dona de uma malharia concorrente no bairro
Itoupava Norte, aparece na Malharia Itoupava e diz:

> *"Não quero mais nenhuma peça sua essa semana — quero comprar todo o seu
> estoque de insumos, e pago um preço justo por cada um."*

Usando os preços sombra que você calculou no Item 3, responda (em texto, logo
abaixo):

(a) Para quais insumos a Tia Marlene precisaria oferecer um preço **positivo**
para convencer a Malharia Itoupava a vender em vez de produzir?

(b) Existe algum insumo que a Malharia venderia até de graça? Por quê?

(c) O que isso te diz sobre a relação entre "sobrar estoque" e "quanto vale
aquele insumo"?

A função auxiliar abaixo já está pronta — ela recebe o nome do insumo, a
restrição correspondente e o estoque total, e diz se ele foi esgotado ou se
sobrou estoque. Use-a para te ajudar a responder (a)-(c).
"""

# ╔═╡ 597b6181-1564-48ae-9b8d-6edf5077f61b
# ╠═╡ pluto_cell_id = "597b6181-1564-48ae-9b8d-6edf5077f61b"
begin
    function analisar_recurso(nome, restricao, estoque_total)
        usado = value(restricao)
        folga = estoque_total - usado
        status = folga < 1e-5 ? "ESGOTADO (folga = 0)" : "SOBROU $(folga)"
        return "- **$nome**: usado $usado / $estoque_total → $status"
    end

    # md"""
    # $(Markdown.parse(analisar_recurso("Lã", c_la, 52000)))
    # $(Markdown.parse(analisar_recurso("Tear", c_tear, 12000)))
    # $(Markdown.parse(analisar_recurso("Aviamentos", c_aviamentos, 600)))
    # $(Markdown.parse(analisar_recurso("Linha", c_linha, 4000)))
    # """
end

# ╔═╡ 5e9ca595-7233-4455-8e5c-962fc6e81ef1
# ╠═╡ pluto_cell_id = "5e9ca595-7233-4455-8e5c-962fc6e81ef1"
md"""
_Escreva aqui sua resposta aos itens (a), (b) e (c) do Item 4._
"""

# ╔═╡ b4dd7df0-9aac-4ff8-81ec-da5e032f8d22
# ╠═╡ pluto_cell_id = "b4dd7df0-9aac-4ff8-81ec-da5e032f8d22"
md"""
## Item 5 — Vale a pena produzir o Poncho?

Usando **apenas** os preços sombra do Item 3 — **sem reotimizar** o modelo com
quatro produtos — calcule o custo de oportunidade do Poncho e compare com o
lucro estimado de R\$ 230,00.
"""

# ╔═╡ 50a068b1-2222-4b5f-a23b-0342afdb6e6d
# ╠═╡ pluto_cell_id = "50a068b1-2222-4b5f-a23b-0342afdb6e6d"
begin
    # custo_oportunidade_poncho = 350*y_la + 60*y_tear + 3*y_aviamentos + 15*y_linha
    # lucro_poncho = 230.00
    # decisao_poncho = lucro_poncho >= custo_oportunidade_poncho ? "SIM, vale a pena" : "NÃO vale a pena"
end

# ╔═╡ aec0e01c-3333-4a67-8c19-e086b8f4d981
# ╠═╡ pluto_cell_id = "aec0e01c-3333-4a67-8c19-e086b8f4d981"
md"""
## Item 6 — Interpretação Econômica

_Escreva aqui sua resposta dissertativa (5 a 10 linhas): o que significa o preço
sombra de um insumo para a Malharia Itoupava, e em qual insumo a proprietária
deveria priorizar investimento?_
"""

# ╔═╡ Cell order:
# ╠═50a068b1-d15f-4b5f-a23b-0342afdb6e6c
# ╠═2431bf70-4c12-4d67-94d0-d6cee8b5ebb6
# ╠═7b9b7ae0-0411-4d65-8464-48ed616cfc7a
# ╠═0d1d0870-ac78-4e4a-a5f5-a657ab470102
# ╠═48a8fd02-67ce-4f7e-a22a-60fe8bc7e9c2
# ╠═a14358a3-deaa-44c1-a4bf-b6154ddd8a43
# ╠═f65cdcd1-9603-4f65-9ee7-daf2d4d20576
# ╠═0a47b4a4-7211-45aa-b7ed-c8130fb8524c
# ╠═28f5b124-c1a8-4b1a-8f3e-5cebe4a7f3aa
# ╠═28f5b124-90d8-4cac-9c39-6ebeb2037548
# ╠═aec0e01c-1c42-4a67-8c19-e086b8f4d980
# ╠═4594e081-add5-4d48-b2a3-6549ee206abd
# ╠═9ff06927-c987-4308-aca6-e1d0ae4f746c
# ╠═2cbdf554-dd07-4edb-990c-45f7348f720e
# ╠═597b6181-1564-48ae-9b8d-6edf5077f61b
# ╠═5e9ca595-7233-4455-8e5c-962fc6e81ef1
# ╠═b4dd7df0-9aac-4ff8-81ec-da5e032f8d22
# ╠═50a068b1-2222-4b5f-a23b-0342afdb6e6d
# ╠═aec0e01c-3333-4a67-8c19-e086b8f4d981
