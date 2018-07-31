Knock::AuthTokenController.class_eval do
  def create
    render json: {
        access_token: auth_token.token,
      }, status: :created
  end
  private
    def auth_params
      # instead of params.require(:auth).permit :email, :password
      # you would need to
      params[:email] = params[:username]
      params.permit :email, :password
    end
end