class RestaurantsController < ApplicationController

  # GET: /restaurants
  get "/restaurants" do
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
