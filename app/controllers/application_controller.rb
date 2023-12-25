class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, ENV["SECRET_KEY_WORD"]) 
  end

  def decoded_token
      header = request.headers['Authorization']
      if header
          token = header.split(" ")[1]
          begin
              JWT.decode(token, ENV["SECRET_KEY_WORD"], true, algorithm: 'HS256')
          rescue JWT::DecodeError
              nil
          end
      end
  end
  
  def current_user 
    if decoded_token
        user_id = decoded_token[0]['user_id']
        @user = User.find_by(id: user_id)
    end
  end

  def authorized
      unless !!current_user
        authenticate_admin_user!
      end
  end
end