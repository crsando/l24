local inspect = require "inspect"
local function factor(n)
    local flg = true 

    local function item(f, cnt)
        if (cnt or 0) <= 0 then return end 

        if flg then 
            flg = false
        else
            io.stdout:write(" x ")
        end

        io.stdout:write(f)

        if cnt > 1 then 
            io.stdout:write("^", cnt)
        end
    end


    local f = 2

    while n > 1 do 
        local cnt = 0 
        while n % f == 0 do 
            cnt = cnt + 1
            n = n / f
        end

        item(f, cnt)
        f = f + 1
    end

    print("")
end



if arg[1] then 
    factor(tonumber(arg[1]))
end
