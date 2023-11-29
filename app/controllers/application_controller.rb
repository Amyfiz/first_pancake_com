class ApplicationController < ActionController::API
  def index
    render json: {status: 'test response'}
  end
end