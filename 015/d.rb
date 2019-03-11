require 'pp'

# W = ARGF.gets.to_i
# N, K = ARGF.gets.split(" ").map(&:to_i)
# ai = []
# bi = []
# # pi = []
# for _ in 0...N
#   a, b = ARGF.gets.split(" ").map(&:to_i)
#   ai << a
#   bi << b
#   # pi << b.to_f/a
# end
#
# # order = pi.each_with_index.sort.reverse.map(&:last)
#
# dp = Array.new(N+1) do Array.new(W+1) do Array.new(K+1, 0) end end
#
# for i in 0...N
#   for w in 1..W
#     for k in 1..K
#       if w >= ai[i] 
#         # pp dp[i][w-ai[i]][k-1]
#         dp[i+1][w][k] = [dp[i][w-ai[i]][k-1]+bi[i], dp[i][w][k]].max
#       else
#         dp[i+1][w][k] = dp[i][w][k]
#       end
#     end
#   end
# end
#
# puts dp[N][W][K]

W = ARGF.gets.to_i
N, K = ARGF.gets.split(" ").map(&:to_i)
A = []
B = []
# pi = []
for _ in 0...N
  a, b = ARGF.gets.split(" ").map(&:to_i)
  A << a
  B << b
  # pi << b.to_f/a
end

DP = Array.new(W+1) do Array.new(K+1) do Array.new(N+1) end end

def dfs(restW, restK, curN)
  return 0 if restW <= 0 || restK <= 0 || curN == N

  m = DP[restW][restK][curN]
  return m unless m.nil?

  if restW >= A[curN] && restK > 0
    res = [ B[curN] + dfs(restW-A[curN], restK-1, curN+1), dfs(restW, restK, curN+1) ].max
  else
    res = dfs(restW, restK, curN+1)
  end

  DP[restW][restK][curN] = res
  return res
end

puts dfs(W, K, 0)
