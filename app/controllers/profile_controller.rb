class ProfileController < ApplicationController
	before_action :authenticate_user
	
	def show
		render json: Profile.find(params[:id]), status: :ok
	end
	
end
