class BucketlistsController < ApplicationController

  # Add restaurant to user's bucket list
  post '/bucketlists/:slug' do
    logged_in_verification
    
    # Verify user is authorized to add to bucket list
    if @user == User.find_by_slug(params[:slug])
      @bucketlist = Bucketlist.create(user_id: @user.id, restaurant_id: params[:bucketlist])
    else
      no_access
    end

    redirect "/user/#{@user.slug}"
  end

  # Delete bucket list
  delete "/bucketlists/:id" do
    logged_in_verification
  
    bucketlist = Bucketlist.find(params[:id])
    bucketlist.destroy

    redirect "/user/#{@user.slug}"
  end

end