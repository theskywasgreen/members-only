module SessionsHelper

  def sign_in(user)
    session[:user_id] = user.id
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_digest
    @current_user = current_user
  end

  def current_user
    if (user_id = session[:id])
      @current_user ||= User.find_by(id: session[:user_id])
    else
      return nil
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def sign_out(user)
    session.delete(:user_id)
    cookies.delete(:remember_token)
    current_user=(nil)
    redirect_to root_path
  end

  def signed_in?
    !current_user.nil?
  end
end
