# frozen_string_literal: true

# Defines Reservation class
class Reservation < ActiveRecord::Base
  validates :start_time, :end_time, presence: true

  def start_time
    Time.parse(self[:start_time])
  end

  def end_time
    Time.parse(self[:end_time])
  end

  def ==(other)
    (start_time.eql?(other.start_time) &&
     end_time.eql?(other.end_time))
  end
end
