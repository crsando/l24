
local function f(n)
	if n == 1 then return 1 end
	
	local s = 1
    local d = 1
    while d <= n/2 do 
        if (n % d) == 0 then 
            s = s + f(d)
        end 
        d = d + 1
    end
    return s
end


local N = { 1, 2,3, 20, 40, 100, 200 }

for _, k in ipairs(N) do 
    print(k, f(k))
end