class Post < ApplicationRecord
  validates :sendername, presence: true
  validates :body, presence: true

  mount_uploader :post_image, PostImageUploader
end
