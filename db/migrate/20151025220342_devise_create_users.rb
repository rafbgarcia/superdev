class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      # Devise Fields
        ## Database authenticatable
        t.string :email,              null: false, default: ""
        t.string :encrypted_password, null: false, default: ""

        ## Recoverable
        t.string   :reset_password_token
        t.datetime :reset_password_sent_at

        ## Rememberable
        t.datetime :remember_created_at


      # OmniAuth
        t.string :provider
        t.string :uid


      # SuperDev fields
        t.string :name
        t.string :gender
        t.string :phone
        t.string :facebook_link
        t.string :facebook_avatar
        t.attachment :avatar

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
