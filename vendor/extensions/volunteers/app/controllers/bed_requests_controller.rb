class BedRequestsController < ApplicationController

  # GET /bed_requests
  def index
    @bed_requests = BedRequest.find(:all)
    @bed_request = BedRequest.new
  end

  # GET /bed_request/1/edit
  def edit
    @bed_request = BedRequest.find(params[:id])
  end

  def update
    @bed_request = BedRequest.find(params[:id])
    if @bed_request.update_attributes(params[:bed_request])
      redirect_to :action => :index
    end
  end

  # GET /bed_requests
  def create
    if params[:bed_request]
      @bed_request = BedRequest.new(params[:bed_request])
      if @bed_request.save
        flash[:info] = 'Bed Request Successfully Created'
      else
        flash[:error] = @bed_request.errors.full_messages.first
      end
    end
    redirect_to :action => :index
  end

  def show
    @br = BedRequest.find(params[:id])
  end
end
