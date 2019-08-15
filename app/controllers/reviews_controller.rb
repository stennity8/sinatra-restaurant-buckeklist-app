class ReviewsController < ApplicationController

  # GET: /reviews
  get "/reviews" do
    logged_in_verification
    
    @user = current_user(session)
    @reviews = Review.all

    erb :"/reviews/index"
  end

  # GET: /reviews/new
  get "/reviews/new" do
    erb :"/reviews/new"
  end

  # POST: /reviews
  post "/reviews" do
    # Logged in verification
    logged_in_verification

    # Create review and restaurant and verify they are valid. Redirect if invalid.
    review = Review.new(params[:review])
    restaurant = Restaurant.new(params[:restaurant])
    
    if review.valid? && restaurant.valid?
      restaurant.save
      review.restaurant_id = restaurant.id
      review.user_id = @user.id
      review.save
    else
      # TODO: Set up error handling
      binding.pry
    end
    
    redirect "/user/#{@user.slug}"
  end


  # GET: /reviews/5/edit
  get "/reviews/:id/edit" do
    logged_in_verification

    erb :"/reviews/edit"
  end

  # PATCH: /reviews/5
  patch "/reviews/:id" do
    redirect "/reviews/:id"
  end

    # GET: /reviews/5
    get "/reviews/:id" do


      erb :"/reviews/show"
    end
  

  # DELETE: /reviews/5/delete
  delete "/reviews/:id/delete" do
    redirect "/reviews"
  end
end
