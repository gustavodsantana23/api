class UsersController < ApplicationController
	before_action :authenticate_user,  only: [:index, :current, :update]
  before_action :authorize_as_admin, only: [:destroy]
  before_action :authorize,          only: [:update]

  include UsersHelper

  def index
    render json: {status: 200, msg: 'Logged-in'}
  end

  def current
    current_user.update!(last_login: Time.now)
    render json: current_user
  end

  # Method to create a new user using the safe params we setup.
	def create
		ok, message = has_basic_params? params
		if ok
			if is_grant_access_valid? params[:grant_access]
				if params[:grant_access] == 'customer'
					ok, message = is_a_valid_customer? params
					if ok
						user = User.new(user_params)
						if user.save!
							if message == 'create'
								# todo send email to admin
								render json: user
							else
								customer = Customer.find_by(email: user.email)
								render json: customer_response(user, customer)
							end
						end
					else
						render json: {code: 400, message: message}
					end
				elsif params[:grant_access] == 'veterinary'
					ok, message = is_a_valid_veterinary? params
					if ok
						user = User.new(user_params)
						if user.save!
							if message == 'create'
								# todo send email to admin
								render json: user
							else
								profile = Profile.find_by(email: user.email)
								render json: profile_response(user, profile)
							end
						end
					else
						render json: {code: 400, message: message}
					end
				else
					ok, message = is_a_valid_clinic? params
					if ok
						user = User.new(user_params)
						if user.save!
							if message == 'create'
								# todo send email to admin
								render json: user
							else
								profile = Profile.find_by(email: user.email)
								render json: profile_response(user, profile)
							end
						end
					else
						render json: {code: 400, message: message}
					end
				end	
			else
				render json: {code: 400, message: "O campo grant_access deve ser 'veterinary'" + \
					"'clinic' ou 'customer'"}
			end
		else
			render json: {code: 400, message: "O campo " + message +" é necessário."}
		end
	end

	# Method to update a specific user. User will need to be authorized.
	def update
	  user = User.find(params[:id])
	  if user.update(user_params)
	    render json: { status: 200, msg: 'User details have been updated.' }
	  end
	end

	# Method to delete a user, this method is only for admin accounts.
	def destroy
	  user = User.find(params[:id])
	  if user.destroy
	    render json: { status: 200, msg: 'User has been deleted.' }
	  end
	end

	private

	def user_params
    permitted_params = params.permit(:email, :password, :grant_access, :name, :phone, :crmv_region,
    	:crvm_number, :cpf)
    return {email: permitted_params[:email], password: permitted_params[:password],
    				role: permitted_params[:grant_access]}
  end  

  # Adding a method to check if current_user can update itself. 
  # This uses our UserModel method.
  def authorize
    return_unauthorized unless current_user && current_user.can_modify_user?(params[:id])
  end

  def profile_response(user, profile)
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

  def customer_response(user, customer)
		{
	    "user_id": user.id,
	    "name": customer.name,
	    "email": user.email,
	    "type": user.role,
	    "avatar": "http://1.semantic-ui.com/images/home-avatar.png",
	    "date_joined": user.created_at,
	    "last_login": user.last_login,
	    "phone": customer.phone,
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
