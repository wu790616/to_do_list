class AddDefaultStatusToTodos < ActiveRecord::Migration[5.1]
  def change
    change_column :todos, :status, :string, default: "no"
  end
end
