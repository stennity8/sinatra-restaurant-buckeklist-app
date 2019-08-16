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
    binding.pry
    # Check if this is an existing restaurant.
    if params[:restaurant][:creator_id] == nil
      restaurant = Restaurant.new(params[:restaurant])
    else
      restaurant = Restaurant.find(params[:restaurant][:id])
    end

    
    if review.valid? && restaurant.valid?
      restaurant.save
      review.restaurant_id = restaurant.id
      review.user_id = @user.id
      
      review.save
    else
      if review.invalid?
        error_messages(review)
        flash[:errors] = @error_messages
      end

      if restaurant.invalid?
        error_messages(restaurant)
        flash[:errors2] = @error_messages
      end

      redirect "reviews/new"
    end
    
    redirect "/user/#{@user.slug}"
  end


  # GET: /reviews/5/edit
  get "/reviews/:id/edit" do

    logged_in_verification
    # Verify if Restaurant was created by user or if it will be uneditable
    @review = Review.find(params[:id])
    @restaurant = @review.restaurant
    #@restaurant.creator_id == @review.user_id ? @read_only = false : @read_only = true

    erb :"/reviews/edit"
  end

  # PATCH: /reviews/5
  patch "/reviews/:id" do
    @review = Review.find(params[:id])
    @restaurant = @review.restaurant
    # Check if user has access to update restaurant
    if read_only
      @review.update(params[:review])
    else
      @restaurant.update(params[:restaurant])
      @review.update(params[:review])
    end

    redirect "/reviews/#{@review.id}"
  end

    # GET: /reviews/5
    get "/reviews/:id" do
      logged_in_verification
      @user = current_user(session)
      @review = Review.find(params[:id])
      
      erb :"/reviews/show"
    end
  

  # DELETE: /reviews/5/delete
  delete "/reviews/:id/delete" do
    redirect "/reviews"
  end
end
