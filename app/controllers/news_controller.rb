class NewsController < ApplicationController
	before_action :authenticate_user
	
	def index
		@news = News.all
		render json: @news, status: :ok
	end
	
end
