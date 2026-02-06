

function a(x,y,z)
    if (x < 0 ) or (y < 0 ) or (z < 0) then 
        return 0
    elseif (x == 0 ) or (y==0) or (z==0) then 
        return math.pow(2, x + y + z )
    else 
        return a(x - 1, y, z ) + a(x, y-1, z) + a(x, y, z-1)
    end 
end

print(a(3,3,1))