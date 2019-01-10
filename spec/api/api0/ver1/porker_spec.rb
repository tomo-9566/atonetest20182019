require 'rails_helper'

RSpec.describe API0::Ver1::Porker do


  context "正常系" do

    describe "ベスト判定" do

      params = {
        "cards":
          ["H1 H13 H12 H11 H10", "H9 C9 S9 H2 C6", "C13 D12 C11 H8 H7"]
      }

      it "1番大きいカードの値に対してベスト判定を下す" do
        post '/api/porker.json', params
        json = JSON.parse(response.body)

        expect(json).to eq({ "result" =>
                               [{ "card" => "H1 H13 H12 H11 H10", "hand" => "ストレートフラッシュ", "best" => true },
                                { "card" => "H9 C9 S9 H2 C6", "hand" => "スリーオブアカインド", "best" => false },
                                { "card" => "C13 D12 C11 H8 H7", "hand" => "ハイカード", "best" => false }] })
      end

    end

  end


  context "異常系" do

    describe "共通処理ファイルで定義したエラーメッセージを返す" do
      include PorkerCheck
      it "半角英大文字SHDC以外または半角の数字1〜13以外の場合" do

        card = "H1 H2 H3 H4 H14"

        expect(PorkerCheck.validation1(card)).to eq("半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。")
      end
    end




    describe "APIにおけるエラーメッセージを返す" do

      it "入力フォームが空の場合" do
        post '/api/porker.json', cards: ""
        expect(response.body).to include("空白になっています。5つのカード指定文字を半角スペース区切りで入力してください。")
      end

    end


    describe "APIにおけるエラーメッセージを返す" do
      params = {
        "card":
          ["H1 H13 H12 H11 H10", "H9 C9 S9 H2 C6", "C13 D12 C11 H8 H7"]
      }

      it "パラメーターの入力形式が間違っている場合" do
        post '/api/porker.json', params
        expect(response.body).to include("パラメーターの形式が不正です。正しい形式で入力してください。")
      end
    end

  end


end










