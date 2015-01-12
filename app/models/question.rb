class Question
  include Mongoid::Document
  include Common::BaseModel
  include Common::CounterCache

  belongs_to :user, inverse_of: :questions

  field :title, type: String
  field :description, type: String

  counter_cache name: :user, inverse_of: :questions


end
