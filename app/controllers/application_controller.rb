class ApplicationController < ActionController::Base
  helper_method :signed_in?, :current_user

  # ログインするたびにremember_tokenは更新されるのでなりすましを防げる
  def sign_in(user)
    remember_token = User.new_remember_token
    # 永続化クッキー(cookies.permanent)
    # http://railsdoc.com/references/cookies
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    @current_user = user
  end

  def signed_in?
    !!current_user
  end

  def sign_out
    current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    @current_user = nil
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
end
