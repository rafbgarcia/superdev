class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.belongs_to :item, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :upvotes, default: 0
      t.string :title
      t.text :text
      t.boolean :resolved, default: false
      t.string :slug, unique: true
      t.boolean :edited, default: :false

      t.timestamps null: false
    end
  end
end
