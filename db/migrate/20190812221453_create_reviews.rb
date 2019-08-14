class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :recommendation
      t.integer :user_id
      t.integer :restaurant_id
      # Bucket list boolean is used to track whether this review is on the bucket list.  
      # All reviews are first added to the bucket list.  Once user reviews them they are in turn
      # removed from the bucket list and 'true' will be changed to false.
      t.boolean :bucket_list, default: 'true'
      t.timestamps null: false
    end
  end
end
