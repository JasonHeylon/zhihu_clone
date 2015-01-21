module Mongoid
  module Followable
    extend ActiveSupport::Concern
    included do
      field :followed_user_ids, type: Array, default: []

    end

    def follow_by(user_id)
      return false if user_id.blank?
      return false if followed_user_ids.include?(user_id)
      self.push(followed_user_ids: user_id)
    end

    def unfollow_by(user_id)
      return false if user_id.blank?
      self.pull(followed_user_ids: user_id)
    end

    def followed_by?(user_id)
      !user_id.blank? && followed_user_ids.include?(user_id)
    end


  end

end