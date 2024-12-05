class OpenAiDay < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true

  def self.can_use_api?(user)
    today = Date.today
    usage_count = where(user:, created_at: today.all_day).count

    if usage_count < 5
      create!(user:)
      true
    else
      false
    end
  end
end
