class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :item, index: true, foreign_key: true, null: false
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.belongs_to :alternative, index: true, foreign_key: true, null: false
      t.boolean :correct

      t.timestamps null: false
    end

    add_index :answers, [:item_id, :user_id], unique: true
  end
end
