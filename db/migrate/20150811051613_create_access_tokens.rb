class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.string :value
      t.integer :user_id
      t.datetime :expire_at

      t.timestamps null: false
    end
  end
end
