class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,           presence: true
  validates :email,              presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, format: { with: /(?=.*[a-zA-Z])(?=.*[0-9]).*/, message: 'Include both letters and numbers' }
  validates :last_name,          presence: true, format: { with: /\A[一-龥ぁ-ん]/}
  validates :first_name,         presence: true, format: { with: /\A[一-龥ぁ-ん]/}
  validates :last_name_kana,     presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :first_name_kana,    presence: true, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :birth_date,         presence: true 

end
