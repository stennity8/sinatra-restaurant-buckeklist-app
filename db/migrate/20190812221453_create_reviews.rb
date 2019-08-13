class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :good
      t.string :bad
      t.string :recommendation
      t.integer :user_id
      t.integer :restaurant_id
      t.timestamps null: false
    end
  end
end
