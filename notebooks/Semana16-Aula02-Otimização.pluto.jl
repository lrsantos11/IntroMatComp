### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ a639d218-d182-11f0-8fb0-5755eed56277
# ╠═╡ pluto_cell_id = "a639d218-d182-11f0-8fb0-5755eed56277"
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Semana 16 - Aula 02
"""

# ╔═╡ 530851f0-6919-475b-b6ca-e75356487bc4
# ╠═╡ pluto_cell_id = "530851f0-6919-475b-b6ca-e75356487bc4"
begin
    using JuMP
    using HiGHS
    using PlutoUI
    using Printf
end

# ╔═╡ 85071236-9f9a-4988-8aef-04748346c8dd
# ╠═╡ pluto_cell_id = "85071236-9f9a-4988-8aef-04748346c8dd"
md"""
# 🎄 Gabarito: Doce Blumenau & 🍺 Otimização Avançada (Dualidade)

Hoje vamos:
1.  Corrigir a tarefa da Confeitaria (4 Variáveis).
2.  Expandir o problema da Cervejaria com uma nova receita (Bock).
3.  Entender o "Preço Sombra" (Quanto vale o seu estoque?).
"""

# ╔═╡ 398a8af1-bca5-406e-a6e1-bb50edea048e
# ╠═╡ pluto_cell_id = "398a8af1-bca5-406e-a6e1-bb50edea048e"
md"""
## Parte 1: Correção da Tarefa "Doce Blumenau" 🍰

A principal "pegadinha" deste exercício era a **Consistência Dimensional**.
As receitas estavam em **gramas** e **minutos**, mas os estoques em **kg** e **horas**.

Para o solver funcionar, precisamos converter tudo para a mesma base (vamos usar gramas e minutos).

* 200 kg de Farinha $\to$ 200.000 g
* 400 horas de Forno $\to$ 24.000 min
"""

# ╔═╡ dc22da63-3703-42ec-a5f2-07387faa95c3
# ╠═╡ pluto_cell_id = "dc22da63-3703-42ec-a5f2-07387faa95c3"
md"""
### 1. Modelo Matemático (PPL)

Sejam as variáveis de decisão:
* ``x_1``: Quantidade de Stollen
* ``x_2``: Quantidade de Panetone de Frutas
* ``x_3``: Quantidade de Chocotone
* ``x_4``: Quantidade de Biscoitos (pacotes)

**Função Objetivo:**
Maximizar o Lucro \$Z\$:
```math
\max Z = 25x_1 + 18x_2 + 20x_3 + 12x_4
```


**Sujeito às restrições:**



1.  **Farinha de Trigo** (Estoque: 200 kg = 200.000 g):

$$500x_1 + 400x_2 + 400x_3 + 200x_4 \le 200.000$$

2.  **Açúcar** (Estoque: 80 kg = 80.000 g):

$$200x_1 + 150x_2 + 150x_3 + 100x_4 \le 80.000$$

3.  **Frutas e Castanhas** (Estoque: 60 kg = 60.000 g):

$$300x_1 + 200x_2 \le 60.000$$

4.  **Chocolate** (Estoque: 40 kg = 40.000 g):

$$250x_3 + 50x_4 \le 40.000$$

5.  **Tempo de Forno** (Disponível: 400 horas = 24.000 min):

$$45x_1 + 40x_2 + 40x_3 + 15x_4 \le 24.000$$

6.  **Contrato Corporativo (Demanda Mínima):**

\$\$x_1 \ge 50\$\$

7.  **Não-negatividade:**

\$\$x_2, x_3, x_4 \ge 0\$\$
"""

# ╔═╡ 6f3ca268-71ee-4122-8d88-06f747515bfe
# ╠═╡ pluto_cell_id = "6f3ca268-71ee-4122-8d88-06f747515bfe"
begin
    # 1. Modelo
    natal = Model(HiGHS.Optimizer)

    # 2. Variáveis (x1=Stollen, x2=Panetone, x3=Chocotone, x4=Biscoito)
    # Note a restrição de mercado do Stollen já no limite inferior!
    # @variable(natal, x1 >= 50, Int) 
    # @variable(natal, x2 >= 0, Int)
    # @variable(natal, x3 >= 0, Int)
    # @variable(natal, x4 >= 0, Int)
    @variable(natal, x1 >= 50)
    @variable(natal, x2 >= 0)
    @variable(natal, x3 >= 0)
    @variable(natal, x4 >= 0)

    # 3. Função Objetivo (Lucro)
    @objective(natal, Max, 25*x1 + 18*x2 + 20*x3 + 12*x4)

    # 4. Restrições (Convertendo para gramas e minutos)
    @constraint(natal, c_farinha, 500*x1 + 400*x2 + 400*x3 + 200*x4 <= 200000)
    @constraint(natal, c_acucar, 200*x1 + 150*x2 + 150*x3 + 100*x4 <= 80000)
    @constraint(natal, c_frutas, 300*x1 + 200*x2 + 0*x3 + 0*x4 <= 60000)
    @constraint(natal, c_choco, 0*x1 + 0*x2 + 250*x3 + 50*x4 <= 40000)
    @constraint(natal, c_forno, 45*x1 + 40*x2 + 40*x3 + 15*x4 <= 24000)

    # 5. Otimizar
    optimize!(natal)

    md"""
     ### ✅ Resultado da Produção Natalina

     * **Lucro Máximo:** R$ $(objective_value(natal))

     **Mix de Produção:**
     * Stollen: $(value(x1)) un
     * Panetone: $(value(x2)) un
     * Chocotone: $(value(x3)) un
     * Biscoitos: $(value(x4)) pct
     """
end

# ╔═╡ f7222adc-8322-45f4-b00f-4b0ec9335d08
# ╠═╡ pluto_cell_id = "f7222adc-8322-45f4-b00f-4b0ec9335d08"
value(c_farinha)

# ╔═╡ 68aab960-f990-4ba6-9d4b-375c9792407b
# ╠═╡ pluto_cell_id = "68aab960-f990-4ba6-9d4b-375c9792407b"
begin
    # Vamos criar uma funçãozinha para analisar folgas
    function analisar_recurso(nome, constraint, total)
        usado = value(constraint) # Quanto o lado esquerdo da equacao resultou
        folga = total - usado
        status = folga < 1e-5 ? "ESGOTADO (Gargalo)" : "SOBROU $(folga)"
        return "- **$nome**: Usado $usado / $total. -> $status"
    end

    md"""
     ### 🔍 O que sobrou na cozinha?

     $(Markdown.parse(analisar_recurso("Farinha", c_farinha, 200000)))
     $(Markdown.parse(analisar_recurso("Açúcar", c_acucar, 80000)))
     $(Markdown.parse(analisar_recurso("Chocolate", c_choco, 40000)))
     $(Markdown.parse(analisar_recurso("Frutas", c_frutas, 60000)))
     $(Markdown.parse(analisar_recurso("Tempo de Forno", c_forno, 24000)))
     """
end

# ╔═╡ 3cd23304-6a33-4e62-8eb0-27c9d07db510
# ╠═╡ pluto_cell_id = "3cd23304-6a33-4e62-8eb0-27c9d07db510"
# Shadow prices - Preço Sombra
begin
    # Recuperando os Preços Sombra (Shadow Prices)
    # O shadow_price diz quanto aumenta o lucro se aumentarmos 1 unidade do recurso
    y_farinha = shadow_price(c_farinha)
    @info "Farinha" y_farinha
    y_acucar = shadow_price(c_acucar)
    @info "Açúcar" y_acucar
    y_frutas = shadow_price(c_frutas)
    @info "Frutas" y_frutas
    y_choco = shadow_price(c_choco)
    @info "Chocolate" y_choco
    y_forno = shadow_price(c_forno)
    @info "Forno" y_forno
end

# ╔═╡ 96fc6cd0-12f6-404b-8a7e-15b31b1f392d
# ╠═╡ pluto_cell_id = "96fc6cd0-12f6-404b-8a7e-15b31b1f392d"
md"""
---
## Parte 2: A Expansão da OtimizaBier 🍺

O **Pedro**, dono da OtimizaBier, decidiu que é hora de expandir. Além das tradicionais **Pilsen** e **IPA**, ele quer lançar uma cerveja sazonal para o inverno: a **Bock**.

No entanto, a introdução de um terceiro produto torna a decisão de produção mais complexa, pois todos competem pelos mesmos ingredientes no armazém.

### 1. O Novo Modelo de Produção

Vamos formular o problema matematicamente antes de programar.

**Variáveis de Decisão:**
* ``x_p``: Litros de Pilsen a produzir.
* ``x_i``: Litros de IPA a produzir.
* ``x_b``: Litros de Bock a produzir.

**Parâmetros (Lucro por Litro):**
* Pilsen: R$ 10,00
* IPA: R$ 14,00
* Bock: R$ 12,00

**Restrições (Receitas vs. Estoque Semanal):**
O Pedro fez um levantamento preciso das receitas (em gramas por litro) e do estoque atual:

| Ingrediente | Pilsen (\$x_p\$) | IPA (\$x_i\$) | Bock (\$x_b\$) | **Estoque Total** |
| :--- | :---: | :---: | :---: | :---: |
| **Malte** | 230 g | 260 g | 369 g | **500 kg** (500.000 g) |
| **Lúpulo** | 1,7 g | 9 g | 1 g | **2,5 kg** (2.500 g) |
| **Levedura** | 0,6 g | 0,9 g | 0,1 g | **200 g** |
| **Água** | 1,6 L | 1,5 L | 1,5 L | **2.000 L** |
"""

# ╔═╡ 8f3aa8b9-9d1d-4ae3-9661-933f135a4652
# ╠═╡ pluto_cell_id = "8f3aa8b9-9d1d-4ae3-9661-933f135a4652"
md"""
### 2. Formulação Matemática (PPL)

```math
\begin{aligned}
\text{Maximizar } \quad & Z = 10x_p + 14x_i + 12x_b \\
\text{Sujeito a:} \quad & \\
& 230x_p + 260x_i + 369x_b \le 500.000 \quad \text{(Malte)} \\
& 1.7x_p + 9x_i + 1x_b \le 2.500 \quad \text{(Lúpulo)} \\
& 0.6x_p + 0.9x_i + 0.1x_b \le 200 \quad \text{(Levedura)} \\
& 1.6x_p + 1.5x_i + 1.5x_b \le 2.000 \quad \text{(Água)} \\
& x_p, x_i, x_b \ge 0
\end{aligned}
```
"""

# ╔═╡ 37c7476b-341c-4329-bbdc-2f9513eb8335
# ╠═╡ pluto_cell_id = "37c7476b-341c-4329-bbdc-2f9513eb8335"
begin
    # 1. Criar o modelo para a OtimizaBier Expandida
    otimizabier = Model(HiGHS.Optimizer)

    # 2. Variáveis
    
    # 3. Função Objetivo
    
    # 4. Restrições (Note o uso de nomes para facilitar a análise posterior)
    
    # 5. Otimizar
    optimize!(otimizabier)

    # Apresentação dos Resultados
    md"""
     ### 🏁 Plano de Produção OtimizaBier

     O Pedro deve configurar a fábrica para produzir:

     * **Pilsen:** $(round(value(xp), digits=2)) Litros
     * **IPA:** $(round(value(xi), digits=2)) Litros
     * **Bock:** $(round(value(xb), digits=2)) Litros

     **Lucro Total Esperado:** R$ $(round(objective_value(otimizabier), digits=2))
     """
end

# ╔═╡ ed51183a-bcb7-4472-acc5-148758df2872
# ╠═╡ pluto_cell_id = "ed51183a-bcb7-4472-acc5-148758df2872"
begin
    # Recuperando os Preços Sombra (Shadow Prices)
    # O shadow_price diz quanto aumenta o lucro se aumentarmos 1 unidade do recurso
    y_malte = shadow_price(c_malte)
    @info y_malte
    y_lupulo = shadow_price(c_lupulo)
    @info y_lupulo
    y_levedura = shadow_price(c_levedura)
    @info y_levedura
    y_agua = shadow_price(c_agua)
    @info y_agua
end

# ╔═╡ 520f0a7a-a579-4dc9-86d8-41f726848078
# ╠═╡ pluto_cell_id = "520f0a7a-a579-4dc9-86d8-41f726848078"
md"""
 ### 3. O Ponto de Vista do Tio João (Dualidade) 💰

 Imagine que o **Tio João** (irmão do pai do Pedro, que também tem uma cervejaria cuja receita é a mesma da OtimizaBier) aparece na OtimizaBier e diz para o Pedro:
 > *"Pedro, eu quero comprar todo o seu estoque de ingredientes. Não produza nada. Eu pago por grama."*

 Para o Pedro aceitar, o preço oferecido por cada ingrediente (\$\pi\$ ou \$y\$) tem que ser tal que compense o lucro que ele deixaria de ter vendendo a cerveja.

 **Quanto vale cada ingrediente na mão do Pedro? (Preço Sombra):**

 * **Malte:** R$ $(round(y_malte, digits=4)) / g
 * **Lúpulo:** R$ $(round(y_lupulo, digits=4)) / g
 * **Levedura:** R$ $(round(y_levedura, digits=4)) / g
 * **Água:** R$ $(round(y_agua, digits=4)) / L

 **Interpretação:**
 1. Recursos que **sobraram** têm preço sombra **ZERO** (Ex: se sobrou água, comprar mais água não aumenta o lucro).
 2. O recurso com maior preço sombra é o "Gargalo" da produção. É onde o Pedro deveria investir.
 """

# ╔═╡ e50dbf47-7f31-4239-906f-f63c110711e7
# ╠═╡ pluto_cell_id = "e50dbf47-7f31-4239-906f-f63c110711e7"
begin
    # Calculando o Custo de Oportunidade da Bock
    # Custo = Quanto valem os ingredientes da Bock se vendidos para o Tio João?
    custo_oportunidade_bock = 369*y_malte + 1*y_lupulo + 0.1*y_levedura + 1.5*y_agua
    lucro_venda_bock = 12.00

    status_bock = lucro_venda_bock >= custo_oportunidade_bock ?
                  "✅ SIM (O lucro cobre o custo dos ingredientes)" :
                  "❌ NÃO (Vale mais a pena vender os ingredientes usados nela)"


end

# ╔═╡ edc494c1-aa68-4b22-b912-6bf8810b3e0c
# ╠═╡ pluto_cell_id = "edc494c1-aa68-4b22-b912-6bf8810b3e0c"
md"""
 ### 4. Análise: Por que produzir (ou não) a Bock?

 O solver decidiu produzir Bock? Vamos entender a matemática por trás.

 * **Receita da Bock:** R$ 12,00 / litro
 * **Valor dos ingredientes (Custo de Oportunidade):** R$ $(round(custo_oportunidade_bock, digits=2)) / litro

 **Conclusão:** $(status_bock)

 Isso ilustra o princípio da folga complementar e custos reduzidos. Se o custo dos ingredientes ("Preço do Tio João") for maior que o preço de venda da cerveja, o solver define a produção como zero!
 """

# ╔═╡ Cell order:
# ╠═a639d218-d182-11f0-8fb0-5755eed56277
# ╠═530851f0-6919-475b-b6ca-e75356487bc4
# ╠═85071236-9f9a-4988-8aef-04748346c8dd
# ╠═398a8af1-bca5-406e-a6e1-bb50edea048e
# ╠═dc22da63-3703-42ec-a5f2-07387faa95c3
# ╠═6f3ca268-71ee-4122-8d88-06f747515bfe
# ╠═f7222adc-8322-45f4-b00f-4b0ec9335d08
# ╠═68aab960-f990-4ba6-9d4b-375c9792407b
# ╠═3cd23304-6a33-4e62-8eb0-27c9d07db510
# ╠═96fc6cd0-12f6-404b-8a7e-15b31b1f392d
# ╠═8f3aa8b9-9d1d-4ae3-9661-933f135a4652
# ╠═37c7476b-341c-4329-bbdc-2f9513eb8335
# ╠═ed51183a-bcb7-4472-acc5-148758df2872
# ╠═520f0a7a-a579-4dc9-86d8-41f726848078
# ╠═e50dbf47-7f31-4239-906f-f63c110711e7
# ╠═edc494c1-aa68-4b22-b912-6bf8810b3e0c
