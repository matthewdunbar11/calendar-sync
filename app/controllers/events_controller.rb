class EventsController < ApplicationController
  def index
    @calendar = Calendar.find_by!(id: params[:calendar_id])
    @events = @calendar.events
    respond_to do |format|
      format.json { render json: @events }
    end    
  end

  def new
    @calendar = Calendar.find_by!(id: params[:calendar_id], user: current_user)
    @event = Event.new(calendar: @calendar)
  end

  def create
    @calendar = Calendar.find_by!(id: params[:calendar_id], user: current_user)
    @event = Event.new(event_params)
    @event.calendar = @calendar
    
    if @event.save
      flash[:notice] = 'Event successfully created'
      redirect_to @calendar
    else
      flash[:error] = @event.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.includes(:calendar).find_by!(id: params[:id], calendars: { user: current_user })
  end

  def update
    @event = Event.includes(:calendar).find_by!(id: params[:id], calendars: { user: current_user })
    if @event.update(event_params)
      flash[:notice] = 'Event successfully updated'
      redirect_to @event.calendar
    else
      flash[:error] = @event.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @event = Event.includes(:calendar).find_by!(id: params[:id], calendars: { user: current_user })

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
    params.require(:event).permit(:title, :start, :end)
  end
end