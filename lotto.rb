require 'httparty'
@lottonum = [*1..45].sample(6).sort
    url = 'http://www.nlotto.co.kr/common.do?method=getLottoNumber'
    res = HTTParty.get(url)
    result = JSON.parse(res.body)
    
    @bn = result['bnusNo']
    @js = Array.new
    
    result.each do |key,value|
        @js << value if key.include? 'drwtNo'
    end
    
    # 6.times do |i|
    #   #@js.append(result['drwtNo'+(i+1).to_s])
    #   @js << result["drwtNo#{i+1}"]
    # end
 
    totnum = @js
    @finalnum = @lottonum & (totnum << @bn)
    p @lottonum
    p @js.sort
    p @finalnum.count