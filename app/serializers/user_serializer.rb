class UserSerializer < ActiveModel::Serializer
  attributes :user_id, :username, :email, :role, :created_at, :updated_at, :last_login, :profile

  def user_id
  	object.id
  end

  def profile
  	Profile.where('email = ?', object.email)
  end

end
