class ApplicationController < ActionController::Base
  alias_method :current_user, :current_person
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
