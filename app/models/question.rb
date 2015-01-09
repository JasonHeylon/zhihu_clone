class Question
  include Mongoid::Document
  include Common::BaseModel

  belongs_to :user

  field :title, type: String
  field :description, type: String
end
