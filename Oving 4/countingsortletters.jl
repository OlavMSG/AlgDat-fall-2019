#=
countingsortletters:
- Julia version: 
- Author: Olav Milian
- Date: 2019-09-27
=#
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



### Tests ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Basic tests" begin
    @test countingsortletters(["aa", "bb", "cc"], 1) == ["aa", "bb", "cc"]
    @test countingsortletters(["cc", "bb", "aa"], 2) == ["aa", "bb", "cc"]
    @test countingsortletters(["ac", "bb", "ca"], 2) == ["ca", "bb", "ac"]
    @test countingsortletters(["ccc", "cba", "ca", "ab", "abc"], 2) == ["ca", "cba", "ab", "abc", "ccc"]
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")