class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :login]
  
  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to "/events"
    else 
      flash[:errors] = ["Invalid Combination"]
      redirect_to "/"
    end
  end

  def destroy
    reset_session
    redirect_to "/"
  end
end
