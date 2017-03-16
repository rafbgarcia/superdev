class AddIuguExpiresAtToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :iugu_subscription_expires_at, :date
  end
end
