class AddProjectIdToCourses < ActiveRecord::Migration[5.0]
  def change
    add_reference :courses, :project, foreign_key: true
  end
end
