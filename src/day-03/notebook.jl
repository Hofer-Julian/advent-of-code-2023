### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 6c825b38-d2b6-4e41-9cd7-6e5d45ce5763
md"## Day 3"

# ╔═╡ 26540c4e-a4ee-456c-b0d7-77735d786503
md"### Part 1"

# ╔═╡ f1c46df3-f14b-4629-bc76-67dc67b808bd
function parse_schematic(input::AbstractString)::Matrix{Char}
	n = split(input, '\n') |> length
	schematic = Matrix{Char}(undef, n, n)
	row = 1
	column = 1
	for c in input
		if c == '\n'
			row += 1
			column = 1
		else
			schematic[row, column] = c
			column += 1
		end
	end
	schematic
end

# ╔═╡ efcfa412-5374-4246-b0a3-2724a0e63980
function is_symbol(char::Char)::Bool
	if char |> isdigit
		false
	elseif char == '.'
		false
	else 
		true
	end
end

# ╔═╡ 0148da0a-e4c1-4532-a2fe-15611e650571
function surrounding_symbol(
    schematic::Matrix{Char},
    row::Int,
    column::Int,
    n::Int,
)::Bool
    if row > 1
		r = row - 1
		if schematic[r, column] |> is_symbol
        	return true
		elseif column > 1 && schematic[r, column - 1] |> is_symbol
			return true
		elseif column < n && schematic[r, column + 1] |> is_symbol
			return true
		end
	end
	
    if row < n
		r = row + 1
		if schematic[r, column] |> is_symbol
        	return true
		elseif column > 1 && schematic[r, column - 1] |> is_symbol
			return true
		elseif column < n && schematic[r, column + 1] |> is_symbol
			return true
		end
	end
	
    if column > 1 && schematic[row, column - 1] |> is_symbol
		return true
	end
	
    if column < n && schematic[row, column + 1] |> is_symbol
        return true
	end
    
	false
end


# ╔═╡ 834c2dfd-7a09-4079-b112-e40566f5ae1b
function part_1(input)::Int
	schematic = parse_schematic(input)
	n = size(schematic)[1]
	total = 0
	number = ""
	valid = false
	for row in 1:n
		for column in 1:n
			value = schematic[row, column]
			if value |> isdigit
				number = string(number, value)
				if surrounding_symbol(schematic, row, column, n)
					valid = true
				end
			else
				if valid
					total += parse(Int, number)
				end
				number = ""
				valid = false
			end
		end
		if valid
			total += parse(Int, number)
		end
		number = ""
		valid = false
	end
	total
end

# ╔═╡ f3f3bb95-861f-4c5c-a7bd-df4ca4b99f63
let input = """\
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...\$.*....
.664.598.."""
	result = part_1(input) 
	@assert result == 4361 "result of $result is incorrect"
end

# ╔═╡ 521c1284-91c9-11ee-12d4-ed62ea9f74a7
let input = read("input.txt", String) |> strip
	part_1(input)
end

# ╔═╡ Cell order:
# ╟─6c825b38-d2b6-4e41-9cd7-6e5d45ce5763
# ╟─26540c4e-a4ee-456c-b0d7-77735d786503
# ╠═f1c46df3-f14b-4629-bc76-67dc67b808bd
# ╠═834c2dfd-7a09-4079-b112-e40566f5ae1b
# ╠═0148da0a-e4c1-4532-a2fe-15611e650571
# ╠═efcfa412-5374-4246-b0a3-2724a0e63980
# ╠═f3f3bb95-861f-4c5c-a7bd-df4ca4b99f63
# ╠═521c1284-91c9-11ee-12d4-ed62ea9f74a7
