### A Pluto.jl notebook ###
# v0.20.23

using Markdown
using InteractiveUtils

# ╔═╡ 2b50dac0-47e7-4d21-a4ac-e22026c51dc5
md"""
## UFSC/Blumenau
## MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Semana 01 - Aula 01
"""

# ╔═╡ 56948164-ddb1-4b45-9f4d-f0354a2d0993
md"""

MAT4642 - Introdução à Matemática Computacional (2026-1)
## Informações do curso


- Professor Luiz-Rafael Santos ([l.r.santos@ufsc.br](mailto:l.r.santos@ufsc.br))

- Ter 20:20-22:00, Qui 18:30-20:10
- Atendimento: Terças e Quintas-feiras 17:00-18:00, ou por agendamento prévio via email.
- Sala B202

- [Disciplina no Moodle](https://presencial.moodle.ufsc.br/course/view.php?id=39576)

- [Página do Github da disciplina](https://github.com/lrsantos11/IntroMatComp)

"""

# ╔═╡ 288d110b-0c15-4355-96cc-03159dc89b10
md"## Ementa de MAT4642 - Introdução à Matemática Computacional

- Representação de números em computador.
- Aritmética de ponto-flutuante e erros de arredondamento. 
- Técnicas de elaboração, estrutura de dados e implementação de programas em linguagem de alto nível. 
- Elaboração e implementação de algoritmos para solução de problemas de matemática computacional. 
- Visualização de dados e de gráficos de funções. 
- Uso de ferramentas de computação simbólica. Uso de bibliotecas para solução de problemas matemáticos e simulação.
"


# ╔═╡ 5f8ae8aa-f20f-4af0-a100-4f1d09d7ce81
md"""
## Avaliação
    
- Serão realizados Projetos Computacionais para aferição de frequência, que renderão média $T$.  
- Além disso, teremos 02 provas, $P1 e P2$ nas semanas 8  e 17 respectivamente.

- A média $$M$$ será calculada na forma:
    $$M = 0,5 T + 0,25 P1 + 0,25 P2$$.
  - Se a frequência for suficiente (75%), 
  - O aluno estará aprovado se M for maior ou igual a 6,0. 
  - O aluno estará reprovado se M for menor que 3,0. 
  - Se M estiver entre 3,0 e 5,5, o mesmo terá direito a uma prova de recuperação. 
    
"""

# ╔═╡ 8164d338-ce20-11eb-29ce-7749362afceb
md"
# Introdução à Linguagem Julia

[Julia](https://www.julialang.org) é uma linguagem dinâmica de *alto nível* e **alto desempenho**.
- Ela se assemelha ao MATLAB e ao Python na facilidade de escrita
de código, mas sua velocidade pode ser comparável ao C e Fortran.

![texty](https://julialang.org/assets/images/benchmarks.svg)


- A versão mais atual do Julia é a **1.12**.
"

# ╔═╡ d0426d69-d528-45d6-b81b-c6d712452073
md"##  Pluto

- O Pluto é uma interface web para Julia que é leve e reativa.
Usando o Pluto, aulas e apresentações ficam mais práticas.

- Cada *célula* do Pluto pode ser executada com um `shift+enter`, ou
um `ctrl+enter`, sendo que o último comando cria automaticamente uma nova célula abaixo da que está sendo usada.

- Você pode adicionar novas células usando o `+` no acima ou abaixo de cada célula.
"

# ╔═╡ 9e5ca483-5b46-4ca8-bffa-1af3b97cd4f7
md"
## O REPL - Terminal Interativo

Ao abrir o Julia no Windows, ou digitar `julia` no terminal do Mac
ou Linux, se abrirá um prompt tipo

````julia
julia>
````

O Pluto também serve como esse prompt e todo comando digitado aqui
pode ser digitado lá.
"

# ╔═╡ 96ede339-ba1a-48d6-899e-d2ec9f54b44f
md"
## Pluto vs Editor

- O Pluto é utilizado para aulas, apresentações, workshops. A parte importante é a interatividade.

- Você pode também usar um editor para programar em Julia (recomendo o [VsCode](https://www.julia-vscode.org)). 
- Um editor é usado para fazer códigos sérios. Para desenvolver os exercícios, projetos, e futuros pacotes, é necessário criar arquivos e ter um ambiente adequado. 

- Nesta disciplina vamos usar o Pluto na maioria do tempo.
"

# ╔═╡ e7b00b38-667e-47eb-9924-69a7f6c6c4e0
md"""
## Introdução ao Julia

- Julia é uma Calculadora!

"""

# ╔═╡ 2539b502-4d09-4048-ac10-17c6577a4ea6
# Números
2+2

# ╔═╡ 1ad53ea8-fd2a-4191-b561-c51c4721679c
2*2

# ╔═╡ 655f327e-194a-42d9-ae47-14feece07c30
2/2

# ╔═╡ bb555372-db11-44dc-93d8-5b182bb8fb05
2^2

# ╔═╡ 64432976-420c-4772-a19c-644c250f6058
pi

# ╔═╡ 2ecff183-f971-4d3e-b080-da1577033546
π

# ╔═╡ 128f6567-24de-4192-bde2-f27f56973bcc
# Funções matemáticas
sin(π)

# ╔═╡ 60c69a55-507f-4437-a0a5-ee33bdc3a3b7
cos(0)

# ╔═╡ 5297a734-153b-4612-acfa-c1cf7864180d
exp(π)

# ╔═╡ b302a4a2-5876-44d2-9841-479b91229d93
ℯ

# ╔═╡ f9169d2f-a436-44d8-928e-11abb6eec7f1
a = sqrt(2)

# ╔═╡ 3709c9ea-487d-4af8-a426-7bf713ab85d8
a*a*a*a

# ╔═╡ c7e6957a-3ffc-4268-b3c0-772105ae970d
0.3 - 0.2

# ╔═╡ 6345f2f4-919c-497d-989f-c09324bd3fb2
md"""
- Mas trabalha bem com Matrizes (herdeiro do MATLAB)
"""

# ╔═╡ d423d847-e90e-49a4-8016-9939cb6a4021
# Matrizes
A = [1 2;
	 2 1.0]

# ╔═╡ 928e168f-4665-43c4-863a-06580d07db0a
#Vetores
x = [1, 3]

# ╔═╡ 39c459e7-9d01-49c9-81da-168085fcea0e
# Produto Matriz vetor
A*x

# ╔═╡ 7af5e389-5ac5-42c5-96ff-e3f5db5ff732
md"""
Uma função simples:
```math
f(x) = \sin(x) \cdot \cos(x)
```
"""

# ╔═╡ 21e4829e-888a-4510-b7d7-3c794c1c62ed
# TODO: Implementação


# ╔═╡ 107e7c1d-4134-4b30-9c6c-20b40efb7cf0
md"""
## Pseudocódigo → Julia
Exemplo: média de três números.
**Pseudocódigo**
1. Ler `x`, `y`, `z`
2. `m ← (x + y + z)/3`
3. Exibir `m`
Experimente reimplementar em Julia na célula abaixo.
"""

# ╔═╡ 6347e072-85c4-4f76-9276-c2fb9fe8c8d2
# TODO: Implementação


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.4"
manifest_format = "2.0"
project_hash = "71853c6197a6a7f222db0f1978c7cb232b87c5ee"

[deps]
"""

# ╔═╡ Cell order:
# ╟─2b50dac0-47e7-4d21-a4ac-e22026c51dc5
# ╟─56948164-ddb1-4b45-9f4d-f0354a2d0993
# ╟─288d110b-0c15-4355-96cc-03159dc89b10
# ╟─5f8ae8aa-f20f-4af0-a100-4f1d09d7ce81
# ╟─8164d338-ce20-11eb-29ce-7749362afceb
# ╟─d0426d69-d528-45d6-b81b-c6d712452073
# ╟─9e5ca483-5b46-4ca8-bffa-1af3b97cd4f7
# ╟─96ede339-ba1a-48d6-899e-d2ec9f54b44f
# ╟─e7b00b38-667e-47eb-9924-69a7f6c6c4e0
# ╠═2539b502-4d09-4048-ac10-17c6577a4ea6
# ╠═1ad53ea8-fd2a-4191-b561-c51c4721679c
# ╠═655f327e-194a-42d9-ae47-14feece07c30
# ╠═bb555372-db11-44dc-93d8-5b182bb8fb05
# ╠═64432976-420c-4772-a19c-644c250f6058
# ╠═2ecff183-f971-4d3e-b080-da1577033546
# ╠═128f6567-24de-4192-bde2-f27f56973bcc
# ╠═60c69a55-507f-4437-a0a5-ee33bdc3a3b7
# ╠═5297a734-153b-4612-acfa-c1cf7864180d
# ╠═b302a4a2-5876-44d2-9841-479b91229d93
# ╠═f9169d2f-a436-44d8-928e-11abb6eec7f1
# ╠═3709c9ea-487d-4af8-a426-7bf713ab85d8
# ╠═c7e6957a-3ffc-4268-b3c0-772105ae970d
# ╟─6345f2f4-919c-497d-989f-c09324bd3fb2
# ╠═d423d847-e90e-49a4-8016-9939cb6a4021
# ╠═928e168f-4665-43c4-863a-06580d07db0a
# ╠═39c459e7-9d01-49c9-81da-168085fcea0e
# ╟─7af5e389-5ac5-42c5-96ff-e3f5db5ff732
# ╠═21e4829e-888a-4510-b7d7-3c794c1c62ed
# ╟─107e7c1d-4134-4b30-9c6c-20b40efb7cf0
# ╠═6347e072-85c4-4f76-9276-c2fb9fe8c8d2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
