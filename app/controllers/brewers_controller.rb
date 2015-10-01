class BrewersController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :show]

  def index
    @brewers = Brewer.order("name").page(params[:page]).per(5)
  end

  def show
    @brewer = Brewer.find(params[:id])
  end

  def new
    @brewer = Brewer.new
  end

  def create
    @brewer = Brewer.new safe_brewer_params
    if @brewer.save
      redirect_to @brewer, :notice => "Successfully created location."
    else
      flash_first_error(@brewer)
      redirect_to new_brewer_path
    end
  end

  def edit
    @brewer = Brewer.find(params[:id])
  end

  def update
    @brewer = Brewer.find(params[:id])
    if @brewer.update safe_brewer_params
      redirect_to brewer_path(@brewer)
    else
      flash_first_error(@brewer)
      redirect_to edit_brewer_path(@brewer)
    end
  end

  def search
    @location = params[:search]
    @distance = params[:miles]
    @brewers = Brewer.near(@location, @distance)

    if @location.empty?
      flash[:notice] = "Please enter in a valid location"
    else
      if @brewers.length < 1
        flash[:notice] = "Dang Nabbit! There are no breweries within #{@distance} miles of #{@location}."
        redirect_to "/"
      else
        search_map(@brewers)
      end
    end

  end

  private

  def search_map(brewers)
    @brewers = brewers
    @hash = Gmaps4rails.build_markers(@brewers) do |brewer, marker|
        marker.lat brewer.latitude
        marker.lng brewer.longitude
        marker.infowindow "<a target='blank' href='https://www.google.com/maps/place/"+"#{brewer.address}"+"#{brewer.city}"+"#{brewer.state}"+"#{brewer.zip}"+"'>Get Directions</a>"
        marker.json({ title: brewer.name })
      end
    end

  def safe_brewer_params
    params.require(:brewer).permit(:name, :address, :description, :website, :city, :state, :zip)
  end

  def flash_first_error(brewer)
    flash[:error] = brewer.errors.first
  end


end
