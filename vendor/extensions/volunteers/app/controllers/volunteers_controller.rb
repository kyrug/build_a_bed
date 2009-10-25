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
      redirect_to :action => :index
    end
  end

  # GET /volunteers
  def create
    if params[:volunteer]
      @volunteer = Volunteer.new(params[:volunteer])
      @volunteer.save
      flash[:info] = 'volunteer Successfully Created'
    else
      flash[:error] = 'No volunteer Specified'
    end
    redirect_to :action => :index
  end
end
