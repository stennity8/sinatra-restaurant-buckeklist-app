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

    # Logged in verification with error message.
    def logged_in_verification
      if is_logged_in?(session)
        @user = current_user(session)
      else
        flash[:message] = "You must be logged in to access that page."
        redirect "/login"
      end
    end

    # Check if Restaurant should be 'readonly' 
    def read_only
      if !(@restaurant.creator_id == @review.user_id) 
         "readonly"
      end
    end

    # Check if Restaurant should be 'readonly' - 'disabled' required to lock dropdowns
    def read_only_disabled
      if !(@restaurant.creator_id == @review.user_id) 
         "disabled"
      end
    end

    # Build array of bucketlist restaurants
    def bucketlist_restaurants
      @bucketlist = []
      @user = current_user(session)
      @user.bucketlists.each do |bucketlist|
        @bucketlist << bucketlist.restaurant_id
      end
      @bucketlist
    end

    def no_access
      flash[:message] = "You do not have access to that page."
      redirect '/'
    end
  end

end
