function x = chebyshev(a, b, N, k)
x = 0.5 * (a+b) + 0.5 * (b-a) * cos(pi * (2*k-1)/(2*N))
end