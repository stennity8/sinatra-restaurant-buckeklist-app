class ReviewsController < ApplicationController

  # GET: /reviews
  get "/reviews" do
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
    if is_logged_in?(session)
      @user = current_user(session)
    else
      flash[:message] = "You must be logged in to create a review."
      redirect "/login"
    end

    # Create review and restaurant and verify they are valid. Redirect if invalid.
    review = Review.new(params[:review])
    restaurant = Restaurant.new(params[:restaurant])
    
    if review.valid? && restaurant.valid?
      restaurant.save
      review.restaurant_id = restaurant.id
      review.user_id = @user.id
      review.save
    else
      binding.pry
    end
    
    redirect "/user/#{@user.slug}"
  end

  # GET: /reviews/5
  get "/reviews/:id" do
    erb :"/reviews/show"
  end

  # GET: /reviews/5/edit
  get "/reviews/:id/edit" do
    erb :"/reviews/edit"
  end

  # PATCH: /reviews/5
  patch "/reviews/:id" do
    redirect "/reviews/:id"
  end

  # DELETE: /reviews/5/delete
  delete "/reviews/:id/delete" do
    redirect "/reviews"
  end
end
