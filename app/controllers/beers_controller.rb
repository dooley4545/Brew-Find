class BeersController < ApplicationController
  before_action :authenticate_user!

  def new
    @beer = Beer.new
  end

  def edit
    @beer = Beer.find(params[:id])
  end

  def update
    @beer = Beer.find(params[:id])
    if @beer.update_attributes(beer_params)
      redirect_to edit_brewer_path(@beer.brewer)
    else
      render :back
    end
  end

  def create
    @brewer = Brewer.find params[:brewer_id]
    @beer = @brewer.beers.build

    @beer.save

    redirect_to @brewer
  end

  def destroy
    @beer = Beer.find(params[:id])
    if @beer.delete
      redirect_to edit_brewer_path(@beer.brewer)
    else
      redirect_to edit_brewer_path(@beer.brewer)
    end
  end

  private

  def beer_params
    params.require(:beer).permit!
  end
end