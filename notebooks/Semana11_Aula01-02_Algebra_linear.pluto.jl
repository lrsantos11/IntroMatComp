### A Pluto.jl notebook ###
# v0.20.24

using Markdown
using InteractiveUtils

# ╔═╡ ab17d546-b975-11f0-3e6a-211d78871469
# ╠═╡ pluto_cell_id = "ab17d546-b975-11f0-3e6a-211d78871469"
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Semana 11 - Aula 01
"""

# ╔═╡ 27a985a2-c7f6-4446-ae0a-34c09052a87d
# ╠═╡ pluto_cell_id = "27a985a2-c7f6-4446-ae0a-34c09052a87d"
md"""
## Julia e Álgebra Linear!

A álgebra linear é uma parte fundamental da computação científica, formando a linguagem usada para descrever tudo, desde modelos de aprendizado de máquina e mecânica quântica até sistemas econômicos e gráficos 3D. Julia é uma linguagem de destaque para essas tarefas, combinando uma sintaxe intuitiva e amigável à matemática com desempenho excepcional.

Esta parte da disciplina apresenta o poderoso pacote `LinearAlgebra` do Julia. Vamos abordar os conceitos essenciais para criar e manipular vetores e matrizes, resolver sistemas complexos de equações e realizar análises importantes, como a decomposição espectral. Também mostraremos outra força do Julia: sua capacidade de aproveitar **estruturas matriciais especiais** para escrever código não apenas correto, mas também rápido e eficiente em termos de memória.

```julia 
using LinearAlgebra
```


"""

# ╔═╡ f603327d-4975-4cb4-8ea9-3b52824746e2
# ╠═╡ pluto_cell_id = "f603327d-4975-4cb4-8ea9-3b52824746e2"
using LinearAlgebra

# ╔═╡ 68d0468e-4533-4e52-bf7e-9863d335e2bb
# ╠═╡ pluto_cell_id = "68d0468e-4533-4e52-bf7e-9863d335e2bb"
begin
	x = rand(3) #Vetor aleatório de 3×1
	# Uma matriz 3x3 com entradas aleatórias
	A = rand(3,3)
end

# ╔═╡ c3b49264-ff14-4519-9040-c2658707e30f
# ╠═╡ pluto_cell_id = "c3b49264-ff14-4519-9040-c2658707e30f"
md"""
### Operações Básicas com Vetores e Matrizes
Julia fornece um conjunto rico de funções para álgebra linear. Algumas operações básicas estão disponíveis por padrão, mas a maioria está na biblioteca padrão LinearAlgebra, que deve ser incluída sempre.
"""

# ╔═╡ 1ec12a7f-0909-4ed0-b357-1774f1adc640
# ╠═╡ pluto_cell_id = "1ec12a7f-0909-4ed0-b357-1774f1adc640"
A*x

# ╔═╡ 4bf42790-6022-420a-a544-edfc5810a7a8
# ╠═╡ pluto_cell_id = "4bf42790-6022-420a-a544-edfc5810a7a8"
# Criar outro vetor aleatório
y = randn(3)

# ╔═╡ bec7eddc-7afa-4f0a-9b8f-11e3166b3834
# ╠═╡ pluto_cell_id = "bec7eddc-7afa-4f0a-9b8f-11e3166b3834"
# Combinação linear
w =  x - 3y

# ╔═╡ a815c85d-e575-4eb6-8079-bbf0eb6bfa36
# ╠═╡ pluto_cell_id = "a815c85d-e575-4eb6-8079-bbf0eb6bfa36"
A*w

# ╔═╡ f97f054c-cd7b-4172-8b71-aa3b2eea031b
# ╠═╡ pluto_cell_id = "f97f054c-cd7b-4172-8b71-aa3b2eea031b"
A*y

# ╔═╡ 30a6da0d-080b-4d12-afa3-7329000e0e52
# ╠═╡ pluto_cell_id = "30a6da0d-080b-4d12-afa3-7329000e0e52"
# Produto escalar (dot product)
x_dot_y = dot(x,y)

# ╔═╡ 0364e2d0-783a-4e2d-8aa6-684f463fac48
# ╠═╡ pluto_cell_id = "0364e2d0-783a-4e2d-8aa6-684f463fac48"
# Sintaxe Unicode para produto escalar
x_dot_y_2 = x ⋅ y #\cdot

# ╔═╡ fd753b38-e444-4b9d-b787-5b245308690e
# ╠═╡ pluto_cell_id = "fd753b38-e444-4b9d-b787-5b245308690e"
md"""
#### Normas de Vetores
A norma mais comum é a Euclidiana (norma-2):
"""

# ╔═╡ f6c021df-9702-4d25-b260-93918d2b3d47
# ╠═╡ pluto_cell_id = "f6c021df-9702-4d25-b260-93918d2b3d47"
md"""
### Normas de Vetores

O comprimento (ou magnitude) de um vetor é calculado usando uma **norma**.  
A mais comum é a norma Euclidiana, ou norma 2:

$$\|x\|_2 = \sqrt{\sum_{i=1}^n |x_i|^2}$$

Podemos calculá-la usando a função `norm`.
"""

# ╔═╡ cb61c06b-6562-443d-893c-264785ec3865
# ╠═╡ pluto_cell_id = "cb61c06b-6562-443d-893c-264785ec3865"
# Norma-2 usando função built-in
norma_x = norm(x)

# ╔═╡ 0bdd8bc0-72f6-47e1-ab7f-64acc69120af
# ╠═╡ pluto_cell_id = "0bdd8bc0-72f6-47e1-ab7f-64acc69120af"
norm_x_no_braço1 = √(dot(x,x))

# ╔═╡ d9b63f0d-1902-4b38-bebf-37d00aa29da0
# ╠═╡ pluto_cell_id = "d9b63f0d-1902-4b38-bebf-37d00aa29da0"
norm_x_no_braço2 = sqrt(dot(x,x))

# ╔═╡ 221225bb-65d8-4e56-b2e4-1376f92ad0da
# ╠═╡ pluto_cell_id = "221225bb-65d8-4e56-b2e4-1376f92ad0da"
norm_x_no_braço3 = sqrt(sum([xi^2 for xi in x]))

# ╔═╡ d5a92349-60a7-4208-9d83-d417b0d03745
# ╠═╡ pluto_cell_id = "d5a92349-60a7-4208-9d83-d417b0d03745"
md"""
Mais geralmente, a função `norm` pode calcular a norma $p$ ao passar `p` como segundo argumento:

$$\|x\|_p = \left( \sum_{i=1}^n | x_i |^p \right)^{1/p}$$

Alguns valores comuns:
- `p = 1`: norma Manhattan (soma dos valores absolutos)
- `p = Inf`: norma máximo (maior valor absoluto)
"""

# ╔═╡ 5822c3ca-8fa4-4aa9-9b3c-50b1557985b0
# ╠═╡ pluto_cell_id = "5822c3ca-8fa4-4aa9-9b3c-50b1557985b0"
norma_1_x = norm(x,1)

# ╔═╡ 5fdee9fd-adcd-4412-9f28-c42f61b61680
# ╠═╡ pluto_cell_id = "5fdee9fd-adcd-4412-9f28-c42f61b61680"
norma_sup_x = norm(x, Inf)

# ╔═╡ f6056735-dadc-454c-a0d1-b502e8e51708
# ╠═╡ pluto_cell_id = "f6056735-dadc-454c-a0d1-b502e8e51708"
md"""
## Multiplicação de Matrizes

A multiplicação de matrizes usa o operador `*`.  
Para que o produto $C = AB$ seja válido, as dimensões internas precisam coincidir.

Se $A$ é $m \times k$ e $B$ é $k \times n$, então $C$ será $m \times n$:

$$C_{ij} = \sum_{\ell=1}^k A_{i\ell} B_{\ell j}$$

Se as dimensões não forem compatíveis, Julia emitirá um erro `DimensionMismatch`.
"""

# ╔═╡ 4352794a-2e94-4bd9-99e3-c75ab9842b64
# ╠═╡ pluto_cell_id = "4352794a-2e94-4bd9-99e3-c75ab9842b64"
B = rand(4,3)

# ╔═╡ 5034e0f7-5575-4a1d-8aab-cf87cf650b1a
# ╠═╡ pluto_cell_id = "5034e0f7-5575-4a1d-8aab-cf87cf650b1a"
 C = B * A  # (4x3) * (3x3) → (4x3)

# ╔═╡ de9bd37a-94f3-4560-8ea6-2013d6dede47
# ╠═╡ pluto_cell_id = "de9bd37a-94f3-4560-8ea6-2013d6dede47"
A * B #  (3x3) * (4x3) não é compatível

# ╔═╡ 694e7369-00a9-46e0-8a29-193418d2da22
# ╠═╡ pluto_cell_id = "694e7369-00a9-46e0-8a29-193418d2da22"
md"""
Novamente, é essencial não confundir a multiplicação matricial (`*`) com a multiplicação elemento a elemento (`.*`), que também é conhecida como **produto de Hadamard**.
"""

# ╔═╡ df0e7c02-ed43-4ffc-a3c8-b0ed34481dd2
# ╠═╡ pluto_cell_id = "df0e7c02-ed43-4ffc-a3c8-b0ed34481dd2"
prod_x_y_had = x .* y

# ╔═╡ acc5a66c-592e-4e6c-9d35-b9f5a828c244
# ╠═╡ pluto_cell_id = "acc5a66c-592e-4e6c-9d35-b9f5a828c244"
A2 = A * A

# ╔═╡ e650c469-f23c-4234-8eb8-dd75bc18af48
# ╠═╡ pluto_cell_id = "e650c469-f23c-4234-8eb8-dd75bc18af48"
A_had_2 = A .* A

# ╔═╡ 6e540cab-cfe2-4986-b6c0-3c48552512de
# ╠═╡ pluto_cell_id = "6e540cab-cfe2-4986-b6c0-3c48552512de"
md"""
### Potências de Matrizes

Da mesma forma, o operador de potência `^` calcula potências de matrizes, o que significa multiplicações matriciais repetidas.
"""

# ╔═╡ b48e68ac-72a3-475a-8a90-794191645b1e
# ╠═╡ pluto_cell_id = "b48e68ac-72a3-475a-8a90-794191645b1e"
A^2 # A * A

# ╔═╡ 094b31e7-fd73-4ecb-b488-4e163d2215f6
# ╠═╡ disabled = true
# ╠═╡ pluto_cell_id = "094b31e7-fd73-4ecb-b488-4e163d2215f6"
#=╠═╡
D = A^(3.5)
  
  ╠═╡ =#

# ╔═╡ 08018cab-0f69-4bd4-820a-9d10f9a984ac
# ╠═╡ pluto_cell_id = "08018cab-0f69-4bd4-820a-9d10f9a984ac"
md"""
## Transposta de Matrizes

A **transposta** de uma matriz troca suas linhas por colunas.  
Uma operação relacionada é o **adjunto** (ou transposta conjugada), que também aplica o conjugado complexo em cada elemento.

Em Julia:
- `transpose(A)` executa a transposta matemática.
- `A'` (aspas simples) é uma forma conveniente de escrever o **adjunto**.

Para matrizes reais, as duas operações são equivalentes.
"""

# ╔═╡ cd0670fc-3284-445a-af5f-7d22e7bbbb85
# ╠═╡ pluto_cell_id = "cd0670fc-3284-445a-af5f-7d22e7bbbb85"
transpose(B)

# ╔═╡ c144088b-9789-47cd-9c64-48a6125c47cd
# ╠═╡ pluto_cell_id = "c144088b-9789-47cd-9c64-48a6125c47cd"
B'

# ╔═╡ 70a04efe-70e7-4459-b758-83a3e7b3e8db
# ╠═╡ pluto_cell_id = "70a04efe-70e7-4459-b758-83a3e7b3e8db"
D'

# ╔═╡ 8805c8d4-7b17-470f-9756-6197e3048392
# ╠═╡ pluto_cell_id = "8805c8d4-7b17-470f-9756-6197e3048392"
A * B'

# ╔═╡ 246ccc0b-830b-452e-bfeb-19dd0b232344
# ╠═╡ pluto_cell_id = "246ccc0b-830b-452e-bfeb-19dd0b232344"
md"""
Como o produto interno pode ser escrito como $x^H y$ (adjunto de $x$ multiplicado por $y$), também é possível calculá-lo usando a sintaxe de multiplicação matricial.

Este é um padrão muito comum e eficiente.
"""

# ╔═╡ c8e399f7-1b4c-4a39-863d-7105aba7e97a
# ╠═╡ pluto_cell_id = "c8e399f7-1b4c-4a39-863d-7105aba7e97a"
x_dot_y_3 = x' * y

# ╔═╡ 8c726df2-9aaa-4ac6-a8f0-f7e0ec1f833a
# ╠═╡ pluto_cell_id = "8c726df2-9aaa-4ac6-a8f0-f7e0ec1f833a"
md"""
### Uma Observação sobre Arrays 1D vs 2D

Até agora, nossos vetores (`x` e `y`) foram `Vector`s (arrays 1D).  
Também é possível criar `Matrix`s (arrays 2D) com apenas **uma linha** ou **uma coluna**.

Isso pode causar confusão!
"""

# ╔═╡ 83cace64-1e2c-4bff-bd8e-cd4219f539d8
# ╠═╡ pluto_cell_id = "83cace64-1e2c-4bff-bd8e-cd4219f539d8"
a = rand(3,1)

# ╔═╡ 443c7890-6930-4e67-bed7-9ef722605394
# ╠═╡ pluto_cell_id = "443c7890-6930-4e67-bed7-9ef722605394"
b = rand(1,3)

# ╔═╡ 8a2ae9a2-59c1-4749-8951-8b8c66b16a42
# ╠═╡ pluto_cell_id = "8a2ae9a2-59c1-4749-8951-8b8c66b16a42"
a' * b

# ╔═╡ a71cbc4a-4b1f-4b9e-af00-2ac1780b23ae
# ╠═╡ pluto_cell_id = "a71cbc4a-4b1f-4b9e-af00-2ac1780b23ae"
md"""
Com esses objetos 2D, `a' * b` agora é inválido por incompatibilidade de dimensões (`(1x3) * (1x3)`).

Por isso, é muitas vezes mais seguro e claro usar `dot()` quando queremos calcular o produto interno — ele funciona corretamente tanto para vetores 1D quanto 2D.
"""

# ╔═╡ 0ebf5f7b-0900-49dd-897b-d362d6a55171
# ╠═╡ pluto_cell_id = "0ebf5f7b-0900-49dd-897b-d362d6a55171"
a_dot_b = dot(a,b)

# ╔═╡ a05b0864-e6d7-4310-9edc-738522376d2a
# ╠═╡ pluto_cell_id = "a05b0864-e6d7-4310-9edc-738522376d2a"
md"""
## Outras Funções Comuns para Matrizes

O pacote `LinearAlgebra` define muitas funções importantes, como:

- `det(A)`: determinante de uma matriz quadrada.
- `tr(A)`: traço (soma dos elementos da diagonal).
- `inv(A)`: inversa da matriz.

"""

# ╔═╡ d7e988fb-513b-4e0d-a7be-c314dcdba33a
# ╠═╡ pluto_cell_id = "d7e988fb-513b-4e0d-a7be-c314dcdba33a"
N = 1000

# ╔═╡ 746f34c0-267e-49bd-9198-e4b94b450239
# ╠═╡ pluto_cell_id = "746f34c0-267e-49bd-9198-e4b94b450239"
M = rand(N,N)

# ╔═╡ a4327875-563e-43f9-be72-879efab0af22
# ╠═╡ pluto_cell_id = "a4327875-563e-43f9-be72-879efab0af22"
det(M)

# ╔═╡ de690a94-7277-4e31-a950-46ad3115ce7c
# ╠═╡ pluto_cell_id = "de690a94-7277-4e31-a950-46ad3115ce7c"
tr(M)

# ╔═╡ 4f59d907-e5d6-4adf-9620-b2d74f5de0cc
# ╠═╡ pluto_cell_id = "4f59d907-e5d6-4adf-9620-b2d74f5de0cc"
inv(M)

# ╔═╡ 275e3b2a-e3a0-4bcd-9b01-9ede7a4c8b88
# ╠═╡ pluto_cell_id = "275e3b2a-e3a0-4bcd-9b01-9ede7a4c8b88"
md"""

**Observação importante:** embora `inv(A)` exista, calcular inversas explicitamente é frequentemente ineficiente e numericamente instável.

Para resolver sistemas lineares como $Ax = b$, use o operador *Barra Invertida*`
```julia
 A\ b
```

Este método é **sempre** o recomendado.
"""

# ╔═╡ e7d2ada3-fede-4bb1-a517-8209bc385182
# ╠═╡ pluto_cell_id = "e7d2ada3-fede-4bb1-a517-8209bc385182"
v = rand(N)

# ╔═╡ 1e75ff95-d898-402d-8461-402f35013ba0
# ╠═╡ pluto_cell_id = "1e75ff95-d898-402d-8461-402f35013ba0"
x1 = inv(M) * v

# ╔═╡ b1e9913d-7f3c-450a-9c33-630422848b12
# ╠═╡ pluto_cell_id = "b1e9913d-7f3c-450a-9c33-630422848b12"
x2 = M \ v

# ╔═╡ 0888ee38-0e59-40b2-afc1-c08bc3f035f0
# ╠═╡ pluto_cell_id = "0888ee38-0e59-40b2-afc1-c08bc3f035f0"
norm(x1 - x2)

# ╔═╡ a3b3c079-7cb9-4b85-a6f3-c4c0d13571c9
# ╠═╡ pluto_cell_id = "a3b3c079-7cb9-4b85-a6f3-c4c0d13571c9"
norm(M*x1 - v)

# ╔═╡ c86d887d-cd82-4aff-a63d-af0fd892c469
# ╠═╡ pluto_cell_id = "c86d887d-cd82-4aff-a63d-af0fd892c469"
norm(M*x2 - v)

# ╔═╡ 940ce1bd-82c0-4edd-a861-f7020c7c2301
# ╠═╡ pluto_cell_id = "940ce1bd-82c0-4edd-a861-f7020c7c2301"
using BenchmarkTools

# ╔═╡ 1d5b6a23-3ea1-4355-a016-dff2431a97d3
# ╠═╡ pluto_cell_id = "1d5b6a23-3ea1-4355-a016-dff2431a97d3"
@time inv(M) * v;

# ╔═╡ 766ebea0-49b1-497f-a9fe-f04a36a74e2e
# ╠═╡ pluto_cell_id = "766ebea0-49b1-497f-a9fe-f04a36a74e2e"
@time M \ v;

# ╔═╡ 488e9a34-1f4c-417b-8f6e-679bb277e287
# ╠═╡ pluto_cell_id = "488e9a34-1f4c-417b-8f6e-679bb277e287"
let 
	# Problema de Quadrados Mínimos
	M2 = rand(20,3)
	b2 = rand(20)
	M2\b2
end

# ╔═╡ 1222897b-e3f0-4a97-9b89-6d8a4da167f3
# ╠═╡ pluto_cell_id = "1222897b-e3f0-4a97-9b89-6d8a4da167f3"
md"""
Até agora, usamos matrizes gerais (arrays 2D) que podem representar qualquer matriz arbitrária. Porém, muitas aplicações envolvem matrizes com **estruturas especiais** (por exemplo, simétricas, diagonais ou triangulares).

Julia fornece um conjunto rico de tipos especializados para lidar com esses casos.  
Usá-los traz duas vantagens importantes:

1. **Desempenho**: Operações podem ser **ordens de magnitude mais rápidas** e usar **muito menos memória**.
2. **Correção**: Impor uma estrutura (como simetria) ajuda a garantir que seus algoritmos estejam corretos.

| Tipo                    | Descrição                                                                                  |
|:------------------------|:--------------------------------------------------------------------------------------------|
| `Symmetric`             | [Matriz simétrica](https://pt.wikipedia.org/wiki/Matriz_sim%C3%A9trica)                   |
| `Hermitian`             | [Matriz hermitiana](https://pt.wikipedia.org/wiki/Matriz_hermitiana)                      |
| `UpperTriangular`       | [Matriz triangular superior](https://pt.wikipedia.org/wiki/Matriz_trigonal)               |
| `UnitUpperTriangular`   | Triangular superior com diagonal unitária                                                  |
| `LowerTriangular`       | Matriz triangular inferior                                                                  |
| `UnitLowerTriangular`   | Triangular inferior com diagonal unitária                                                   |
| `Tridiagonal`           | [Matriz tridiagonal](https://pt.wikipedia.org/wiki/Matriz_tridiagonal)                    |
| `SymTridiagonal`        | Matriz tridiagonal simétrica                                                               |
| `Bidiagonal`            | [Matriz bidiagonal](https://pt.wikipedia.org/wiki/Matriz_bidiagonal)                      |
| `Diagonal`              | [Matriz diagonal](https://pt.wikipedia.org/wiki/Matriz_diagonal)                          |
| `UniformScaling`        | Operador de escala uniforme, `α*I`                                                          |
"""

# ╔═╡ 5e25ad83-0463-47cb-8de9-5d12207749ed
# ╠═╡ pluto_cell_id = "5e25ad83-0463-47cb-8de9-5d12207749ed"
md"""
Por exemplo, se você sabe que sua matriz é **simétrica e tridiagonal**, pode usar o tipo `SymTridiagonal`.

O exemplo abaixo constrói o **Laplaciano discreto 1D**, uma matriz muito comum ao resolver equações diferenciais.
"""

# ╔═╡ c8a66b7b-44b7-442e-9ce4-de9f4e5f7ebc
# ╠═╡ pluto_cell_id = "c8a66b7b-44b7-442e-9ce4-de9f4e5f7ebc"
T = SymTridiagonal(2ones(5), -ones(4))  # cria matriz tridiagonal simétrica

# ╔═╡ 0cd25e1e-f80b-4f3b-bd63-b96c605e37b8
# ╠═╡ pluto_cell_id = "0cd25e1e-f80b-4f3b-bd63-b96c605e37b8"
T * rand(5)

# ╔═╡ a4d1fc49-4e3b-4d22-a079-450cf2c07854
# ╠═╡ pluto_cell_id = "a4d1fc49-4e3b-4d22-a079-450cf2c07854"
T^3

# ╔═╡ 5af4e507-22e2-40cb-9d1a-9b6726df158a
# ╠═╡ pluto_cell_id = "5af4e507-22e2-40cb-9d1a-9b6726df158a"
md"""
### Exemplo: Melhora Dramática de Desempenho e Escalabilidade

O verdadeiro poder desses tipos especiais aparece quando trabalhamos com matrizes **grandes**.

Considere uma matriz tridiagonal de **1.000.000 × 1.000.000**.

Se a armazenássemos como uma `Matrix{Float64}` comum, ela precisaria de:
```math
1.000.000\times1.000.000 \times 8 \text{bytes} = 8 \text{terabytes}
```

Isso está muito além da memória de um computador comum.

Ao usar `SymTridiagonal`, armazenamos apenas a diagonal e a sub/super-diagonal.  
"""

# ╔═╡ f8954f5d-af27-4b48-88a1-8fa67fd81578
# ╠═╡ pluto_cell_id = "f8954f5d-af27-4b48-88a1-8fa67fd81578"
let 
	N = 1_000
	T_large = SymTridiagonal(2ones(N), -ones(N-1) )
	b_rand = rand(N)
	println("Resolvendo com SymTridiagonal")
	@time xfast = T_large \ b_rand

	#Converter T_large para T_full
	T_full = Matrix(T_large)
	println("Resolvendo com Matriz Cheia")
	@time x_slow = T_full \ b_rand;

	
end

# ╔═╡ 3b1db9a5-cc42-479a-b148-a644592cb85a
# ╠═╡ pluto_cell_id = "3b1db9a5-cc42-479a-b148-a644592cb85a"
md"""
## Autovalores e Autovetores

Para uma matriz quadrada $A$, um autovetor $v\neq 0$ e seu autovalor correspondente $\lambda$ satisfazem:

$$Av = \lambda v$$

A análise espectral é fundamental em muitas áreas da ciência e engenharia.  
Em Julia, podemos calcular autovalores e autovetores usando `eigvals` e `eigvecs`.
"""

# ╔═╡ ff3f0a54-301f-421e-9470-4f47920a9fd5
# ╠═╡ pluto_cell_id = "ff3f0a54-301f-421e-9470-4f47920a9fd5"
D = randn(5, 5)

# ╔═╡ af272c21-3ee9-4e8b-9d51-95b59f10ebc6
# ╠═╡ pluto_cell_id = "af272c21-3ee9-4e8b-9d51-95b59f10ebc6"
# Eigenvalues => Autovalores
Λ = eigvals(D) # Autovalores

# ╔═╡ 92a94f28-89cd-45eb-8455-bec2245fbaff
# ╠═╡ pluto_cell_id = "92a94f28-89cd-45eb-8455-bec2245fbaff"
md"""
A função `Diagonal` usada acima é um exemplo de um tipo especial de matriz estruturada em Julia — exploraremos esse tipo de estrutura na próxima seção.
"""

# ╔═╡ a0abf554-acba-46ee-a347-40a04f325c81
# ╠═╡ pluto_cell_id = "a0abf554-acba-46ee-a347-40a04f325c81"
Diagonal(Λ)

# ╔═╡ 0abe18b0-6946-4df3-ad39-c3d526237aea
# ╠═╡ pluto_cell_id = "0abe18b0-6946-4df3-ad39-c3d526237aea"
X = eigvecs(D) #Autovetores

# ╔═╡ fa5346ec-1c41-4148-9e11-6463f6b772d3
# ╠═╡ pluto_cell_id = "fa5346ec-1c41-4148-9e11-6463f6b772d3"
norm(D*X  - X * Diagonal(Λ))

# ╔═╡ 9454e8a6-78ef-4422-91e1-96186e12f62a
# ╠═╡ pluto_cell_id = "9454e8a6-78ef-4422-91e1-96186e12f62a"
D*X ≈ X*Diagonal(Λ)

# ╔═╡ cb50887d-6cea-43b2-987b-5817b3e7e440
# ╠═╡ pluto_cell_id = "cb50887d-6cea-43b2-987b-5817b3e7e440"


# ╔═╡ 21c7609a-1d0a-4bcb-8b36-03c850d731f0
# ╠═╡ pluto_cell_id = "21c7609a-1d0a-4bcb-8b36-03c850d731f0"
md"""
### Exemplo: Autovalores de Matrizes Aleatórias

A teoria de matrizes aleatórias estuda propriedades de matrizes com entradas aleatórias.  
Por exemplo, a **lei circular de Girko** afirma que os autovalores de uma matriz quadrada grande com entradas normais padrão tendem a se concentrar dentro de um círculo de raio $\sqrt{n}$ no plano complexo.
"""

# ╔═╡ c448131c-6dd3-49be-b355-902a36836c81
# ╠═╡ pluto_cell_id = "c448131c-6dd3-49be-b355-902a36836c81"
using Plots

# ╔═╡ fc330d9e-c79c-4875-9ef9-09a5bb39e0d1
# ╠═╡ pluto_cell_id = "fc330d9e-c79c-4875-9ef9-09a5bb39e0d1"
let
	N = 1000

	# Criar uma matriz aleatória da normal quadrada
	A = randn(N,N)
	lambda = eigvals(A)
	#Plotar parte real vs parte imaginária de cada autovalor
	scatter(real(lambda), imag(lambda),
			label = "Autovalores",
		   markersize = 1.5,
		   aspect_ratio = :equal,
		   leg = :best,
		   title = "Autovalores de uma matriz aleatória (n = $N)"
		   )
	raio = sqrt(N)
	phi = range(0, 2π, length=101)

	plot!(raio*cos.(phi), raio*sin.(phi),
		 linecolor = :red,
		 linestyle = :dash,
		 linewidth = 2,
		 label = "Limitante Teórico")
end

# ╔═╡ 963cb000-9d66-4a31-aefd-1c720f3a5eb0
# ╠═╡ pluto_cell_id = "963cb000-9d66-4a31-aefd-1c720f3a5eb0"
md"""
## Álgebra Linear Exata com Números Racionais

Além de números reais e complexos, muitas operações de álgebra linear também estão definidas para números racionais.  
Isso permite cálculos **exatos**, livres de erros de arredondamento.
"""

# ╔═╡ 62c916f3-f1e7-4517-83d1-dc54b5144f2e
# ╠═╡ pluto_cell_id = "62c916f3-f1e7-4517-83d1-dc54b5144f2e"
num_racional = 2//3

# ╔═╡ e35c3cd5-82b0-40fc-9168-b6dfd3bbcfc5
# ╠═╡ pluto_cell_id = "e35c3cd5-82b0-40fc-9168-b6dfd3bbcfc5"
num_racional.num

# ╔═╡ 5c50f2ba-c19e-4e93-93b4-dbb83163e3b1
# ╠═╡ pluto_cell_id = "5c50f2ba-c19e-4e93-93b4-dbb83163e3b1"
let
	using Random
	Random.seed!(42)
	numerador = rand(-10:10, 5, 5)
	denominador = rand(1:10, 5, 5)
	A_racional = numerador .// denominador
	@time inv(A_racional)
end

# ╔═╡ Cell order:
# ╠═ab17d546-b975-11f0-3e6a-211d78871469
# ╠═27a985a2-c7f6-4446-ae0a-34c09052a87d
# ╠═f603327d-4975-4cb4-8ea9-3b52824746e2
# ╠═68d0468e-4533-4e52-bf7e-9863d335e2bb
# ╠═c3b49264-ff14-4519-9040-c2658707e30f
# ╠═1ec12a7f-0909-4ed0-b357-1774f1adc640
# ╠═4bf42790-6022-420a-a544-edfc5810a7a8
# ╠═bec7eddc-7afa-4f0a-9b8f-11e3166b3834
# ╠═a815c85d-e575-4eb6-8079-bbf0eb6bfa36
# ╠═f97f054c-cd7b-4172-8b71-aa3b2eea031b
# ╠═30a6da0d-080b-4d12-afa3-7329000e0e52
# ╠═0364e2d0-783a-4e2d-8aa6-684f463fac48
# ╠═fd753b38-e444-4b9d-b787-5b245308690e
# ╠═f6c021df-9702-4d25-b260-93918d2b3d47
# ╠═cb61c06b-6562-443d-893c-264785ec3865
# ╠═0bdd8bc0-72f6-47e1-ab7f-64acc69120af
# ╠═d9b63f0d-1902-4b38-bebf-37d00aa29da0
# ╠═221225bb-65d8-4e56-b2e4-1376f92ad0da
# ╠═d5a92349-60a7-4208-9d83-d417b0d03745
# ╠═5822c3ca-8fa4-4aa9-9b3c-50b1557985b0
# ╠═5fdee9fd-adcd-4412-9f28-c42f61b61680
# ╠═f6056735-dadc-454c-a0d1-b502e8e51708
# ╠═4352794a-2e94-4bd9-99e3-c75ab9842b64
# ╠═5034e0f7-5575-4a1d-8aab-cf87cf650b1a
# ╠═de9bd37a-94f3-4560-8ea6-2013d6dede47
# ╠═694e7369-00a9-46e0-8a29-193418d2da22
# ╠═df0e7c02-ed43-4ffc-a3c8-b0ed34481dd2
# ╠═acc5a66c-592e-4e6c-9d35-b9f5a828c244
# ╠═e650c469-f23c-4234-8eb8-dd75bc18af48
# ╠═6e540cab-cfe2-4986-b6c0-3c48552512de
# ╠═b48e68ac-72a3-475a-8a90-794191645b1e
# ╠═094b31e7-fd73-4ecb-b488-4e163d2215f6
# ╠═08018cab-0f69-4bd4-820a-9d10f9a984ac
# ╠═cd0670fc-3284-445a-af5f-7d22e7bbbb85
# ╠═c144088b-9789-47cd-9c64-48a6125c47cd
# ╠═70a04efe-70e7-4459-b758-83a3e7b3e8db
# ╠═8805c8d4-7b17-470f-9756-6197e3048392
# ╠═246ccc0b-830b-452e-bfeb-19dd0b232344
# ╠═c8e399f7-1b4c-4a39-863d-7105aba7e97a
# ╠═8c726df2-9aaa-4ac6-a8f0-f7e0ec1f833a
# ╠═83cace64-1e2c-4bff-bd8e-cd4219f539d8
# ╠═443c7890-6930-4e67-bed7-9ef722605394
# ╠═8a2ae9a2-59c1-4749-8951-8b8c66b16a42
# ╠═a71cbc4a-4b1f-4b9e-af00-2ac1780b23ae
# ╠═0ebf5f7b-0900-49dd-897b-d362d6a55171
# ╠═a05b0864-e6d7-4310-9edc-738522376d2a
# ╠═d7e988fb-513b-4e0d-a7be-c314dcdba33a
# ╠═746f34c0-267e-49bd-9198-e4b94b450239
# ╠═a4327875-563e-43f9-be72-879efab0af22
# ╠═de690a94-7277-4e31-a950-46ad3115ce7c
# ╠═4f59d907-e5d6-4adf-9620-b2d74f5de0cc
# ╠═275e3b2a-e3a0-4bcd-9b01-9ede7a4c8b88
# ╠═e7d2ada3-fede-4bb1-a517-8209bc385182
# ╠═1e75ff95-d898-402d-8461-402f35013ba0
# ╠═b1e9913d-7f3c-450a-9c33-630422848b12
# ╠═0888ee38-0e59-40b2-afc1-c08bc3f035f0
# ╠═a3b3c079-7cb9-4b85-a6f3-c4c0d13571c9
# ╠═c86d887d-cd82-4aff-a63d-af0fd892c469
# ╠═940ce1bd-82c0-4edd-a861-f7020c7c2301
# ╠═1d5b6a23-3ea1-4355-a016-dff2431a97d3
# ╠═766ebea0-49b1-497f-a9fe-f04a36a74e2e
# ╠═488e9a34-1f4c-417b-8f6e-679bb277e287
# ╠═1222897b-e3f0-4a97-9b89-6d8a4da167f3
# ╠═5e25ad83-0463-47cb-8de9-5d12207749ed
# ╠═c8a66b7b-44b7-442e-9ce4-de9f4e5f7ebc
# ╠═0cd25e1e-f80b-4f3b-bd63-b96c605e37b8
# ╠═a4d1fc49-4e3b-4d22-a079-450cf2c07854
# ╠═5af4e507-22e2-40cb-9d1a-9b6726df158a
# ╠═f8954f5d-af27-4b48-88a1-8fa67fd81578
# ╠═3b1db9a5-cc42-479a-b148-a644592cb85a
# ╠═ff3f0a54-301f-421e-9470-4f47920a9fd5
# ╠═af272c21-3ee9-4e8b-9d51-95b59f10ebc6
# ╠═92a94f28-89cd-45eb-8455-bec2245fbaff
# ╠═a0abf554-acba-46ee-a347-40a04f325c81
# ╠═0abe18b0-6946-4df3-ad39-c3d526237aea
# ╠═fa5346ec-1c41-4148-9e11-6463f6b772d3
# ╠═9454e8a6-78ef-4422-91e1-96186e12f62a
# ╠═cb50887d-6cea-43b2-987b-5817b3e7e440
# ╠═21c7609a-1d0a-4bcb-8b36-03c850d731f0
# ╠═c448131c-6dd3-49be-b355-902a36836c81
# ╠═fc330d9e-c79c-4875-9ef9-09a5bb39e0d1
# ╠═963cb000-9d66-4a31-aefd-1c720f3a5eb0
# ╠═62c916f3-f1e7-4517-83d1-dc54b5144f2e
# ╠═e35c3cd5-82b0-40fc-9168-b6dfd3bbcfc5
# ╠═5c50f2ba-c19e-4e93-93b4-dbb83163e3b1
