class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 255 }
  enum role: { general: 0, admin: 1 }

  has_many :posts, dependent: :destroy
  has_many :ais, dependent: :destroy
  has_many :ai_posts, through: :ais, source: :post
  has_many :tuns, dependent: :destroy
  has_many :tun_posts, through: :tuns, source: :post

  def ai(post)
    ai_posts << post
  end
  def unai(post)
    ai_posts.destroy(post)
  end
  def ai?(post)
    ai_posts.include?(post)
  end

  def tun(post)
    tun_posts << post
  end
  def untun(post)
    tun_posts.destroy(post)
  end
  def tun?(post)
    tun_posts.include?(post)
  end
end
