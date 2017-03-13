class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.belongs_to :course, index: true
      t.integer :weight
      t.string :slug, unique: true
      t.boolean :free, default: false

      t.timestamps null: false
    end

    add_index :lessons, [:course_id, :weight], unique: true
  end
end
