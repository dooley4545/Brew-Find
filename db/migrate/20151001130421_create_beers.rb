class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.integer :brewer_id
      t.integer :user_id
      t.string :style
      t.string :abv

      t.timestamps null: false
    end
  end
end
