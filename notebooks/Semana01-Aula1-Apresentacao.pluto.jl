### A Pluto.jl notebook ###
# v0.20.13

using Markdown
using InteractiveUtils

# ╔═╡ 497b6fbc-788b-432a-98d9-8079142c9b50
using Printf

# ╔═╡ 2b50dac0-47e7-4d21-a4ac-e22026c51dc5
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Semana 01 - Aula 01
"""

# ╔═╡ 56948164-ddb1-4b45-9f4d-f0354a2d0993
md"""
## Informações do curso

- Professor Luiz-Rafael Santos ([l.r.santos@ufsc.br](mailto:l.r.santos@ufsc.br))

- Ter 08:20-10:00, Sex 10:11-12:00$^*$ 

- Atendimento: TBD

- [Disciplina no Moodle](https://presencial.moodle.ufsc.br/course/view.php?id=36035)

- [Página do Github da disciplina] (https://github.com/lrsantos11/IntroMatComp)

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
- Além disso, teremos 02 provas, $P1$ e $P2$ nas semanas 8  e 17 respectivamente.

- A média $$M$$ será calculada na forma:
    $$M = 0,5 T + 0,25 P1 + 0,25 P2$$.
  - Se a frequência for suficiente (75%), 
  - O aluno estará aprovado se M for maior ou igual a 6,0. 
  - O aluno estará reprovado se M for menor que 3,0. 
  - Se M estiver entre 3,0 e 5,5, o mesmo terá direito a uma prova de recuperação. 
    
"""

# ╔═╡ 8164d338-ce20-11eb-29ce-7749362afceb
md"
## Introdução à Linguagem Julia

[Julia](https://www.julialang.org) é uma linguagem dinâmica de *alto nível* e **alto desempenho**.
- Ela se assemelha ao MATLAB e ao Python na facilidade de escrita
de código, mas sua velocidade pode ser comparável ao C e Fortran.

![texty](https://julialang.org/assets/images/benchmarks.svg)


- A versão mais atual do Julia é a **1.11**.
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
"""

# ╔═╡ 2539b502-4d09-4048-ac10-17c6577a4ea6
# Numeros
2 + 2

# ╔═╡ 1ad53ea8-fd2a-4191-b561-c51c4721679c
# Operações
2 * 3

# ╔═╡ 319ea98e-9a82-4a35-90e6-e9c98a645880
0.3 - 0.2

# ╔═╡ 298cfcda-7f7c-4229-a9b8-2f953fe692a8
bitstring(0.3)

# ╔═╡ 07041c36-e88d-4c0f-9bae-3b782d225a2d
bitstring(0.2)

# ╔═╡ 56dcd858-a360-49ab-8e97-7615c59c8097
md"""
## Ponto flutuante: por que `0.3 - 0.2` não é exatamente `0.1`?

- Em binário, `0.3` e `0.2` são dízimas infinitas, então **não cabem exatamente** em `Float64`.
- O computador armazena aproximações; operações carregam **erros de arredondamento**.
- Abaixo mostramos o resultado com muitas casas, os bits internos, e alternativas exatas.
"""

# ╔═╡ 5a917180-cf0b-4ec9-97e6-0d910fa2b33b
begin
  res = 0.3 - 0.2
  @printf("%.20f\n", res)  # mostra 20 casas decimais
  res
end

# ╔═╡ 2d598f69-3f0c-4669-b80c-1b984fb0744d
bitstring(res)  # representação IEEE 754 (64 bits)

# ╔═╡ 461f290a-75b8-4092-b3ca-2cd959def6f2
begin
  r = 3 // 10 - 2 // 10         # aritmética exata com racionais
  (r, float(r))             # racional e versão Float64
end

# ╔═╡ 67541f4b-e9cd-44e2-a96c-1a79ed7d5271
setprecision(128) do
  big_res = big"0.3" - big"0.2"  # BigFloat com maior precisão
  big_res
end

# ╔═╡ 08e87f3d-f10e-4b13-906e-039ce104af7a
md"""
## Funções Matemáticas
"""

# ╔═╡ 128f6567-24de-4192-bde2-f27f56973bcc
# Funções matemáticas
sin(π)

# ╔═╡ 60c69a55-507f-4437-a0a5-ee33bdc3a3b7
cos(0)

# ╔═╡ 5297a734-153b-4612-acfa-c1cf7864180d
exp(π)

# ╔═╡ 7af5e389-5ac5-42c5-96ff-e3f5db5ff732
md"""
Uma função simples:
```math
f(x) = \sin(x) \cdot \cos(x)
```
"""

# ╔═╡ 21e4829e-888a-4510-b7d7-3c794c1c62ed
# TODO: Implementação de uma fução


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


# ╔═╡ cf49eb0c-6cf2-4cb6-a431-db7d6c49a401


# ╔═╡ 237140f5-283a-43fa-8c64-f1c5698d50e3


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.6"
manifest_format = "2.0"
project_hash = "f604830d70fa58877def5710c5d1fa32dcb3f998"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"
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
# ╠═319ea98e-9a82-4a35-90e6-e9c98a645880
# ╠═298cfcda-7f7c-4229-a9b8-2f953fe692a8
# ╠═07041c36-e88d-4c0f-9bae-3b782d225a2d
# ╟─56dcd858-a360-49ab-8e97-7615c59c8097
# ╠═497b6fbc-788b-432a-98d9-8079142c9b50
# ╠═5a917180-cf0b-4ec9-97e6-0d910fa2b33b
# ╠═2d598f69-3f0c-4669-b80c-1b984fb0744d
# ╠═461f290a-75b8-4092-b3ca-2cd959def6f2
# ╠═67541f4b-e9cd-44e2-a96c-1a79ed7d5271
# ╟─08e87f3d-f10e-4b13-906e-039ce104af7a
# ╠═128f6567-24de-4192-bde2-f27f56973bcc
# ╠═60c69a55-507f-4437-a0a5-ee33bdc3a3b7
# ╠═5297a734-153b-4612-acfa-c1cf7864180d
# ╟─7af5e389-5ac5-42c5-96ff-e3f5db5ff732
# ╠═21e4829e-888a-4510-b7d7-3c794c1c62ed
# ╟─107e7c1d-4134-4b30-9c6c-20b40efb7cf0
# ╠═6347e072-85c4-4f76-9276-c2fb9fe8c8d2
# ╠═cf49eb0c-6cf2-4cb6-a431-db7d6c49a401
# ╠═237140f5-283a-43fa-8c64-f1c5698d50e3
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
