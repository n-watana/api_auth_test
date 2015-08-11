class Api::UsersController < Api::BaseController
  before_action :authenticated?

  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end
end

