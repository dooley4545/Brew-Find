class AlterBrewers < ActiveRecord::Migration
  def change
    remove_column :brewers, :type, :string
  end
end
