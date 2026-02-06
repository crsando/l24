
local t = {1, 0, 1}


for i = 4, 20 do 
	t[i] = t[i-2] + t[i-3]
end

print(t[20])
