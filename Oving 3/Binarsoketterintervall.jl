#=
Binarsoketterintervall:
- Julia version: 
- Author: Olav Milian
- Date: 2019-09-25
=#
function binaryintervalsearch(x, delta, coordinate)
    n = size(x, 1)
    print("\n")
    print(n, "  ")
    q = Int(floor((n + 1) / 2))
    print("\n")
    print(q, " q ")
    if n%2 == 0
        median = (x[q, coordinate] + x[q + 1, coordinate]) / 2
    else
        median = x[q, coordinate]
    end

    min = median - delta
    max = median + delta
    print("\n")
    print(median, "  ")
    print("\n")
    print(median - delta, "  ", median+ delta)
    lq = Int(floor((q + 1) / 2))
    print("\n")
    print("  ", lq)
    min_index, max_index = 0, 0
    while true
        print("\n")
        print(" lq ", lq)

        if x[lq, coordinate] >= min
            print("\n")
            print(" hei sdreeeqwerwetwertyeryertf")
            if lq == 1
                min_index = lq
                print("\n")
                print(" minindex ", min_index)
                break
            elseif x[lq - 1, coordinate] < min
                min_index = lq
                print("\n")
                print(" minindex ", min_index)
                break
            end
            lq = Int(floor((lq + 1) / 2))
        elseif x[lq, coordinate] < min
            if lq == q && x[lq + 1, coordinate] >= max
                min_index = -1
                print("\n")
                print(" min_index ", min_index)
                break
            end
            print("\n")
            print(" hei sdreeetyeryertf")
            lq = Int(floor((q + 1 + lq) / 2))
        end
    end

    #print(min_index)
    rq = Int(floor((n + q) / 2))
    print("\n")
    print("  ", rq)

    while true
        print("\n")
        print(" rq ", rq)

        if x[rq, coordinate] <= max
            print("\n")
            print(" hei ")
            if rq == n
                print("\n")
                print(" hei sdf")
                max_index = rq
                print("\n")
                print(" maxindex ", max_index)
                break
            elseif x[rq + 1, coordinate] > max
                print("\n")
                print(" hei sderyhrtf")
                max_index = rq
                print("\n")
                print(" maxindex ", max_index)
                break
            end
            rq = Int(floor((n + 1 + rq) / 2))
        elseif x[rq, coordinate] > max
            print("\n")
            print(" hei sdfsfsdgdfhfgjfghjgh")
            if rq == q + 1 && x[rq - 1, coordinate] <= min
                max_index = -1
                print("\n")
                print(" maxindex ", max_index)
                break
            end
            rq = Int(floor((q + rq) / 2))
        end
    end
    return (min_index, max_index)
end

I = binaryintervalsearch([1 2; 2 0; 3 3; 4 4], 0.25, 1)
print("\n")
print(I)
I = binaryintervalsearch([1 0; 2 0; 2 0; 3 0; 4 0; 5 0; 5 0], 1, 1)
print("\n")
print(I)