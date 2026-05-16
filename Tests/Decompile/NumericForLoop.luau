print("Hello World!");
for v1 = 1, 20 do
	print(v1);
	if v1 % 2 == 0 then
		continue;
	end;
	print("i % 2 ~= 0");
	print("Intermediate statement");
	print("Goodbye World!");
end;