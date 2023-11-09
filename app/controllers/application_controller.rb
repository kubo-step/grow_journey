class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  skip_before_action :verify_authenticity_token # skip CSRF check if API
end
