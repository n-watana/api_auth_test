class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login_id
      t.string :password
      t.string :email
      t.text :memo

      t.timestamps null: false
    end
  end
end
