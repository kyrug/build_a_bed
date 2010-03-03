class DonationRequestsController < ApplicationController

  # GET /donation_requests
  def index
    @donation_requests = DonationRequest.find(:all)
    @donation_request = DonationRequest.new
  end

  # GET /donation_request/1/edit
  def edit
    @donation_request = DonationRequest.find(params[:id])
  end

  def update
    @donation_request = DonationRequest.find(params[:id])
    if @donation_request.update_attributes(params[:donation_request])
      flash[:info] = 'Donation Request Successfully Updated'
    else
      flash[:error] = @donation_request.errors.full_messages.first
    end
    redirect_to donation_requests_path
  end

  # GET /donation_requests
  def create
    if params[:donation_request]
      @donation_request = DonationRequest.new(params[:donation_request])
      if @donation_request.save
        flash[:info] = 'Donation Request Successfully Created'
      else
        flash[:error] = @donation_request.errors.full_messages.first
      end
    end
    redirect_to donation_requests_path
  end
  
  def destroy
    @donation_request = DonationRequest.find(params[:id])
    @donation_request.destroy
    redirect_to donation_requests_path
  end
end
