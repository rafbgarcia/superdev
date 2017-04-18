class AddExerciseToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :exercise, :boolean
  end
end
