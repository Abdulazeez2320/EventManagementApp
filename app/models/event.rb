
  class Event < ApplicationRecord
    has_many :comments, dependent: :destroy
    has_many :rsvps, dependent: :destroy
    has_many :users, through: :rsvps
  
    def rsvp(user)
      users << user unless users.include?(user)
    end
  
    def cancel_rsvp(user)
      users.delete(user)
    end
  
    def rsvp?(user)
      users.include?(user)
    end
  end
