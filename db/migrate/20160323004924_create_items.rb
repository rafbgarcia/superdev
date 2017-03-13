class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :lesson, index: true, foreign_key: true
      t.references :itemable, polymorphic: true

      t.integer :weight
      t.string :title
      t.text :description
      t.integer :difficulty, default: 0

      t.timestamps null: false
    end

    add_index :items, [:lesson_id, :weight], unique: true
  end
end
