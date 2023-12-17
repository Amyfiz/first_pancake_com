class SearchController < ApplicationController

    # возвращает списки всех рецептов
    def index
        render json: Receipt.all.to_json
    end
    
end
