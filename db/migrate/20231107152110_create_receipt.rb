class CreateReceipt < ActiveRecord::Migration[7.1]
  def change
    create_table :receipts do |t|

      t.string :title, null: false
      # t._____ :photo, null: false
      t.text :description, null: false

      t.references :user
      # t._____ :id_categories
      # t.bool :marked
      # t._____ :subscriptions
      t.timestamps
    end
  end
end
