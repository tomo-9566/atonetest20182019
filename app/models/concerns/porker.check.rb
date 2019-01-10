#WebアプリケーションとWebAPIの共通処理

module PorkerCheck


  # エラーメッセージを出すメソッド
  def self.validation1(card)

    card1 = card.split


    # 全角空白が含まれている
    if card.include?("　")
      return "全角空白が含まれています。5つのカード指定文字を半角スペース区切りで入力してください。"
    end


    #半角空白が2つ以上ある
    if card.match(/[\s]{2}/)
      return "半角空白が2つ以上あります。5つのカード指定文字を半角スペース区切りで入力してください。"
    end


    #5つ未満、6つ以上の値を入力した場合
    if card1.size != 5
      return "指定された文字と数字で、５枚のカードを入力してください。"
    end


    # 半角英語大文字の指定スートと指定数字以外を入力した場合
    if !(card =~ /[SHCD]([1-9]|1[0-3])\s[SHCD]([1-9]|1[0-3])\s[SHCD]([1-9]|1[0-3])\s[SHCD]([1-9]|1[0-3])\s[SHCD]([1-9]|1[0-3])\z/)
      return "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
    end


    # 数またはスートが重複している
    if card1.size != card1.uniq.size
      return "重複する値が含まれています。正しいスートと数字を入力してください。"
    end


  end


  # 役判定につかう要素を定義するメソッド
  def self.handName(card)
    card1 = card.split
    card = card1

    suit1 = []
    suit = suit1

    number1    = []
    prenumber = number1

    card.each do |h1|
      suit << h1.match(/[a-zA-Z]/)[0]
      print suit
    end

    card.each do |h2|
      prenumber << h2.match(/\d+/)[0].to_i
    end

    number = prenumber.sort


    return number, suit, card

  end


  #役判定をするメソッド
  def self.handcheck(number, suit)


    if suit.uniq.count == 1
      v = (suit.uniq.count == 1) && number == (number[0]..number[0] + 4).to_a

      if v
        return "ストレートフラッシュ"
      elsif number == [1, 10, 11, 12, 13]
        return "ストレートフラッシュ"
      else
        return "フラッシュ"
      end

    elsif number == (number[0]..number[0] + 4).to_a
      return "ストレート"
    elsif number == [1, 10, 11, 12, 13]
      return "ストレート"

    elsif number.uniq.count == 2
      if number[1] == number[3]
        return "フォーオブアカインド"
      else
        return "フルハウス"
      end

    elsif number.uniq.count == 3
      if number.select do |a|
        a == number[2]
      end.count == 3
        return "スリーオブアカインド"
      else
        return "ツーペア"
      end

    elsif number.uniq.count == 4
      return "ワンペア"
    end

    "ハイカード"

  end


end
