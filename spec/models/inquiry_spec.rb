require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  before do
    @inquiry = FactoryBot.build(:inquiry)
    sleep(1)
  end

  context 'お問い合わせ機能' do
    context 'フォーム送信できるとき' do
      it '全ての情報が正しければ送信できる' do
        expect(@inquiry).to be_valid
      end
    end

    context 'フォーム送信できないとき' do
      it 'ニックネームが空だと送信できない' do
        @inquiry.name = ''
        @inquiry.valid?
        expect(@inquiry.errors.full_messages).to include 'ニックネームを入力してください'
      end
      it 'お問い合わせ内容が空だと送信できない' do
        @inquiry.message = ''
        @inquiry.valid?
        expect(@inquiry.errors.full_messages).to include 'お問い合わせ内容を入力してください'
      end
    end
  end
end
