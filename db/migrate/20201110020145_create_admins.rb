class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.integer :admin_type
      t.integer :status, default: 0
      t.integer :login_attempts, default: 3
      t.string :ref_code_digest
      t.datetime :ref_code_expiry

      t.timestamps
    end
    add_index :admins, :email, unique: true
  end
end
