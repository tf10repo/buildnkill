BK = {}

if CLIENT then
	-- Run all the cl_ files
	for _, Filename in SortedPairs(file.Find("btk/cl_*.lua", "LUA"), true) do
		include("btk/"..Filename)
	end

	-- Run all the sh_ files
	for _, Filename in SortedPairs(file.Find("btk/sh_*.lua", "LUA"), true) do
		include("btk/"..Filename)
	end
elseif SERVER then
	-- Run all the sv_ files
	for _, Filename in SortedPairs(file.Find("btk/sv_*.lua", "LUA"), true) do
		include("btk/"..Filename)
	end

	-- Transfer all the cl_ files to the client
	for _, Filename in SortedPairs(file.Find("btk/cl_*.lua", "LUA"), true) do
		AddCSLuaFile("btk/"..Filename)
	end

	-- Transfer all the sh_ files to the client, and run them
	for _, Filename in SortedPairs(file.Find("btk/sh_*.lua", "LUA"), true) do
		AddCSLuaFile("btk/"..Filename)
		include("btk/"..Filename)
	end
end

