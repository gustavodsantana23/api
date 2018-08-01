module ExamsHelper

	def get_current_user_exams(current_user)
		if current_user.role == "customer"

		elsif current_user.role == "veterinary"
			return veterinary_exams_response(current_user)
		else

		end
	end

	def veterinary_exams_response(veterinary)
  	vet = Profile.find_by(email: veterinary.email)
  	exams = Exam.where(veterinary_id: vet.id)
  end

end