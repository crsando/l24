

function check(seq)
    for i = 1, 4 do 
        local j = i + 1; if j > 4 then j = 1 end;
        if (seq[i] == 1) and (seq[j] == 1) then 
            return false 
        end
        if (seq[i] == 2) and (seq[j] == 2) then 
            return false 
        end
    end

    return true
end


print(check{1,2,3,4})
print(check{1,1,3,4})
print(check{1,3,2,2})


local cnt = 0
for a = 1,4 do
    for b = 1,4 do 
        for c = 1,4 do 
            for d = 1,4 do 
                local seq = {a,b,c,d}
                if check(seq) then 
                    cnt = cnt + 1
                end
            end 
        end
    end
end

print(cnt)