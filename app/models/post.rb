class Post < ApplicationRecord
  validates :sendername, presence: true
  validates :body, presence: true
  validates :post_image, presence: true
  validates :character_id, presence: true

  enum status: { draft: 0, private: 1, public: 2 }, _prefix: true

  mount_uploader :post_image, PostImageUploader
end
