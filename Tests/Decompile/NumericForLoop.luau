
print("Hello World!")

for i = 1, 20 do
	print(i)
	
	if i % 2 ~= 0 then
		print("i % 2 ~= 0")
		print("Intermediate statement")
		print("Goodbye World!")
	end
end