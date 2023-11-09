class AddDeviseTokenAuthColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :provider, :string, null: false
    add_column :users, :uid, :string, null: false, default: ""
    add_column :users, :encrypted_password, :string, null: false, default: ""
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
    add_column :users, :remember_created_at, :datetime
    add_column :users, :email, :string, null: false

    add_index :users, [:uid, :provider], unique: true
  end
end
