class RestaurantsController < ApplicationController

  # GET ALL restaurants
  get "/restaurants" do
    logged_in_verification
    @restaurants = Restaurant.all

    # Slug username for 'Add to Bucket List' route
    @user_slug = User.find(session[:user_id]).slug
    bucketlist_restaurants
    
    erb :"/restaurants/index"
  end

  # GET specific restaurant by ID
  get "/restaurants/:id" do
    logged_in_verification
    
    @restaurant = Restaurant.find(params[:id])
    @reviews = @restaurant.reviews

    erb :"/restaurants/show"
  end
end
