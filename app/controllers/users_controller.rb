class UsersController < ApplicationController
	before_action :authenticate_user,  only: [:index, :current, :update, :exams]
  before_action :authorize_as_admin, only: [:destroy]
  before_action :authorize,          only: [:update]

  include UsersHelper

  def index
    render json: {status: 200, msg: 'Logged-in'}
  end

  def current
    current_user.update!(last_login: Time.now)
    if current_user.role == "customer"
    	render json: customer_response(current_user)
    else	
    	render json: profile_response(current_user)
    end
  end

  def exams
  	
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
								create_new_customer params
								render json: customer_response(user, params)
							else
								render json: customer_response(user)
							end
						end
					else
						render json: {code: 400, description: message}, status: 400
					end
				elsif params[:grant_access] == 'veterinary'
					ok, message = is_a_valid_veterinary? params
					if ok
						user = User.new(user_params)
						if user.save!
							if message == 'create'
								# todo send email to admin
								create_new_veterinary params
								render json: profile_response(user, params)
							else
								render json: profile_response(user)
							end
						end
					else
						render json: {code: 400, description: message}, status: 400
					end
				else
					ok, message = is_a_valid_clinic? params
					if ok
						user = User.new(user_params)
						if user.save!
							if message == 'create'
								# todo send email to admin
								create_new_clinic params
								render json: profile_response(user, nil, params)
							else
								profile = Profile.find_by(email: user.email)
								render json: profile_response(user, profile)
							end
						end
					else
						render json: {code: 400, description: message}, status: 400
					end
				end	
			else
				render json: {code: 400, description: "O campo grant_access deve ser 'veterinary'" + \
					"'clinic' ou 'customer'"}, status: 400
			end
		else
			render json: {code: 400, description: "O campo " + message +" é necessário."}, status: 400
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

	# def customer_params
	# 	params[:role] = params[:grant_access]
 #    params.permit(:email, :password, :role)
	# end

	# def user_params
 #    params[:role] = params[:grant_access]
 #    params.permit(:email, :password, :role, :crmv_region,
 #    	:crvm_number, :cpf)
 #  end  

  # Adding a method to check if current_user can update itself. 
  # This uses our UserModel method.
  def authorize
    return_unauthorized unless current_user && current_user.can_modify_user?(params[:id])
  end
end