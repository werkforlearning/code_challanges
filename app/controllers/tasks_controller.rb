class TasksController < ApplicationController
    before_action :require_user_logged_in!
    before_action :set_task, only: [:update, :destroy]
    helper_method :sort_column, :sort_direction

    def index
        @tasks = Current.user.tasks.order("#{sort_column} #{sort_direction}").to_a
    end

    def new
        @task = Task.new
    end

    def create
        @task = Current.user.tasks.new(task_params)
        @task.status = "New"

        if @task.due_date < Date.today
            redirect_to new_task_path, alert: "Due Date should be atleast today or after"
            return
        end
        
        if @task.save
            redirect_to tasks_path, notice: "Task Created"
        else
            render :new
        end
    end

    def update
        if @task.update(status: "Completed")
           redirect_to tasks_path, notice: "Success"
        else
            render :index
        end
    end

    def destroy
        @task.destroy
        redirect_to tasks_path, notice: "Task deleted with description: #{@task.description}"
    end

    
    private
    def task_params
        params.require(:task).permit(:description, :priority, :due_date)
    end

    def set_task
        @task = Current.user.tasks.find_by(id: params[:id])
    end

    def sort_column
        %w[description due_date priority status].include?(params[:sort]) ? params[:sort] : "due_date"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end