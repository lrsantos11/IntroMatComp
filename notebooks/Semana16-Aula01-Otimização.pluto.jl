### A Pluto.jl notebook ###
# v0.20.27

using Markdown
using InteractiveUtils

# ╔═╡ d4fe42a4-cf1a-11f0-926b-a9c86a22502c
# ╠═╡ pluto_cell_id = "d4fe42a4-cf1a-11f0-926b-a9c86a22502c"
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Semana 16 - Aula 01
"""

# ╔═╡ 96428adf-9fff-4b78-881b-64a089c0c64d
# ╠═╡ pluto_cell_id = "96428adf-9fff-4b78-881b-64a089c0c64d"
md"""
# 🍺 Otimização na Cervejaria _OtimizaBier_ de Blumenau/SC
## Introdução à Modelagem com JuMP
"""

# ╔═╡ 2eab799b-2bba-411a-840c-101e20daa8c9
# ╠═╡ pluto_cell_id = "2eab799b-2bba-411a-840c-101e20daa8c9"


# ╔═╡ 8cfd4d11-b4c8-4b92-bd36-d6c5f90f26c8
# ╠═╡ pluto_cell_id = "8cfd4d11-b4c8-4b92-bd36-d6c5f90f26c8"
begin
    using JuMP #Modelagem Matemática (Julia Mathematical Programming)
    using HiGHS # Solver de Programação Linear Open source
    using Plots
    using PlutoUI
end

# ╔═╡ 56de9f54-57e4-4f28-8716-0c979613a115
# ╠═╡ pluto_cell_id = "56de9f54-57e4-4f28-8716-0c979613a115"
md"""
### O Problema da Semana

Você é o gerente de produção da *OtimizaBier*, uma microcervejaria localizada no Garcia, perto das nascentes da Nova Rússia. Vocês produzem dois tipos de cerveja:

1.  **IPA (India Pale Ale):** Lucro de **R$ 5,00** por litro.
2.  **Pilsen:** Lucro de **R$ 3,00** por litro.

Para a produção desta semana, você tem os seguintes estoques limitados:
* **Malte:** 75 kg.
* **Lúpulo:** 100 g.
* **Água da Nova Rússia:** Devido a limitações de transporte do caminhão-pipa, só conseguimos buscar **70 Litros** dessa água especial por semana.

**Receitas (Consumo por Litro):**

|Ingrediente         | IPA ($x_1$)    | Pilsen ($x_2$) | Estoque Total |
|:-------------|:----------|:--------------------------|:--------------------------|
| Malte | 2 kg | 1 kg | **75 kg** |
| Lúpulo | 4 g | 1 g | **100 g** |
| Água | 1 L | 1 L | **70 L** |s

**Objetivo:** Decidir quantos litros de IPA ($x_1$) e Pilsen ($x_2$) produzir para **MAXIMIZAR O LUCRO**.

"""

# ╔═╡ 24e44249-8e7a-446e-ac4e-9947d2c35558
# ╠═╡ pluto_cell_id = "24e44249-8e7a-446e-ac4e-9947d2c35558"
md"""
### 1. Modelo Matemático

```math
\begin{aligned}
\text{Maximizar } \quad & Z = 5x_1 + 3x_2 \\
\text{Sujeito a:} \quad & \\
& 2x_1 + 1x_2 \le 75 \quad \text{(Restrição de Malte)} \\
& 4x_1 + 1x_2 \le 100 \quad \text{(Restrição de Lúpulo)} \\
& 1x_1 + 1x_2 \le 70 \quad \text{(Restrição da Água Nova Rússia)} \\
& x_1, x_2 \ge 0 \quad \quad \text{(Não-negatividade)}
\end{aligned}
```
"""

# ╔═╡ 2e982223-71d7-48da-bb0d-ff3bbd859af0
# ╠═╡ pluto_cell_id = "2e982223-71d7-48da-bb0d-ff3bbd859af0"
begin
    # 1. Criar o modelo escolhendo o Solver (HiGHS)
    cervejaria = Model(HiGHS.Optimizer)

    # 2. Definir as Variáveis de Decisão (com limites inferiores)
    @variable(cervejaria, ipa ≥ 0) # IPA
    @variable(cervejaria, pilsen ≥ 0) # Pilsen

    # 3. Definir a Função Objetivo (Maximizar Lucro)
    @objective(cervejaria, Max, 5*ipa + 3*pilsen)

    # 4. Adicionar as Restrições
    # Dica didática: Nomear as restrições ajuda a debuggar e ler o Dual depois
    @constraint(cervejaria, c_malte, 2*ipa + 1*pilsen ≤ 75)
    @constraint(cervejaria, c_lupulo, 4*ipa + 1*pilsen ≤ 100)
    @constraint(cervejaria, c_agua, 1*ipa + 1*pilsen ≤ 70)

    # 5. Otimizar (O Solver trabalha aqui)
    optimize!(cervejaria)
end

# ╔═╡ de0b34f2-0bb4-47c4-92d8-a3337f583552
# ╠═╡ pluto_cell_id = "de0b34f2-0bb4-47c4-92d8-a3337f583552"
# Retornando um texto formatado para o aluno ver o resultado
md"""
### 🏁 Solução Ótima Encontrada:

* **IPA ($x_1$):** $(value(ipa)) Litros
* **Pilsen ($x_2$):** $(value(pilsen)) Litros
* **LUCRO MÁXIMO:** R$ $(objective_value(cervejaria))



#### Análise de Estoque
- Malte usado: $(value(2*ipa + pilsen)) / 75
- Lúpulo usado: $(value(4*ipa + pilsen)) / 100
- Água usada:  $(value(ipa + pilsen)) / 70

"""

# ╔═╡ 8104d2c1-9f65-4fb2-83a3-028a91ea287b
# ╠═╡ pluto_cell_id = "8104d2c1-9f65-4fb2-83a3-028a91ea287b"
value(ipa)

# ╔═╡ a49cf50e-4f25-4dc5-806c-077dba52f835
# ╠═╡ pluto_cell_id = "a49cf50e-4f25-4dc5-806c-077dba52f835"
value(pilsen)

# ╔═╡ 159294ba-d4b2-4068-aac5-4df2ca604b14
# ╠═╡ pluto_cell_id = "159294ba-d4b2-4068-aac5-4df2ca604b14"
objective_value(cervejaria)

# ╔═╡ cebdb37b-0199-4a81-8dce-ea264612ca92
# ╠═╡ pluto_cell_id = "cebdb37b-0199-4a81-8dce-ea264612ca92"
begin
    # Isolando x2 nas equações para plotar (y = mx + b)

    # Malte: 2x1 + x2 <= 75  -> x2 <= 75 - 2x1
    r_malte(x) = 75 - 2x

    # Lúpulo: 4x1 + x2 <= 100 -> x2 <= 100 - 4x1
    r_lupulo(x) = 100 - 4x

    # Água: x1 + x2 <= 70    -> x2 <= 70 - x1
    r_agua(x) = 70 - x

    # Função que define o teto da Região Viável
    # É o MÍNIMO de todas as restrições (e deve ser maior que zero)
    regiao_viavel(x) = max(0, min(r_malte(x), r_lupulo(x), r_agua(x)))
end

# ╔═╡ 34042f00-995a-4e84-bdf2-dcf043431211
# ╠═╡ pluto_cell_id = "34042f00-995a-4e84-bdf2-dcf043431211"
@bind lucro_alvo Slider(0:400, default=400, show_value=true)

# ╔═╡ 796bc66c-16cc-4e80-b756-73ab3e2930d5
# ╠═╡ pluto_cell_id = "796bc66c-16cc-4e80-b756-73ab3e2930d5"
begin
    # Definindo o domínio do gráfico (eixo X)
    x_range = 0:30

    # Criando o plot base
    p = plot(title="Região Viável e Solução Ótima",
        xlabel="Litros de IPA (ipa)", ylabel="Litros de Pilsen (pilsen)",
        legend=:topright, size=(600, 400))

    # 1. Plotar a Região Viável (Preenchida)
    plot!(regiao_viavel, 0, 30, fillrange=0, fillalpha=0.2,
        color=:pink, label="Região Viável", linewidth=0)

    # 2. Plotar as linhas das restrições (Tracejadas)
    plot!(p, x_range, r_malte, label="Restrição Malte", style=:dash, color=:red)
    plot!(p, x_range, r_lupulo, label="Restrição Lúpulo", style=:dash, color=:green)
    plot!(p, x_range, r_agua, label="Restrição Água", style=:dash, color=:blue, linewidth=2)

    # 3. Plotar a Reta de Lucro (Isolucro) baseada no Slider
    # Z = 5x1 + 3x2  ->  3x2 = Z - 5x1  ->  x2 = (Z - 5x1)/3
    r_lucro(x) = (lucro_alvo - 5x)/3
    plot!(p, x_range, r_lucro, label="Lucro Z = $(lucro_alvo)", color=:orange, linewidth=2)

    # 4. Marcar o Ponto Ótimo encontrado pelo JuMP
    scatter!(p, [value(ipa)], [value(pilsen)], label="SOLUÇÃO ÓTIMA",
        color=:black, markersize=6)

    # Ajustando limites para focar na área de interesse
    plot!(p, xlims=(0, 30), ylims=(0, 110))

    p
end

# ╔═╡ be8df83e-37de-42b3-9415-ed847df4a24f
# ╠═╡ pluto_cell_id = "be8df83e-37de-42b3-9415-ed847df4a24f"


# ╔═╡ Cell order:
# ╠═d4fe42a4-cf1a-11f0-926b-a9c86a22502c
# ╠═96428adf-9fff-4b78-881b-64a089c0c64d
# ╠═2eab799b-2bba-411a-840c-101e20daa8c9
# ╠═8cfd4d11-b4c8-4b92-bd36-d6c5f90f26c8
# ╠═56de9f54-57e4-4f28-8716-0c979613a115
# ╠═24e44249-8e7a-446e-ac4e-9947d2c35558
# ╠═2e982223-71d7-48da-bb0d-ff3bbd859af0
# ╠═de0b34f2-0bb4-47c4-92d8-a3337f583552
# ╠═8104d2c1-9f65-4fb2-83a3-028a91ea287b
# ╠═a49cf50e-4f25-4dc5-806c-077dba52f835
# ╠═159294ba-d4b2-4068-aac5-4df2ca604b14
# ╠═cebdb37b-0199-4a81-8dce-ea264612ca92
# ╠═34042f00-995a-4e84-bdf2-dcf043431211
# ╠═796bc66c-16cc-4e80-b756-73ab3e2930d5
# ╠═be8df83e-37de-42b3-9415-ed847df4a24f
