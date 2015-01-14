class Answer
  include Mongoid::Document
  include Common::BaseModel
  include Common::CounterCache

  field :content, type: String

  belongs_to :user, inverse_of: :answers
  belongs_to :question, inverse_of: :answers

  counter_cache name: :user, inverse_of: :answers
  counter_cache name: :question, inverse_of: :answers


end
