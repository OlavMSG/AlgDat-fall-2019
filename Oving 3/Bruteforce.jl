#=
Bruteforce:
- Julia version: 
- Author: Olav Milian
- Date: 2019-09-26
=#


function bruteforce(x)
    n = size(x, 1)
    min = -1
    for i in 1:n-1
        for j in i+1:n
            pot_min = ((x[i, 1] - x[j, 1]) ^ 2 + (x[i, 2] - x[j, 2]) ^ 2) ^(1/2)
            print("\npot_min")
            print(pot_min)
            if (i==1 && j==2)
                min = pot_min
            elseif pot_min < min
                min = pot_min
            end
            print("\nmin")
            print(min)
        end
    end
    return min
end

x = [2 2; 10 0; 1 1; 5 5]
y = bruteforce(x)
print("\n")
print(y)