### A Pluto.jl notebook ###
# v0.20.23

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

# ╔═╡ bbb00001-0000-0000-0000-000000000001
using PlutoUI

# ╔═╡ bbb00002-0000-0000-0000-000000000002
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Semana 03 - Aulas 01 e 02
#### Recursividade

---

**Nome:**

**Data:**

---

> **Instruções:**
> - Implemente as funções nos espaços marcados com `# IMPLEMENTE AQUI`
> - Execute cada célula após implementar (Shift+Enter)
> - As células de teste logo abaixo de cada implementação verificam se sua solução está correta
> - Ao final, salve e entregue o arquivo `.jl` no Moodle
"""

# ╔═╡ bbb00003-0000-0000-0000-000000000003
md"""
---
## 1. Motivação: de somatórios a recursividade

Na aula passada calculamos somatórios com laços `for`:

$$S(n) = \sum_{i=1}^{n} i = 1 + 2 + \cdots + n$$

Há uma outra forma de pensar nessa soma:

$$S(n) = \underbrace{1 + 2 + \cdots + (n-1)}_{S(n-1)} + n = S(n-1) + n, \quad S(0) = 0$$

O problema de tamanho $n$ **se reduziu** ao problema de tamanho $n-1$.
Essa é a essência da **recursividade**.
"""

# ╔═╡ bbb00004-0000-0000-0000-000000000004
md"""
### Estrutura geral de um algoritmo recursivo

```julia
function algo_com_f(n)
    if <caso_base>
        return <valor_base>        # para a recursão
    else
        return <algo_com_f(n-1)>  # passo recursivo
    end
end
```

**Dois requisitos obrigatórios:**
1. **Caso base** — condição em que a função retorna sem chamar a si mesma
2. **Convergência** — cada chamada recursiva fica *mais próxima* do caso base

!!! dica 
    Sem caso base correto → recursão infinita → `StackOverflowError`
"""

# ╔═╡ bbb00010-0000-0000-0000-000000000010
md"""
---
## 2. Aquecimento: Somatório recursivo

Vamos partir da definição:

$$S(n) = \begin{cases} 0, & n = 0 \\ S(n-1) + n, & n \geq 1 \end{cases}$$

**Rastreamento** para $n = 4$:
```
somatorio_rec(4) = somatorio_rec(3) + 4
                 = (somatorio_rec(2) + 3) + 4
                 = ((somatorio_rec(1) + 2) + 3) + 4
                 = (((somatorio_rec(0) + 1) + 2) + 3) + 4
                 = (((0 + 1) + 2) + 3) + 4
                 = 10
```
"""

# ╔═╡ bbb00011-0000-0000-0000-000000000011
# Esta função já está implementada — estude como ela funciona!
function somatorio_rec(n)
    if n == 0
        return 0                          # caso base: S(0) = 0
    else
        return somatorio_rec(n - 1) + n  # passo recursivo
    end
end

# ╔═╡ bbb00012-0000-0000-0000-000000000012
md"""
**Teste:** Execute a célula abaixo e verifique que os valores batem com a fórmula $S(n) = \frac{n(n+1)}{2}$:
"""

# ╔═╡ bbb00013-0000-0000-0000-000000000013
let
    n = 10
    rec = somatorio_rec(n)
    form = n * (n + 1) ÷ 2
    @show rec, form, rec == form
end

# ╔═╡ bbb00014-0000-0000-0000-000000000014
@bind N_som Slider(0:50, default=10, show_value=true)

# ╔═╡ bbb00015-0000-0000-0000-000000000015
md"""
S($N_som) = $(somatorio_rec(N_som))

(fórmula: $(N_som*(N_som+1)÷2))
"""

# ╔═╡ bbb00020-0000-0000-0000-000000000020
md"""
---
## 3. Fatorial

**Definição matemática por recorrência:**

$$n! = \begin{cases} 1, & n = 0 \\ n \cdot (n-1)!, & n \geq 1 \end{cases}$$

**Rastreamento** para $n = 3$:
```
fatorial_rec(3) = 3 × fatorial_rec(2)
               = 3 × (2 × fatorial_rec(1))
               = 3 × (2 × (1 × fatorial_rec(0)))
               = 3 × (2 × (1 × 1))
               = 6
```
"""

# ╔═╡ bbb00021-0000-0000-0000-000000000021
md"""
### 📝 Implemente: fatorial recursivo
"""

# ╔═╡ bbb00022-0000-0000-0000-000000000022
function fatorial_rec(n)
    @assert n >= 0 "n deve ser não-negativo"
    # IMPLEMENTE AQUI
    # Dica: use a definição recursiva acima
    # Caso base: n == 0  →  retorne 1
    # Passo recursivo: retorne n * fatorial_rec(n - 1)

    return missing   # remova esta linha quando implementar
end

# ╔═╡ bbb00023-0000-0000-0000-000000000023
md"""
**Teste automático** (deve mostrar `true` para todos):
"""

# ╔═╡ bbb00024-0000-0000-0000-000000000024
let
    resultados = [
        fatorial_rec(0) == 1,
        fatorial_rec(1) == 1,
        fatorial_rec(3) == 6,
        fatorial_rec(5) == 120,
        fatorial_rec(10) == 3628800,
    ]
    all(resultados) ? "✅ Todos os testes passaram!" : "❌ Algum teste falhou: $resultados"
end

# ╔═╡ bbb00025-0000-0000-0000-000000000025
md"""
### 📝 Implemente: fatorial iterativo
"""

# ╔═╡ bbb00026-0000-0000-0000-000000000026
function fatorial_iter(n)
    @assert n >= 0 "n deve ser não-negativo"
    # IMPLEMENTE AQUI
    # Use um laço for com uma variável acumuladora
    # fat = 1
    # for i in 1:n ...

    return missing   # remova esta linha quando implementar
end

# ╔═╡ bbb00027-0000-0000-0000-000000000027
let
    resultados = [
        fatorial_iter(0) == 1,
        fatorial_iter(1) == 1,
        fatorial_iter(3) == 6,
        fatorial_iter(5) == 120,
        fatorial_iter(10) == 3628800,
        fatorial_rec(7) == fatorial_iter(7),
    ]
    all(resultados) ? "✅ Todos os testes passaram!" : "❌ Algum teste falhou: $resultados"
end

# ╔═╡ bbb00028-0000-0000-0000-000000000028
@bind N_fat Slider(0:22, default=5, show_value=true)

# ╔═╡ bbb00029-0000-0000-0000-000000000029
md"""
Recursivo: $(N_fat)! = $(fatorial_rec(N_fat))

Iterativo: $(N_fat)! = $(fatorial_iter(N_fat))
"""

# ╔═╡ bbb00030-0000-0000-0000-000000000030
md"""
---
## 4. Sequência de Fibonacci

$$F_n = \begin{cases} 0 & n = 0 \\ 1 & n = 1 \\ F_{n-1} + F_{n-2} & n \geq 2 \end{cases}$$

Primeiros termos: $0, 1, 1, 2, 3, 5, 8, 13, 21, 34, \ldots$

> ⚠️ Note que esta definição tem **dois casos base**: $F_0 = 0$ e $F_1 = 1$.
"""

# ╔═╡ bbb00031-0000-0000-0000-000000000031
md"""
### 📝 Implemente: Fibonacci recursivo
"""

# ╔═╡ bbb00032-0000-0000-0000-000000000032
function fibonacci_rec(n)
    @assert n >= 0 "n deve ser não-negativo"
    # IMPLEMENTE AQUI
    # Dois casos base: n == 0 e n == 1
    # Passo recursivo: fibonacci_rec(n-1) + fibonacci_rec(n-2)

    return missing   # remova esta linha quando implementar
end

# ╔═╡ bbb00033-0000-0000-0000-000000000033
let
    esperado = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
    obtido = [fibonacci_rec(i) for i in 0:10]
    obtido == esperado ?
    "✅ Correto! Os primeiros 11 termos são: $obtido" :
    "❌ Esperado: $esperado\nObtido:   $obtido"
end

# ╔═╡ bbb00034-0000-0000-0000-000000000034
@bind N_fib Slider(0:30, default=10, show_value=true)

# ╔═╡ bbb00035-0000-0000-0000-000000000035
md"""
F($N_fib) = $(fibonacci_rec(N_fib))

> ⚠️ Para valores de N acima de ~35, a versão recursiva fica muito lenta!
> Isso vai ficar claro na próxima célula.
"""

# ╔═╡ bbb00036-0000-0000-0000-000000000036
md"""
### O problema de eficiência

A versão recursiva recalcula os mesmos valores repetidamente.
Veja a árvore de chamadas para $F(5)$:

```
fib(5)
├── fib(4)
│   ├── fib(3)
│   │   ├── fib(2)  ← calculado de novo!
│   │   └── fib(1)
│   └── fib(2)      ← calculado de novo!
└── fib(3)          ← calculado de novo!
    ├── fib(2)      ← calculado de novo!
    └── fib(1)
```

**`fib(2)` é calculado 3 vezes.** Para $n$ grande, isso cresce como $2^n$.
"""

# ╔═╡ bbb00037-0000-0000-0000-000000000037
md"""
### 📝 Implemente: Fibonacci iterativo

A ideia: mantenha apenas os dois valores anteriores, atualize a cada passo.

```
a, b = F(0), F(1) = 0, 1
i=2: a, b = F(1), F(2) = 1, 0+1 = 1, 1
i=3: a, b = F(2), F(3) = 1, 1+1 = 1, 2
i=4: a, b = F(3), F(4) = 2, 1+2 = 2, 3
...
```
"""

# ╔═╡ bbb00038-0000-0000-0000-000000000038
function fibonacci_iter(n)
    @assert n >= 0 "n deve ser não-negativo"
    # IMPLEMENTE AQUI
    # Dica: trate n <= 1 separadamente, depois use um laço for
    # Use atribuição simultânea: a, b = b, a + b

    return missing   # remova esta linha quando implementar
end

# ╔═╡ bbb00039-0000-0000-0000-000000000039
let
    esperado = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
    obtido = [fibonacci_iter(i) for i in 0:10]
    if obtido == esperado
        "✅ Correto! Primeiros 11 termos: $obtido"
    else
        "❌ Esperado: $esperado\nObtido:   $obtido"
    end
end

# ╔═╡ bbb00040-0000-0000-0000-000000000040
md"""
**Compare o tempo das duas versões:**
"""

# ╔═╡ bbb00041-0000-0000-0000-000000000041
let
    n = 35
    t_rec = @elapsed fibonacci_rec(n)
    t_iter = @elapsed fibonacci_iter(n)
    md"""
    F($n) = $(fibonacci_iter(n))

    Recursivo:  $(round(t_rec  * 1e3, digits=1)) ms

    Iterativo:  $(round(t_iter * 1e6, digits=3)) μs
    """
end

# ╔═╡ bbb00050-0000-0000-0000-000000000050
md"""
---
## 5. Algoritmo de Euclides — MDC

**Propriedade fundamental:**

$$\text{mdc}(a, b) = \begin{cases} a & b = 0 \\ \text{mdc}(b,\; a \bmod b) & b > 0 \end{cases}$$

**Exemplo:** mdc(48, 18)
```
mdc(48, 18) → resto(48÷18) = 12 → mdc(18, 12)
mdc(18, 12) → resto(18÷12) =  6 → mdc(12,  6)
mdc(12,  6) → resto(12÷6)  =  0 → mdc( 6,  0)
mdc( 6,  0) → b = 0, retorna 6
```
"""

# ╔═╡ bbb00051-0000-0000-0000-000000000051
md"""
### 📝 Implemente: MDC (Algoritmo de Euclides)
"""

# ╔═╡ bbb00052-0000-0000-0000-000000000052
function mdc(a, b)
    # IMPLEMENTE AQUI
    # Caso base: b == 0  →  retorne a
    # Passo recursivo: retorne mdc(b, mod(a, b))

    return missing   # remova esta linha quando implementar
end

# ╔═╡ bbb00053-0000-0000-0000-000000000053
let
    testes = [
        (48, 18, 6),
        (100, 75, 25),
        (7, 13, 1),
        (12, 8, 4),
        (0, 5, 5),
    ]
    resultados = [mdc(a, b) == esp for (a, b, esp) in testes]
    all(resultados) ?
    "✅ Todos os testes passaram!" :
    "❌ Falhou em: $([(a,b,esp) for ((a,b,esp),ok) in zip(testes,resultados) if !ok])"
end

# ╔═╡ bbb00054-0000-0000-0000-000000000054
md"""
**Slider interativo:**
"""

# ╔═╡ bbb00055-0000-0000-0000-000000000055
@bind a_mdc Slider(1:200, default=48, show_value=true)

# ╔═╡ bbb00056-0000-0000-0000-000000000056
@bind b_mdc Slider(1:200, default=18, show_value=true)

# ╔═╡ bbb00057-0000-0000-0000-000000000057
md"""
mdc($a_mdc, $b_mdc) = $(mdc(a_mdc, b_mdc))
"""

# ╔═╡ bbb00060-0000-0000-0000-000000000060
md"""
---
## 6. Exercícios

### Exercício 1 — Potência recursiva

Implemente `potencia(a, n)` usando a definição:

$$a^n = \begin{cases} 1 & n = 0 \\ a \cdot a^{n-1} & n \geq 1 \end{cases}$$
"""

# ╔═╡ bbb00061-0000-0000-0000-000000000061
function potencia(a, n)
    @assert n >= 0 "n deve ser não-negativo"
    # IMPLEMENTE AQUI

    return missing
end

# ╔═╡ bbb00062-0000-0000-0000-000000000062
let
    testes = [
        potencia(2, 0) == 1,
        potencia(2, 1) == 2,
        potencia(2, 10) == 1024,
        potencia(3, 5) == 243,
        potencia(2, 0) == 2^0,
        potencia(5, 4) == 5^4,
    ]
    all(testes) ? "✅ Todos os testes passaram!" : "❌ Algum teste falhou: $testes"
end

# ╔═╡ bbb00063-0000-0000-0000-000000000063
md"""
### Exercício 2 — Soma dos quadrados

Implemente `soma_quadrados(n)` que calcula $\displaystyle Q(n) = \sum_{i=1}^{n} i^2$.

Escreva antes a definição por recorrência:

$$Q(n) = \begin{cases} \;\; ? & n = 0 \\ \;\; ? & n \geq 1 \end{cases}$$
"""

# ╔═╡ bbb00064-0000-0000-0000-000000000064
function soma_quadrados(n)
    # IMPLEMENTE AQUI

    return missing
end

# ╔═╡ bbb00065-0000-0000-0000-000000000065
let
    # Verifica com a fórmula fechada Q(n) = n(n+1)(2n+1)/6
    testes = [soma_quadrados(n) == n * (n + 1) * (2n + 1) ÷ 6 for n in 0:20]
    all(testes) ? "✅ Todos os testes passaram (n = 0 a 20)!" : "❌ Falhou em algum n"
end

# ╔═╡ bbb00066-0000-0000-0000-000000000066
md"""
### Exercício 3 — Exponenciação rápida ⭐

A **exponenciação rápida** reduz as multiplicações de $O(n)$ para $O(\log n)$:

$$a^n = \begin{cases}
  1 & n = 0 \\
  \bigl(a^{n \div 2}\bigr)^2 & n \text{ par} \\
  a \cdot a^{n-1} & n \text{ ímpar}
\end{cases}$$

> **Dica Julia:** use `iseven(n)` para verificar paridade.
"""

# ╔═╡ bbb00067-0000-0000-0000-000000000067
function pot_rapida(a, n)
    @assert n >= 0
    # IMPLEMENTE AQUI
    # Atenção: no caso par, calcule pot_rapida(a, n÷2) UMA só vez
    # e depois faça metade * metade (não chame a função duas vezes!)

    return missing
end

# ╔═╡ bbb00068-0000-0000-0000-000000000068
let
    testes = [
        pot_rapida(2, 0) == 1,
        pot_rapida(2, 10) == 1024,
        pot_rapida(3, 5) == 243,
        pot_rapida(2, 64) == 2^64,
        pot_rapida(2, 64) == potencia(2, 64),
    ]
    all(testes) ? "✅ Todos os testes passaram!" : "❌ Algum teste falhou: $testes"
end

# ╔═╡ bbb00069-0000-0000-0000-000000000069
md"""
### Exercício 4 — MMC via MDC

Use a relação $\text{mmc}(a,b) = \dfrac{a \cdot b}{\text{mdc}(a,b)}$ para implementar `mmc(a, b)`.

> **Dica:** para evitar overflow, divida antes de multiplicar: `(a ÷ mdc(a,b)) * b`.
"""

# ╔═╡ bbb00070-0000-0000-0000-000000000070
function mmc(a, b)
    # IMPLEMENTE AQUI  (use a função mdc definida acima)

    return missing
end

# ╔═╡ bbb00071-0000-0000-0000-000000000071
let
    testes = [
        mmc(12, 18) == 36,
        mmc(4, 6) == 12,
        mmc(7, 13) == 91,
        mmc(100, 75) == 300,
    ]
    all(testes) ? "✅ Todos os testes passaram!" : "❌ Algum teste falhou: $testes"
end

# ╔═╡ bbb00080-0000-0000-0000-000000000080
md"""
---
## Resumo: o que aprendemos hoje

| Conceito | Descrição |
|:---------|:----------|
| **Recursão** | Função que chama a si mesma com argumento menor |
| **Caso base** | Condição de parada — sem ela há recursão infinita |
| **Convergência** | Garantia de que a recursão termina |
| **Pilha de chamadas** | Estrutura de memória usada pela recursão |
| **Eficiência** | Recursão ingênua pode ser $O(2^n)$; iteração é $O(n)$ |

### Entrega no Moodle

Salve este notebook com o nome `Semana03_SeuNome.jl` e entregue na atividade
correspondente no Moodle.

Certifique-se de que **todos os testes automáticos mostram ✅**.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.4"
manifest_format = "2.0"
project_hash = "f20af9a63323b1060a7b241a873638fb72e163a3"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "8b72179abc660bfab5e28472e019392b97d0985c"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.4"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.15.0+0"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.0+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "OpenSSL_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.3+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.12.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.11.4"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.4+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.12.1"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "ab55ee1510ad2af0ff674dbcced5e94921f867a9"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.59"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.7.0+0"
"""

# ╔═╡ Cell order:
# ╟─bbb00002-0000-0000-0000-000000000002
# ╟─bbb00003-0000-0000-0000-000000000003
# ╟─bbb00004-0000-0000-0000-000000000004
# ╠═bbb00001-0000-0000-0000-000000000001
# ╟─bbb00010-0000-0000-0000-000000000010
# ╠═bbb00011-0000-0000-0000-000000000011
# ╟─bbb00012-0000-0000-0000-000000000012
# ╠═bbb00013-0000-0000-0000-000000000013
# ╠═bbb00014-0000-0000-0000-000000000014
# ╟─bbb00015-0000-0000-0000-000000000015
# ╟─bbb00020-0000-0000-0000-000000000020
# ╟─bbb00021-0000-0000-0000-000000000021
# ╠═bbb00022-0000-0000-0000-000000000022
# ╟─bbb00023-0000-0000-0000-000000000023
# ╠═bbb00024-0000-0000-0000-000000000024
# ╟─bbb00025-0000-0000-0000-000000000025
# ╠═bbb00026-0000-0000-0000-000000000026
# ╠═bbb00027-0000-0000-0000-000000000027
# ╠═bbb00028-0000-0000-0000-000000000028
# ╟─bbb00029-0000-0000-0000-000000000029
# ╟─bbb00030-0000-0000-0000-000000000030
# ╟─bbb00031-0000-0000-0000-000000000031
# ╠═bbb00032-0000-0000-0000-000000000032
# ╠═bbb00033-0000-0000-0000-000000000033
# ╠═bbb00034-0000-0000-0000-000000000034
# ╟─bbb00035-0000-0000-0000-000000000035
# ╟─bbb00036-0000-0000-0000-000000000036
# ╟─bbb00037-0000-0000-0000-000000000037
# ╠═bbb00038-0000-0000-0000-000000000038
# ╠═bbb00039-0000-0000-0000-000000000039
# ╟─bbb00040-0000-0000-0000-000000000040
# ╟─bbb00041-0000-0000-0000-000000000041
# ╟─bbb00050-0000-0000-0000-000000000050
# ╟─bbb00051-0000-0000-0000-000000000051
# ╠═bbb00052-0000-0000-0000-000000000052
# ╠═bbb00053-0000-0000-0000-000000000053
# ╟─bbb00054-0000-0000-0000-000000000054
# ╠═bbb00055-0000-0000-0000-000000000055
# ╠═bbb00056-0000-0000-0000-000000000056
# ╟─bbb00057-0000-0000-0000-000000000057
# ╟─bbb00060-0000-0000-0000-000000000060
# ╠═bbb00061-0000-0000-0000-000000000061
# ╠═bbb00062-0000-0000-0000-000000000062
# ╟─bbb00063-0000-0000-0000-000000000063
# ╠═bbb00064-0000-0000-0000-000000000064
# ╠═bbb00065-0000-0000-0000-000000000065
# ╟─bbb00066-0000-0000-0000-000000000066
# ╠═bbb00067-0000-0000-0000-000000000067
# ╠═bbb00068-0000-0000-0000-000000000068
# ╟─bbb00069-0000-0000-0000-000000000069
# ╠═bbb00070-0000-0000-0000-000000000070
# ╠═bbb00071-0000-0000-0000-000000000071
# ╟─bbb00080-0000-0000-0000-000000000080
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
