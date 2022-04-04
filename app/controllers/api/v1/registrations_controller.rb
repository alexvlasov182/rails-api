class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_params_exist, only: :create
  # sign up
  def create
    user = User.new user_params
    if user.save
      render json: {
        message: 'Signed Up Successfully',
        is_success: true,
        data: {
          user: user
        }
      }, status: :ok
    else
      # json_response('Something wrong', false, {}, :unprocessable_entity)
      render json: {
        message: 'Something wrong',
        is_success: false,
        data: {}
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def ensure_params_exist
    return if params[:user].present?

    # json_response('Missing params', false, {}, :bad_request)
    render json: {
      message: 'Missing params',
      is_success: false,
      data: {}
    }, status: :bad_request
  end
end
