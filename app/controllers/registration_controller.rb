class RegistrationController < ApplicationController


    def create
        @user = User.new user_params
        if @user.save && @user.valid?
            render json: @user, status: :created
         else
            render json: @user.errors, status: :forbidden
        end
    end

    private 
    def user_params
        params.permit(:username, :email, :password)
    end
end
