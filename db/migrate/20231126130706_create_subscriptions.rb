class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions, id: false do |t|
      t.references :follower, foreign_key: {to_table: 'users'}
      t.references :follow, foreign_key: {to_table: 'users'}

      t.timestamps
    end
  end
end
