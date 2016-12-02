#/usr/bin/ruby
tf= [[4, 0, 0, 3, 1, 1, 0, 1, 2],[3, 0, 0, 3, 1, 1, 1, 0, 2],[2, 0, 0, 1, 2, 1, 2, 0, 0],[2, 1, 1, 2, 0, 1, 0, 3, 0],[1, 0, 2, 2, 0, 1, 0, 0, 0],[1, 3, 0, 3, 0, 1, 0, 0, 0]]

for i in 1..5 do
  for j in 0..4 do
    if j<i
      nai=0
      9.times do |p|
        nai+=tf[i][p]*tf[j][p]
      end
      nag1=0
      nag2=0
      9.times do |p|
        nag1+=tf[i][p]*tf[i][p]
        nag2+=tf[j][p]*tf[j][p]
      end
      print i+1,",",j+1,":",(nai)/(Math.sqrt(nag1)*Math.sqrt(nag2)),"\n"
    end
  end
end
