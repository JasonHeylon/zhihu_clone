class Answer
  include Mongoid::Document
  include Common::BaseModel
  include Mongoid::CounterCache
  include Mongoid::Voteable

  field :content, type: String

  belongs_to :user, inverse_of: :answers
  belongs_to :question, inverse_of: :answers

  counter_cache name: :user, inverse_of: :answers
  counter_cache name: :question, inverse_of: :answers



  def up_voted_users
    User.find(up_voted_user_ids)
  end


end
