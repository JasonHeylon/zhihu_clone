class Question
  include Mongoid::Document
  include Common::BaseModel

  embedded_in :user

  field :title, type: String
  field :description, type: String
end
