# APIの役割（役の名前をつけて、強さ判定をする）を書く場所

require_relative '../../../../app/models/concerns/porker.check'
require_relative '../../../../app/models/concerns/handscore'


module API0
  module Ver1

    class Porker < Grape::API

      format :json


      # 共通処理の読み込み
      include PorkerCheck
      include HandScore

      # resourceはURLを作成するという意味。
      resource :porker do


        desc 'ポーカーの役を返す'
        post do


          # 入力エラー：パラメーターの入力形式が間違っている場合
          unless params.has_key?(:cards)
            return "パラメーターの形式が不正です。正しい形式で入力してください。"
          end


          # 入力したデータがparamsに代入されて、APIのエンドポイントで受け取る
          cards = params[:cards]


          # 入力エラー：カードが空白だった場合
          if cards.blank?
            return "空白になっています。5つのカード指定文字を半角スペース区切りで入力してください。"
          end






          # 空の配列を定義する
          handname = []
          result1  = []
          score    = []




          # 配列cardsの要素の数だけ、以下の処理を繰り返す
          cards.each do |abc|


            # 共通処理の読み込み
            gamelose       = PorkerCheck.validation1(abc)
            all_info_cards = PorkerCheck.handName(abc)
            gamewin        = PorkerCheck.handcheck(all_info_cards[0], all_info_cards[1])


            # 正しい値が入力されているかどうかをチェックする
            if gamelose.present?

              return gamelose

            else

              handname << gamewin


              # スコアリング
              handname.each do |d|
                if d === "ストレートフラッシュ" then
                  score << 9
                elsif d === "フォーオブアカインド" then
                  score << 8
                elsif d === "フルハウス" then
                  score << 7
                elsif d === "フラッシュ" then
                  score << 6
                elsif d === "ストレート" then
                  score << 5
                elsif d === "スリーオブアカインド" then
                  score << 4
                elsif d === "ツーペア" then
                  score << 3
                elsif d === "ワンペア" then
                  score << 2
                else
                  score << 1
                end
              end


              # 強さ判定
              score.each do |e|
                if e === score.max
                  @answer = true
                else
                  @answer = false
                end
              end

            end


            # 結果をハッシュに詰める
            @real_hash = { card: abc, hand: gamewin, best: @answer }
            result1.push(@real_hash)
          end


          # ビューに出力する
          @real_answer = { result: result1 }
          p @real_answer


        end


      end
    end
  end
end


