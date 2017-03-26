class AddWeightToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :weight, :integer, default: 1
  end
end
