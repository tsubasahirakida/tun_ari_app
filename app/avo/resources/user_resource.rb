class UserResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :name, as: :text
  field :email, as: :text
  field :password, as: :text
  field :password_confirmation, as: :text
  field :role, as: :select, enum: ::User.roles
  field :authentications, as: :has_many
  field :posts, as: :has_many
  field :ais, as: :has_many
  field :ai_posts, as: :has_many, through: :ais
  field :tuns, as: :has_many
  field :tun_posts, as: :has_many, through: :tuns
  field :deres, as: :has_many
  field :dere_posts, as: :has_many, through: :deres
  field :bookmarks, as: :has_many
  field :bookmark_posts, as: :has_many, through: :bookmarks
  # add fields here
end
