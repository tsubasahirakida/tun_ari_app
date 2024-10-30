class GenerateAiModalForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :recipient, :string
  attribute :message, :string
  attribute :tone, :string

  validates :recipient, presence: true
  validates :message, presence: true
  validates :tone, presence: true
end
