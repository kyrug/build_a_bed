class DonationsController < ApplicationController

  # GET /donations
  def index
    @donations = Donation.find(:all)
    @donation = Donation.new
  end

  # GET /donation/1/edit
  def edit
    @donation = Donation.find(params[:id])
  end

  def update
    @donation = Donation.find(params[:id])
    if @donation.update_attributes(params[:donation])
      redirect_to :action => :index
    end
  end

  # GET /donations
  def create
    if params[:donation]
      @donation = Donation.new(params[:donation])
      if @donation.save
        flash[:info] = 'Donation Successfully Created'
      else
       flash[:error] = @donation.errors.full_messages.first
      end
    end
    puts flash.inspect
    redirect_to :action => :index
  end
end
