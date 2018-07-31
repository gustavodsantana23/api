class ExamController < ApplicationController
	before_action :authenticate_user
	
	def show
		render json: Exam.find(params[:id]), status: :ok
	end
	
end
