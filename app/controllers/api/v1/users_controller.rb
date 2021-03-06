class Api::V1::UsersController < ApplicationController
    before_action :authorized, except: [:create]

    def index
        @users = User.all
        render json: @users
    end
    
    def profile
        puts UserSerializer.new(current_user)
        render json: {user: UserSerializer.new(current_user)}
    end
  
    def create
        @user = User.new(user_params)
        if @user.valid?
            @user.save
            @userToken = encode_userToken(@user)
            byebug
            render json: { user: UserSerializer.new(@user), jwt: @userToken }
                #use encode_userToken method to do JWT.encode (AppController)
        else
            render json: { error: 'Failed to create new user account' }, status: :not_acceptable
        end
    end
    
    def update 
        @user = User.find(params[:id])
        @user.update(user_params)
        render json: @user
    end

    def destroy
        @user = User.find(params[:id])
        if @user 
            @user.destroy 
            render json: {message: "User successfully deleted"}
        else 
            render json: {message: 'Could not delete user'}, status: :not_acceptable
        end
    end
    
    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :username, :password, :email, :location)
    end
end
