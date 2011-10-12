class ProfilesController < ApplicationController
  def show

  end

  def edit
    @user_to_edit = User.find(current_user.id)
  end

  def update

  end
end
