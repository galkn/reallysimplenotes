module UsersHelper
  
  def sign_in user
    session[:user_id] = user.id
    @current_user = user
  end
  
  def user_signed_in? 
    return false if session[:user_id].nil?
    return true
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def sign_out_user
    @current_user = nil
    session[:user_id] = nil
  end
  
end
