class EventsController < ApplicationController
  load_and_authorize_resource :calendar
  load_and_authorize_resource :event, through: :calendar, shallow: true

  def index
    respond_to do |format|
      format.json { render json: @events }
    end    
  end

  def create
    if @event.save
      flash[:notice] = 'Event successfully created'
      redirect_to @calendar
    else
      flash[:error] = @event.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @event.update(event_params)
      flash[:notice] = 'Event successfully updated'
      redirect_to @event.calendar
    else
      flash[:error] = @event.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @event.destroy
      flash[:notice] = 'Event successfully deleted'
      redirect_to calendar_url(@event.calendar)
    else
      flash[:error] = @event.errors.full_messages.to_sentence
      redirect_to @event
    end    
  end

  private

  def event_params
    params.require(:event).permit(:title, :start, :end, :description)
  end
end