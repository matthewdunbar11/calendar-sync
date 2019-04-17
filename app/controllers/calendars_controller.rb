class CalendarsController < ApplicationController
  load_and_authorize_resource
  layout 'navless', only: :present

  def create
    if @calendar.save
      flash[:notice] = 'Calendar successfully created'
      redirect_to @calendar
    else
      flash[:error] = @calendar.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @calendar_webcal_url = calendar_url(@calendar, protocol: 'webcal', format: 'ics')
    @google_url = "https://www.google.com/calendar/r?cid=#{@calendar_webcal_url}"
    respond_to do |format|
      format.html
      format.ics do 
        calendar_to_webcal(@calendar)
      end
    end
  end

  def present
    @calendar = Calendar.find(params[:id])
    @calendar_webcal_url = calendar_url(@calendar, protocol: 'webcal', format: 'ics')
    @google_url = "https://www.google.com/calendar/r?cid=#{@calendar_webcal_url}"
    render :show
  end

  def update
    if @calendar.update(calendar_params)
      flash[:notice] = 'Calendar successfully updated'
      redirect_to @calendar
    else
      flash[:error] = @calendar.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @calendar.destroy
      flash[:notice] = 'Calendar successfully deleted'
      redirect_to calendars_path
    else
      flash[:error] = @calendar.errors.full_messages.to_sentence
      redirect_to @calendar
    end
  end

  private

  def calendar_params
    params.require(:calendar).permit(:name)
  end

  def calendar_to_webcal(calendar)
    cal = Icalendar::Calendar.new
    cal.x_wr_calname = @calendar.name
    
    calendar.events.each do |event|
      cal.event do |e|
        e.dtstart     = event.start
        e.dtend       = event.end
        e.summary     = event.title
      end
    end
    
    cal.publish

    render plain: cal.to_ical
  end
end