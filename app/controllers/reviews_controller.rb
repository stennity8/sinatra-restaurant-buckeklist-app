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
    # Logged in verification
    logged_in_verification
    
    erb :"/reviews/new"
  end

  # This is for existing restaurant reviews coming from bucketlist
  get "/reviews/new/:id" do
    # Logged in verification
    logged_in_verification
    @restaurant = Restaurant.find(params[:id])

    erb :"/reviews/new_bucketlist"
  end

  # This post is for reviews being added from the bucketlist.
  post "/reviews/:id" do
    # Logged in verification
    logged_in_verification

    # Create review verify it is valid. Redirect if invalid.
    review = Review.new(params[:review])
    restaurant = Restaurant.find(params[:id])
    
    if review.valid?
      review.restaurant_id = restaurant.id
      review.user_id = @user.id
      review.save

      # Delete restaurant from bucketlist
      @user.bucketlists.find_by(restaurant.id).destroy
    else
      if review.invalid?
        error_messages(review)
        flash[:errors] = @error_messages
      end

      redirect "reviews/new/#{restaurant.id}"
    end
    
    redirect "/user/#{@user.slug}"
  end

  # POST: /reviews
  post "/reviews" do
    # Logged in verification
    logged_in_verification

    # Create review and restaurant and verify they are valid. Redirect if invalid.
    review = Review.new(params[:review])
    # Check if this is an existing restaurant.
    if params[:restaurant][:creator_id].empty?
      restaurant = Restaurant.new(params[:restaurant])
    else
      restaurant = Restaurant.find(params[:restaurant][:id])
    end

    
    if review.valid? && restaurant.valid?
      restaurant.creator_id = current_user(session).id
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
    logged_in_verification

    @review = Review.find(params[:id])

    if @user.id = @review.user_id
      @review.destroy
    end

    redirect "/reviews"
  end
end
