class AiResource < Avo::BaseResource
  self.title = :type
  self.includes = []
  self.model_class = ::Ai
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :user_id, as: :number
  field :post_id, as: :number
  field :type, as: :text
  field :user, as: :belongs_to
  field :post, as: :belongs_to
  # add fields here
end
