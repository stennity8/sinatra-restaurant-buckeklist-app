class RestaurantsController < ApplicationController

  # GET: /restaurants
  get "/restaurants" do
    logged_in_verification
    @restaurants = Restaurant.all

    # Slug username for 'Add to Bucket List' route
    @user_slug = User.find(session[:user_id]).slug
    bucketlist_restaurants
    reviewed_restaurants

    erb :"/restaurants/index"
  end

  # GET: /restaurants/new
  get "/restaurants/new" do
    erb :"/restaurants/new"
  end

  # POST: /restaurants
  post "/restaurants" do
    redirect "/restaurants"
  end

  # GET: /restaurants/5
  get "/restaurants/:id" do
    logged_in_verification
    
    @restaurant = Restaurant.find(params[:id])
    @reviews = @restaurant.reviews

    erb :"/restaurants/show"
  end

  # GET: /restaurants/5/edit
  get "/restaurants/:id/edit" do
    erb :"/restaurants/edit"
  end

  # PATCH: /restaurants/5
  patch "/restaurants/:id" do
    redirect "/restaurants/:id"
  end

  # DELETE: /restaurants/5/delete
  delete "/restaurants/:id/delete" do
    redirect "/restaurants"
  end
end
