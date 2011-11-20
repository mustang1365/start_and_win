class UsersController < ApplicationController

 before_filter :require_login, :except => [:new, :create]
 #sorry  за костыль, но пока нормальное решение не придумал
 before_filter :normalize_params, :only => :update

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path, :notice => 'Registration successfull.'
    else
      render :action => "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to users_path, :notice => 'User was successfully updated.'
    else
      render :action => "edit"
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def normalize_params
    if params[:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end

end
