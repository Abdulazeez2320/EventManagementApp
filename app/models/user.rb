class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :rsvps, dependent: :destroy
  has_many :events, through: :rsvps
  def rsvp_to(event)
    events << event unless rsvps.find_by(event_id: event.id)
  end

  def cancel_rsvp_to(event)
    events.delete(event)
  end

  def rsvped_to?(event)
    events.include?(event)
  end
end
