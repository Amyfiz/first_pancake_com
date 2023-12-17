class SearchController < ApplicationController

    # возвращает списки всех рецептов
    def index
        render json: Receipt.all.sort_by(&:created_at).reverse.to_json
    end
    
end
