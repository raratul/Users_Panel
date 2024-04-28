class UserSessionsController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
        @user = User.find_by(email: params[:user][:email], status: 'Active')
    
        if @user&.authenticate(params[:user][:password])
          session[:user_id] = @user.id
          @user.update!(last_login: Time.current)
          redirect_to users_path
        else
          flash[:alert] = "Invalid email or password."
          redirect_to new_user_session_path
        end
      end
    
      def destroy
        session[:user_id] = nil
        flash[:notice] = "Successfully logged out."
        redirect_to root_path
      end
end
