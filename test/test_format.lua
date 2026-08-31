local function foo()
	local x = { "a", "b", "c" }
	for i, v in ipairs(x) do
		print(i, v)
	end
end

local t = { a = 1, b = 2, c = 3 }
return t
