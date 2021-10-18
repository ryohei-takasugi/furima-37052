class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  with_options presence: true do
    validates :nickname
    validates :last_name,          format: { with: NAME_REGEX, message: 'には全角を入力してください' }
    validates :last_name_kana,     format: { with: NAME_REGEX, message: 'には全角を入力してください' }
    validates :first_name,         format: { with: NAME_REGEX, message: 'には全角を入力してください' }
    validates :first_name_kana,    format: { with: NAME_REGEX, message: 'には全角を入力してください' }
    validates :birthday
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
end
