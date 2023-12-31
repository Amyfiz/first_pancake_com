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
        #@receipt = Receipt.find_by(     id: 1)
        #@receipt.favourites.create(user_id: @user.id)
        render json: {
          id: @user.id,
          username: @user.username,
          email: @user.email,
          subscribers_count: Subscription.where(follow_id: @user.id).count,
          subscriptions_count: Subscription.where(follower_id: @user.id).count,
          receipts_count: @user.receipts.count,
          favourite_receipts: @user.favourites.count,
          profile_image: @user.profile_image,
        }, status: :ok
    end

    def user_info_by_id
        @user = User.find_by(id: params[:id])
        render json: {
          subscribers_count: Subscription.where(follow_id: @user.id).count,
          subscriptions_count:  Subscription.where(follower_id: @user.id).count,
          receipts_count: @user.favourites.count,
        }, status: :ok
    end


    def get_user_by_id
        @user = User.find(params[:id])
        render json: {
          id: @user.id,
          username: @user.username,
          email: @user.email,
          subscribers_count: @user.subscriptions.count,
          subscriptions_count: @user.subscriptions.count,
          receipts_count: @user.receipts.count,
          favourite_receipts: @user.favourites.count,
          profile_image: @user.profile_image,
        }, status: :ok
    end

    def add_photo
        @user = current_user
        @user.update(profile_image: params[:photo])
        render json: { message: "Photo added sucessfully."}
    end

    def delete_photo
        @user = current_user
        @user.update(profile_image: nil)
        render json: { message: "Photo deleted successfully."}
    end

    private 
    def login_params 
        params.permit(:email,:password)
    end
end