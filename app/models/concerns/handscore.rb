# 今使ってないファイル！

module HandScore
include PorkerCheck

     def self.scoretest(card3)
       # binding.pry
       case card3
       when "ストレートフラッシュ"
         return 9
       when "フォー・オブ・ア・カインド"
         return 8
       when "フルハウス"
         return 7
       when "フラッシュ"
         return 6
       when "スリーオブアカイン"
         return 5
       when "ストレート"
         return 4
       when "スリーオブカインド"
         return 3
       when "ワンペア"
         return 2
       else "ハイカード"
       return 1
       end

     end



  end

  # 役の強さ判定
  # scoreing = handname(card)


#   end
#
#
# end
