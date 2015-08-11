class Api::BaseController < ActionController::Base
  def current_user
    access_token = AccessToken.find_by_value(request.headers['X-Access-Token'])

    return nil if access_token.blank? || access_token.expired?

    @current_user = access_token.user
  end

  protected

  def authenticated?
    return head :unauthorized if current_user.blank?
  end
end
