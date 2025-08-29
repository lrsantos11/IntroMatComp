### A Pluto.jl notebook ###
# v0.20.13

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

# ╔═╡ 79afca88-d86b-45be-993d-2a7bea872982
using PlutoUI

# ╔═╡ b6f6e191-50a1-4ddb-811e-2bb784ae5031
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Semana 02 - Aulas 01 e 02
"""

# ╔═╡ e45bbc21-b1dd-492e-8550-22b080a5ad9a
md"""
## Algoritmos numéricos com Julia
### Comandos Básicos
"""

# ╔═╡ 49d2d518-0895-4013-aa21-08da48721577
md"""
* Como inicializar o Pluto:
```julia
julia> using Pluto; Pluto.run()
```
"""

# ╔═╡ 319c8f13-e5f6-41b6-8027-9499d9b8ae34
# Comandos

# ╔═╡ 62aaef76-98ba-4dbf-a5af-3f6d8eaefa1f
1 - 1

# ╔═╡ 7a36715c-e0b3-42fb-a93e-d5ff9b0c3983
1. + 1

# ╔═╡ 29afc281-0de5-4a5b-b8c3-d858b315fbaa
7 * 3.1

# ╔═╡ 9bb4738c-ff24-4cf7-9514-1ffa4c6ccb7b
7 ^ 20

# ╔═╡ 55501d6f-e8a5-4ae7-a699-00b66a615a6c
π

# ╔═╡ 046ba2a1-d0f8-439a-9185-514ccf60ddb0
ℯ

# ╔═╡ 98be5776-b2b5-4dbc-8f4e-cc4106efff4b
typeof(π)

# ╔═╡ f4ea46d9-bea1-428d-9bd8-277ebf98c7fa
cos(π)

# ╔═╡ 9ed8f819-5c16-451e-ad59-51d6bb12dd4c
sin(pi/4)

# ╔═╡ d0e31f18-cfc2-4c87-8c85-f4cada587f37
log(ℯ) # log(x,base) Se base for ℯ, não é necessário informar

# ╔═╡ e8172063-af6b-40c1-9524-8bdade35347e
log2(2) # log(2,2)

# ╔═╡ 9b5fe0c2-0aa2-4b2c-9510-bb68f4ade89b
log10(100) # log(100,10)

# ╔═╡ 953f37a5-df32-47a7-b72b-764783ef68ce
x = 11

# ╔═╡ d14793a9-f44b-437c-9b33-ba88482c51f4
x ^ 2

# ╔═╡ a9420bd8-1373-4e69-afcc-834c18b4e965
√2 # sqrt(2)

# ╔═╡ 63073453-b7dd-4a53-81cb-e9bd76c285aa
exp(x) #ℯ ^ x

# ╔═╡ 48792c2a-a70e-40f0-bafe-b210c706aea4
5.8e-2  #5.8 × 10^(-2)

# ╔═╡ 4168a974-822b-45f7-b16d-d451687a6a57
1.2356e-6

# ╔═╡ 64d5b46f-1e11-4f95-97f8-6b94665eb1a4
1_000_000

# ╔═╡ b8f2125d-55c7-408d-a100-ca48ed987f66
0.1 + 0.2 - 0.3

# ╔═╡ 3096795f-5169-49ed-9c2a-59542c62d8e1
-0.3 + 0.1 + 0.2

# ╔═╡ 090f0ee1-0fba-4771-9271-40d5f9c6abef
-0.3 + 0.2 + 0.1

# ╔═╡ b04f4fc2-ebde-4901-aa9f-0315f379b715
md"""
## Pluto é REATIVO

- Qualquer alteração em uma célula é refletida em todas as outras células
"""

# ╔═╡ 6d0293c3-a67d-4ed1-8dbf-4b549282af2e
begin
	y = 4
	z = 10
end

# ╔═╡ ab9dea6e-0ee2-4424-8e9b-6b5832329e5a
z + x

# ╔═╡ 12d93f85-309c-4b4a-8e8b-28bd5ec4381b
md"""
## Pacote `PlutoUI.jl`
"""

# ╔═╡ fb9bd0ca-0a65-4d3b-96a0-fcf4112133a8
println("Hello, ")

# ╔═╡ 4e192825-1212-48bb-bdff-b575fe3997a2
begin
	print("Hello, ")
    println("World!")
end

# ╔═╡ d048bcf5-221f-4df7-8e7c-1383e398d6a0
begin
	println("Hello, ")
    println("World!")
	@show 2 + 3 
	@show x # println("x = $x")
	println("O resultado é x = $x")
	@show x + y 
end

# ╔═╡ 44ea2c67-9e6a-4b93-894f-2a3b66d6a42a
"x é variável valendo $x"

# ╔═╡ 4701e06d-68c8-4143-ae04-f9653d6fb1fe
false

# ╔═╡ fd97eb9e-d128-4b3b-bee8-003b013cbaf6
true

# ╔═╡ c06da7e9-7792-475c-b996-a58d457db0b3
2 == 3

# ╔═╡ 5f39024f-31fb-4bb3-9401-d8cd44da1ac3
2 ≤ 3 #\leq <=

# ╔═╡ c18c227c-ae99-447e-8f87-3b180b2b157a
2 ≥ 3 # \geq >=

# ╔═╡ 2de8ac14-da66-4992-92b2-762be4e901c7
2 != 3

# ╔═╡ 897c2ae0-cb64-4799-ba16-a9fae8eb2356
2.99999999 ≈ 3  # \approx - aproximadamente

# ╔═╡ 81a97a42-b5a8-40f4-9fcc-63d20541f1d1
md"""
- Uso de `@bind` do pacote `PlutoUI` em conjunto com a função `Slider`
"""

# ╔═╡ 6971750b-bd68-4e10-a716-88abb9805872
@bind K Slider(2:300, show_value = true) #PlutoUI

# ╔═╡ 1dd3dc7b-b977-4c8e-aad8-d99db7c1e9f1
let
	soma = 0
	@show K
	for i ∈ 1:K
		soma = i^2 + soma
	end
	@show soma
end

# ╔═╡ d232035e-e65e-406d-bd4b-a68b467ce55b
md"""
De forma mais geral, um laço `for` pode ter a sintaxe

```julia
for x = início:passo:fim
    # Código a ser repetido
end
```
Isso fará com que o código dentro do laço seja repetido, com `x` começando no valor `início`, aumentando de acordo com `passo` a cada repetição e terminando em ou antes de x alcançar o valor `fim`.
"""

# ╔═╡ 9bfd6085-389b-4f81-897c-2c8591977fd1
md"""
### Funções
- Em Julia funções tem a estrutura
```julia
function nome_func(input1, input2, ...)
	#Comandos com variáveis inputs
	return output1, output 2 #Um ou mais outputs
end
```
- Construir funções é melhor e mais útil para reprodutibilidade.
- Facilita debugging
"""

# ╔═╡ 6583763d-073f-4f94-b45f-00a73eec8d3d
# Criar funções do mesmo jeito que em matemática
h(x,y) = cos(x) * sin(y)

# ╔═╡ b0f60c52-abea-4f60-b928-cde1c6ab0ad9
h(π,2)

# ╔═╡ 9524bacc-c839-43a2-8fa2-3326ce90366e
h(π/4,ℯ)

# ╔═╡ d44a8a2e-ebb2-4f9d-8aa2-29edd790bedd
function primeira_func(x,y)
	@show x
	@show y
	h(variavel) = sin(variavel)*log(variavel)
	z = h(x) + h(y)
	return 	z
end

# ╔═╡ 7e94f239-c97d-4e67-98e6-3ec6c4a57d9f
z1 = primeira_func(2,3)

# ╔═╡ 825889e5-22f6-4b78-bfdf-d54bffcd07f8
z2 = primeira_func(5,4)

# ╔═╡ 79b22457-22eb-4424-8781-c74fc76687ed
md"""
### Função que calcula o Fatorial $n!$

$$n! := 1\cdot 2\cdot \cdots \cdot n$$
"""

# ╔═╡ 9c90333c-4134-4e86-8d10-d41bff035ab7
# Implementar
function meu_fatorial(n)
	# Laço for

	# Retonar fatorial de n
end

# ╔═╡ 7eac8d7b-cde0-4f86-8e00-09d6cadb38da


# ╔═╡ 05461694-b4c4-4a2e-8f9f-01574dca4919
md"""
## Calculando Raízes quadradas

Vamos agora implementar nosso Algoritmo para encontrar raízes quadradas de um inteiro $n>0$. 

- Quero encontrar ${m \in \mathbb{Z}}$  tal que ${m^2 = n}$.
"""

# ╔═╡ f25056db-7961-4ffb-91d3-5a7bdba3b85a
md"""
- Uso do type `Symbol` em Julia
"""

# ╔═╡ 2c17e973-e8e6-496d-a7fd-c484cf0e4238
qualquer_outra_coisa = :LRS

# ╔═╡ adec5130-12a1-4740-823b-b3bcb2e2f28f
qualquer_outra_coisa == :LR

# ╔═╡ 765f0776-f910-4acf-a42f-827fabcd1381
# Implementar
function calcula_raiz(n)
	for m ∈ 1:n
		# @show m 
		if m^2 == n # (true ou false)
			# Declarar que m é raiz quadrada de n
			# println("$m é raiz quadrada de $n")
			# Parar o loop for 
			return m, m, :RaizExata 
		end
		if m^2 > n
			# Declarar que n não tem raiz quadrada
			# println("$n não tem raiz quadrada inteira")
			# Parar o loop for 
			return  m-1, m, :IntervaloRaiz  
		end
	end
end

# ╔═╡ dd93b856-008d-498e-be2e-e07fe2a9666b
md"""
#### Tarefa Semana 2

> Dar as implementações em Julia das funções que: 
> 1. calculam fatorial;
>    - Uma das duas funções deve usar recursividade
> 2.  de uma função que calcula a raiz quadrada exata de de um número inteiro ${n >0}$:
>    - A função raiz inteira deve retorna o valor da raiz; ou
>    - Um intervalo de inteiros em que a raiz (não-inteira) está.

**Observações:** 
- Suba um Notebook Pluto com nome _Tarefa1_Meu_Nome.pluto.jl_ na Tarefa 1 específica no _moodle_

- Não esqueça de incluir as *Referências* consultadas, incluindo pessoas.

"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.16"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[HypertextLiteral]]
git-tree-sha1 = "5efcf53d798efede8fee5b2c8b09284be359bf24"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.2"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "f19e978f81eca5fd7620650d7dbea58f825802ee"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.0"

[[PlutoUI]]
deps = ["Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "4c8a7d080daca18545c56f1cac28710c362478f3"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.16"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"
"""

# ╔═╡ Cell order:
# ╟─b6f6e191-50a1-4ddb-811e-2bb784ae5031
# ╠═e45bbc21-b1dd-492e-8550-22b080a5ad9a
# ╟─49d2d518-0895-4013-aa21-08da48721577
# ╠═319c8f13-e5f6-41b6-8027-9499d9b8ae34
# ╠═62aaef76-98ba-4dbf-a5af-3f6d8eaefa1f
# ╠═7a36715c-e0b3-42fb-a93e-d5ff9b0c3983
# ╠═29afc281-0de5-4a5b-b8c3-d858b315fbaa
# ╠═9bb4738c-ff24-4cf7-9514-1ffa4c6ccb7b
# ╠═55501d6f-e8a5-4ae7-a699-00b66a615a6c
# ╠═046ba2a1-d0f8-439a-9185-514ccf60ddb0
# ╠═98be5776-b2b5-4dbc-8f4e-cc4106efff4b
# ╠═f4ea46d9-bea1-428d-9bd8-277ebf98c7fa
# ╠═9ed8f819-5c16-451e-ad59-51d6bb12dd4c
# ╠═d0e31f18-cfc2-4c87-8c85-f4cada587f37
# ╠═e8172063-af6b-40c1-9524-8bdade35347e
# ╠═9b5fe0c2-0aa2-4b2c-9510-bb68f4ade89b
# ╠═953f37a5-df32-47a7-b72b-764783ef68ce
# ╠═d14793a9-f44b-437c-9b33-ba88482c51f4
# ╠═a9420bd8-1373-4e69-afcc-834c18b4e965
# ╠═63073453-b7dd-4a53-81cb-e9bd76c285aa
# ╠═48792c2a-a70e-40f0-bafe-b210c706aea4
# ╠═4168a974-822b-45f7-b16d-d451687a6a57
# ╠═64d5b46f-1e11-4f95-97f8-6b94665eb1a4
# ╠═b8f2125d-55c7-408d-a100-ca48ed987f66
# ╠═3096795f-5169-49ed-9c2a-59542c62d8e1
# ╠═090f0ee1-0fba-4771-9271-40d5f9c6abef
# ╟─b04f4fc2-ebde-4901-aa9f-0315f379b715
# ╠═6d0293c3-a67d-4ed1-8dbf-4b549282af2e
# ╠═ab9dea6e-0ee2-4424-8e9b-6b5832329e5a
# ╟─12d93f85-309c-4b4a-8e8b-28bd5ec4381b
# ╠═79afca88-d86b-45be-993d-2a7bea872982
# ╠═fb9bd0ca-0a65-4d3b-96a0-fcf4112133a8
# ╠═4e192825-1212-48bb-bdff-b575fe3997a2
# ╠═d048bcf5-221f-4df7-8e7c-1383e398d6a0
# ╠═44ea2c67-9e6a-4b93-894f-2a3b66d6a42a
# ╠═4701e06d-68c8-4143-ae04-f9653d6fb1fe
# ╠═fd97eb9e-d128-4b3b-bee8-003b013cbaf6
# ╠═c06da7e9-7792-475c-b996-a58d457db0b3
# ╠═5f39024f-31fb-4bb3-9401-d8cd44da1ac3
# ╠═c18c227c-ae99-447e-8f87-3b180b2b157a
# ╠═2de8ac14-da66-4992-92b2-762be4e901c7
# ╠═897c2ae0-cb64-4799-ba16-a9fae8eb2356
# ╟─81a97a42-b5a8-40f4-9fcc-63d20541f1d1
# ╠═6971750b-bd68-4e10-a716-88abb9805872
# ╠═1dd3dc7b-b977-4c8e-aad8-d99db7c1e9f1
# ╟─d232035e-e65e-406d-bd4b-a68b467ce55b
# ╟─9bfd6085-389b-4f81-897c-2c8591977fd1
# ╠═6583763d-073f-4f94-b45f-00a73eec8d3d
# ╠═b0f60c52-abea-4f60-b928-cde1c6ab0ad9
# ╠═9524bacc-c839-43a2-8fa2-3326ce90366e
# ╠═d44a8a2e-ebb2-4f9d-8aa2-29edd790bedd
# ╠═7e94f239-c97d-4e67-98e6-3ec6c4a57d9f
# ╠═825889e5-22f6-4b78-bfdf-d54bffcd07f8
# ╟─79b22457-22eb-4424-8781-c74fc76687ed
# ╠═9c90333c-4134-4e86-8d10-d41bff035ab7
# ╠═7eac8d7b-cde0-4f86-8e00-09d6cadb38da
# ╟─05461694-b4c4-4a2e-8f9f-01574dca4919
# ╟─f25056db-7961-4ffb-91d3-5a7bdba3b85a
# ╠═2c17e973-e8e6-496d-a7fd-c484cf0e4238
# ╠═adec5130-12a1-4740-823b-b3bcb2e2f28f
# ╠═765f0776-f910-4acf-a42f-827fabcd1381
# ╟─dd93b856-008d-498e-be2e-e07fe2a9666b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
