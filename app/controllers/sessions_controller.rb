class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if user
      login!(user)
      redirect_to new_session_url # TODO: fixme
    else
      flash.now[:errors] = ["Couldn't find user by credential"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end
end
