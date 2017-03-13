class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.references :notificable, polymorphic: true
      t.boolean :seen, default: false

      t.timestamps null: false
    end
  end
end
