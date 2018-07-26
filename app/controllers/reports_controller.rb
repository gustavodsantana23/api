class ReportsController < ApplicationController
	def index
		@reports = Report.all
		render json: @reports, status: :ok
	end

	def show
		render json: Report.find(params[:id]), status: :ok
	end
end
