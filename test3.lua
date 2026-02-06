local inspect = require "inspect"

local seq = { 1,2,3,4,5,6,7,8,9 } 

function clone(s)
    local o = {}
    for k, v in pairs(s) do 
        o[k]= v
    end
    return o
end

function except(s, t)
    local o = {}
    for k ,v in pairs(s) do 
        if v == t then 
            -- do nothing
        else 
            o[k] = v
        end
    end
    return o
end

function is_empty(s)
    for k,v in pairs(s) do 
        return false
    end
    return true
end

function search(seq, candidates, hook)
    if is_empty(candidates) then
        hook(seq)
        return
    end

    for _, v in pairs(candidates) do 
        local o = clone(seq)
        o[#o + 1] = v
        search(o, except(candidates, v), hook)
    end
end



function criterion(seq)
    local k = 1
    while 2*k < #seq do 
        if seq[2*k-1] < seq[2 * k] then 
            return false 
        elseif seq[2*k+1] < seq[2 * k] then 
            return false
        end
        k = k + 1
    end
    return true
end


local cnt = 0
search({}, {1,2,3,4,5, 6,7}, 
    function (seq) cnt = cnt + (criterion(seq) and 1 or 0) end
)

print(cnt)