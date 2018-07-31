class UserSerializer < ActiveModel::Serializer
  attributes :user_id, :name, :email, :type, :avatar, :date_joined, :last_login
  attributes :phone, :emergency_phone, :crmv_region, :crmv_number, :document
  attributes :notify_when_exam_created, :notify_when_report_is_ready
  attributes :address

  def name
  	if object.role == 'customer'
  		return Customer.find_by(email: object.email).name
  	else
  		return Profile.find_by(email: object.email).name
  	end
  end

  def user_id
  	object.id
  end

  def type
  	object.role
  end

  def profile
  	Profile.where('email = ?', object.email)
  end

  def avatar
  	"http://1.semantic-ui.com/images/home-avatar.png"
  end

  def date_joined
  	object.created_at
  end

  def phone
  	return "3235369852"
  end

  def emergency_phone
  	nil
  end

  def crmv_region
  	"SP"
  end

  def crmv_number
  	"123"
  end

  def document
  	nil
  end

  def notify_when_exam_created
  	true
  end

  def notify_when_report_is_ready
  	true
  end

  def address
  	{
      "address_city": "",
      "address_name": "",
      "address_number": "",
      "address_state": "",
      "address_zipcode": "",
      "address_neighborhood": ""
    }
  end
end
