class AddAvailableAtToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :available_at, :datetime
  end
end
