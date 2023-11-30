class LoginController < ApplicationController
    def create
        @user = User.find_by(email: params[:email])
        if @user
            if @user.authenticate(params[:password])
                render json: { username: @user.username }
            else
                render json: "Authentification failed", status: :unauthorized
            end
        else
            render json: "Could not find user", status: :not_found
        end
    end
end
