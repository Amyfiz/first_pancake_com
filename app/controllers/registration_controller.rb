class RegistrationController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        @user = User.new user_params
        if @user.save && @user.valid?
            @token = encode_token(user_id: @user.id)
            render json: { token: @token, user_id: @user.id, profile_image: @user.profile_image }, status: :created
         else
            render json: {message: "User already exists."}, status: :forbidden
        end
    end

    private 
    def user_params
        params.permit(:username, :email, :password, :profile_image)
    end
end