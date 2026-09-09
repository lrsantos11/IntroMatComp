### A Pluto.jl notebook ###
# v0.20.27

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

# ╔═╡ fa000001-0000-4000-8000-000000000001
begin
    using PlutoUI
    using LinearAlgebra
    using DataFrames
end

# ╔═╡ fa000002-0000-4000-8000-000000000002
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos  |  Semana 05 — Aula 01
"""

# ╔═╡ fa000003-0000-4000-8000-000000000003

md"""
# Erros em Algoritmos Numéricos
## Erros absolutos e relativos

Ao implementar algoritmos numéricos encontramos inevitavelmente erros, pois buscamos uma *aproximação $v$* de alguma *solução exata $u$*.

Há dois tipos principais:

- **Erro absoluto:**
```math
E_A = \lvert u - v \rvert
```
- **Erro relativo:**
```math
E_R = \frac{\lvert u - v \rvert}{\lvert u \rvert}, \quad u \neq 0
```

> O erro relativo é mais informativo: é adimensional e independe da escala do problema.
"""

# ╔═╡ fa000019-0000-4000-8000-000000000019

md"""
## 1. Funções de Erro

Usamos `norm` do `LinearAlgebra` para calcular normas (generaliza o valor absoluto para vetores).
"""

# ╔═╡ fa000020-0000-4000-8000-000000000020

Eₐ(u, v) = norm(u - v)              # erro absoluto

# ╔═╡ fa000021-0000-4000-8000-000000000021

Eᵣ(u, v) = norm(u - v) / norm(u)   # erro relativo

# ╔═╡ fa000022-0000-4000-8000-000000000022

md"""
### Exemplo: pares exato/aproximado
"""

# ╔═╡ fa000023-0000-4000-8000-000000000023

u = [1.0, 1.0, -1.5, 100.0, 100.0]

# ╔═╡ fa000024-0000-4000-8000-000000000024

v = [0.99, 1.01, -1.2, 99.99, 99.0]

# ╔═╡ a2a1fabe-c8ec-483c-a02a-397d2c853433

Eₐ(u, v)

# ╔═╡ 936e38fb-7a69-4cad-a5a0-be95e6b0fd06

Eᵣ(u, v)

# ╔═╡ 26947c99-a703-455b-99db-63ce480082cb

Eₐ.(u, v)

# ╔═╡ f8ac4cbe-7ec7-478c-9fe0-954fbe72db91

Eᵣ.(u, v)

# ╔═╡ fa000025-0000-4000-8000-000000000025

md"""
`Eₐ.(u, v)` usa o operador ponto (`.`) para **distribuir** a função sobre os vetores elemento a elemento (*broadcasting*).
"""

# ╔═╡ fa000026-0000-4000-8000-000000000026

df_erros = DataFrame(
    :ValorExato => u,
    :Aproximação => v,
    :ErroAbsoluto => Eₐ.(u, v),
    :ErroRelativo => Eᵣ.(u, v),
)

# ╔═╡ fa000032-0000-4000-8000-000000000032

md"""
## 2. Exemplo: Aproximação de Stirling para $n!$

A fórmula de Stirling:
```math
S_n = \sqrt{2\pi n}\left(\frac{n}{e}\right)^n \approx n!
```
é assintoticamente exata: $S_n / n! \to 1$ quando $n \to \infty$.
"""

# ╔═╡ fa000033-0000-4000-8000-000000000033

Sₙ(n) = sqrt(2π * n) * (n / ℯ)^n   #  e = \euler, π = \pi

# ╔═╡ fa000034-0000-4000-8000-000000000034

@bind n_max Slider(1:20, show_value=true, default=10)

# ╔═╡ fa000035-0000-4000-8000-000000000035

let
    ns = (collect(1:n_max))
    fat = factorial.(ns)
    stir = Sₙ.(ns)
    DataFrame(
        :n => ns,
        :n! => fat,
        :Sₙ => stir,
        :ErroAbsoluto => Eₐ.(fat, stir),
        :ErroRelativo => Eᵣ.(fat, stir),
    )
end

# ╔═╡ fa000036-0000-4000-8000-000000000036

md"""
!!! nota
	O erro *absoluto* cresce com $n$, mas o erro *relativo* decresce — Stirling fica **proporcionalmente** mais preciso para $n$ grande.
"""

# ╔═╡ c3a16d30-bcaa-4db2-b392-abd88d31d60b

md"""
## 3. Propagação de Erro e Instabilidade Numérica

Para ilustrar o impacto letal do erro de arredondamento em sequências numéricas, considere avaliar as integrais:

$$y_n = \int_{0}^{1} \frac{x^n}{x + 10} dx, \quad n = 1, \dots, 30.$$

Resolvendo a integral analiticamente para estabelecer uma relação, deduzimos a **recorrência progressiva**:

$$y_n = \frac{1}{n} - 10y_{n-1}$$

Onde o valor inicial é $y_0 = \ln(11) - \ln(10)$.
"""

# ╔═╡ 3407ef43-bb62-4c61-be42-42355a114560

function seq_progressiva(n_max)
    y = zeros(n_max)
    yzero = log(11) - log(10)
    #  n = 1
    y[1] = 1 - 10 * yzero
    for n = 2:n_max
        y[n] = 1 / n - 10 * y[n-1]
    end
    return y
end

# ╔═╡ aea0972c-e6a8-4dbc-a14c-03444360134e

seq_progressiva(30)

# ╔═╡ 34ceb838-b3fa-4139-9a8e-3f9e1f2fa3b4

DataFrame(:n => 1:30, :y_n => seq_progressiva(30))

# ╔═╡ 4ae08607-3893-4aff-95bd-310acabf11b2

md"""
!!! warning "Explosão do Erro"
    Note na tabela acima como, a partir de $n=18$, os valores começam a oscilar descontroladamente e assumir números gigantescos (e negativos!). Sabemos da integral original que $0 < y_n < 1$. O que aconteceu?
	
    A cada passo, o erro de arredondamento da iteração anterior é **multiplicado por -10**. Deixamos a derivação da solução estável (a recorrência regressiva) como exercício prático!
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
DataFrames = "~1.8.2"
PlutoUI = "~0.7.83"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.6"
manifest_format = "2.0"
project_hash = "48b7773c1a65ba058207dbfe48360a5d202a340c"

[[deps.AbstractPlutoDingetjes]]
git-tree-sha1 = "e71ee7b4aa06b045259a7d6101e1cb45ad140bce"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.4.1"

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
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "9d8a54ce4b17aa5bdce0ea5c34bc5e7c340d16ad"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.18.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.Crayons]]
git-tree-sha1 = "54b76cbb40d9a0f5368c880725b2f141da77c94f"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.2.0"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "DataStructures", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrecompileTools", "PrettyTables", "Printf", "Random", "Reexport", "SentinelArrays", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "5fab31e2e01e70ad66e3e24c968c264d1cf166d6"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.8.2"

[[deps.DataStructures]]
deps = ["OrderedCollections"]
git-tree-sha1 = "b0bc6d2cad1fed8b7fd59a1551a991cb3d2809e6"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.19.6"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

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
deps = ["Random", "Statistics"]
git-tree-sha1 = "59af96b98217c6ef4ae0dfe065ac7c20831d1a84"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.6"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "d1a86724f81bcd184a38fd284ce183ec067d71a0"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "1.0.0"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "0ee181ec08df7d7c911901ea38baf16f755114dc"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "1.0.0"

[[deps.InlineStrings]]
git-tree-sha1 = "06b65886c7577a3784d616e29f1302c2e36e389d"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.6"

    [deps.InlineStrings.extensions]
    ArrowTypesExt = "ArrowTypes"
    ParsersExt = "Parsers"

    [deps.InlineStrings.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"
    Parsers = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.InvertedIndices]]
git-tree-sha1 = "6da3c4316095de0f5ee2ebd875df8721e7e0bdbe"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.1"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f88f3ccef05a6a72a0cf0ed417c8fd68530f4ab2"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.15.0+0"

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
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

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

[[deps.OrderedCollections]]
git-tree-sha1 = "05f45c2e0de6259db764adbfd2f1dc6d3f8de13c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "2.0.1"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "e189d0623e7ce9c37389bac17e80aac3b0302e75"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.83"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "36d8b4b899628fb92c2749eb488d884a926614d3"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.3"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "edbeefc7a4889f528644251bdb5fc9ab5348bc2c"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.3.4"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "8b770b60760d4451834fe79dd483e318eee709c4"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.2"

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "REPL", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "1b8aa19f229b1cea7fc93874a52e49db6a854450"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "3.4.8"

    [deps.PrettyTables.extensions]
    PrettyTablesExcelExt = "XLSX"
    PrettyTablesTypstryExt = "Typstry"

    [deps.PrettyTables.weakdeps]
    Typstry = "f0ed7684-a786-439e-b1e3-3b82803b501e"
    XLSX = "fdbf4ff8-1666-58a4-91e7-1b58723a45e0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.REPL]]
deps = ["InteractiveUtils", "JuliaSyntaxHighlighting", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
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

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "084c47c7c5ce5cfecefa0a98dff69eb3646b5a80"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.10"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "13cd91cc9be159e3f4d95b857fa2aa383b53772a"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.3"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "e2b53ce13a53367e96601081e33d34746b571bad"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.5"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "773065c6e0e903924a9d838259be74338422aef2"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.5.0"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "a94d9bdda1b7bed0046cea645639ab3f62196fac"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.14.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "311349fd1c93a31f783f977a71e8b062a57d4101"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.13"

[[deps.URIs]]
git-tree-sha1 = "908fec9df6c5de98548ead82a468c95ccf6cd263"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.7.0"

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
"""

# ╔═╡ Cell order:
# ╠═fa000001-0000-4000-8000-000000000001
# ╟─fa000002-0000-4000-8000-000000000002
# ╟─fa000003-0000-4000-8000-000000000003
# ╟─fa000019-0000-4000-8000-000000000019
# ╠═fa000020-0000-4000-8000-000000000020
# ╠═fa000021-0000-4000-8000-000000000021
# ╟─fa000022-0000-4000-8000-000000000022
# ╠═fa000023-0000-4000-8000-000000000023
# ╠═fa000024-0000-4000-8000-000000000024
# ╠═a2a1fabe-c8ec-483c-a02a-397d2c853433
# ╠═936e38fb-7a69-4cad-a5a0-be95e6b0fd06
# ╠═26947c99-a703-455b-99db-63ce480082cb
# ╠═f8ac4cbe-7ec7-478c-9fe0-954fbe72db91
# ╟─fa000025-0000-4000-8000-000000000025
# ╠═fa000026-0000-4000-8000-000000000026
# ╟─fa000032-0000-4000-8000-000000000032
# ╠═fa000033-0000-4000-8000-000000000033
# ╠═fa000034-0000-4000-8000-000000000034
# ╠═fa000035-0000-4000-8000-000000000035
# ╟─fa000036-0000-4000-8000-000000000036
# ╟─c3a16d30-bcaa-4db2-b392-abd88d31d60b
# ╠═3407ef43-bb62-4c61-be42-42355a114560
# ╠═aea0972c-e6a8-4dbc-a14c-03444360134e
# ╠═34ceb838-b3fa-4139-9a8e-3f9e1f2fa3b4
# ╟─4ae08607-3893-4aff-95bd-310acabf11b2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
