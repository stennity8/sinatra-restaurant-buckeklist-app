class SessionsController < ApplicationController
  get '/login' do
    if is_logged_in?(session)
      flash[:message] = "You are already logged in."
      redirect '/reviews'
    end
      erb :"/sessions/new"
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      redirect "/reviews"
    else
      flash[:message] = "Incorrect login credentials.  Please try again."
      redirect "/login"
    end
  end

  get '/logout' do
    if is_logged_in?(session)
      session.destroy
      redirect "/login"
    else
      flash[:message] = "You're not logged in."
      redirect "/login"
    end
   end

end
