
class HomeController < ApplicationController

  # 共通処理を書いたファイルを読み込む（require：ファイルの読み込みをする）
  require_relative '../../app/models/concerns/porker.check'
  include PorkerCheck


  def top
    card = params[:card]


    if card.present?


       if PorkerCheck.validation1(card).present?
        @name = PorkerCheck.validation1(card)


       else
        all_info_card = PorkerCheck.handName(card)
        @name = PorkerCheck.handcheck(all_info_card[0], all_info_card[1])
       end


     else

      @name = "空白になっています。5つのカード指定文字を半角スペース区切りで入力してください。" if card&.empty? || card&.blank?

    end


  end




end
