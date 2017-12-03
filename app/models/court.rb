# frozen_string_literal: true

# Defines Court class
class Court < ActiveRecord::Base
  validates :longitude, :latidute, presence: true
  has_many :reservations, dependent: :destroy
  belongs_to :user

  def add_reservation(start_time, end_time)
    Reservation.create(
      start_time: start_time,
      end_time: end_time,
      court_id: id
    )
  end

  def remove_reservation(start_time)
    reservations.each do |reservation|
      if Integer(reservation.start_time).eql? Integer(start_time)
        reservations.delete(reservation)
      end
    end
  end

  def ==(other)
    longitude.eql?(other.longitude) && latidute.eql?(other.latidute)
  end

  def user
    User.find(users_id)
  end
end
