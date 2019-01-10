require 'rails_helper'

  RSpec.describe PorkerCheck do


    before do

    end



    context "正常系" do
      describe "正常な値を入力した時、handcheckメソッドが呼び出されて、正常な値を返す" do
        include PorkerCheck
        it "フラッシュを返す" do
         number = 1,3,4,5,6
         suit = "H", "H", "H", "H", "H"
         expect(PorkerCheck.handcheck(number, suit)).to eq("フラッシュ")
        end

        it "ストレートフラッシュを返す" do
          number = 1,2,3,4,5
          suit = "H", "H", "H", "H", "H"
          expect(PorkerCheck.handcheck(number, suit)).to eq("ストレートフラッシュ")
        end

        it "ストレートを返す" do
          number = 1,2,3,4,5
          suit = "H", "S", "H", "S", "H"
          expect(PorkerCheck.handcheck(number, suit)).to eq("ストレート")
        end

        it "フォーオブアカインドを返す" do
          number = 1,1,1,1,3
          suit = "H", "S", "C", "D", "H"
          expect(PorkerCheck.handcheck(number, suit)).to eq("フォーオブアカインド")
        end

        it "フルハウスを返す" do
          number = 1,1,1,2,2
          suit = "H", "S", "C", "H", "S"
          expect(PorkerCheck.handcheck(number, suit)).to eq("フルハウス")
        end

        it "スリーオブアカインドを返す" do
          number = 1,1,1,2,3
          suit = "H", "S", "C", "D", "H"
          expect(PorkerCheck.handcheck(number, suit)).to eq("スリーオブアカインド")
        end

        it "ツーペアを返す" do
          number = 1,1,2,3,3
          suit = "H", "S", "H", "S", "H"
          expect(PorkerCheck.handcheck(number, suit)).to eq("ツーペア")
        end

        it "ワンペアを返す" do
          number = 1,1,2,3,4
          suit = "H", "S", "C", "D", "H"
          expect(PorkerCheck.handcheck(number, suit)).to eq("ワンペア")
        end

        it "ハイカードを返す" do
          number = 1,10,9,5,4
          suit = "D", "D", "S", "C", "C"
          expect(PorkerCheck.handcheck(number, suit)).to eq("ハイカード")
        end
      end
    end





    context "異常系" do
      describe "異常な値を入力した" do
        include PorkerCheck


        it "全角空白が含まれている" do
          card = "H1　H2 H3 H4 H5"
          expect(PorkerCheck.validation1(card)).to eq("全角空白が含まれています。5つのカード指定文字を半角スペース区切りで入力してください。")
        end



        it "半角空白が2つ以上ある" do
          card = "H1  H2 H3 H4 H5"
          expect(PorkerCheck.validation1(card)).to eq("半角空白が2つ以上あります。5つのカード指定文字を半角スペース区切りで入力してください。")
        end


        it "5つ未満、6つ以上の値を入力した場合" do
          # card1 = ["H1","H2"]
          card = "H1 H2"
          expect(PorkerCheck.validation1(card)).to eq("指定された文字と数字で、５枚のカードを入力してください。")
         end



        it "半角の英語大文字SHDC以外、または、半角の数字1〜13以外の場合" do
        card = "A1 S2 S3 S4 K5"
        expect(PorkerCheck.validation1(card)).to eq("半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。")
        end



        it "数またはスートが重複している" do
          # card1 = ["H1", "H2", "H2", "H3", "H4"]
          card = "H1 H2 H2 H3 H4"
          expect(PorkerCheck.validation1(card)).to eq("重複する値が含まれています。正しいスートと数字を入力してください。")
        end


       end

      end



    end



