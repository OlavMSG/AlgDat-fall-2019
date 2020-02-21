#=
Minsteavstandinlogn:
- Julia version: 
- Author: Olav Milian
- Date: 2019-09-26
=#
# x og y er to sorterte tabeller, coordinate angir koordinat
function mergearrays(x,y,coordinate)
	n_x, m_x = size(x)
    n_y, m_y = size(y)
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
	n_x, m_x = size(x)
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

function binaryintervalsearch(x, delta, coordinate)
	n = size(x, 1)
    q = Int(floor((n + 1) / 2))
    if n%2 == 0
        median = (x[q, coordinate] + x[q + 1, coordinate]) / 2
    else
        median = x[q, coordinate]
    end
    min = median - delta
    max = median + delta
    lq = Int(floor((q + 1) / 2))
    min_index, max_index = 0, 0
    while true
        if x[lq, coordinate] >= min
            if lq == 1
                min_index = lq
                break
            elseif x[lq - 1, coordinate] < min
                min_index = lq
                break
            end
            lq = Int(floor((lq + 1) / 2))
        elseif x[lq, coordinate] < min
            if lq == q && x[lq + 1, coordinate] >= max
                min_index = -1
                break
            end
            lq = Int(floor((q + 1 + lq) / 2))
        end
    end
    rq = Int(floor((n + q) / 2))
    while true
        if x[rq, coordinate] <= max
            if rq == n
                max_index = rq
                break
            elseif x[rq + 1, coordinate] > max
                max_index = rq
                break
            end
            rq = Int(floor((n + 1 + rq) / 2))
        elseif x[rq, coordinate] > max
            if rq == q + 1 && x[rq - 1, coordinate] <= min
                max_index = -1
                break
            end
            rq = Int(floor((q + rq) / 2))
        end
    end
    return (min_index, max_index)
end

function bruteforce(x)
	n = size(x, 1)
    min = -1
    for i in 1:n-1
        for j in i+1:n
            pot_min = ((x[i, 1] - x[j, 1]) ^ 2 + (x[i, 2] - x[j, 2]) ^ 2) ^(1/2)
            if (i==1 && j==2)
                min = pot_min
            elseif pot_min < min
                min = pot_min
            end
        end
    end
    return min
end

function splitintwo(x,y)
	n = size(x, 1)
    q = Int(floor((n + 1) / 2))
    xv = x[1:q, :]
    xh = x[q+1:end, :]
    yv = zeros(q * 2)
    yv = reshape(yv, (q, 2))
    yh = zeros((n - q) * 2)
    yh = reshape(yh, (n - q, 2))
    jv = 1
    jh = 1
    for i in 1:n
        if i <= q
            if (y[i, 2] in xv[:, 2]) && (y[i, 1] in xv[:, 1])
                yv[jv, :] = y[i, :]
                jv +=1
            else
                yh[jh, :] = y[i, :]
                jh +=1
            end
        else
            if (y[i, 2] in xv[:, 2]) && (y[i, 1] in xv[:, 1])
                yv[jv, :] = y[i, :]
                jv +=1
            else
                yh[jh, :] = y[i, :]
                jh +=1
            end
        end
    end
    return xv, xh, yv, yh
end

function callclosestpair(arr, hva=0)
    x = mergesort(arr,1)
    y = mergesort(arr,2)
    #x = [1.0 2.0; 2.0 3.0; 3.0 2.0; 4.0 5.0; 6.0 6.0; 7.0 1.0]

    #y = [7.0 1.0; 1.0 2.0; 3.0 2.0; 2.0 3.0; 4.0 5.0; 6.0 6.0]
    if hva == 1
        return bruteforce(x)
    end
    return closestpair(x,y)
end

function closestpair(x,y)
    n = size(x, 1)
    if n <= 3
        delta = bruteforce(x)
    else
        xv, xh, yv, yh = splitintwo(x, y)
        min_v = closestpair(xv, yv)
        min_h = closestpair(xh, yh)
        if min_v < min_h
            delta = min_v
        else
            delta = min_h
        end
		(imin_x, imax_x) = binaryintervalsearch(x, delta, 1)
		(imin_y, imax_y) = binaryintervalsearch(y, delta, 2)
		if (imin_x != -1 && imax_x != -1 && imin_y != -1 && imax_y != -1)
			print(x[imin_x:imax_x, :], " x \n")
			print(y[imin_y:imax_y, :], " y \n")
		end
		"""if imin <= 0
			imin = 1
		end
		if imax >= n +1
			imax = n
		end
		print(imin, "  ", n / 2, "   ", imax, "\n")
        if imin <= imax
    		n2 = size(y[imin:imax, :], 1)
			ym = y[imin:imax, :]
			print(n2, " n2\n")
			print(delta, " delta\n")
			print(y, "\n")
			print(y[imin:imax, :], "\n")
			min3 = bruteforce(y[imin:imax, :])
			if min3 >= 0 && delta > min3
				delta = min3
			end
        end"""
    end
    return delta
end



for i in 1:1
    arr = rand(50, 2)

    min1 = callclosestpair(arr, 1)

    print(min1, " bruteforce\n")

    min2 = callclosestpair(arr)

    print(min1, " bruteforce\n")
    print(min2, " not bruteforce\n")

    if min1 == min2
        print("yes\n")
    end
end
