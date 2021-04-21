require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
    sleep(1)
  end

  describe '画像投稿機能' do
    context '画像投稿できるとき' do
      it '全ての情報が正しければ投稿できる' do
        expect(@tweet).to be_valid
      end
    end

    context '画像が投稿できないとき' do
      it 'タイトルが空だと投稿できない'do
        @tweet.title = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include "Title can't be blank"
      end

      it 'テキストが空だと投稿できない' do
        @tweet.text = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include "Text can't be blank"
      end

      it '画像が選択されていないと投稿できない' do
        @tweet.image = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include "Image can't be blank"
      end

      it 'userが紐付いていないと保存できない' do
        @tweet.user = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include "User must exist"
      end

      it 'titleが30文字以上だと投稿できない' do
        @tweet.title = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' #31文字
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include "Title is too long (maximum is 30 characters)"
      end

      it 'textが140文字以上だと投稿できない' do
        @tweet.text = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' #141文字
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include "Text is too long (maximum is 140 characters)"
      end
    end
  end
end
