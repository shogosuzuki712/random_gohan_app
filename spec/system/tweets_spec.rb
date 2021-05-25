require 'rails_helper'

RSpec.describe 'ツイート投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet_image = Faker::Lorem.sentences
    @tweet_title = Faker::Lorem.sentences
    @tweet_text = Faker::Lorem.sentences
  end

  context 'ツイート投稿できるとき' do
    it 'ログインユーザーは新規投稿できる' do
      # ログインする
      # 新規投稿ページへのボタン(シェア)があることを確認する
      # 新規投稿ページへ遷移する
      # フォームに情報を入力する
      # 送信するとTweetモデルのカウントが1上がることを確認する
      # トップページに遷移する
      # トップページに先ほど投稿したツイートが存在することを確認する(画像)
      # トップページに先ほど投稿したツイートが存在することを確認する(タイトル)
      # トップページに先ほど投稿したツイートが存在することを確認する(テキスト)
    end
  end
  context 'ツイート投稿できないとき' do
    it 'ログインしていないと新規投稿ページへ遷移できない' do
      # トップページに遷移する
      # 新規投稿ページへのボタンがないことを確認する
    end
  end
end
