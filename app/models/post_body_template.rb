class PostBodyTemplate < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :post
end
