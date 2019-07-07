class User < ApplicationRecord
  has_secure_password

  before_validation { self.email = email.downcase }
  before_create :create_remember_token

  def self.find_by_email(email)
    find_by(email: email.downcase)
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    # to_sメソッドを呼び出しているのは、nilトークンを扱えるようにするためです
    # nil.to_sは""になる
    # Digest::SHA1.hexdigest("")でも文字列は発行される
    # https://railstutorial.jp/chapters/sign-in-sign-out?version=4.0
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end
end
