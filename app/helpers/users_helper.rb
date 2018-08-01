module UsersHelper
	REGIONS = ['AC', 'AL', 'AM', 'AP', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA', 'PB',
                              'PE', 'PI', 'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SE', 'SP', 'TO']
  def has_basic_params?(params)
  	if not params[:grant_access].present?
	  	return false, "grant_access"
	  end

	  if not params[:email].present?
	  	return false, "Email"
	  end

	  if not params[:password].present? or params[:password].length < 6
	  	return false, "Senha"
	  end

	  return true
  end

  def is_grant_access_valid?(grant_access)
  	["veterinary", "clinic", "customer"].include? grant_access
  end

	def is_veterinary_crmv_valid?(params)
		params[:crmv_region].present? and params[:crmv_number].present?\
			and REGIONS.include? params[:crmv_region]\
			and params[:crmv_number].length > 3
	end

	def is_customer_cpf_valid?(params)
		params[:cpf].present? and params[:cpf].scan(/\d/).join('').length == 11
	end

	def is_email_valid?(email)
		return email.match(URI::MailTo::EMAIL_REGEXP) != nil
	end

	def is_a_valid_customer?(params)
		if is_customer_cpf_valid? params
			if is_email_valid? params[:email]
				if User.where(email: params[:email]).length > 0
					return false, "Já existe um usuário com este email."
				end
				customers = Customer.where(email: params[:email])
				if customers.length == 0
					if Customer.where(cpf: params[:cpf]).length > 0
						return false, "Já existe outro usuário com esse CPF."
					end
					return true, "create"
				elsif customers.length == 1
					other_customer = Customer.where(cpf: params[:cpf])
					if other_customer.length == 1 and other_customer[0].email != customers[0].email
						return false, "Já existe outro usuário com este CPF."
					end
					return true, "update"
				end
			else
				return false, "Email inválido. Verifique o email digitado."
			end
		else
			return false, "CPF inválido. Verifique o CPF digitado."
		end
	end

	def is_a_valid_veterinary?(params)
		if is_veterinary_crmv_valid? params
			if is_email_valid? params[:email]
				if User.find_by(email: params[:email])
					return false, "Já existe um usuário com este email."
				end
				profile = Profile.where(email: params[:email])
				if profile.length == 0
					if Profile.where(registration_region: params[:crmv_region],\
						registration_number: params[:crmv_number]).length > 0
						return false, "Já existe outro usuário com esse CRMV."
					end
					return true, "create"
				else
					other = Profile.where(registration_region: params[:crmv_region],\
						registration_number: params[:crmv_number])
					if other.length == 1
						if other[0].email != profile[0].email
							return false, "Já existe outro usuário com este CRMV"
						end
					end	
					return true, "update"
				end
			else
				return false, "Email inválido."
			end
		else
			return false, "CRMV inválido"
		end
	end

	def is_a_valid_clinic?(params)
		if not is_email_valid? params[:email]
			return false, "Email inválido."
		else
			profile = Profile.find_by(email: params[:email])
			user = User.find_by(email: params[:email])
			if user
				return false, "Já existe um usuário com esse email."
			elsif profile
				return true, "update"
			else
				return true, "create"
			end
		end
		return true
	end

  def profile_response(user, params=nil)
  	if params
  		{
		    "user_id": user.id,
		    "name": "",
		    "email": user.email,
		    "type": user.role,
		    "avatar": "http://1.semantic-ui.com/images/home-avatar.png",
		    "date_joined": user.created_at,
		    "last_login": user.last_login,
		    "phone": "",
		    "emergency_phone": "",
		    "crmv_region": params[:registration_region],
		    "crmv_number": params[:registration_number],
		    "notify_when_exam_created": "",
		    "notify_when_report_is_ready": "",
		    "address": {
		      "address_city": "",
		      "address_name": "",
		      "address_number": "",
		      "address_state": "",
		      "address_zipcode": "",
		      "address_neighborhood": "",
	    	}
	    }
	  else
	  	profile = Profile.find_by(email: user.email)
	  	{
		    "user_id": user.id,
		    "name": profile.name,
		    "email": user.email,
		    "type": user.role,
		    "avatar": "http://1.semantic-ui.com/images/home-avatar.png",
		    "date_joined": user.created_at,
		    "last_login": user.last_login,
		    "phone": profile.phone,
		    "emergency_phone": profile.emergency_phone,
		    "crmv_region": profile.registration_region,
		    "crmv_number": profile.registration_number,
		    "notify_when_exam_created": profile.notify_exam_created,
		    "notify_when_report_is_ready": profile.notify_report_finished,
		    "address": {
		      "address_city": profile.address_city,
		      "address_name": profile.address_name,
		      "address_number": profile.address_number,
		      "address_state": profile.address_state,
		      "address_zipcode": profile.address_zipcode,
		      "address_neighborhood": profile.address_neighborhood
	    	}
	    }
	  end
  end

  def customer_response(user, params=nil)
  	if params
  		{
  			"user_id": user.id,
  			"name": "",
  			"email": user.email,
  			"type": user.role,
		    "avatar": "http://1.semantic-ui.com/images/home-avatar.png",
  			"date_joined": user.created_at,
		    "last_login": user.last_login,
		    "phone": "",
		    "document": params[:cpf],
		    "address": {
		      "address_city": "",
		      "address_name": "",
		      "address_number": "",
		      "address_state": "",
		      "address_zipcode": "",
		      "address_neighborhood": "",
	    	}
  		}
  	else
	  	customer = Customer.find_by(email: user.email)
			{
		    "user_id": user.id,
		    "name": customer.name,
		    "email": user.email,
		    "type": user.role,
		    "avatar": "http://1.semantic-ui.com/images/home-avatar.png",
		    "date_joined": user.created_at,
		    "last_login": user.last_login,
		    "phone": customer.phone,
		    "document": customer.cpf,
		    "notify_when_exam_created": customer.notify_exam_created,
		    "notify_when_report_is_ready": customer.notify_report_finished,
		    "address": {
		      "address_city": customer.address_city,
		      "address_name": customer.address_name,
		      "address_number": customer.address_number,
		      "address_state": customer.address_state,
		      "address_zipcode": customer.address_zipcode,
		      "address_neighborhood": customer.address_neighborhood
	    	}
	    }
  	end
  end

  def create_new_veterinary(params)
  	Profile.create(:name => params[:name]) do |u|
		  u.phone = params[:phone]
		  u.registration_number = params[:crmv_number]
		  u.registration_region = params[:crmv_region]
		  u.email = params[:email]
		  u.professional_type = '2'
		end
  end

  def create_new_clinic(params)
  	Profile.create(:name => params[:name]) do |u|
		  u.phone = params[:phone]
		  u.email = params[:email]
		  u.professional_type = '1'
		end
  end

  def create_new_customer(params)
  	Customer.create(:name => params[:name]) do |u|
		  u.phone = params[:phone]
		  u.email = params[:email]
		  u.cpf = params[:cpf]
		end
  end

  # def create_new_veterinary(params)
  # 	Profile.create(:name => params[:name]) do |u|
		#   u.phone = params[:phone]
		#   u.registration_number = params[:crmv_number]
		#   u.registration_region = params[:crmv_region]
		#   u.email = params[:email]
		#   u.professional_type = '2'
		#   u.is_independent = true
		# 	u.notify_exam_created = true
		# 	u.notify_report_finished = true
		# 	u.notify_clinic_updated = true
		# end
  # end

  # def create_new_clinic(params)
  # 	Profile.create(:name => params[:name]) do |u|
		#   u.phone = params[:phone]
		#   u.email = params[:email]
		#   u.professional_type = '1'
		#   u.notify_exam_created = true
		# 	u.notify_report_finished = true
		# 	u.notify_clinic_updated = true
		# end
  # end

  # def create_new_customer(params)
  # 	Customer.create(:name => params[:name]) do |u|
		#   u.phone = params[:phone]
		#   u.email = params[:email]
		#   u.cpf = params[:cpf]
		#   u.notify_exam_created = true
  #   	u.notify_report_finished = true
		# end
  # end
end