class ApplicationController < ActionController::Base
  serialization_scope :view_context

  protected

  def after_sign_in_path_for(resource)
    rails_admin_path
  end
end
