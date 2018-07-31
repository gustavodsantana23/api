module UsersHelper
	REGIONS = ['AC', 'AL', 'AM', 'AP', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA', 'PB',
                              'PE', 'PI', 'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SE', 'SP', 'TO']
  def has_basic_params?(params)
  	if not params[:grant_access].present?
	  	return false, "grant_access"
	  end

	  if not params[:name].present?
	  	return false, "Nome"
	  end

	  if not params[:email].present?
	  	return false, "Email"
	  end

	  if not params[:phone].present?
	  	return false, "Telefone"
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
				return false, "Email inválido."
			end
		else
			return false, "CPF inválido."
		end
	end

	def is_a_valid_veterinary?(params)
		if is_veterinary_crmv_valid? params
			if is_email_valid? params[:email]
				if User.where(email: params[:email]).length > 0
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
					if other.length == 1 and other.email != profile.email
						return false, "Já existe outro usuário com este CRMV"
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
		end

		return true
	end
end