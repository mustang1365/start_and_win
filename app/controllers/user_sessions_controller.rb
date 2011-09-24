class UserSessionsController < Devise::SessionsController
  def new
     super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # GET /resource/sign_out
  def destroy
    super
  end
end
