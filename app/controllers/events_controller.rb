class EventsController < ApplicationController

    def create
        event = Event.new event_params
        if event.save
          redirect_to "/events"
        else
          flash[:errors] = event.errors.full_messages
          redirect_to "/events"
        end
    end

    def show
        @event = Event.where(id: params[:id])
        @discussion
    end

    def edit
        @event = Event.where(id: params[:id])
    end

    def update
        @event = Event.find(params[:id])
        @event.update(event_params)
        if @event.valid?
            @event.save
            redirect_to '/events'
        else
            flash[:errors] = @event.errors.full_messages
            redirect_to :back
        end
    end

    def delete
        @event = Event.find(params[:id])
        @event.destroy if @event.user === current_user
        redirect_to '/events'
    end

    private
    def event_params
        params.require(:event).permit(:name, :date, :location, :state).merge(user: current_user)
    end
end
