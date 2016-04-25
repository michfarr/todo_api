class TasksController < ApplicationController

  def index
    @tasks = Task.order(id: :asc)
    render json: { tasks: @tasks }
  end

  def show
    @task = Task.find( params[:id])
    render json: { task: @task }
  end

  def create
    @task = Task.new

    if @task.save
      render json: { task: @task, location: task_url(@task) }, status: :created # 201
    else
      render json: { errors: @task.errors }, status: :unprocessable_entity # 422
    end
  end

  def update
    @task = Task.find( params[:id] )

    if @task.update( task_params )
      render json: { task: @task }, status: :accepted # 202
    else
      render json: { errors: @task.errors }, status: :unprocessable_entity # 422
  end

  def destroy
    @task = Task.find( params[:id] )
    if @task.destroy
      render json: { task: nil }, status: :accepted # 202
    else
      render json: { errors: @task.erros }, status: :unprocessable_entity # 422
  end

  protected

    def task_params
      params.require(:task).permit(:title, :complete)
    end
end
