class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password_digest
      t.boolean :active, :default => false

      # Roles
      t.boolean :junior
      t.boolean :senior
      t.boolean :leader 
      t.boolean :admin
      t.boolean :super

      t.string :member_reference
      t.string :bacs_reference

      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
