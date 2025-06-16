
local function duplicate(t)
    local o = {}
    for k, v in pairs(t) do o[k] = v end
    return o
end

local function except(t, v)
    local is_done = false 
    local o = {}
    for _, e in ipairs(t) do 
        if (not is_done) and (e == v) then 
            is_done = true
            -- do not copy
        else 
            o[#o + 1] = e
        end
    end
    return o
end

function seq_to_str(s)
    local output = ""
    for _, e in ipairs(s) do 
        output = output .. " " .. tostring(e)
    end
    return output
end

function textify(seq)
    local stack = {}
    local push = function(n)
            stack[#stack + 1] = n
        end
    local pop = function()
            local r = stack[#stack]
            stack[#stack] = nil
            return r
        end

    local function any_of(e, t) 
        for _, s in ipairs(t) do 
            if e == s then return true end
        end
        return false
    end
    
    for _, token in ipairs(seq) do 
        if type(token) == "number" then 
            push(token)
        elseif any_of(token, {"+", "-", "/", "*", "^"}) then 
            local b = pop()
            local a = pop()
            push( "(" .. a .. token .. b .. ")" )
        elseif token == "!" then
            local n = pop()
            push( "("..  tostring(n) .. "!)" )
        else 
            print("invalid token")
            return nil
        end
    end

    assert(#stack == 1, "error, wrong seq")
    return pop()
end

function calculate(seq)
    local stack = {}
    local push = function(n)
            stack[#stack + 1] = n
        end
    local pop = function()
            local r = stack[#stack]
            stack[#stack] = nil
            return r
        end

    local wrap_binary = function(op) 
            return function() 
                    local b = pop()
                    local a = pop()
                    push( op(a,b) )
                    return true -- valid operation
                end
        end

    local operators = {
        ["+"] = wrap_binary(function(a,b) return a + b end) ,
        ["-"] = wrap_binary(function(a,b) return a - b end) ,
        ["*"] = wrap_binary(function(a,b) return a * b end) ,
        ["/"] = function()
                local b = pop()
                local a = pop()

                if b == 0 then return false end

                local r = a / b

                -- cannot be divided
                if (b * r) ~= a then 
                    return false
                end

                push(r)
                return true
            end,
        
        ["^"] = function ()
                local b = pop()
                local a = pop()

                local n = 0 
                local s = 1
                if s < 0 then return false end 
                while n < b do 
                    s = s * a
                    n = n + 1
                end 
                push(s)
                return true
            end,
        ["!"] = function ()
                local n = pop()
                if (n < 0) or (n > 50) then 
                    return false
                end
                local rst = 1
                while n >= 1 do 
                    rst = rst * n
                    n = n - 1
                end
                push(rst)
                return true
            end,
    }


    for _, token in ipairs(seq) do 
        -- print("meet:", token)
        -- try operator first, if not found, do nothing

        if type(token) == "number" then 
            push(token)
        else 
            local valid = assert(operators[token], "invalid token")()
            if not valid then 
                return nil, "invalid seq"
            end
        end
    end

    assert(#stack == 1, "error, wrong seq")
    return pop()
end

function search(nums)

    local function criterion(seq)
        local rst = calculate(seq)
        if rst == 24 then 
            print(textify(seq), "=", rst)
            return true, seq
        end
        return false, nil
    end

    assert(type(nums) == "table")

    local function recursive(seq, nums, depth) 
        local n_search = 0

        local function dive(token, deeper)
            local seq_next = duplicate(seq)
            seq_next[#seq_next + 1] = token
            local r, t = recursive(seq_next, except(nums, token), depth + deeper)
            n_search = n_search + 1
            return r, t
        end

        if depth >= 2 then 
            for _, c in ipairs{"+", "-", "*", "/"} do 
                local r,t =  dive(c, -1)
                if r then return r, t end
            end
        end 

        if #nums > 0 then 
            for _, n in pairs(nums) do 
                local r,t =  dive(n, 1)
                if r then return r, t end
            end
        end

        if (depth >= 1) and (seq[#seq] ~= "!" ) then 
            local r,t =  dive("!", 0)
            if r then return r, t end
        end

        -- nothing to search, abort
        if n_search == 0 then 
            return criterion(seq)
        end
    end -- end function recursive

    return recursive({}, nums, 0)
end


local inspect = require "inspect"

local function test1() 
    local test_seq = { 0, 1, 2, "-", 4, "*", "-"  }
    local nums = { 4, 6, 1, 2}
    print(inspect(nums))
    print(inspect(except(nums, 4)))
    local rst = calculate(test_seq)
    print(textify(test_seq), "=", rst)
end

local function test2()
    local r, seq = search{7,2,3,4}

    if r then 
        print("24 found")
    end
end

local function main()

    local nums = {}

    for i = 1, #arg do 
        local n = tonumber(arg[i])
        if n then 
            nums[#nums + 1] = n 
        end
    end

    if #nums == 4 then 
        local r, seq = search(nums)
        if r then print("found") end
    else 
        print("invalid arguments")
    end

end


local function test3()
    local test_seq = { 2, 1, 1, 1, "+", "+", "^" }
    local rst = calculate(test_seq)
    print(textify(test_seq), "=", rst)
end

-- test3()

-- test3()
main()