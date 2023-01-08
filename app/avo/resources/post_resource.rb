class PostResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :sendername, as: :text
  field :body, as: :text
  field :post_image, as: :text
  field :character_id, as: :number
  field :status, as: :select, enum: ::Post.statuses
  field :user_id, as: :number
  field :user, as: :belongs_to
  field :ais, as: :has_many
  field :aied_users, as: :has_many, through: :ais
  field :tuns, as: :has_many
  field :tuned_users, as: :has_many, through: :tuns
  field :deres, as: :has_many
  field :dered_users, as: :has_many, through: :deres
  field :bookmarks, as: :has_many
  # add fields here
end
