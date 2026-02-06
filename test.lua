
--[[

function criterion(a,b,c)
    return (2025 >= 10 * a) and 
        (10 * a > 100 * b) and 
        (100 * b >= 1000 * c) 
end


for b = 10, 20 do 
    local cnt = 0 
    for a = 1,2025 do 
        for c = 1, 1 do 
            if criterion(a,b,c) then cnt = cnt + 1 end
        end
    end

    print(b, cnt)
end

print(cnt)

]]



local cnt = 0
for a = -3, 3 do 
    for b = -3, 3 do 
        for c = -3, 3 do 
            if a+ b + c == 0 then 
                cnt = cnt + 1
            end
        end
    end
end
print(cnt)