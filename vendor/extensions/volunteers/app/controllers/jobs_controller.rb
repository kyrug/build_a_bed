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
      flash[:info] = 'Job Successfully Updated'
    else
      flash[:error] = @job.errors.full_messages.first
    end
    redirect_to jobs_path
  end

  # GET /jobs
  def create
    if params[:job]
      @job = Job.new(params[:job])
      if @job.save
        flash[:info] = 'Job Successfully Created'
      else
        flash[:error] = @job.errors.full_messages.first
      end
    end
    redirect_to jobs_path
  end
  
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path
  end
end
