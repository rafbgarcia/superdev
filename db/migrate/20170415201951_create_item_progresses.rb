class CreateItemProgresses < ActiveRecord::Migration[5.0]
  def change
    create_table :item_progresses do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :item, foreign_key: true

      t.timestamps
    end
  end
end
