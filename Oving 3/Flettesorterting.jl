#=
Flettesorterting:
- Julia version: 
- Author: Olav Milian
- Date: 2019-09-25
=#

# x og y er to sorterte tabeller, coordinate angir koordinat
function mergearrays(x,y,coordinate)
    n_x = size(x, 1)
    n_y = size(y, 1)
    n = n_x + n_y
    i = 1
    j = 1
    xy = zeros(n * 2)
    xy = reshape(xy, (n, 2))
    for k in 1:n
        if i <= n_x && j > n_y
            xy[k, :] = x[i, :]
            i += 1
        elseif i > n_x && j <= n_y
            xy[k, :] = y[j, :]
            j += 1
        elseif x[i,coordinate] <= y[j,coordinate]
            xy[k, :] = x[i, :]
            i += 1
        elseif x[i,coordinate] > y[j,coordinate]
            xy[k, :] = y[j, :]
            j += 1
        end
    end
    return xy
end

# x er en usortert tabell, coordinate angir koordinat vi skal sortere langs
function mergesort(x, coordinate)
    n_x = size(x, 1)
    q = Int(floor(n_x/2))
    if n_x != 1
        x1 = mergesort(x[1:q, :], coordinate)
        x2 = mergesort(x[q+1:n_x, :], coordinate)
        x3 = mergearrays(x1, x2, coordinate)
        return x3
    else
        return x
    end
end

D = mergearrays([1 2; 2 2], [2 1; 3 3], 1)
print("\n")
print([1 2; 2 2; 2 1; 3 3])
print("\n")
print(D)
D = mergesort([1 2; 4 6; 2 1],1)
print("\n")
print([1 2; 2 1; 4 6])
print("\n")
print(D)
D = mergesort([1 2; 4 5; 2 1],2)
print("\n")
print([2 1; 1 2; 4 5])
print("\n")
print(D)