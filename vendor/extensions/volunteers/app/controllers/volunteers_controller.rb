class VolunteersController < ApplicationController

  # GET /volunteers
  def index
    @volunteers = Volunteer.find(:all)
    @volunteer = Volunteer.new
  end

  # GET /volunteer/1/edit
  def edit
    @volunteer = Volunteer.find(params[:id])
  end

  def update
    @volunteer = Volunteer.find(params[:id])
    if @volunteer.update_attributes(params[:volunteer])
      flash[:info] = 'Volunteer Successfully Updated'
    else
     flash[:error] = @volunteer.errors.full_messages.first
    end
    redirect_to volunteers_path
  end

  # GET /volunteers
  def create
    if params[:volunteer]
      @volunteer = Volunteer.new(params[:volunteer])
      if @volunteer.save
        flash[:info] = 'Volunteer Successfully Created'
      else
       flash[:error] = @volunteer.errors.full_messages.first
      end
    end
    puts flash.inspect
    redirect_to volunteers_path
  end

  def destroy
    @volunteer = Volunteer.find(params[:id])
    @volunteer.destroy
    redirect_to volunteers_path
  end
end
