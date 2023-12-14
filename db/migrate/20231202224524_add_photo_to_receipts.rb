class AddPhotoToReceipts < ActiveRecord::Migration[7.1]
  def change
    add_column :receipts, :photo, :string
  end
end
