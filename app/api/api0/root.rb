require 'grape'

module API0
  class Root < Grape::API

# http://localhost:3000/api/
    prefix 'api/'
    mount API0::Ver1::Porker

    get do

    end
  end
end

# 基底となるAPIクラスを作成します。
# このファイルで各バージョンのAPIをマウントします
