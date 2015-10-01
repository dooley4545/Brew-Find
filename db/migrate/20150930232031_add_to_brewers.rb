class AddToBrewers < ActiveRecord::Migration
  def change
    add_column :brewers, :latitude, :float
    add_column :brewers, :longitude, :float
  end
end
