class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.string :slug, unique: true
      t.attachment :image

      t.timestamps null: false
    end
  end
end
