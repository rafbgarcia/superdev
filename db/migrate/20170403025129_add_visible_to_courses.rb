class AddVisibleToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :visible, :boolean, default: true
  end
end
