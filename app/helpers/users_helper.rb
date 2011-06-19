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
  
  def get_existing_or_generate_new_token
    token = cookies[:token] 
    token.nil? ? new_token : token
  end
  
  def new_token
    token = rand(100**10).to_s(36)
    cookies[:token] = { :value => token, :expires => 1.year.from_now }
    return token
  end
  
end
