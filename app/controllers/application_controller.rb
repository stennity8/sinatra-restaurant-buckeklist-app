require './config/environment'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "password_security"
    register Sinatra::Flash
  end

  get '/' do
    # binding.pry
    erb :"index"
  end

  helpers do
    # Get current user
    def current_user(session) 
      @user = User.find_by_id(session[:user_id])
    end
  
    # Check if user logged in
    def is_logged_in?(session)
      !!session[:user_id]
    end

    # Get error messages from validation.
    def error_messages(instance)
      @error_messages = instance.errors.messages.map do |k,v|
        k = k.capitalize
        v = v[0]
        "#{k} #{v}. "
      end.join(" ")
    end
  end

end
