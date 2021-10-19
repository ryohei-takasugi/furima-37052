require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @name = Gimei.new
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'email、passwordとpassword_confirmation、nickname、last_name、last_name_kana、first_name、first_name_kana、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上かつ半角英数字混合であれば登録できる' do
        @user.password = 'abc456'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      it 'last_nameは漢字であれば登録できる' do
        @user.last_name = @name.last.kanji
        expect(@user).to be_valid
      end
      it 'last_nameはカタカナであれば登録できる' do
        @user.last_name = @name.last.katakana
        expect(@user).to be_valid
      end
      it 'last_nameはひらがなであれば登録できる' do
        @user.last_name = @name.last.hiragana
        expect(@user).to be_valid
      end
      it 'first_nameは漢字であれば登録できる' do
        @user.first_name = @name.first.kanji
        expect(@user).to be_valid
      end
      it 'first_nameはカタカナであれば登録できる' do
        @user.first_name = @name.first.katakana
        expect(@user).to be_valid
      end
      it 'first_nameはひらがなであれば登録できる' do
        @user.first_name = @name.first.hiragana
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      # 空では登録できない
      it 'emailが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = nil
        @user.password_confirmation = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'nicknameが空では登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      # 文字数制限外では登録できない
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'abc45'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      # フォーマット違いでは登録できない
      it 'passwordが数字のみであれば登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordが英字のみであれば登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordが全角文字であれば登録できない' do
        @user.password = 'パスワード'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'last_nameには半角文字では登録できない' do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name には全角（漢字・ひらがな・カタカナ）を入力してください')
      end
      it 'first_nameには半角文字では登録できない' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name には全角（漢字・ひらがな・カタカナ）を入力してください')
      end
      it 'last_name_kanaには漢字では登録できない' do
        @user.last_name_kana = @name.last.kanji
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana には全角カタカナを入力してください')
      end
      it 'fitst_name_kanaには漢字では登録できない' do
        @user.first_name_kana = @name.first.kanji
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana には全角カタカナを入力してください')
      end
      it 'last_name_kanaにはひらがなでは登録できない' do
        @user.last_name_kana = @name.last.hiragana
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana には全角カタカナを入力してください')
      end
      it 'fitst_name_kanaにはひらがなでは登録できない' do
        @user.first_name_kana = @name.first.hiragana
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana には全角カタカナを入力してください')
      end
      it 'emailは＠なしでは登録できない' do
        @user.email = 'test.test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      # その他
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'abc456'
        @user.password_confirmation = 'abc4567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合登録できない' do
        user_already = FactoryBot.create(:user)
        @user.email = user_already.email
        @user.valid?
        expect(@user.errors.full_messages).to include('Email has already been taken')
      end
    end
  end
end
