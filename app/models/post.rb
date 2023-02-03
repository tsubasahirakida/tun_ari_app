class Post < ApplicationRecord
  validates :sendername, presence: true, length: { maximum: 15 }
  validates :body, presence: true
  validates :post_image, presence: true
  validates :character_id, presence: true
  validates :status, presence: true

  enum status: { draft: 0, archive: 1, publish: 2 }

  belongs_to :user
  has_many :ais, dependent: :destroy
  has_many :aied_users, through: :ais, source: :user
  has_many :tuns, dependent: :destroy
  has_many :tuned_users, through: :tuns, source: :user
  has_many :deres, dependent: :destroy
  has_many :dered_users, through: :deres, source: :user
  has_many :bookmarks, dependent: :destroy

  mount_uploader :post_image, PostImageUploader
end
