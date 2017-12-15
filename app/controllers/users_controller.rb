class UsersController < ApplicationController

    def new
    end

    def create
        @user = User.new user_params
        if @user.save
            session[:user_id] = @user.id
            redirect_to "/events"
        else
            flash[:errors] = [@user.errors.full_messages]
            redirect_to "/"
        end
    end

    def events
        @events = Event.where(state: current_user.state)
        @otherevent = Event.where.not(state: current_user.state)
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update user_params
          redirect_to "/events"
        else
          flash[:errors] = @user.errors.full_messages     
          redirect_to :back
        end
    end


    private
        def user_params
            params.require(:user).permit(:first_name, :last_name, :email, :location, :state, :password, :password_confirmation)
        end
end
