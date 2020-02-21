#=
mincoinsgreedy:
- Julia version: 
- Author: Olav Milian
- Date: 2019-10-22
=#
function mincoinsgreedy(coins, value)
    k = 1
    coin_count = 0
    while value != 0
        @inbounds for coin in coins[k:end]
            @fastmath if coin <= value
                coin_count += 1
                value -= coin
                break
            else
                k +=1
            end
        end
    end
    return coin_count
end

### Tester ###
# Disse testene blir kjørt når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!

printstyled("\n\n\n---------------\nKjører tester\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test mincoinsgreedy([1000,500,100,20,5,1],1226) == 6
  @test mincoinsgreedy([20,10,5,1],99) == 10
  @test mincoinsgreedy([5,1],133) == 29
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")
