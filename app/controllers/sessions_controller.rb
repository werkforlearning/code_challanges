class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        user = User.find_by(email: params[:email])
        if user.present? && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_path, notice: "You're logged in!"
        else
            flash[:alert] = "Invalid credentials"
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to sign_in_path, notice: "Logged out"
    end
end