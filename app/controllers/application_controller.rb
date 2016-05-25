class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :set_csrf_cookie_for_ng
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  before_action :set_menus

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_ability
    if current_admin
      @current_ability = Ability.new(current_admin)
    elsif current_user
      @current_ability = Ability.new(current_user)
    else
      @current_ability = Ability.new(nil)
    end
  end

  def set_menus
    @products = Product.where(published: true).order('ordering desc')
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  protected

  # In Rails 4.1 and below
  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end
end
