class User < ApplicationRecord
	has_secure_password
	start_at = 1000

	validates_length_of       :password, maximum: 72, minimum: 6, allow_nil: true, allow_blank: false
  validates_confirmation_of :password, allow_nil: true, allow_blank: false

  before_validation { 
    (self.email = self.email.to_s.downcase)
  }

  validates_presence_of     :email
  validates_uniqueness_of   :email

  def can_modify_user?(user_id)
    role == 'admin' || id.to_s == user_id.to_s
  end

  def is_admin?
    role == 'admin'
  end
end
