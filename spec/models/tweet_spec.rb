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
        expect(@tweet.errors.full_messages).to include "ごはんの名前を入力してください"
      end

      it 'テキストが空だと投稿できない' do
        @tweet.text = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include "ごはんの感想を入力してください"
      end

      it '画像が選択されていないと投稿できない' do
        @tweet.image = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include "ごはんの写真を入力してください"
      end

      it 'userが紐付いていないと保存できない' do
        @tweet.user = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include "Userを入力してください"
      end

      it 'titleが30文字以上だと投稿できない' do
        @tweet.title = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' #31文字
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include "ごはんの名前は30文字以内で入力してください"
      end

      it 'textが140文字以上だと投稿できない' do
        @tweet.text = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' #141文字
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include "ごはんの感想は140文字以内で入力してください"
      end
    end
  end
end
