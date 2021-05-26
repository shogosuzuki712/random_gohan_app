require 'rails_helper'

RSpec.describe 'お問い合わせ', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @inquiry = FactoryBot.build(:inquiry)
  end
  context 'お問い合わせができるとき' do
    it 'ログインしたユーザーはお問い合わせができる' do
      # ログインする
      visit root_path
      expect(page).to have_content('ログイン')
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      # お問い合わせページへのボタンがあることを確認する
      expect(page).to have_content('お問い合わせ')
      # お問い合わせページに遷移する
      visit new_inquiry_path
      # フォームに情報を入力する
      fill_in 'inquiry_name', with: 'ニックネーム'
      fill_in 'inquiry_message', with: 'メッセージ'
      # 送信するとInquiryモデルのカウントが1上がることを確認する
      expect { find('input[name="commit"]').click }.to change { Inquiry.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
    end
  end
  context 'お問い合わせができないとき' do
    it 'ログインしていないとお問い合わせページに遷移できない' do
      # トップページに移動する
      visit root_path
      # お問い合わせページへのボタンがないことを確認する
      expect(page).to have_no_content('お問い合わせ')
    end
  end
end
