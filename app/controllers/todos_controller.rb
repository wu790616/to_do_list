class TodosController < ApplicationController
  before_action :set_todo, :only => [:show, :edit, :update, :destroy]

  def index
    @todos = Todo.all
    @todos.each do |todo|
      todo_overdue?(todo)
    end
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      redirect_to todos_url
    else
      render :action => :new
    end
  end

  #def show
  #end

  #def edit
  #end

  def update
    if @todo.update_attributes(todo_params)
      todo_overdue?(@todo)
      redirect_to todo_path(@todo)
    else
      render :action => :edit
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_url
  end

  private

  def todo_params
    params.require(:todo).permit(:status, :name, :due_date, :note)
  end

  def todo_overdue?(todo)
    if (todo.due_date < Date.today) && (todo.status == "no")
      todo.status = "over"
      todo.save
    elsif (todo.due_date >= Date.today) && (todo.status == "over")
      todo.status = "no"
      todo.save
    end
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end
