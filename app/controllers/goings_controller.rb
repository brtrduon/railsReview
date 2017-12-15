class GoingsController < ApplicationController
    def join
        Going.create going_params
        redirect_to '/events'
    end

    def delete
        @going = Going.find(params[:id])
        @going.destroy if current_user === @going.user
        redirect_to '/events'
    end

    private
    def going_params
        params.require(:going).permit(:event_id).merge(user: current_user)
    end
end
