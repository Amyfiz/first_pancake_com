class ReceiptController < ApplicationController
    
    # показывает список рецептов
    def index
        @user = current_user
        render json: @user.receipts.as_json
    end

    # создаёт рецепт
    def create_receipt
        @receipt = Receipt.new receipt_params
        @receipt.user_id = current_user.id
        @receipt.save
        render json: {
            receipt: @receipt
        }
    end

    # показывает список избранных рецептов пользователя
    def favourites
        @user = current_user
        @favourite_receipts = Receipt.joins(:favourites).where(favourites: { user_id: @user.id })
        render json: @favourite_receipts
    end

    # добавляет рецепт в избранное по его id
    def add_favourite
        @user = current_user
        @receipt = Receipt.find_by(id: params[:id])
        @receipt.favourites.create(receipt_id: @receipt.id, user_id: @user.id)
        render json: {
            receipt: @receipt
        }
    end

    # удаляет любимый рецепт авторизованного пользователя
    def delete_favourite
        @user = current_user
        @favourite_receipt = @user.favourites.where(receipt_id: params[:id], user_id: @user.id)
        @favourite_receipt.delete_all
        render json: {
            favourite_receipt: @favourite_receipt
        }
    end

    # удаляет рецепт по его
    def delete_receipt
        @user = current_user
        @receipt = Receipt.where(id: params[:id])
        @receipt.delete_all
        render json: {
            receipt: @receipt
        }
    end
    

    def subscriptions_receipts
        @user = current_user
        @subscriptions = User.joins(:subscriptions).where(subscriptions: { follower_id: @user.id })
        @receipts = Receipt.where(user_id: @subscriptions).order(created_at: :desc)
        @receipts_result = @receipts.map do |receipt| {
            title: receipt.title,
            id: receipt.id,
            description: receipt.description,
            user_id: receipt.user_id,
            created_at: receipt.created_at,
            photo: receipt.photo,
            receipt_author: receipt.user.username
        }
        end 
        render json: @receipts_result
    end

    # возвращает рецепт по его id
    def receipt_id
        @receipt = Receipt.find_by(id: params[:id])

        render json: {
            id: @receipt.id,
            title: @receipt.title,
            description: @receipt.description,
            user_id: @receipt.user_id,
            receipt_author: @receipt.user.username,
            created_at: @receipt.created_at,
            category_id: @receipt.category_id,
            photo: @receipt.photo 
        }, status: :ok
    end

    def receipts_by_user_id
        @user = User.find(params[:id])
        @receipts = @user.receipts
        render json: @receipts   
    end

    private
    def receipt_params
        params.permit(:title, :description, :photo, :id)
    end
end