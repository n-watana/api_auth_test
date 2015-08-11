class Api::AuthController < Api::BaseController
  before_action :authenticated?, only: [:destroy]

  def create
    user = User.authenticate(params[:login_id], params[:password])
    return head :unauthorized if user.blank?

    user.load_token!

    response.headers['X-Access-Token'] = user.access_token.value
    render nothing: true, status: 200
  end

  def destroy
    @current_user.access_token.destroy
    head :ok
  end
end
