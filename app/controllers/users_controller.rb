class UsersController < ApplicationController

  before_action :find_user, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      cookies.signed[:user_id] = @user.id
      flash[:success] = 'You have successfully signed up.'
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your profile was successfully updated.'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    msg = "#{@user.username}'s profile and articles have been successfully deleted."
    @user.destroy
    flash[:success] = msg
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if !logged_in? || (!admin? && current_user != @user)
      flash[:danger] = 'You can only edit your own profile.'
      redirect_to articles_path
    end
  end

  def require_admin
    if !admin?
      flash[:danger] = 'Only admin can delete a profile.'
      redirect_to users_path
    end
  end

end