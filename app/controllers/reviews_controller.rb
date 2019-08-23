class ReviewsController < ApplicationController

  # Get ALL reviews
  get "/reviews" do
    logged_in_verification

    @user = current_user(session)
    @reviews = Review.all
    @user_slug = User.find(session[:user_id]).slug
    bucketlist_restaurants

    erb :"/reviews/index"
  end

  # Get form for creating new reviews and restaurants
  get "/reviews/new" do
    # Logged in verification
    logged_in_verification
    
    erb :"/reviews/new"
  end

  # This is for creating a review for a restaurant that is in user's bucket list
  get "/reviews/new/:id" do
    # Logged in verification
    logged_in_verification
    @restaurant = Restaurant.find(params[:id])

    erb :"/reviews/new_bucketlist"
  end

  # This post is for new reviews being added to restaurant from the user's bucketlist.
  post "/reviews/:id" do
    # Logged in verification
    logged_in_verification

    # Create review. 
    review = Review.new(params[:review])
    restaurant = Restaurant.find(params[:id])
    
    #verify review is valid. Redirect if invalid.
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

  # This post is for creating new reviews and/or restaurants
  post "/reviews" do
    # Logged in verification
    logged_in_verification

    # Create review and restaurant. 
    review = Review.new(params[:review])
    # Check if this is an existing restaurant.
    if params[:restaurant][:creator_id].empty?
      restaurant = Restaurant.new(params[:restaurant])
    else
      restaurant = Restaurant.find(params[:restaurant][:id])
    end

    # Verify review and restaurant are valid. Redirect if invalid.
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


  # Get edit form for existing reviews
  get "/reviews/:id/edit" do

    logged_in_verification
    # Verify if Restaurant was created by user or if it will be uneditable
    @review = Review.find(params[:id])
    @restaurant = @review.restaurant
    if @review.user_id != current_user(session).id
      redirect "/"
    else
      erb :"/reviews/edit"
    end
  end

  # Update existing review
  patch "/reviews/:id" do
    logged_in_verification
    @review = Review.find(params[:id])
    @restaurant = @review.restaurant

    # Check if user has access to update restaurant
    access_verification(@review)
 
    if @restaurant.creator_id != @review.user_id
      @review.update(params[:review])
    else
      @restaurant.update(params[:restaurant])
      @review.update(params[:review])
    end

    redirect "/reviews/#{@review.id}"
  end

  # Show specific review
  get "/reviews/:id" do
    logged_in_verification
    @user = current_user(session)
    @review = Review.find(params[:id])
    
    erb :"/reviews/show"
  end
  
  # Delete existing review
  delete "/reviews/:id/delete" do
    logged_in_verification
    @review = Review.find(params[:id])

    # Check if user has access to update restaurant
    access_verification(@review)
    @review.destroy

    redirect "/reviews"
  end

end
