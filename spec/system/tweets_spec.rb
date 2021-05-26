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

RSpec.describe 'ツイート編集', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context 'ツイートが編集できる時' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user_email', with: @tweet1.user.email
      fill_in 'user_password', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート1に「編集」へのリンクがあることを確認する
      expect(find('div[class="menu"]').click).to have_link '編集', href: edit_tweet_path(@tweet1)
      # 編集ページへ遷移する
      visit edit_tweet_path(@tweet1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      # expect(find('#tweet_image').value).to eq(@tweet1.image)
      expect(find('#tweet_title').value).to eq(@tweet1.title)
      expect(find('#tweet_text').value).to eq(@tweet1.text)
      # 投稿内容を編集する
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('tweet[image]', image_path, make_visible: true)
      fill_in 'tweet_title', with: "#{@tweet1.title}+編集したテキスト"
      fill_in 'tweet_text', with: "#{@tweet1.text}+編集したテキスト"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect { find('input[name="commit"]').click }.to change { Tweet.count }.by(0)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test_image.png']")
      # トップページには先ほど変更した内容のツイートが存在することを確認する（タイトル）
      expect(page).to have_content("#{@tweet1.title}+編集したテキスト")
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content("#{@tweet1.text}+編集したテキスト")
    end
  end
  context 'ツイートが編集できない時' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user_email', with: @tweet1.user.email
      fill_in 'user_password', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート2に「編集」へのリンクがないことを確認する
      expect(find('div[class="menu"]').click).to have_no_link '編集', href: edit_tweet_path(@tweet2)
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # トップページに投稿したツイートが表示されていないことを確認する
      expect(page).to have_no_content(@tweet1)
      expect(page).to have_no_content(@tweet2)
    end
  end
end

RSpec.describe 'ツイート削除', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context 'ツイート削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したツイートの削除ができる' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user_email', with: @tweet1.user.email
      fill_in 'user_password', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート1に「削除」へのリンクがあることを確認する
      expect(find('div[class="menu"]').click).to have_link '削除', href: tweet_path(@tweet1)
      # 「削除」をクリックすると確認ダイヤログが表示される
      expect { find_link('削除', href: tweet_path(@tweet1)).click }.to change { Tweet.count }.by(0)
      # 確認ダイアログの内容を確認する
      expect(page.driver.browser.switch_to.alert.text).to eq '【確認】投稿を削除してもよろしいですか？'
      # 確認ダイアログでOKを選択する
      page.driver.browser.switch_to.alert.accept
      # 削除完了画面に遷移したことを確認する
      expect(current_path).to eq(tweet_path(@tweet1))
      # 「削除しました」の文字があることを確認する
      expect(page).to have_content('削除しました')
      # マイページに遷移する←ここ課題
      visit root_path
      # マイページにはツイート1が存在しないことを確認する
      expect(page).to have_no_content(@tweet1)
    end
  end
  context 'ツイート削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの削除ができない' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user_email', with: @tweet1.user.email
      fill_in 'user_password', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ツイート2に「削除」へのリンクがないことを確認する
      expect(find('div[class="menu"]').click).to have_no_link '削除', href: tweet_path(@tweet2)
    end
    it 'ログインしていないとツイートの削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # トップページに投稿したツイートが表示されていないことを確認する
      expect(page).to have_no_content(@tweet1)
      expect(page).to have_no_content(@tweet2)
    end
  end
end
