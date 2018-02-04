class Todo < ApplicationRecord
  validates_presence_of :status, :name, :due_date
end
