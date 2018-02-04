class TodosController < ApplicationController
  before_action :set_todo, :only => [:show, :edit, :update, :destroy]

  def index
    @todos = Todo.all
    todo_overdue?
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
    params.require(:todo).permit(:name, :due_date, :note)
  end

  def todo_overdue?
    @todos.each do |todo|
      if (todo.due_date < Date.today) && (todo.status == "no")
        todo.status = "over"
        todo.save
      end
    end
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end
