# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.boolean :activated, default: false
      t.string :activation_key
      t.string :token
      t.integer :admin_level, default: 0
      t.datetime :can_post_date, default: DateTime.now
      t.datetime :can_comment_date, default: DateTime.now

      t.timestamps
    end
  end
end
