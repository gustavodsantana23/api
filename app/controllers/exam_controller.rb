class ExamController < ApplicationController
	before_action :authenticate_user
	include ExamsHelper
	def show
		render json: Exam.find(params[:id]), status: :ok
	end

	def me
		render json: get_current_user_exams(current_user)
	end
	
end
