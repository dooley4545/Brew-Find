class WelcomeController < ApplicationController
  
  #GET "/"
  def index
    @recent_brewers = Brewer.last(5).reverse
    populate_markers
  end

  # Creates all the markers for the farms... Used to on the map in the view.
  def populate_markers
    @all_brewers = Brewer.all 
    @hash = Gmaps4rails.build_markers(@all_brewers) do |brewer, marker|
      marker.lat brewer.latitude
      marker.lng brewer.longitude
      marker.infowindow "<a href='/brewers/"+"#{brewer.id}"+"'>#{brewer.name}, #{brewer.address}</a>"
      marker.json({ title: brewer.name, id: brewer.id })
    end
  end
end