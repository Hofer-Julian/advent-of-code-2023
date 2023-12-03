### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 1af040a2-90fa-11ee-1397-1930d430630e
md"## Day 2"

# ╔═╡ 75c07b34-c6f3-421e-bc02-b3beca91a100
md"### Part 1"

# ╔═╡ 695c1fe7-40c9-4d24-bdc2-168cac4de709
struct RGB
	red::Int
	green::Int
	blue::Int
end

# ╔═╡ e99f7970-0c78-4d16-96fb-244bb24338bb
function is_set_possible(set::AbstractString, content::RGB)::Bool
	for cube in split(set, ",")
		cube = strip(cube)
		count, color = match(r"(\d+) (.*)", cube).captures
		count = parse(Int, count)
		if color == "red" && count > content.red
			return false
		elseif color == "green" && count > content.green
			return false
		elseif color == "blue" && count > content.blue
			return false
		end
	end
	true
end

# ╔═╡ 921f2637-5310-4f84-9323-059e3c96a27e
function is_game_possible(game::AbstractString, content::RGB)::Bool
	for set in split(game, ";")
		if !is_set_possible(set, content)
			return false
		end
	end
	true
end

# ╔═╡ f79e3f5e-1566-45f6-acd0-f890facd48ab
function part_1(input::AbstractString)::Int
	content = RGB(12, 13, 14)
	sum = 0
	for line in split(input, "\n")
		id, game = match(r"Game (\d+): (.*)", line).captures
		if is_game_possible(game, content)
			sum += parse(Int, id)
		end
	end
	sum
end

# ╔═╡ 307ab643-435c-4f98-9859-c419f15304aa
let input = """\
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"""
	result = part_1(input) 
	@assert  result == 8 "result of $result is incorrect"
end

# ╔═╡ afab1083-e6be-41e9-9235-25e0dfe231ff
let input = read("input.txt", String) |> strip
	part_1(input)
end

# ╔═╡ 9954d70b-41c1-4088-93f4-b84282fdd0cb
md"### Part 2"

# ╔═╡ 4530c09f-1370-46ae-9909-2d6081c1dac8
function merge(a::RGB, b::RGB)::RGB
	RGB(max(a.red, b.red), max(a.green, b.green), max(a.blue, b.blue))
end

# ╔═╡ 5db61eff-2f47-4c20-9d25-625f8ddd48da
function parse_set(set::AbstractString)::RGB
	set_rgb = RGB(0, 0, 0)
	for cube in split(set, ",")
		cube = strip(cube)
		count, color = match(r"(\d+) (.*)", cube).captures
		count = parse(Int, count)
		if color == "red"
			set_rgb = merge(set_rgb, RGB(count, 0, 0))
		elseif color == "green"
			set_rgb = merge(set_rgb, RGB(0, count, 0))
		elseif color == "blue"
			set_rgb = merge(set_rgb, RGB(0, 0, count))
		end
	end
	set_rgb
end

# ╔═╡ 920b3fa4-95c1-4eb0-b217-cecc52f9e9d2
function power_game(game::AbstractString)::Int
	min_set = RGB(0, 0, 0)
	for set in split(game, ";")
		min_set = merge(min_set, parse_set(set))
	end
	min_set.red * min_set.green * min_set.blue
end

# ╔═╡ 24bb68b3-1698-4aa1-8ad0-d97f16b8fc60
function part_2(input::AbstractString)::Int
	sum = 0
	for line in split(input, "\n")
		id, game = match(r"Game (\d+): (.*)", line).captures
		sum += power_game(game)
	end
	sum
end

# ╔═╡ af0e8fd6-3618-4750-9147-b78080171389
let input = """\
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"""
	result = part_2(input) 
	@assert  result == 2286 "result of $result is incorrect"
end

# ╔═╡ a1a3ad44-706b-47f2-b3fa-9762db035d8d
let input = read("input.txt", String) |> strip
	part_2(input)
end

# ╔═╡ Cell order:
# ╟─1af040a2-90fa-11ee-1397-1930d430630e
# ╟─75c07b34-c6f3-421e-bc02-b3beca91a100
# ╠═695c1fe7-40c9-4d24-bdc2-168cac4de709
# ╠═f79e3f5e-1566-45f6-acd0-f890facd48ab
# ╠═921f2637-5310-4f84-9323-059e3c96a27e
# ╠═e99f7970-0c78-4d16-96fb-244bb24338bb
# ╠═307ab643-435c-4f98-9859-c419f15304aa
# ╠═afab1083-e6be-41e9-9235-25e0dfe231ff
# ╟─9954d70b-41c1-4088-93f4-b84282fdd0cb
# ╠═24bb68b3-1698-4aa1-8ad0-d97f16b8fc60
# ╠═920b3fa4-95c1-4eb0-b217-cecc52f9e9d2
# ╠═5db61eff-2f47-4c20-9d25-625f8ddd48da
# ╠═4530c09f-1370-46ae-9909-2d6081c1dac8
# ╠═af0e8fd6-3618-4750-9147-b78080171389
# ╠═a1a3ad44-706b-47f2-b3fa-9762db035d8d
