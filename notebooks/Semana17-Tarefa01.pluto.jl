### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ 6624fad2-cf24-11f0-ac06-e9ebf0acea00
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Semana 17 - Tarefa
"""

# ╔═╡ 7d342c7b-f2b7-47d0-9f26-31f32e00ea72
md"""
Nome: (PREENCHER COM SEU NOME AQUI)
"""

# ╔═╡ 759e2874-f0b7-4b99-8ada-ca070571d48b
md"""
# 🎄 Tarefa de Casa: Otimização da Produção Natalina


---

### 1. Contextualização: A Confeitaria "Doce Blumenau"

Você foi contratado para auxiliar no planejamento de produção da *Confeitaria Doce Blumenau* para a semana crítica que antecede o Natal. A gerência precisa definir o **Mix de Produção** ideal para maximizar o lucro, respeitando os estoques limitados de ingredientes e a capacidade operacional da cozinha.

Diferente do problema da Cervejaria visto em aula (que tinha apenas 2 variáveis), aqui temos **4 produtos** competindo pelos mesmos recursos, o que torna a resolução gráfica inviável. Você deverá usar o `JuMP` para encontrar a solução ótima multidimensional.

### 2. Os Dados do Problema

#### Produtos e Lucros (Variáveis de Decisão)
A confeitaria produz quatro itens principais. As variáveis de decisão ($x_i$) representam a quantidade a ser produzida de cada um:

* **$x_1$ - Stollen:** O tradicional bolo de frutas alemão. Lucro estimado: **R$ 25,00 / unidade**.
* **$x_2$ - Panetone de Frutas:** Clássico natalino. Lucro estimado: **R$ 18,00 / unidade**.
* **$x_3$ - Chocotone:** Panetone com gotas de chocolate. Lucro estimado: **R$ 20,00 / unidade**.
* **$x_4$ - Biscoitos Decorados:** Pacote com 200g. Lucro estimado: **R$ 12,00 / pacote**.

#### Receitas e Disponibilidade de Recursos (Restrições)

A tabela abaixo mostra o consumo de ingredientes por unidade produzida e o estoque total disponível para a semana.

| Recurso / Ingrediente | Stollen  | Panetone | Chocotone  | Biscoitos  | **Estoque Disponível** |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Farinha de Trigo** | 500 g | 400 g | 400 g | 200 g | **200 kg** |
| **Açúcar Refinado** | 200 g | 150 g | 150 g | 100 g | **80 kg** |
| **Frutas/Castanhas** | 300 g | 200 g | 0 g | 0 g | **60 kg** |
| **Chocolate** | 0 g | 0 g | 250 g | 50 g | **40 kg** |
| **Tempo de Forno** | 45 min | 40 min | 40 min | 15 min | **400 horas** |

> **⚠️ Atenção às unidades:** Note que o consumo está em **gramas** ou **minutos**, enquanto o estoque está em **kg** ou **horas**. Garanta que seu modelo matemático use a mesma unidade de medida nas inequações (converta tudo para gramas e minutos)!

#### Restrições de Mercado
Além dos ingredientes, o departamento comercial fechou um contrato corporativo que exige a entrega mínima de **50 unidades de Stollen** ($x_1$). O modelo deve respeitar essa exigência.

---

### 3. O que você deve entregar

Neste notebook, adicione células de código e texto para resolver os itens abaixo:

#### A. Modelagem Matemática (Texto)
Escreva o **PPL (Problema de Programação Linear)** formalmente usando notação matemática (LaTeX).
* Defina a Função Objetivo ($Z$).
* Liste todas as restrições (técnicas e de não-negatividade).

#### B. Implementação no JuMP
Implemente o modelo computacionalmente:
1.  Carregue os pacotes `JuMP` e `HiGHS`.
2.  Defina as variáveis (lembre-se do limite inferior do Stollen!).
3.  Implemente a função objetivo e as restrições de recursos.
4.  Otimize o modelo.

#### C. Análise dos Resultados
Use células de texto ou `print()` para responder:
1.  Qual é o **Lucro Máximo** que a confeitaria pode obter nesta semana?
2.  Qual é a quantidade ótima a ser produzida de cada item?
3.  **Análise de Sobras (Folgas):**
    * Todo o estoque de **Chocolate** foi utilizado? Se não, quanto sobrou?
    * Todo o tempo de **Forno** foi utilizado?
    * *Reflexão:* Baseado nisso, se você pudesse comprar mais um ingrediente ou investir em mais equipamentos, qual seria sua prioridade para aumentar o lucro? (Não precisa calcular, apenas argumente baseado nos recursos esgotados).
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.2"
manifest_format = "2.0"
project_hash = "71853c6197a6a7f222db0f1978c7cb232b87c5ee"

[deps]
"""

# ╔═╡ Cell order:
# ╟─6624fad2-cf24-11f0-ac06-e9ebf0acea00
# ╠═7d342c7b-f2b7-47d0-9f26-31f32e00ea72
# ╟─759e2874-f0b7-4b99-8ada-ca070571d48b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
