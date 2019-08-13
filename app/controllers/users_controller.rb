require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/login' do
      if is_logged_in?(session)
        flash[:message] = "You are already logged in."
        redirect '/reviews'
      end
        erb :"/users/login"
  end

  get '/register' do
    # binding.pry
    if is_logged_in?(session)
      flash[:message] = "You are already logged in."
      redirect '/reviews'
    end
      erb :"/users/register"
  end

  post '/register' do
    # binding.pry
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


# get '/signup' do
#   # binding.pry
#   if is_logged_in?(session)
#     flash[:message] = "You are already logged in."
#     redirect '/tweets'
#   end
#     erb :"/users/signup"
# end

# post '/signup' do
#   # binding.pry
#   @user = User.create(params)
#   if @user.id == nil 
#     flash[:message] = "Invalid user credentials.  Please try again."
#     redirect '/signup'
#   else
#     session[:user_id] = @user.id
#     redirect "/tweets"
#   end
# end

# get '/login' do
#   if is_logged_in?(session)
#     flash[:message] = "You are already logged in."
#     redirect '/tweets'
#   end
#     erb :"/users/login"
# end

# post '/login' do
#   # binding.pry
#   @user = User.find_by(username: params[:username])

#   if @user && @user.authenticate(params[:password])
#     session[:user_id] = @user.id

#     redirect "/tweets"
#   else
#     flash[:message] = "Incorrect login credentials.  Please try again."
#     redirect "/login"
#   end
# end

# get '/logout' do
#   if is_logged_in?(session)
#     session.clear
#     redirect "/login"
#   else
#     redirect "/"
#   end
# end

# get '/users/:slug' do
#   @user = User.find_by_slug(params[:slug])
#   @tweets = @user.tweets
#   erb :"/users/show"
# end 
  # # GET: /users
  # get "/users" do
  #   erb :"/users/index.html"
  # end

  # # GET: /users/new
  # get "/users/new" do
  #   erb :"/users/new.html"
  # end

  # # POST: /users
  # post "/users" do
  #   redirect "/users"
  # end

  # # GET: /users/5
  # get "/users/:id" do
  #   erb :"/users/show.html"
  # end

  # # GET: /users/5/edit
  # get "/users/:id/edit" do
  #   erb :"/users/edit.html"
  # end

  # # PATCH: /users/5
  # patch "/users/:id" do
  #   redirect "/users/:id"
  # end

  # # DELETE: /users/5/delete
  # delete "/users/:id/delete" do
  #   redirect "/users"
  # end
