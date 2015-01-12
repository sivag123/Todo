class TaskController < ApplicationController
  def new
    @task=Task.new(task_params)
    @task.update_attributes(user_id: session[:userid])
    
    if !@task.valid?
      flash.now[:danger]=@task.errors.full_messages
    end
    if @task!=nil
      if @task.save
        flash.now[:success]="Todo Saved successfully"
        redirect_to task_path
      else
        flash.now[:danger]=params[:id]
      end
    end 
  end


  def home
    if(session[:userid] !=nil)
      @user=User.find(session[:userid])
      @task=Task.new
  	  @task_array=Task.where("user_id=?",session[:userid])
    else
      redirect_to "/home"
    end
  end


  def delete
  	@task=Task.find_by(id: params[:id])
    if !@task.nil?
      @task.destroy
    end

    flash.now[:success]="Deleted successfully"
    redirect_to task_path
  end


  def update
    @task=Task.find_by_id(params[:id])

    if !@task.nil?
      if @task.status=="undone"
        @task.update_attributes(status: "done");
      else
        @task.update_attributes(status: "undone");
      end
    end

    respond_to do |format|
      format.html
      format.json {
        render :json => "Update success"
      }
    end

  end

  private
  	def task_params
  		params.require(:task).permit(:description,:status)
  	end
end
