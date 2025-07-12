
function div(n, q)
    while n >= q do 
        n = n - q
    end

    return (n==0)
end



function test()
    local ctr = 0
    for n = 1, 150 do 
        local s = n*n - 1

        if div(s, 120) then 
            ctr = ctr + 1 
        end
    end
    print("result is ", ctr)
end

test()