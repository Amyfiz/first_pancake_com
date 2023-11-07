class AccessLevel < ActiveRecord::Migration[7.1]
  def change
    create_table :level do |t|

      t.integer :level, null: false
      t.timestamps
    end
  end
end
