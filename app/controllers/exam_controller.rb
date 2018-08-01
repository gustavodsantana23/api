class ExamController < ApplicationController
	before_action :authenticate_user
	def show
		render json: Exam.find(params[:id]), status: :ok
	end

	def me
		case current_user.role
		when 'veterinary'
			vet = Profile.find_by(email: current_user.email)
  		@exams = Exam.where(veterinary_id: vet.id)
  	when 'clinic'
  		clinic = Profile.find_by(email: current_user.email)
  		@exams = Exam.where(clinic_id: clinic.id)
  	when 'customer'
  		customer = Customer.find_by(email: current_user.email)
  		@exams = Exam.where(customer_id: customer.id)
  	else
		end
	end
	
end
