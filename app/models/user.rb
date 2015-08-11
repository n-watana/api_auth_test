class User < ActiveRecord::Base
  attr_accessor :editing_password

  has_one :access_token

  before_save :set_password_if_editing

  def load_token!
    self.access_token ||= AccessToken.new(user_id: self.id)
    self.access_token.update_value!
    self.access_token.update_expire_at!
    self.access_token.save!
  end

  def self.digest(str)
    Digest::SHA256.hexdigest(str)
  end

  def self.authenticate(login_id, password)
    user = User.find_by_login_id(login_id)
    return nil if user.blank? || User.digest(password) != user.password
    user
  end

  private

  def set_password_if_editing
    if self.editing_password.present?
      self.password = User.digest(editing_password)
    end
  end
end
