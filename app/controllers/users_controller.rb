class UsersController < ApplicationController
  
  get '/register' do
    # binding.pry
    if is_logged_in?(session)
      flash[:message] = "You are already logged in."
      redirect '/reviews'
    end
      erb :"/users/new"
  end

  post '/register' do
    # binding.pry
    # Check password and confirm password match
    if params[:user][:password] != params[:confirm_password]
      flash[:errors] = "Your passwords do not match.  Please try again."
      redirect '/register'
    end

    @user = User.create(params[:user])
    if @user.valid? 
      flash[:errors] = "Invalid user credentials.  Please try again."
      redirect '/register'
    else
      session[:user_id] = @user.id
      redirect "/reviews"
    end
  end

end


