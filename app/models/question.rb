class Question
  include Mongoid::Document
  include Common::BaseModel
  include Common::CounterCache
  include Common::Followable

  belongs_to :user, inverse_of: :questions

  has_many :answers, dependent: :destroy

  field :title, type: String
  field :description, type: String
  field :answers_count, type: Integer, default: 0

  counter_cache name: :user, inverse_of: :questions


end
