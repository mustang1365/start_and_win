class UsersController < Devise::RegistrationsController
  before_filter :user_create_left_menu, :only =>[:new, :create]

  def new
    super
  end

  def edit
    super
  end

  def create
    build_resource
    if resource.save
      session[:success_registration] = true
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => redirect_location(resource_name, resource)
      else
        set_flash_message :notice, :inactive_signed_up, :reason => inactive_reason(resource) if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
    end
  end

  def update
    super
  end

  def index
    super
  end

  def destroy
    super
  end

  private
  def user_create_left_menu
    @user_create_left_menu = true
  end
end
