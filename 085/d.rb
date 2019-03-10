require 'pp'

n, h = ARGF.gets.split(" ").map(&:to_i)

ai = []
bi = []
for _ in 0...n
  a, b = ARGF.gets.split(" ").map(&:to_i)
  ai << a
  bi << b
end

amax = ai.max

bi = bi.sort.reverse
count = 0
for i in 0...bi.size
  break if bi[i] <= amax

  h -= bi[i]
  count += 1

  if h <= 0
    puts count
    exit
  end
end

count += h/amax
count+=1 if h % amax != 0 

puts count
