class UserController < ApplicationController
  def signup
  	@user=User.new()
  end

  def create
 	@user=User.new(user_params)

 	if @user!=nil
 		if @user.save
 			flash[:success]=@user
 		else
 			flash[:danger]="user unsuccesful"
 		end
 	end

 	redirect_to "/login" 
  end

  def login
  	session[:userid]=params[:id]

  	#flash[:success]=session[:userid]
  end
  


  private

  def user_params
  	params.require(:user).permit(:username,:email,:password,:password_confirmation)
  end
end
