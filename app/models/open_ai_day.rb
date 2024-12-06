class OpenAiDay < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true

  def self.can_use_api?(user)
    today = Date.today
    usage_count = where(user:, created_at: today.all_day).count

    # 5回未満ならtrueを返す
    usage_count < 5
  end
end
