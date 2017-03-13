class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.date :expires_at
      t.string :type

      t.timestamps null: false
    end
  end
end
