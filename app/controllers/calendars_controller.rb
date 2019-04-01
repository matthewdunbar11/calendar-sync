class CalendarsController < ApplicationController
  def new
    @calendar = Calendar.new
  end

  def create
    @calendar = Calendar.new(calendar_params)
    @calendar.user = current_user
    if @calendar.save
      flash[:notice] = 'Calendar successfully created'
      redirect_to @calendar
    else
      flash[:error] = @calendar.errors.full_messages.to_sentence
      render :new
    end
  end

  def index
    @calendars = Calendar.where(user: current_user)
  end

  def show
    @calendar = Calendar.find(params[:id])
  end

  def edit
    @calendar = Calendar.find_by!(id: params[:id], user: current_user)
  end

  def update
    @calendar = Calendar.find_by!(id: params[:id], user: current_user)
    if @calendar.update(calendar_params)
      flash[:notice] = 'Calendar successfully updated'
      redirect_to @calendar
    else
      flash[:error] = @calendar.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @calendar = Calendar.find_by!(id: params[:id], user: current_user)

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
end