class UsersController < ApplicationController
    def index
        @users = User.all 
        render :index
    end

    def new
        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            login!(@user)
            flash[:messages] = ["SUCCESS"]
            redirect_to user_url(@user.id)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    private
    
    def user_params
        params.require(:user).permit(:username, :password)
    end
end