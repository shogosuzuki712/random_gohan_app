require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
    sleep(1)
  end

  describe 'ユーザー新規登録' do

    context '新規登録できるとき' do
      it '全ての情報が正しければ登録できる' do
        expect(@user).to be_valid
      end

      it 'パスワードが6文字以上なら登録できる' do
        @user.password = 'aiu123'
        @user.password_confirmation = 'aiu123'
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ニックネームが空だと登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end

      it 'メールアドレスが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "メールアドレスを入力してください"
      end

      it '同じメールアドレスは一意性制約によって登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include "メールアドレスはすでに存在します"
      end

      it 'メールアドレスは@を含めないと登録できない' do
        @user.email = 'aiueoaiueo'
        @user.valid?
        expect(@user.errors.full_messages).to include "メールアドレスは不正な値です"
      end

      it 'パスワードが空だと登録できない' do
        @user.password = ''
        @user.password_confirmation = 'aaa111'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください", "パスワードは不正な値です", "パスワード（確認用）とパスワードの入力が一致しません"
      end

      it 'パスワードは５文字以下では登録できない' do
        @user.password = 'aaa12'
        @user.password_confirmation = 'aaa12'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは6文字以上で入力してください"
      end

      it 'パスワードは確認用を含めて２回入力しないと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end

      it 'パスワードとパスワード確認用は一致しないと登録できない' do
        @user.password = 'aaa123'
        @user.password_confirmation = 'bbb123'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end

      it 'パスワードは半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは不正な値です"
      end

      it 'パスワードは半角数字のみでは登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは不正な値です"
      end

      it 'パスワードは全角文字は登録できない' do
        @user.password = 'ａａａ１１１'
        @user.password_confirmation = 'ａａａ１１１'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは不正な値です"
      end

    end
  end
end