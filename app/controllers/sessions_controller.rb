class SessionsController < ApplicationController

	def new
  end

  def create
		user = User.find_by_email(params[:session][:email].downcase)
    if user
     sign_in user
     redirect_to user
    else
      flash[:error] = 'could not start session' 
      redirect_to new_user_path
    end
  end

  def destroy
		sign_out
    redirect_to signin_path
  end

end
