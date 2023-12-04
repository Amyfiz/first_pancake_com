class RegistrationController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        @user = User.new user_params
        if @user.save && @user.valid?
            @token = encode_token(user_id: @user.id)
            render json: { token: @token }, status: :created
         else
            render json: {message: "User already exists."}, status: :unprocessable_entity
        end
    end

    private 
    def user_params
        params.permit(:username, :email, :password)
    end
end