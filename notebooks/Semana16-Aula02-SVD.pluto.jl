### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ 60007818-cc5a-11f0-96cb-154fedaff16d
# ╠═╡ pluto_cell_id = "60007818-cc5a-11f0-96cb-154fedaff16d"
md"""
## UFSC/Blumenau
### MAT4642 - Introdução à Matemática Computacional
### Prof. Luiz-Rafael Santos
### Semana 16 - Aula 02
"""

# ╔═╡ 0f90a5d0-3b0a-4d81-8430-c46badcae84f
# ╠═╡ pluto_cell_id = "0f90a5d0-3b0a-4d81-8430-c46badcae84f"
md"""
 ## Singular Value Decomposition e Compressão de Imagens
"""

# ╔═╡ 1304b548-e631-4e10-872e-591349d5a7a8
# ╠═╡ pluto_cell_id = "1304b548-e631-4e10-872e-591349d5a7a8"
using LinearAlgebra

# ╔═╡ d6b5dadb-e031-484c-a3c9-3443ffd7cac5
# ╠═╡ pluto_cell_id = "d6b5dadb-e031-484c-a3c9-3443ffd7cac5"
A = randn(40,20)

# ╔═╡ b6034c23-6c14-4f6f-beb8-8ab4db3f748d
# ╠═╡ pluto_cell_id = "b6034c23-6c14-4f6f-beb8-8ab4db3f748d"
U, Σ, V = svd(A)

# ╔═╡ 0d2bfafd-2069-4906-bf49-c41975ceab8b
# ╠═╡ pluto_cell_id = "0d2bfafd-2069-4906-bf49-c41975ceab8b"
Σ

# ╔═╡ 78ba767b-211b-4286-8673-ae4a01104818
# ╠═╡ pluto_cell_id = "78ba767b-211b-4286-8673-ae4a01104818"
norm(A - U*Diagonal(Σ)*V')

# ╔═╡ b2988802-bdd8-4cb2-95db-87bbc35066cd
# ╠═╡ pluto_cell_id = "b2988802-bdd8-4cb2-95db-87bbc35066cd"
F = svd(A)

# ╔═╡ eaaae42e-952c-47d4-9025-27f83ed82349
# ╠═╡ pluto_cell_id = "eaaae42e-952c-47d4-9025-27f83ed82349"
F.Vt

# ╔═╡ e5880912-a531-44e4-a239-19d476e9d727
# ╠═╡ pluto_cell_id = "e5880912-a531-44e4-a239-19d476e9d727"
U'*U

# ╔═╡ 4870df71-4d2a-4aec-b8db-d0ec948d5769
# ╠═╡ pluto_cell_id = "4870df71-4d2a-4aec-b8db-d0ec948d5769"
V'*V

# ╔═╡ 81b9b060-f66c-492a-851a-e5230b88e0b0
# ╠═╡ pluto_cell_id = "81b9b060-f66c-492a-851a-e5230b88e0b0"
md"""
# Usando imagens no Julia
"""

# ╔═╡ 3b6e67aa-863a-4415-a2f0-24a281ebac84
# ╠═╡ pluto_cell_id = "3b6e67aa-863a-4415-a2f0-24a281ebac84"
using Images, FileIO

# ╔═╡ a6ef3e89-9351-44a0-a1f0-de0c9d9e7762
# ╠═╡ pluto_cell_id = "a6ef3e89-9351-44a0-a1f0-de0c9d9e7762"
img = float.(load("../assets/Knicks.png"))

# ╔═╡ aedfa4cc-a082-4cfe-a476-85558d7213c3
# ╠═╡ pluto_cell_id = "aedfa4cc-a082-4cfe-a476-85558d7213c3"
size(img)

# ╔═╡ 6b108ed8-3d6a-4454-8665-c714d2148e5a
# ╠═╡ pluto_cell_id = "6b108ed8-3d6a-4454-8665-c714d2148e5a"
channelview(img)

# ╔═╡ efe04dc6-e48c-476b-be63-8ff5c5edcdc6
# ╠═╡ pluto_cell_id = "efe04dc6-e48c-476b-be63-8ff5c5edcdc6"
img_cinza = Gray.(img)

# ╔═╡ 8e7dc369-a352-4857-b860-f6faa512f509
# ╠═╡ pluto_cell_id = "8e7dc369-a352-4857-b860-f6faa512f509"
channelview(img_cinza)

# ╔═╡ 8f4b18d3-c6c1-4691-b91f-71f0c7676d5b
# ╠═╡ pluto_cell_id = "8f4b18d3-c6c1-4691-b91f-71f0c7676d5b"


# ╔═╡ 5272f54b-9992-457c-8cb0-655216681eee
# ╠═╡ pluto_cell_id = "5272f54b-9992-457c-8cb0-655216681eee"
F_img = svd(img_cinza)

# ╔═╡ 1a6e8a06-c54c-4851-a5c4-641519057f27
# ╠═╡ pluto_cell_id = "1a6e8a06-c54c-4851-a5c4-641519057f27"
using Plots

# ╔═╡ 25eb751b-360d-4657-8ab2-52314db82fbc
# ╠═╡ pluto_cell_id = "25eb751b-360d-4657-8ab2-52314db82fbc"
plot(F_img.S, title = "Distribuição de Valores Singulares", leg = false)

# ╔═╡ fdc145e9-99c3-4861-844b-8a324057065a
# ╠═╡ pluto_cell_id = "fdc145e9-99c3-4861-844b-8a324057065a"
function rank_approx(F_SVD, k)
	U, Σ, V = F_SVD
	img_approx = U[:,1:k]*Diagonal(Σ[1:k])* V[:,1:k]'
	colorview(Gray, img_approx)
end

# ╔═╡ df326888-023d-49a0-a13c-807be700ce3c
# ╠═╡ pluto_cell_id = "df326888-023d-49a0-a13c-807be700ce3c"
using PlutoUI

# ╔═╡ 0b61638b-c028-45d6-b8a6-2e76fcca7939
# ╠═╡ pluto_cell_id = "0b61638b-c028-45d6-b8a6-2e76fcca7939"
m,n = size(img_cinza)

# ╔═╡ 00d72f20-ca11-453e-b34e-85999f5438ff
# ╠═╡ pluto_cell_id = "00d72f20-ca11-453e-b34e-85999f5438ff"
@bind k Slider(1:min(m,n), show_value=true)

# ╔═╡ 9d4398d0-649c-4ae7-bfb1-4b5e1547968b
# ╠═╡ pluto_cell_id = "9d4398d0-649c-4ae7-bfb1-4b5e1547968b"
rank_approx(F_img, k)

# ╔═╡ Cell order:
# ╠═60007818-cc5a-11f0-96cb-154fedaff16d
# ╠═0f90a5d0-3b0a-4d81-8430-c46badcae84f
# ╠═1304b548-e631-4e10-872e-591349d5a7a8
# ╠═d6b5dadb-e031-484c-a3c9-3443ffd7cac5
# ╠═b6034c23-6c14-4f6f-beb8-8ab4db3f748d
# ╠═0d2bfafd-2069-4906-bf49-c41975ceab8b
# ╠═78ba767b-211b-4286-8673-ae4a01104818
# ╠═b2988802-bdd8-4cb2-95db-87bbc35066cd
# ╠═eaaae42e-952c-47d4-9025-27f83ed82349
# ╠═e5880912-a531-44e4-a239-19d476e9d727
# ╠═4870df71-4d2a-4aec-b8db-d0ec948d5769
# ╠═81b9b060-f66c-492a-851a-e5230b88e0b0
# ╠═3b6e67aa-863a-4415-a2f0-24a281ebac84
# ╠═a6ef3e89-9351-44a0-a1f0-de0c9d9e7762
# ╠═aedfa4cc-a082-4cfe-a476-85558d7213c3
# ╠═6b108ed8-3d6a-4454-8665-c714d2148e5a
# ╠═efe04dc6-e48c-476b-be63-8ff5c5edcdc6
# ╠═8e7dc369-a352-4857-b860-f6faa512f509
# ╠═8f4b18d3-c6c1-4691-b91f-71f0c7676d5b
# ╠═5272f54b-9992-457c-8cb0-655216681eee
# ╠═1a6e8a06-c54c-4851-a5c4-641519057f27
# ╠═25eb751b-360d-4657-8ab2-52314db82fbc
# ╠═fdc145e9-99c3-4861-844b-8a324057065a
# ╠═df326888-023d-49a0-a13c-807be700ce3c
# ╠═0b61638b-c028-45d6-b8a6-2e76fcca7939
# ╠═00d72f20-ca11-453e-b34e-85999f5438ff
# ╠═9d4398d0-649c-4ae7-bfb1-4b5e1547968b
