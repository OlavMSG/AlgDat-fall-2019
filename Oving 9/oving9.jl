#=
findset:
- Julia version: 
- Author: Olav Milian
- Date: 2019-10-29
=#
mutable struct DisjointSetNode
    rank::Int
    p::DisjointSetNode
    DisjointSetNode() = (obj = new(0); obj.p = obj;)
end

#oppgave 1
function findset(x)
    if x != x.p
        x.p = findset(x.p)
    end
    return x.p
end

#oppgave 2
function link!(x,y)
    if x.rank > y.rank
        y.p = x
    else
        x.p = y
        if x.rank == y.rank
            y.rank += 1
        end
    end
end

function union!(x, y)
    link!(findset(x), findset(y))
end


#oppgave 3
function hammingdistance(s1, s2)
    count = 0
    @inbounds for i in 1:length(s1)
        if s1[i] != s2[i]
            count += 1
        end
    end
    return count
end

#oppgave 4
function findclusters(E, n, k)
    @inbounds nodes = [DisjointSetNode() for i in 1:n]
    @inbounds sort!(E)
    no_lists = n
    @inbounds for (w, u, v) in E
        if no_lists == k
            break
        end
        if findset(nodes[u]) != findset(nodes[v])
            union!(nodes[u], nodes[v])
            no_lists -= 1
        end
    end
    @inbounds lists = Dict{DisjointSetNode, Vector{Int}}()
    @inbounds for i in 1:n
        node = findset(nodes[i])
        list = get!(lists, node, Vector{Int}())
        push!(list, i)
    end
    @inbounds return collect(Vector{Int}, values(lists))
end

#oppgave 5
function findanimalgroups(animals, k)
    @inbounds E = Tuple{Int, Int, Int}[]
    println(E)
    @inbounds n = length(animals)
    @inbounds node_index_array = [i for i in 1:n]
    @inbounds for i in 1:n
        for j in i+1:n
            w = hammingdistance(animals[i][2], animals[j][2])
            push!(E, (w, node_index_array[i], node_index_array[j]))
            push!(E, (w, node_index_array[j], node_index_array[i]))
        end
    end
    grouplist_nodes = [[1], [2, 3]] #findclusters(E, n, k)
    @inbounds grouplist_animals = []
    println(grouplist_animals)
    @inbounds for list in grouplist_nodes
        animallist = []
        for i in 1:length(list)
            push!(animallist, animals[list[i]][1])
        end
        push!(grouplist_animals, animallist)
    end
    return grouplist_animals
end

k = 2
animals = [("Ugle", "CGGCACGT"), ("Elg", "ATTTGACA"), ("Hjort", "AATAGGCC")]

Q = findanimalgroups(animals, k)
println(Q)














#test oppgave 4
if true
    println("---------------------")
    n = 2
    k = 2
    E=Tuple{Int64,Int64,Int64}[(1, 1, 2), (1, 2, 1)]

    Q = findclusters(E, n, k)
    println("1 ",Q) #Any[[1], [2]]

    n= 1
    k = 1
    E=Tuple{Int64,Int64,Int64}[]

    Q = findclusters(E, n, k)
    println("2 ",Q) # Any[[1]]


    n= 3
    k = 1
    E=Tuple{Int64,Int64,Int64}[(1, 1, 2), (2, 1, 3), (3, 2, 3), (1, 2, 1), (2, 3, 1), (3, 3, 2)]

    Q = findclusters(E, n, k)
    println("3 ",Q) #Any[[1, 2, 3]]

    n=3
    k=3
    E=Tuple{Int64,Int64,Int64}[(1, 1, 2), (2, 1, 3), (3, 2, 3), (1, 2, 1), (2, 3, 1), (3, 3, 2)]
    Q = findclusters(E, n, k)
    println("4 ",Q) #Any[[1], [2], [3]]
end