### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 38fc2e36-c473-11f0-2d90-a9becdec9769
# ╠═╡ pluto_cell_id = "38fc2e36-c473-11f0-2d90-a9becdec9769"
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Semana 12 - Aula 01
"""

# ╔═╡ cdf8afe7-ab82-45e7-bfab-13c4bbf56bbb
# ╠═╡ pluto_cell_id = "cdf8afe7-ab82-45e7-bfab-13c4bbf56bbb"
using LinearAlgebra

# ╔═╡ 11449667-a3db-426b-b6b2-b4738f1fbcfa
# ╠═╡ pluto_cell_id = "11449667-a3db-426b-b6b2-b4738f1fbcfa"
md"""
### Problema de Quadrados Mínimos

Suponha que você queria ajustar um conjunto de ``n`` pontos ``(x_i, y_i)`` em uma reta ``y = a_0 + a_1 x``. Isto pode ser expressado como o sistema sobredeterminado 

```math
\begin{bmatrix}
1 & x_1\\
1 & x_2 \\
\vdots & \vdots \\
1 & x_n 
\end{bmatrix}
\begin{bmatrix}
a_0\\a_1
\end{bmatrix} = 
\begin{bmatrix}
y_1 \\
y_2 \\
 \vdots \\
y_n 
\end{bmatrix}
```
"""

# ╔═╡ 038df58d-0239-45d1-a34a-ab2ccdffa7a4
# ╠═╡ pluto_cell_id = "038df58d-0239-45d1-a34a-ab2ccdffa7a4"
# Dados em X
x_data = 0:0.1:10

# ╔═╡ c627c1bf-0be4-4eae-863e-d3f2808d602b
# ╠═╡ pluto_cell_id = "c627c1bf-0be4-4eae-863e-d3f2808d602b"
# Tamanoh dos dados
m = length(x_data)

# ╔═╡ e452bdc0-f58a-43b5-9c6e-eecc4aed615f
# ╠═╡ pluto_cell_id = "e452bdc0-f58a-43b5-9c6e-eecc4aed615f"
# Y perturbado 
# y = 3x - 2 +  dados aleatórios com ruído
y_data = 3x_data .- 2 + 2randn(m)

# ╔═╡ 2a62988b-b41a-48e4-a88f-9b9b612e1236
# ╠═╡ pluto_cell_id = "2a62988b-b41a-48e4-a88f-9b9b612e1236"
using Plots

# ╔═╡ 345ca377-2193-4299-9357-7cc4faee4c50
# ╠═╡ pluto_cell_id = "345ca377-2193-4299-9357-7cc4faee4c50"
# Plotar gráfico de espalhamento dos dados x_data vs y_data
plt = scatter(x_data, y_data, label =  "Dados", marker_size = 3)

# ╔═╡ 474fbfe9-d594-4e8c-8b6f-06df3e3ca37b
# ╠═╡ pluto_cell_id = "474fbfe9-d594-4e8c-8b6f-06df3e3ca37b"
# Matrix A
A = [ones(m) x_data]

# ╔═╡ d353d832-8fe9-4a69-9bf6-46361b20375e
# ╠═╡ pluto_cell_id = "d353d832-8fe9-4a69-9bf6-46361b20375e"
b = y_data

# ╔═╡ 9ef17684-2ded-405c-80fc-d54f7b6fbd3c
# ╠═╡ pluto_cell_id = "9ef17684-2ded-405c-80fc-d54f7b6fbd3c"
AtA = A' * A

# ╔═╡ 98fabda6-a2d0-4039-a030-ca2bd2d1552c
# ╠═╡ pluto_cell_id = "98fabda6-a2d0-4039-a030-ca2bd2d1552c"
Atb = A'* b

# ╔═╡ 69ce04bd-a607-4e64-8871-7fe0003f35db
# ╠═╡ pluto_cell_id = "69ce04bd-a607-4e64-8871-7fe0003f35db"
x_sol = AtA \ Atb

# ╔═╡ 8783cd26-fc67-48bf-891c-e42a23ee10a8
# ╠═╡ pluto_cell_id = "8783cd26-fc67-48bf-891c-e42a23ee10a8"
begin
	a0 = x_sol[1]
	a1 = x_sol[2]
	reta(x) = a0 + a1*x
	plot(plt, reta, 0, 10, label = "Ajuste linear", color = :red, lw = 3)
end

# ╔═╡ d399adcb-78c9-41cf-a936-cd2189334a08
# ╠═╡ pluto_cell_id = "d399adcb-78c9-41cf-a936-cd2189334a08"
erro = .5 * norm(b - A*x_sol)^2

# ╔═╡ e1b5fcb9-27cc-4dcf-98d6-3fb59320d70c
# ╠═╡ pluto_cell_id = "e1b5fcb9-27cc-4dcf-98d6-3fb59320d70c"
erro2 = .5 * norm(b - A*[-2, 3])^2

# ╔═╡ 6e71c8bf-fc90-4772-b0c2-8bc309b5a276
# ╠═╡ pluto_cell_id = "6e71c8bf-fc90-4772-b0c2-8bc309b5a276"
md"""
#### Ajuste de dados não lineares, porém com base linear
"""

# ╔═╡ 00570b18-4c01-418c-a7fc-35a1a46feb7e
# ╠═╡ pluto_cell_id = "00570b18-4c01-418c-a7fc-35a1a46feb7e"


# ╔═╡ 11bd525f-9582-4b38-b85e-8724ecced6c4
# ╠═╡ pluto_cell_id = "11bd525f-9582-4b38-b85e-8724ecced6c4"


# ╔═╡ ce283fca-b8c6-4175-9eed-27b046729c1e
# ╠═╡ pluto_cell_id = "ce283fca-b8c6-4175-9eed-27b046729c1e"
begin
	m2 = 200
	
	true_coeffs = [2; -2; .5]

	
	x_data2 = rand(m2)*5
	x_data_expanded2 = hcat([x_data2 .^ i for i in 1 : 3]...)
	y_data2 = x_data_expanded2 * true_coeffs + .8 * randn(m2)
	plt2 = scatter(x_data2, y_data2, label = "Dados Aleatórios")
end

# ╔═╡ 2d4315ad-2ea0-46a0-b1bc-6cf87060be21
# ╠═╡ pluto_cell_id = "2d4315ad-2ea0-46a0-b1bc-6cf87060be21"
begin
 	A2 = [ones(m2) x_data2]
 	b2 = y_data2
	A2tA2 = A2'*A2
	A2tb2 = A2'*b2
	xsol2 = A2tA2 \ A2tb2
	reta2(x) = xsol2[1] + xsol2[2]*x
	plot(plt2, reta2, 0, 5, label = "Ajuste linear", color = :red, lw = 3)


end

# ╔═╡ 04fa0116-801c-40c4-8757-8f0475a47878
# ╠═╡ pluto_cell_id = "04fa0116-801c-40c4-8757-8f0475a47878"
erro_2 = .5 * norm(b2 - A2*xsol2)^2

# ╔═╡ 1fe3df56-c2f9-4c44-8719-078b2bfe084b
# ╠═╡ pluto_cell_id = "1fe3df56-c2f9-4c44-8719-078b2bfe084b"
md"""
##### Ajustando uma parábola
"""

# ╔═╡ 8378ab83-b4b6-4c4c-bf9b-6d3992c9be0d
# ╠═╡ pluto_cell_id = "8378ab83-b4b6-4c4c-bf9b-6d3992c9be0d"
begin
 	A3 = [ones(m2) x_data2 x_data2.^2]
 	b3 = y_data2
	A3tA3 = A3'*A3
	A3tb3 = A3'*b3
	xsol3 = A3tA3 \ A3tb3
	@info  .5 * norm(b3 - A3*xsol3)^2
	parabola1(x) = xsol3[1] + xsol3[2]*x + xsol3[3]* x^2
	plot(plt2, parabola1, 0, 5, label = "Ajuste quadrático", color = :blue, lw = 3)


end

# ╔═╡ 63f71837-6b4f-4c11-a93b-c334bc778e45
# ╠═╡ pluto_cell_id = "63f71837-6b4f-4c11-a93b-c334bc778e45"
md"""
##### Ajustando uma Cúbica
"""

# ╔═╡ 460b7b09-5669-4edc-89b0-e2905791ac72
# ╠═╡ pluto_cell_id = "460b7b09-5669-4edc-89b0-e2905791ac72"
begin
 	A4 = [ones(m2) x_data2 x_data2.^2 x_data2.^3]
 	b4 = y_data2
	# A3tA3 = A3'*A3
	# A3tb3 = A3'*b3
	xsol4 = A4 \ b4
	@info xsol4
	@info  .5 * norm(b4 - A4*xsol4)^2
	cubica(x) = xsol4[1] + xsol4[2]*x + xsol4[3]* x^2 + xsol4[4] * x^3
	plot(plt2, cubica, 0, 5, label = "Ajuste cúbico", color = :black, lw = 3)


end

# ╔═╡ 67bfb83a-4abc-40c7-a752-3b2a005c863d
# ╠═╡ pluto_cell_id = "67bfb83a-4abc-40c7-a752-3b2a005c863d"
md"""
#### Fatoração QR
```math
Ax = b \Rightarrow Rx = Q^Tb
```
"""

# ╔═╡ 2ba744ae-4203-48f4-bb7f-7137ed4e3fc4
# ╠═╡ pluto_cell_id = "2ba744ae-4203-48f4-bb7f-7137ed4e3fc4"
# Fatoração QR
FatQR = qr(A4)

# ╔═╡ 5895c0c4-24b7-4076-899e-1e54a0d5f50f
# ╠═╡ pluto_cell_id = "5895c0c4-24b7-4076-899e-1e54a0d5f50f"
# Solução de Quadrados Mínimos
FatQR.R \ FatQR.Q[:,1:4]' * b4

# ╔═╡ Cell order:
# ╠═38fc2e36-c473-11f0-2d90-a9becdec9769
# ╠═cdf8afe7-ab82-45e7-bfab-13c4bbf56bbb
# ╠═11449667-a3db-426b-b6b2-b4738f1fbcfa
# ╠═038df58d-0239-45d1-a34a-ab2ccdffa7a4
# ╠═c627c1bf-0be4-4eae-863e-d3f2808d602b
# ╠═e452bdc0-f58a-43b5-9c6e-eecc4aed615f
# ╠═2a62988b-b41a-48e4-a88f-9b9b612e1236
# ╠═345ca377-2193-4299-9357-7cc4faee4c50
# ╠═474fbfe9-d594-4e8c-8b6f-06df3e3ca37b
# ╠═d353d832-8fe9-4a69-9bf6-46361b20375e
# ╠═9ef17684-2ded-405c-80fc-d54f7b6fbd3c
# ╠═98fabda6-a2d0-4039-a030-ca2bd2d1552c
# ╠═69ce04bd-a607-4e64-8871-7fe0003f35db
# ╠═8783cd26-fc67-48bf-891c-e42a23ee10a8
# ╠═d399adcb-78c9-41cf-a936-cd2189334a08
# ╠═e1b5fcb9-27cc-4dcf-98d6-3fb59320d70c
# ╠═6e71c8bf-fc90-4772-b0c2-8bc309b5a276
# ╠═00570b18-4c01-418c-a7fc-35a1a46feb7e
# ╠═11bd525f-9582-4b38-b85e-8724ecced6c4
# ╠═ce283fca-b8c6-4175-9eed-27b046729c1e
# ╠═2d4315ad-2ea0-46a0-b1bc-6cf87060be21
# ╠═04fa0116-801c-40c4-8757-8f0475a47878
# ╠═1fe3df56-c2f9-4c44-8719-078b2bfe084b
# ╠═8378ab83-b4b6-4c4c-bf9b-6d3992c9be0d
# ╠═63f71837-6b4f-4c11-a93b-c334bc778e45
# ╠═460b7b09-5669-4edc-89b0-e2905791ac72
# ╠═67bfb83a-4abc-40c7-a752-3b2a005c863d
# ╠═2ba744ae-4203-48f4-bb7f-7137ed4e3fc4
# ╠═5895c0c4-24b7-4076-899e-1e54a0d5f50f
