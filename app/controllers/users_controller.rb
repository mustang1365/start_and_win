class UsersController < Devise::RegistrationsController
  before_filter :user_create_left_menu, :only =>[:new, :create]

  def new
    super
  end

  def edit
    super
  end

  def create
    super
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
