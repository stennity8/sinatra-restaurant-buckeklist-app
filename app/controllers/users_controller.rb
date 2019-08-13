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
    binding.pry
    @user = User.create(params)
    if @user.id == nil 
      flash[:message] = "Invalid user credentials.  Please try again."
      redirect '/register'
    else
      session[:user_id] = @user.id
      redirect "/reviews"
    end
  end

end


