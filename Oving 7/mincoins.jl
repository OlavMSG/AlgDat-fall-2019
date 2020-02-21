#=
mincoins:
- Julia version: 
- Author: Olav Milian
- Date: 2019-10-22
=#
function usegreed(coins)
    use_greed = true
    @inbounds for i in 1:length(coins)-1
        if coins[i] % coins[i+1] != 0
            use_greed = false
            break
        end
    end
    return use_greed
end

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

function mincoins(coins, value)
    if usegreed(coins) # min_coins if the right answer
        return mincoinsgreedy(coins, value)
    else # worst case I need value 1-coins
    	r = zeros(value)
		@inbounds for j in 1:value
			if j in coins
				r[j] = 1
			else
				q = j
				for coin in coins
					if coin <= j
    					pot_q = 1 + r[j - coin]
                        if pot_q < q
                            q = pot_q
                        end
					end
				end
				r[j] = q
			end
		end
		@inbounds return r[value]
    end
end

### Tester ###
# Disse testene blir kjørt når du kjører filen
# Du trenger ikke å endre noe her, men du kan eksperimentere!


printstyled("\n\n\n---------------\nKjører tester\n---------------\n"; color = :magenta)

using Test
@testset "Tester" begin
	@test mincoins([4,3,1],18) == 5
  @test mincoins([1000,500,100,30,7,1],14) == 2
  @test mincoins([40, 30, 20, 10, 1], 90) == 3
  @test mincoins([1000, 500, 200, 100, 40, 30, 10, 5, 1], 2567) == 8
end

println("\nFungerte alt? Prøv å kjør koden i inginious!")
println("Husk at disse testene ikke alltid sjekker alle edge-cases")
println("---------------------------------------------------------\n\n")