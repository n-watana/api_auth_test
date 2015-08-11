class AccessToken < ActiveRecord::Base
  EXPIRE_FOR = 30 # minutes

  belongs_to :user

  def expired?
    Time.now > self.expire_at
  end

  def update_expire_at!
    self.expire_at = Time.now.advance(minutes: EXPIRE_FOR)
  end

  def update_value!
    self.value = Digest::SHA256.hexdigest("#{self.id}#{Time.now.to_s}")
  end
end
