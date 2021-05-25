require 'rails_helper'

RSpec.describe 'ツイート投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.build(:tweet)
    sleep(0.5)
  end

  context 'ツイート投稿できるとき' do
    it 'ログインユーザーは新規投稿できる' do
      # ログインする
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのボタン(シェア)があることを確認する
      expect(page).to have_content('シェア')
      # 新規投稿ページへ遷移する
      visit new_tweet_path
      # フォームに情報を入力する
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('tweet[image]', image_path, make_visible: true)
      fill_in 'tweet_title', with: @tweet.title
      fill_in 'tweet_text', with: @tweet.text
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect { find('input[name="commit"]').click }.to change { Tweet.count }.by(1)
      # トップページに遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページに先ほど投稿したツイートが存在することを確認する(画像)
      expect(page).to have_selector("img[src$='test_image.png']")
      # トップページに先ほど投稿したツイートが存在することを確認する(タイトル)
      expect(page).to have_content(@tweet.title)
      # トップページに先ほど投稿したツイートが存在することを確認する(テキスト)
      expect(page).to have_content(@tweet.text)
    end
  end
  context 'ツイート投稿できないとき' do
    it 'ログインしていないと新規投稿ページへ遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content('シェア')
    end
  end
end
