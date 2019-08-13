class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :cuisine
      t.string :city
      t.string :state
      t.integer :zip_code
      t.timestamps null: false
    end
  end
end
