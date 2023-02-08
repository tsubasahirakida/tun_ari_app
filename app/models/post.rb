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

  def self.ai_boostings
    to = Time.current.at_end_of_day
    from = (to - 6.days).at_beginning_of_day
    includes(:aied_users).publish.sort_by { |x|
      x.aied_users.includes(:ais).where(ais: {created_at: from...to}).size}.reverse
  end

  def self.tundere_boostings
    to = Time.current.at_end_of_day
    from = (to - 6.days).at_beginning_of_day
    includes(:tuned_users, :dered_users).publish
                 .sort_by { |x|
      x.tuned_users.includes(:tuns).where(tuns: {created_at: from...to}).size + x.dered_users.includes(:deres).where(deres: {created_at: from...to}).size}.reverse
  end
end
