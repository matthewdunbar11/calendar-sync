# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Event
    can %i[read present], Calendar

    return unless user

    can :manage, Calendar, user_id: user.id
    can :manage, Event, calendar: { user_id: user.id }
  end
end
