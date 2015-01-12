module Common
  module Voteable
    extend ActiveSupport::Concern

    included do
      field up_voted_user_ids, type: Array, default: []
      field down_voted_user_ids, type: Array, default: []
    end


  end
end