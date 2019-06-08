# frozen_string_literal: true

class AdminAbility
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :access, :rails_admin   # grant access to rails_admin
    can :read, :dashboard       # grant access to the dashboard

    can :manage, Calendar, user_id: user.id
    can :manage, Event, calendar: { user_id: user.id }
  end
end
