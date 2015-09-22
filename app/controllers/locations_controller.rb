class LocationsController < ApplicationController

  def index
    if params[:search].present?
      @locations = Location.near(params[:search], 50, :order => :distance)
    else
      @locations = Location.all
      @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
        marker.lat location.latitude
        marker.lng location.longitude
      end
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new safe_location_params
    if @location.save
      redirect_to @location, :notice => "Successfully created location."
    else
      flash_first_error(@location)
      redirect_to new_location_path
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update safe_location_params
      redirect_to location_path(@location)
    else
      flash_first_error(@location)
      redirect_to edit_location_path(@location)
    end
  end

  private

  def safe_location_params
    params.require(:location).permit(:address)
  end

  def flash_first_error(location)
    flash[:error] = location.errors.first
  end


end
