class UpdateReceipt < ActiveRecord::Migration[7.1]
  def change
    change_table :receipts do |t|
      t.references :category
    end
  end
end
