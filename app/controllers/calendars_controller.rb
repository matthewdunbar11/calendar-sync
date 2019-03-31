class CalendarsController < ApplicationController
  def new
    @calendar = Calendar.new
  end

  def create
    @calendar = Calendar.new(calendar_params)
    @calendar.user = current_user
    if @calendar.save
      redirect_to @calendar
    else
      flash[:error] = @calendar.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @calendar = Calendar.find(params[:id])
  end

  private

  def calendar_params
    params.require(:calendar).permit(:name)
  end
end