class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|

      t.string :username, null: false
      # t._____ :photo

      t.string :email, unique: true, null: false
      t.string :password, null: false
      t.integer :access_level

      # t._____ :own_recipes
      # t._____ :favourites
      # t._____ :subscribers
      # t._____ :subscriptions
      t.timestamps
    end
  end
end