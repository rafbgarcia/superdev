class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :weight, default: 0
      t.attachment :image

      t.timestamps
    end
  end
end
