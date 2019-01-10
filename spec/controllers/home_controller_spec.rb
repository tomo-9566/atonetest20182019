require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  before do

  end


  it "HTTPリクエストが成功する" do
    get :top
    expect(response.status).to eq 200
  end

  it "共通処理内で定義したvalidation1(card)メソッドの返り値を、コントローラーにインクルードする" do
    card = "H1　H2 H3 H4 H5"
    expect(PorkerCheck.validation1(card)).to eq("全角空白が含まれています。5つのカード指定文字を半角スペース区切りで入力してください。")
  end


  it "共通処理内で定義したhandcheck(number, suit)メソッドの返り値を、コントローラーにインクルードする" do
    number = 1, 3, 4, 5, 6
    suit   = "H", "H", "H", "H", "H"
    expect(PorkerCheck.handcheck(number, suit)).to eq("フラッシュ")
  end

  it "判定結果を変数(@nameまたは@noname)に代入して、ビュー（/home/top）に表示させる" do
    post :top, { card: "H1 H2 H3 H4 H5" }
    expect(response).to render_template("home/top")
  end

end
