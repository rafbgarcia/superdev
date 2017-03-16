class AddIuguInfoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :iugu_token, :string
    add_column :users, :iugu_customer_id, :string
    add_column :users, :iugu_subscription_id, :string
    add_column :users, :iugu_subscription_expires_at, :date
  end
end
