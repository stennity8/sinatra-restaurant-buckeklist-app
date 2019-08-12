require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do

    erb :welcome
  end

  helpers do
    def current_user(session) 
      @user = User.find_by_id(session[:user_id])
    end
  
    def is_logged_in?(session)
      !!session[:user_id]
    end
  end

end
