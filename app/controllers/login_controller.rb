class LoginController < ApplicationController
    skip_before_action :authorized, only: [:login]

    def login        
        @user = User.find_by(email: params[:email])
        if @user
            if @user.authenticate(login_params[:password])
                @token = encode_token(user_id: @user.id)
                render json: {
                    token: @token,
                    user_id: @user.id
                }, status: :accepted
            else
                render json: {message: 'Incorrect password'}, status: :unauthorized
            end
        else
            render json: {message: 'User doesn`t exist'}, status: :unauthorized
        end
    end

    def user
        @user = current_user
        #@user.subscriptions.create(follow_id: @user.id, follower_id: @user.id) // через это можно создавать в бд записи
        # @receipt = Receipt.find_by(     id: 1)
        # @receipt.favourites.create(user_id: @user.id)
        render json: {
            user: @user,
            subscribers: @user.subscriptions.count,
            receipts_count: @user.receipts.count,
            favoutite_receipts: @user.favourites.count
        }, status: :ok
    end


    private 
    def login_params 
        params.permit(:email,:password)
    end
end