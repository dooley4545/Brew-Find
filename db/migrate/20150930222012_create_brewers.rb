class CreateBrewers < ActiveRecord::Migration
  def change
    create_table :brewers do |t|
      t.string :name
      t.string :type
      t.text :description
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :website

      t.timestamps null: false
    end
  end
end
