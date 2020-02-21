#=
Splittsteget:
- Julia version: 
- Author: Olav Milian
- Date: 2019-09-26
=#

function splitintwo(x,y)
    n = size(x, 1)
    print("\n")
    print(n, "  ")
    q = Int(floor((n + 1) / 2))
    print("\n")
    print(q, " q ")
    xv = x[1:q, :]
    xh = x[q+1:end, :]
    yv = zeros(q * 2)
    yv = reshape(yv, (q, 2))
    yh = zeros((n - q) * 2)
    yh = reshape(yh, (n - q, 2))
    jv = 1
    jh = 1
    for i in 1:n
        print("\n")
        print(xv)
        print("\n")
        print(xh)
        print("\n")
        print(yv)
        print("\n")
        print(yh)
        print("\n")
        if i <= q
            if (y[i, 2] in xv[:, 2]) && (y[i, 1] in xv[:, 1])
                yv[jv, :] = y[i, :]
                jv +=1
            else
                yh[jh, :] = y[i, :]
                jh +=1
            end
            print("\n", i)
        else
            print("\n", i - q)
            if (y[i, 2] in xv[:, 2]) && (y[i, 1] in xv[:, 1])
                yv[jv, :] = y[i, :]
                jv +=1
            else
                yh[jh, :] = y[i, :]
                jh +=1
            end
            print("ewrwe")
        end
        print("werwer")
    end
    print("werewrweteryrtuiyuouipøioåopi¨poå")
    return xv, xh, yv, yh
end

x = [1.0 2.0; 2.0 3.0; 3.0 2.0; 4.0 5.0; 6.0 6.0; 7.0 1.0]
y = [7.0 1.0; 1.0 2.0; 3.0 2.0; 2.0 3.0; 4.0 5.0; 6.0 6.0]
xv = [1.0 2.0; 2.0 3.0; 3.0 2.0]
xh = [4.0 5.0; 6.0 6.0; 7.0 1.0]
yv = [1.0 2.0; 3.0 2.0; 2.0 3.0]
yh = [7.0 1.0; 4.0 5.0; 6.0 6.0]

xv, xh, yv, yh = splitintwo(x, y)

print("\n")
print(xv)
print("\n")
print(xh)
print("\n")
print(yv)
print("\n")
print(yh)
print("\n")

