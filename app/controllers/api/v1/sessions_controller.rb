class Api::V1::SessionsController < Devise::SessionsController
  before_action :ensure_params_exist, only: :create
  before_action :sign_in_params, only: :create
  before_action :load_user, only: :create
  before_action :valid_token, only: :destroy
  skip_before_action :verify_signed_out_user, only: :destroy
  # sign in
  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in 'user', @user
      json_response 'Signed In Successfuly', true, { user: @user }, :ok
    else
      json_response 'Unauthorized', false, {}, :unauthorized
    end
  end

  # log out
  def destroy
    sign_out @user
    @user.generate_new_authentication_token
    json_response 'Log out successfuly', true, {}, :ok
  end

  private

  def sign_in_params
    params.require(:sign_in).permit(:email, :password)
  end

  def ensure_params_exist
    return if params[:sign_in].present?

    json_response('Missing params', false, {}, :bad_request)
  end

  # load user
  def load_user
    @user = User.find_for_database_authentication(email: sign_in_params[:email])
    @user || json_response('Cannot get User', false, {}, :failed_dependency)
  end

  def valid_token
    @user = User.find_by authentication_token: request.headers['AUTH-TOKEN']
    @user || json_response('Invalid Token', false, {}, :failed_dependency)
  end
end
