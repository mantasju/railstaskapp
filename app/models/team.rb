# frozen_string_literal: true

# Defines Team class
class Team < ActiveRecord::Base
  validates :name, :size, presence: true
  after_initialize :add_creator
  belongs_to :user
  has_and_belongs_to_many :users

  def change_team_owner(user_to_change_to)
    unless LoginHelper.logged_in_user.eql? team_owner
      raise 'Only team owner can change the team owner'
    end
    raise 'New team owner can\'t be nil' if user_to_change_to.equal?(nil)
    self[:users_id] = user_to_change_to.id
  end

  def add_team_member(user_to_add)
    perform_add_checks(user_to_add)
    raise 'Team is already full' if users.length.equal?(size)
    raise 'User is already on the team' if users.include? user_to_add
    users.push(user_to_add)
  end

  def remove_team_member(user_to_remove)
    user = LoginHelper.logged_in_user
    raise 'You are not the team owner' unless team_owner.eql? user
    users.delete(user_to_remove)
  end

  def player_on_team?(user_to_check)
    users.include? user_to_check
  end

  def ==(other)
    (other.team_owner.eql? team_owner) && (other.name.eql? name)
  end

  def team_owner
    User.find(users_id)
  end

  private

  def add_creator
    self[:users_id] = LoginHelper.logged_in_user.id
  end

  def perform_add_checks(user_to_add)
    raise 'User to add cannot be nil' if user_to_add.equal?(nil)
    user = LoginHelper.logged_in_user
    raise 'You are not the team owner' unless team_owner.eql? user
  end
end
