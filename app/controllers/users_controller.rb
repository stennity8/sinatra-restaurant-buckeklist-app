class UsersController < ApplicationController
  
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
      flash[:errors] = "Invalid user credentials.  Please try again."
      redirect '/register'
    else
      session[:user_id] = @user.id
      redirect "/reviews"
    end
  end

end