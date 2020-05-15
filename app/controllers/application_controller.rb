class ApplicationController < ActionController::API

    def encode_userToken(user)
        JWT.encode( {user_id: user.id, username: user.username}, 'uHave-iWant', 'HS256')
    end

    def decoded_userToken
        begin
            JWT.decode(userToken, 'uHave-iWant', true, algorithm: 'HS256')
        rescue
            JWT::DecodeError
            [{error: "Invalid userToken"}]
        end
    end

    def userToken
        request.headers['Authorization']
    end

    def user_id
        decoded_userToken.first['user_id']
    end

    def authorized
        render json: {message: "Please log in"}, status: :unauthorized unless logged_in?
    end
    

    def current_user
        @user ||= User.find_by(id: user_id)
    end

    def logged_in?
        !!current_user
    end
end
