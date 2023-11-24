class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  skip_before_action :verify_authenticity_token # skip CSRF check if API

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || goals_path
  end
end
