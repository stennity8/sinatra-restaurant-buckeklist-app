class UsersController < ApplicationController

  # Show user's bucket list and reviews
  get '/user/:slug' do
    logged_in_verification

    # Verify user is authorized to access these reviews
    if @user == User.find_by_slug(params[:slug])
      @user_restaurants = @user.restaurants
      @user_reviews = @user.reviews
    else
      no_access
    end
    # binding.pry
    
    erb :"/users/show"
  end

  # Add restaurant to user's bucket list
  post '/user/:slug' do
    logged_in_verification
    
    # Verify user is authorized to add to bucket list
    if @user == User.find_by_slug(params[:slug])
      @bucketlist = Bucketlist.create(user_id: @user.id, restaurant_id: params[:bucketlist])
    else
      no_access
    end

    redirect "/user/#{@user.slug}"
  end
  
  # Get register form
  get '/register' do
    if is_logged_in?(session)
      flash[:message] = "You are already logged in."
      redirect '/reviews'
    end
    
      erb :"/users/new"
  end

  # Register new user
  post '/register' do
    # Check password and confirm passwords match.  Redirect if they do not match.
    if params[:user][:password] != params[:confirm_password]
      flash[:errors] = "Your passwords do not match.  Please try again."
      redirect '/register'
    end
   
    # Create user and then validate provided input.  Redirect if not valid.
    @user = User.create(params[:user])
    if @user.invalid? 
      # Get error messages using helper function and then flash to user.
      error_messages(@user)
      flash[:errors] = @error_messages

      redirect '/register'
    else
      session[:user_id] = @user.id
      redirect "/reviews"
    end
  end

end