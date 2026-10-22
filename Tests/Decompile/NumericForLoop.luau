-- [[ lunaux-decompiler.dev | v1.4.7 | discord.gg/2mJUD4XDDT ]]
-- [[ Luau version 11 | Types version 3 | took 0.4ms ]]

print("Hello World!")

for i = 1, 20 do
	print(i)
	
	if i % 2 ~= 0 then
		print("i % 2 ~= 0")
		print("Intermediate statement")
		print("Goodbye World!")
	end
end