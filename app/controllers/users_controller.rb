class UsersController < ApplicationController

  get '/user/:slug' do
    logged_in_verification

    # Verify user is authorized to access these reviews
    if @user == User.find_by_slug(params[:slug])
      @user_restaurants = @user.restaurants
      @user_reviews = @user.reviews
    else
      flash[:message] = "You do not have access to that page."
      redirect '/'
    end
    binding.pry
    
    erb :"/users/show"
  end

  post '/user/:slug' do
    logged_in_verification
    
    # Verify user is authorized to add to bucketlist
    if @user == User.find_by_slug(params[:slug])
      binding.pry
      @user_restaurants = @user.restaurants
      @user_reviews = @user.reviews
    else
      flash[:message] = "You do not have access to that page."
      redirect '/'
    end
  end
  
  get '/register' do
    if is_logged_in?(session)
      flash[:message] = "You are already logged in."
      redirect '/reviews'
    end
    
      erb :"/users/new"
  end

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