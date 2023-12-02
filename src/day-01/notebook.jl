### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 2e0e76ad-ea10-4c2b-9c1b-4b8a3276d96b
function part_1(input)
	result = 0
	for l in split(input, "\n")
	    digits = []
	    for c in l
	        if isdigit(c)
	            push!(digits, c)
	        end
	    end
	    first_digit = first(digits)
	    last_digit = last(digits)
	    result += 10 * parse(Int, first_digit) + parse(Int, last_digit)
	end
	result
end

# ╔═╡ b769e85d-2119-4c76-808e-14f1a7577721
let input = "\
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet"
	part_1(input)
end

# ╔═╡ f74ab8e9-9aa5-45f3-b219-eb2473a9818e
let input = read("input.txt", String)
	part_1(input |> rstrip)
end

# ╔═╡ Cell order:
# ╠═2e0e76ad-ea10-4c2b-9c1b-4b8a3276d96b
# ╠═b769e85d-2119-4c76-808e-14f1a7577721
# ╠═f74ab8e9-9aa5-45f3-b219-eb2473a9818e
