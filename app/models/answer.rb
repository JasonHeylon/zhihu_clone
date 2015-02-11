class Answer
  include Mongoid::Document
  include Common::BaseModel
  include Mongoid::CounterCache
  include Mongoid::Voteable

  field :content, type: String

  belongs_to :user, inverse_of: :answers
  belongs_to :question, inverse_of: :answers

  has_many :notifications, class_name: 'Notification::Base', dependent: :destroy

  counter_cache name: :user, inverse_of: :answers
  counter_cache name: :question, inverse_of: :answers

  after_create :send_notify_to_followers

  validates :content, presence: true, length: { maximum: 10000 }

  def up_voted_users
    User.find(up_voted_user_ids)
  end


  protected
    def send_notify_to_followers
      self.question.followed_user_ids.each do |user_id|
        Notification::NewAnswerNotify.create(answer: self, user_id: user_id)
      end
    end


end
