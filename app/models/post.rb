class Post < ApplicationRecord
  validates :sendername, presence: true
  validates :body, presence: true
  validates :post_image, presence: true
  validates :character_id, presence: true

  enum status: { draft: 0, private: 1, public: 2 }, _prefix: true

  has_one :post_body_templates, dependent: :destroy
  belongs_to :user
  has_many :ais, dependent: :destroy
  has_many :aied_users, through: :ais, source: :user
  has_many :tuns, dependent: :destroy
  has_many :deres, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  mount_uploader :post_image, PostImageUploader
end
