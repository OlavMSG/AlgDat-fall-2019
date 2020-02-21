#=
Oving2_2:
- Julia version: 
- Author: Olav Milian
- Date: 2019-09-18
=#

## Du skal implementere denne funksjonen
function reverseandlimit(array, maxnumber)
	b = length(array)
    m = floor(Int, b / 2)
    if array[m + 1] > maxnumber
        array[m + 1] = maxnumber
    end
    for i in 1:m
        if array[i] > maxnumber
            ph = maxnumber
        else
            ph = array[i]
        end
        if array[b + 1 - i] > maxnumber
            array[b + 1 - i] = maxnumber
        end
        array[i] = array[b + 1 - i]
        array[b + 1 - i] = ph
    end
    return array
end




### Tests ###
# Disse testene blir kjør når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

# Helper function in case the argument is modified (IT should not be btw)
function deep(a) return deepcopy(a) end

## Simple array to be used in tests
array = [6,5,4,3,2,1]
array2 = [6,5,4,3,2,1, 1]

using Test
printstyled("\n\n---------------\nKjører tester!!\n---------------\n"; color = :magenta)
@testset "Basic tests" begin
    @test reverseandlimit(deep(array), 3) == [1,2,3,3,3,3]
    @test reverseandlimit(deep(array), 4) == [1,2,3,4,4,4]
    @test reverseandlimit(deep(array), 50) == [1,2,3,4,5,6]
    @test reverseandlimit(deep(array), -1) == [-1,-1,-1,-1,-1,-1]
    @test reverseandlimit(deep(array2), 50) == [1, 1,2,3,4,5,6]
    @test reverseandlimit(deep(array2), -1) == [-1,-1,-1,-1,-1,-1,-1]
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n\n\n")