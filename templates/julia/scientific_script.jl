using LinearAlgebra

A = [1 2; 3 4]
b = [5, 6]

x = A \ b

println("Solution:")
println(x)
