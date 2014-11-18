def test(x, &block) 
  puts (lambda &block).call(x)
end

test(3) do |x| 
  x
end
