#=
countingsortlength:
- Julia version: 
- Author: Olav Milian
- Date: 2019-10-04
=#
## Du skal implementere denne funksjonen
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



### Tests ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)

using Test
@testset "Basic tests" begin
    @test countingsortlength(["ccc", "bb", "a"]) == ["a", "bb", "ccc"]
    @test countingsortlength(["aaa", "bb", "c"]) == ["c", "bb", "aaa"]
    @test countingsortlength(["bb", "a", ""]) == ["", "a", "bb"] # Testen her sjekker om du kan sortere også med emtpy string
    @test countingsortlength(["bbbb", "aa", "aaaa", "ccc"]) == ["aa", "ccc", "bbbb", "aaaa"] # Fra oppgaven
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
