class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])

    # If the user exists AND the password entered is correct.
    if user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id
    else
      @status = false
      render json: {'error': 'login incorrect'}
    end
  end

  def destroy
    session[:user_id] = nil
    puts session[:user_id]
    # reset_session
    # session.delete(:user_id)
  end


end
