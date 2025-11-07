### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ f603327d-4975-4cb4-8ea9-3b52824746e2
using LinearAlgebra

# ╔═╡ ab17d546-b975-11f0-3e6a-211d78871469
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Semana 12 - Aula 01
"""

# ╔═╡ 27a985a2-c7f6-4446-ae0a-34c09052a87d
md"""
## Julia e Álgebra Linear!

A álgebra linear é uma parte fundamental da computação científica, formando a linguagem usada para descrever tudo, desde modelos de aprendizado de máquina e mecânica quântica até sistemas econômicos e gráficos 3D. Julia é uma linguagem de destaque para essas tarefas, combinando uma sintaxe intuitiva e amigável à matemática com desempenho excepcional.

Esta parte da disciplina apresenta o poderoso pacote `LinearAlgebra` do Julia. Vamos abordar os conceitos essenciais para criar e manipular vetores e matrizes, resolver sistemas complexos de equações e realizar análises importantes, como a decomposição espectral. Também mostraremos outra força do Julia: sua capacidade de aproveitar **estruturas matriciais especiais** para escrever código não apenas correto, mas também rápido e eficiente em termos de memória.

```julia 
using LinearAlgebra
```


"""

# ╔═╡ 68d0468e-4533-4e52-bf7e-9863d335e2bb
begin
	x = rand(3) #Vetor aleatório de 3×1
	# Uma matriz 3x3 com entradas aleatórias
	A = rand(3,3)
end

# ╔═╡ c3b49264-ff14-4519-9040-c2658707e30f
md"""
### Operações Básicas com Vetores e Matrizes
Julia fornece um conjunto rico de funções para álgebra linear. Algumas operações básicas estão disponíveis por padrão, mas a maioria está na biblioteca padrão LinearAlgebra, que deve ser incluída sempre.
"""

# ╔═╡ 1ec12a7f-0909-4ed0-b357-1774f1adc640
A*x

# ╔═╡ 4bf42790-6022-420a-a544-edfc5810a7a8
# Criar outro vetor aleatório
y = randn(3)


# ╔═╡ bec7eddc-7afa-4f0a-9b8f-11e3166b3834
# Combinação linear
w =  x - 3y

# ╔═╡ a815c85d-e575-4eb6-8079-bbf0eb6bfa36
A*w

# ╔═╡ f97f054c-cd7b-4172-8b71-aa3b2eea031b
A*y

# ╔═╡ 30a6da0d-080b-4d12-afa3-7329000e0e52
# Produto escalar (dot product)
x_dot_y = dot(x,y)

# ╔═╡ 0364e2d0-783a-4e2d-8aa6-684f463fac48
# Sintaxe Unicode para produto escalar
x_dot_y_2 = x ⋅ y #\cdot 

# ╔═╡ fd753b38-e444-4b9d-b787-5b245308690e
md"""
#### Normas de Vetores
A norma mais comum é a Euclidiana (norma-2):
"""

# ╔═╡ cb61c06b-6562-443d-893c-264785ec3865
# Norma-2 usando função built-in
norma_x = norm(x)

# ╔═╡ 0bdd8bc0-72f6-47e1-ab7f-64acc69120af
norm_x_no_braço1 = √(dot(x,x))

# ╔═╡ d9b63f0d-1902-4b38-bebf-37d00aa29da0
norm_x_no_braço2 = sqrt(dot(x,x))

# ╔═╡ 221225bb-65d8-4e56-b2e4-1376f92ad0da
norm_x_no_braço3 = sqrt(sum([xi^2 for xi in x]))

# ╔═╡ f8348b7f-99f0-42cc-8114-90a056f7b68d
md"""
Também é possível calcular outras normas, como p=1 (Manhattan) ou p=Inf (máxima).

"""

# ╔═╡ 5822c3ca-8fa4-4aa9-9b3c-50b1557985b0
norma_1_x = norm(x,1)

# ╔═╡ 5fdee9fd-adcd-4412-9f28-c42f61b61680
norma_sup_x = norm(x, Inf)

# ╔═╡ 98444737-deca-4d22-a217-9209f36f2b3b
md"""
###  Multiplicação de Matrizes
A multiplicação de matrizes usa o operador *. Para ser válida, as dimensões internas devem coincidir.
"""

# ╔═╡ 4352794a-2e94-4bd9-99e3-c75ab9842b64
B = rand(4,3)

# ╔═╡ 5034e0f7-5575-4a1d-8aab-cf87cf650b1a
 C = B * A  # (4x3) * (3x3) → (4x3)

# ╔═╡ de9bd37a-94f3-4560-8ea6-2013d6dede47
A * B #  (3x3) * (4x3) não é compatível

# ╔═╡ 3113723d-c9b7-42cf-b106-d99443d6ff65
md"""
Para multiplicação elemento a elemento, use .* (produto de Hadamard):

"""

# ╔═╡ df0e7c02-ed43-4ffc-a3c8-b0ed34481dd2
prod_x_y_had = x .* y

# ╔═╡ acc5a66c-592e-4e6c-9d35-b9f5a828c244
A2 = A * A

# ╔═╡ e650c469-f23c-4234-8eb8-dd75bc18af48
A_had_2 = A .* A

# ╔═╡ b48e68ac-72a3-475a-8a90-794191645b1e
A^2 # A * A

# ╔═╡ 094b31e7-fd73-4ecb-b488-4e163d2215f6
D = A^(3.5)

# ╔═╡ dda808ff-f7c3-477a-a5d4-4c119642f2ce
md"""
#### Transpondo matrizes
"""

# ╔═╡ cd0670fc-3284-445a-af5f-7d22e7bbbb85
transpose(B)

# ╔═╡ c144088b-9789-47cd-9c64-48a6125c47cd
B'

# ╔═╡ 70a04efe-70e7-4459-b758-83a3e7b3e8db
D'

# ╔═╡ 8805c8d4-7b17-470f-9756-6197e3048392
A * B'

# ╔═╡ c8e399f7-1b4c-4a39-863d-7105aba7e97a
x_dot_y_3 = x' * y

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.6"
manifest_format = "2.0"
project_hash = "ac1187e548c6ab173ac57d4e72da1620216bce54"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"
"""

# ╔═╡ Cell order:
# ╟─ab17d546-b975-11f0-3e6a-211d78871469
# ╟─27a985a2-c7f6-4446-ae0a-34c09052a87d
# ╠═f603327d-4975-4cb4-8ea9-3b52824746e2
# ╠═68d0468e-4533-4e52-bf7e-9863d335e2bb
# ╟─c3b49264-ff14-4519-9040-c2658707e30f
# ╠═1ec12a7f-0909-4ed0-b357-1774f1adc640
# ╠═4bf42790-6022-420a-a544-edfc5810a7a8
# ╠═bec7eddc-7afa-4f0a-9b8f-11e3166b3834
# ╠═a815c85d-e575-4eb6-8079-bbf0eb6bfa36
# ╠═f97f054c-cd7b-4172-8b71-aa3b2eea031b
# ╠═30a6da0d-080b-4d12-afa3-7329000e0e52
# ╠═0364e2d0-783a-4e2d-8aa6-684f463fac48
# ╟─fd753b38-e444-4b9d-b787-5b245308690e
# ╠═cb61c06b-6562-443d-893c-264785ec3865
# ╠═0bdd8bc0-72f6-47e1-ab7f-64acc69120af
# ╠═d9b63f0d-1902-4b38-bebf-37d00aa29da0
# ╠═221225bb-65d8-4e56-b2e4-1376f92ad0da
# ╟─f8348b7f-99f0-42cc-8114-90a056f7b68d
# ╠═5822c3ca-8fa4-4aa9-9b3c-50b1557985b0
# ╠═5fdee9fd-adcd-4412-9f28-c42f61b61680
# ╟─98444737-deca-4d22-a217-9209f36f2b3b
# ╠═4352794a-2e94-4bd9-99e3-c75ab9842b64
# ╠═5034e0f7-5575-4a1d-8aab-cf87cf650b1a
# ╠═de9bd37a-94f3-4560-8ea6-2013d6dede47
# ╟─3113723d-c9b7-42cf-b106-d99443d6ff65
# ╠═df0e7c02-ed43-4ffc-a3c8-b0ed34481dd2
# ╠═acc5a66c-592e-4e6c-9d35-b9f5a828c244
# ╠═e650c469-f23c-4234-8eb8-dd75bc18af48
# ╠═b48e68ac-72a3-475a-8a90-794191645b1e
# ╠═094b31e7-fd73-4ecb-b488-4e163d2215f6
# ╟─dda808ff-f7c3-477a-a5d4-4c119642f2ce
# ╠═cd0670fc-3284-445a-af5f-7d22e7bbbb85
# ╠═c144088b-9789-47cd-9c64-48a6125c47cd
# ╠═70a04efe-70e7-4459-b758-83a3e7b3e8db
# ╠═8805c8d4-7b17-470f-9756-6197e3048392
# ╠═c8e399f7-1b4c-4a39-863d-7105aba7e97a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
