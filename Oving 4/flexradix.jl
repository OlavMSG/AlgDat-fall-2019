#=
flexradix:
- Julia version: 
- Author: Olav Milian
- Date: 2019-10-04
=#

## Hvis du bruker denne, kan jeg desverre ikke gi ut LF
## Da må du fylle den ut selv
## Du skal implementere denne funksjonen
function countingsortletters(A,position)
	#TODO
    n = length(A)
    max = A[1][position]
    for i in 2:n
        k = A[i][position]
        if max < k
            max = k
        end
    end
    max = chartodigit(max)
    C = zeros(Int, max)
    for j in 1:n
        k = chartodigit(A[j][position])
        C[k] += 1
    end
    for i in 2:max
        C[i] += C[i - 1]
    end
    B = fill("", n)
    for j in 1:n
        k = chartodigit(A[n + 1 - j][position])
        B[C[k]] = A[n + 1 - j]
        C[k] -= 1
    end
    return B
end


# Don't mind me
function chartodigit(character)
    #Dette er en hjelpefunksjon for å få omgjort en char til tall
    #Den konverterer 'a' til 1, 'b' til 2 osv.
    #Eksempel: chartodigit("hei"[2]) gir 5 siden 'e' er den femte bokstaven i alfabetet.
    return character - '`'
end

## Hvis du bruker denne, kan jeg desverre ikke gi ut LF
## Da må du fylle den ut selv
function countingsortlength(A)
    # TODO
    n = length(A)
    max = length(A[1])
    r = 0
    for i in 2:n
        k = length(A[i])
        if max < k
            max = k
        end
        if k == 0
            r = 1
        end
    end
    C = zeros(Int, max + r)
    for j in 1:n
        k = length(A[j])
        C[k + r] += 1
    end
    for i in 2:max+r
        C[i] += C[i - 1]
    end
    B = fill("", n)
    for j in 1:n
        k = length(A[n + 1 - j])
        B[C[k + r]] = A[n + 1 - j]
        C[k + r] -= 1
    end
    return B
end

## Du skal implementere denne funksjonen
function flexradix(A, maxlength)
    # TODO
    n = length(A)
    B = countingsortlength(A)
    C = zeros(Int, n)
    for i in 1:n
        C[i] = length(B[i])
    end
    while maxlength > 0
        for i in 1:n
            if C[i] == maxlength
                B[i:end] = countingsortletters(B[i:end], maxlength)
                C[i] -= 1
                break
            end
        end
        maxlength -= 1
    end
    return B
end





### Tests ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Basic tests" begin
    @test flexradix(["d", "c", "b", "a"], 1) == ["a", "b", "c", "d"]
    @test flexradix(["d", "c", "b", ""], 1) == ["", "b", "c", "d"]
    @test flexradix(["jeg", "elsker", "deg"], 6) == ["deg", "elsker", "jeg"]
    @test flexradix(["denne", "oppgaven", "mangler", "emojies"], 8) == ["denne", "emojies", "mangler", "oppgaven"]
    @test flexradix(["kobra", "aggie", "agg", "kort", "hyblen"], 6) == ["agg", "aggie", "hyblen", "kobra", "kort"] # Fra oppgaven
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")