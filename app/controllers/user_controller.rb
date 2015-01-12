class UserController < ApplicationController
  def signup
  	@user=User.new()
  end

  def create
 	@user=User.new(user_params)

 	if @user!=nil
 		if @user.save
      session[:userid]=@user.id
 			flash[:success]=@user
      redirect_to "/task"
 		else
 			flash[:danger]="user unsuccesful"
 		end
 	end

 	
  end

  def login
    @user=User.new
  end

  def login_auth
    @user=User.find_by(email: login_params[:email])
    if @user && @user.authenticate(login_params[:password])
  	  session[:userid]=@user.id
      redirect_to "/task"
    else
      flash[:danger]="Username not registered . please signup"
      redirect_to "/signup"
    end
  end
  


  private

  def login_params
    params.require(:user).permit(:email,:password)
  end

  def user_params
  	params.require(:user).permit(:username,:email,:password,:password_confirmation)
  end
end
