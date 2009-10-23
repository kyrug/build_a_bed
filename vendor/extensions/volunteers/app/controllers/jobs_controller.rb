class JobsController < ApplicationController

  # GET /jobs
  def index
    @jobs = Job.find(:all)
    @job = Job.new
  end

  # GET /job/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(params[:job])
      redirect_to :action => :index
    end
  end

  # GET /jobs
  def create
    if params[:job]
      @job = Job.new(params[:job])
      @job.save
      flash[:info] = 'Job Successfully Created'
    else
      flash[:error] = 'No Job Specified'
    end
    redirect_to :action => :index
  end
end
