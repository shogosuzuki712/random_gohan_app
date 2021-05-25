require 'rails_helper'

RSpec.describe 'ユーザーが新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザーが新規登録できるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに遷移する' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ遷移する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_name', with: @user.name
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # 新規登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect { find('input[name="commit"]').click }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # 新規登録画面へ遷移するボタンやログインページに遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザーが新規登録できないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規投稿ページへ戻ってくる' do
      # トップページへ移動する
      visit root_path
      # トップページに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ遷移する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_name', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      # 新規登録ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect { find('input[name="commit"]').click }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq(user_registration_path)
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインできるとき' do
    it '保存されているユーザー情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # 新規登録画面へ遷移するボタンやログインページに遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')
    end
  end
  context 'ログインできないとき' do
    it '保存されているユーザー情報と合致しないとログインができない' do
      # トップページへ遷移する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 誤ったユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
