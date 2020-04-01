class SessionsController < ApplicationController

	before_action :not_logged_in, only: [:new, :create]

	def new
	end

	def create
		user = User.find_by(username: params[:session][:username])
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:success] = 'You have successfully logged in.'
			redirect_to user_path(user)
		else
			flash.now[:danger] = 'Invalid username or password.'
			render 'new'
		end	
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = 'You have logged out.'
		redirect_to root_path
	end

	private

	def not_logged_in
		if logged_in?
			flash[:danger] = 'You are already logged in.'
      redirect_to articles_path
		end
	end

end