class CreateFavourites < ActiveRecord::Migration[7.1]
  def change
    create_table :favourites, id: false do |t|
      t.references :user
      t.references :receipt

      t.timestamps
    end
  end
end
