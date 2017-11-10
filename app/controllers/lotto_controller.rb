class LottoController < ApplicationController
  def index
  end

  def show
    @lottonum = [*1..45].sample(6).sort
  end
  
  def api
    require 'json'
    
    @lottonum = [*1..45].sample(6).sort
    
    url = 'http://www.nlotto.co.kr/common.do?method=getLottoNumber'
    res = HTTParty.get(url)
    result = JSON.parse(res.body)
    
    @bn = Array.new
    @js = Array.new
    
    result.each do |key,value|
        @js << value if key.include? 'drwtNo'
        @bn << value if key.include? 'bnusNo'
    end
    
    # 6.times do |i|
    #   #@js.append(result['drwtNo'+(i+1).to_s])
    #   @js << result["drwtNo#{i+1}"]
    # end
    
    @fnum = @lottonum & (@js + @bn)
    #p @fnum.include?(@bn) @bn 은 array 형식이기 때문에 false가 return 됨.
    @ranking = (@fnum.count == 6  && @fnum.include?(@bn.pop)) ? '2등' : (@fnum.count == 6)? '1등' : 
               (@fnum.count == 5) ? '3등' : (@fnum.count == 4) ? '4등' : (@fnum.count == 3) ? '5등' : '꽝'

  end
end
