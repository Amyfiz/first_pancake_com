class LoginController < ApplicationController
    skip_before_action :authorized, only: [:login]

    def login
        @user = User.find_by(email: params[:email])
        if @user
            if @user.authenticate(login_params[:password])
                @token = encode_token(user_id: @user.id)
                render json: {
                    token: @token
                }, status: :accepted
            else
                render json: {message: 'Incorrect password'}, status: :unauthorized
            end
        else
            render json: {message: 'User doesn`t exist'}, status: :unauthorized
        end
    end

    def me
        render json:current_user, status: :ok
    end

    private 
    def login_params 
        params.permit(:email,:password)
    end
end