# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, Calendar, user_id: user.id
    can :manage, Event, calendar: { user_id: user.id }
  end
end
