# frozen_string_literal: true

# Defines message class
class Message < ActiveRecord::Base
  validates :text, :date, presence: true
  belongs_to :user
end
