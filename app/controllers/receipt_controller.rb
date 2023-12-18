class ReceiptController < ApplicationController
    
    # показывает список рецептов
    def index
        @user = current_user
        render json: @user.receipts.as_json
    end

    # возвращает рецепт по его id
    def receipt_id
        @receipt = Receipt.find_by(id: params[:id])
        render json: @receipt.as_json
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
        render json: {
            favourite_receipts: @user.favourites
        }
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

    def subscriptions_receipts
        @user = current_user
        @subscriptions = User.joins(:subscriptions).where(subscriptions: { follower_id: @user.id })
        @receipts = Receipt.where(user_id: @subscriptions).order(created_at: :desc)
        render json: {
          receipt: @receipts
        }
    end

    def receipts_by_user_id
        @user = User.find(params[:id])
        @receipts = Receipt.where(user_id: @user).order(created_at: :desc)
        render json: {
          receipt: @receipts
        }
    end

    private
    def receipt_params
        params.permit(:title, :description, :photo, :id)
    end
end