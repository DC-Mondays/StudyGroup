class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.boolean :admin
      t.integer :added_by
      t.boolean :confirmed
      t.boolean :banned
      t.text :about
      t.string :github
      t.string :handle

      t.timestamps null: false
    end
  end
end
