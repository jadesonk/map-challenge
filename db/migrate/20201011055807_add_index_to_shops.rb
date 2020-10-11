class AddIndexToShops < ActiveRecord::Migration[6.0]
  def change
    add_index :shops, :category
  end
end
