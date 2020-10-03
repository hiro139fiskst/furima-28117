class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ } do
    validates :first_name
    validates :last_name
    validates :nickname
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/ } do
    validates :first_name_kana
    validates :last_name_kana
  end

  # PASSWORD_REGEX = /\A(?=.?[a-z])(?=.?\d)[a-z\d]{8,100}+\z/i
  # validates_format_of :password, with: PASSWORD_REGEX
  # validates :password, length: { minimum: 6 }
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])\w{6,12}\z/.freeze
  validates :password, presence: true,
                       format: { with: VALID_PASSWORD_REGEX,
                                 message: 'は半角6~12文字小文字・数字それぞれ１文字以上含む必要があります' }

  # VALID_EMAIL_REGEX = /\A([a-zA-Z0-9])+([a-zA-Z0-9\._-])*@([a-zA-Z0-9_-])+([a-zA-Z0-9\._-]+)+\z/
  # validates_format_of :email, with: VALID_EMAIL_REGEX

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :email, presence: true
  validates :birth_date, presence: true
end
