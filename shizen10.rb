ku = [8360,17440,12420,24500]
dou = [26600,5070,8090,3340,2160]
soukann = [[371,84,59,1,1],[486,2,75,52,10],[137,18,29,192,2],[730,13,154,97,14]]
size = 20000000.0
kudamono = Array.new(10){Array.new(6)}

print "分散表示:\n"
4.times do |i|
    case i
    when 0 then
        print "いちご:\n"
    when 1 then
        print "ナシ:\n"
    when 2 then
        print "みかん:\n"
    when 3 then
        print "りんご:\n"
    end
    5.times do |j|
        kudamono[i][j] = Math.log2((soukann[i][j]/size)/((ku[i]/size)*(dou[j]/size)))
        if kudamono[i][j]<0 
            p 0
        else p kudamono[i][j]
        end
    end
    print "\n"
end
print "\n"

print "類似度:\n"
3.times do |i|
    nai = 0
    f = 0
    s = 0
    5.times do |j|
        nai += kudamono[3][j]*kudamono[i][j]
    end
    5.times do |j|
        f += kudamono[3][j]*kudamono[3][j]
    end
    5.times do |j|
        s += kudamono[i][j]*kudamono[i][j]
    end
    case i
    when 0 then
        print "いちご:\n"
    when 1 then
        print "ナシ:\n"
    when 2 then
        print "みかん:\n"
    end
    p (nai/(Math.sqrt(f) * Math.sqrt(s)))
    print "\n"
end
