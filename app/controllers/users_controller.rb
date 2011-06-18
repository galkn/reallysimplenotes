class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.password = Digest::SHA2.hexdigest @user.password
    if @user.save
      sign_in @user
      redirect_to root_url, :notice => "Successfully created user."
    else
      redirect_to root_url, :notice => "You have an error"
    end
  end
  
  def sign_out
    sign_out_user
    redirect_to root_url, :notice => "Successfully logged out."
  end
  
end
